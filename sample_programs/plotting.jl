#=
- if package plots not found in current path, execute following code: import Pkg; Pkg.add("Plots")
- This program shows the compilation and execution speed of Julia programs. Compiling and running the function the first time it runs very slow, but subsequent calls of the function will be much faster. 
  This assumes you're in the same session of Julia 
=#
using Plots
function makePlot(num1,num2,name)
    x = range(0.0,stop = num1*π,length = num2);
    y = sin.(x);
    plot(x,y)
    savefig("$name.pdf")
end

makePlot(2, 100, "plot1")
makePlot(20, 200, "plot2")
makePlot(50, 300, "plot3")