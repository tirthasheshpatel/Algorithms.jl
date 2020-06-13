function selectionsort!(x::AbstractArray)
    n = length(x)
    for i ∈ 1:n
        # mi = minimum index
        mi = i
        for j ∈ (i+1):n
            @inbounds if x[j] ≤ x[mi]
                mi = j
            end
        end
        @inbounds tmp   = x[i]
        @inbounds x[i]  = x[mi]
        @inbounds x[mi] = tmp
    end
    return nothing
end
