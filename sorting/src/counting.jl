function countingsort(x::AbstractArray{<:Int})::AbstractArray{<:Int}
    l = length(x)
    n = maximum(x)+1
    count = zeros(Int, n)
    aux = copy(x)
    for i ∈ 1:l
        count[x[i]+1]+=1
    end
    for i ∈ 2:n
        count[i] += count[i-1]
    end
    for i ∈ l:-1:1
        aux[count[x[i]+1]] = x[i]
        count[x[i]+1]-=1
    end
    return aux
end
