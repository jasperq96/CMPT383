#=
- Julia makes it very simple for function overloading, which is a feature that python does not support.
=#

function calc(a,b)
    a*b
end

function calc(a,b,c)
    a*b*c
end


function calc(a,b,c,d)
    a+b+c+d
end

function calc(a,b,c,d,e...)
    a + b + c + d + map(+, e...)
end