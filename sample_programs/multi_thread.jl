#=
- Julia comes with parallelism right out of the box, below is an example of multi-threading.
- The function represents the Lucas number sequence, which is very similar to the Fibonacci sequence except with different starting values
- @spawn computes lucas(n-2) in parallel with lucas(n-1)
- fetch() waits and grabs the returned value of second_thread
=#


import Base.Threads.@spawn

function lucas(n::Int)
    if n == 0
        return 2
    elseif n == 1
        return 1
    end
    second_thread = @spawn lucas(n - 2)
    return lucas(n - 1) + fetch(second_thread)
end