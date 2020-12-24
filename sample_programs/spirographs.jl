#=
- if package plots not found in current path, execute following code: import Pkg; Pkg.add("Plots")
- This program shows the compilation and execution speed of Julia programs. Compiling and running the function the first time it runs very slow, but subsequent calls of the function will be much faster. 
  This assumes you're in the same session of Julia.
- In order to see true speed, need to compile once, then any calls to "spirograph" will be faster than original
- Also shows Julia's capability to calculate complex formulas in a fast time
- Spirograph formulas found at: http://www.mathematische-basteleien.de/spirographs.htm#:~:text=The%20standard%20equations%20of%20the,to%202Pi%20for%20one%20period.&text=A%20rectangle%20and%20two%20half,this%20part%20of%20the%20spirograph.
=#

using Plots

function spirograph(R, r, t, a, name)
    x = [(R-r)*cos((r/R)*i) + a*cos((1-(r/R))*i) for i in 1:t]
    y = [(R-r)*sin((r/R)*i) - a*sin((1-(r/R))*i) for i in 1:t]
    plot(x,y)
    savefig("$name.pdf")
end

spirograph(5,1,1000,1,"first")
spirograph(5,1,1000,4,"second")
spirograph(5,1,1000,10,"third")
spirograph(1,5,1000,4,"fourth")