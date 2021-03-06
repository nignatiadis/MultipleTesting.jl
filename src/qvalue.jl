## qValues ##

function qValues{T<:AbstractFloat}(pValues::Vector{T}, pi0::T, pfdr::Bool = false)
    validPValues(pValues)
    validPValues([pi0])
    n = length(pValues)
    u = sortperm(pValues)
    v = competerank(pValues) ## ties with 'min'
    if pfdr
        qvals = (pi0 .* n .* pValues) ./ (v .* (1 - (1 - pValues) .^ n))
    else
        qvals = (pi0 .* n .* pValues) ./ v
    end
    qvals[u[n]] = min(qvals[u[n]], 1)
    for i in (n - 1):-1:1
        qvals[u[i]] = min(qvals[u[i]], qvals[u[i + 1]])
    end
    return qvals
end
