function selectionsort!(x::AbstractArray)
    n = length(x)
    for i ∈ 1:n
        # mi = minimum index
        mi = i
        for j ∈ (i+1):n
            if x[j] ≤ x[mi]
                mi = j
            end
        end
        tmp   = x[i]
        x[i]  = x[mi]
        x[mi] = tmp
    end
    return nothing
end
