function countingsort(x::AbstractArray{<:Int})::AbstractArray{<:Int}
    l = length(x)
    n = maximum(x)+1
    count = zeros(Int, n)
    aux = copy(x)
    for i ∈ 1:l
        @inbounds count[x[i]+1]+=1
    end
    for i ∈ 2:n
        @inbounds count[i] += count[i-1]
    end
    for i ∈ l:-1:1
        @inbounds aux[count[x[i]+1]] = x[i]
        @inbounds count[x[i]+1]-=1
    end
    return aux
end
