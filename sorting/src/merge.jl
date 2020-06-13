"""
    _merge!(x::AbstractArray, p::Int, q::Int, r::Int)

Merges tow sorted arrays inplace of size `q-p+1` and `r-q` into one
sorted array. For private use only.
"""
function _merge!(x::AbstractArray, p::Int, q::Int, r::Int)
    x1 = x[p:q]
    x2 = x[(q+1):r]

    i = p
    j = q+1
    k = p

    while i ≤ q && j ≤ r
        if x1[i-p+1] < x2[j-q]
            x[k] = x1[i-p+1]
            k += 1
            i += 1
        else
            x[k] = x2[j-q]
            k += 1
            j += 1
        end
    end

    while i ≤ q
        x[k] = x1[i-p+1]
        k += 1
        i += 1
    end

    while j ≤ r
        x[k] = x2[j-q]
        k += 1
        j += 1
    end
    
    return nothing
end


function mergesort!(x::AbstractArray, p::Int, r::Int)
    if p ≥ r
        return nothing
    end
    q::Int = floor(( p+r ) / 2)
    mergesort!(x, p, q)
    mergesort!(x, q+1, r)
    _merge!(x, p, q, r)
    return nothing
end;
