import graphs as g
import matplotlib.pyplot as plt #if cannot find module (vagrant), execute: pip3 install matplotlib
import json
import zmq

'''
SWIG commands:
swig -python -py3 -modern graphs.i
gcc -fPIC -c graphs.c graphs_wrap.c -I/usr/include/python3.8
ld -shared graphs.o graphs_wrap.o -o _graphs.so
'''
def spirograph(R, r, t, a, combine):
    x = [g.spiroX(R,r,i,a) for i in range(1,t)] 
    y = [g.spiroY(R,r,i,a) for i in range(1,t)]

    if combine == "no":
        plt.clf()
    plt.plot(x,y)
    plt.xlabel('x values')
    plt.ylabel('y values')
    plt.title('Spirograph')
    plt.savefig('plot.png', dpi=300, bbox_inches='tight')


context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

while True:
    request = json.loads(socket.recv().decode('utf-8'))
    spirograph(int(request['outer']),int(request['inner']),int(request['points']),int(request['angle']),request['combine'])
    response = {}
    socket.send(json.dumps(response).encode('utf-8'))