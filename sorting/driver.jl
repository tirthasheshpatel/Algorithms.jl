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

    dtime::Float64      = 0.0
    dtime_best::Float64 = 1000.0

    @show algo
    @show nrep
    @show start
    @show stop
    @show inc
    @show filename

    buffer = "size, time\n"

    if algo == "quick"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                quicksort!(a, 1, len);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "merge"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                mergesort!(a, 1, len);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "insertion"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                insertionsort!(a);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "selection"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                selectionsort!(a);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "bubble"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                bubblesort!(a);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "counting"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = rand(0:1_000_000, len)
                dtime = time()
                countingsort(a);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end
    if algo == "inbuilt"
        for len ∈ start:inc:stop
            for rep ∈ 1:nrep
                a = randn(len)
                dtime = time()
                sort!(a);
                dtime = time() - dtime
                if rep == 1 dtime_best = dtime
                else dtime_best = ( dtime < dtime_best ? dtime : dtime_best )
                end
            end
            buffer *= "$len, $(dtime_best*1.0e09)\n"
        end
    end

    open(filename, "w") do io
        println("Writing Results...")
        write(io, buffer)
    end
end


main(ARGS)
