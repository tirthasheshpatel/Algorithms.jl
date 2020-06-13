function _partition(x::AbstractArray, p::Int, r::Int)::Int
    y = x[r]
    i = p-1
    for j ∈ p:(r-1)
        if x[j] ≤ y
            i += 1
            tmp  = x[i]
            x[i] = x[j]
            x[j] = tmp
        end
    end
    tmp    = x[i+1]
    x[i+1] = x[r]
    x[r]   = tmp
    return i+1
end


function quicksort!(x::AbstractArray, p::Int, r::Int)
    if p ≥ r
        return nothing
    end
    q::Int = _partition(x, p, r)
    quicksort!(x, p, q-1)
    quicksort!(x, q+1, r)
end
