#=
- One of the advantages of using Julia is the advanced math syntax and functions offered by the language. 
- It's ability to do huge calculations in a short time.
- To use bench mark tools need to inlcude: import Pkg; Pkg.add("BenchmarkTools")
=#

using Random
using BenchmarkTools

function complexCalc(x1,x2,x3,x4)
    x1+x2-x3+x4
end

formula = ℯ^(im*π) + 1 #eulers identity, able to type easily using math syntax offered by Julia
println(formula)

N = 100000 #I want 100000 columns in my array
rng = MersenneTwister(1234) #randomly pick the number of rows in my array
lst = [Random.randn(rng, N) for i in 1:4] #generate 4 lists, each with an array of size rng x N with normally-distributed random values.
println(@benchmark complexCalc(lst...))