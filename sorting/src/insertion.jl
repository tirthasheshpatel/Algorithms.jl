function insertionsort!(x::AbstractArray)
    n = length(x)
    for i ∈ 1:n
        @inbounds key = x[i]
        j = i-1
        @inbounds while j > 0 && x[j] > key
            @inbounds x[j+1] = x[j]
            j-=1
        end
        @inbounds x[j+1] = key
    end
    return nothing
end
