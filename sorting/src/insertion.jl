function insertionsort!(x::AbstractArray)
    n = length(x)
    for i ∈ 1:n
        key = x[i]
        j = i-1
        while j > 0 && x[j] > key
            x[j+1] = x[j]
            j-=1
        end
        x[j+1] = key
    end
    return nothing
end
