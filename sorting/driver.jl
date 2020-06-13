using BenchmarkTools
include("src/quick.jl")
include("src/merge.jl")
include("src/selection.jl")
include("src/insertion.jl")
include("src/bubble.jl")
include("src/counting.jl")


function main(args)
    if length(args) ≠ 6
        error("usage: julia driver.jl <algo> <nrep> <start> <stop> <inc> <filename>\nfound $(args)")
    end

    algo::String     =            args[1]
    nrep::Int        = parse(Int, args[2])
    start::Int       = parse(Int, args[3])
    stop::Int        = parse(Int, args[4])
    inc::Int         = parse(Int, args[5])
    filename::String =            args[6]

    @show algo
    @show nrep
    @show start
    @show stop
    @show inc
    @show filename

    BenchmarkTools.DEFAULT_PARAMETERS.samples = nrep

    buffer = "size, time\n"

    if algo == "quick"
        for len ∈ start:inc:stop
            res = @benchmark quicksort!(a, 1, $len) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "merge"
        for len ∈ start:inc:stop
            res = @benchmark mergesort!(a, 1, $len) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "insertion"
        for len ∈ start:inc:stop
            res = @benchmark insertionsort!(a) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "selection"
        for len ∈ start:inc:stop
            res = @benchmark selectionsort!(a) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "bubble"
        for len ∈ start:inc:stop
            res = @benchmark bubblesort!(a) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "counting"
        for len ∈ start:inc:stop
            res = @benchmark countingsort(a) setup=(a=rand(1:10_000, $len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end
    if algo == "inbuilt"
        for len ∈ start:inc:stop
            res = @benchmark sort!(a) setup=(a=randn($len));
            buffer *= "$len, $(minimum(res.times))\n"
        end
    end

    open(filename, "w") do io
        println("Writing Results...")
        write(io, buffer)
    end
end


main(ARGS)
