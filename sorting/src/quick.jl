function _partition(x::AbstractArray, p::Int, r::Int)::Int
    @inbounds y = x[r]
    i = p-1
    for j ∈ p:(r-1)
        @inbounds if x[j] ≤ y
            i += 1
            @inbounds tmp  = x[i]
            @inbounds x[i] = x[j]
            @inbounds x[j] = tmp
        end
    end
    @inbounds tmp    = x[i+1]
    @inbounds x[i+1] = x[r]
    @inbounds x[r]   = tmp
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
