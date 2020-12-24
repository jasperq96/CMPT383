//after running on vagrant, use http://localhost:80/form.html on local browswer

package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"text/template"

	zmq "github.com/pebbe/zmq4"
)

type info struct {
	Outer  string
	Inner  string
	Angle  string
	Points string
}

func graphHandler(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		fmt.Fprintf(w, "ParseForm() err: %v", err)
		return
	}
	outR := r.FormValue("outRadius")
	inR := r.FormValue("inRadius")
	points := r.FormValue("points")
	angle := r.FormValue("angle")
	combine := r.FormValue("combine")
	makeRequest(outR, inR, points, angle, combine)
	p := info{
		Outer:  outR,
		Inner:  inR,
		Angle:  angle,
		Points: points,
	}
	t, err := template.ParseFiles("./static/image.html")
	if err != nil {
		log.Fatal(err)
	}
	t.Execute(w, p)
}

func makeRequest(out, in, p, a, comb string) {
	requester, _ := zmq.NewSocket(zmq.REQ)
	defer requester.Close()
	requester.Connect("tcp://localhost:5555")

	request, _ := json.Marshal(map[string]string{
		"outer":   out,
		"inner":   in,
		"points":  p,
		"angle":   a,
		"combine": comb,
	})
	requester.SendBytes(request, 0)
	_, _ = requester.RecvBytes(0)
}

func main() {
	fileServer := http.FileServer(http.Dir("./static"))
	http.Handle("/", fileServer) //by default, grab index.html
	http.HandleFunc("/form", graphHandler)

	fmt.Printf("Starting server at port 8080\n")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
