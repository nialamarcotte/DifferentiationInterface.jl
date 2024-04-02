pretty(b::AbstractADType) = string(b)

pretty(::AutoZeroForward) = "ZeroForward"
pretty(::AutoZeroReverse) = "ZeroReverse"

pretty(::AutoChainRules) = "ChainRules"
pretty(::AutoDiffractor) = "Diffractor"
pretty(::AutoEnzyme) = "Enzyme"
pretty(::AutoFastDifferentiation) = "FastDifferentiation"
pretty(::AutoFiniteDiff) = "FiniteDiff"
pretty(::AutoFiniteDifferences) = "FiniteDifferences"
pretty(::AutoForwardDiff) = "ForwardDiff"
pretty(::AutoPolyesterForwardDiff) = "PolyesterForwardDiff"
pretty(b::AutoReverseDiff) = "ReverseDiff$(b.compile ? "{compiled}" : "")"
pretty(::AutoTapir) = "Tapir"
pretty(::AutoTracker) = "Tracker"
pretty(::AutoZygote) = "Zygote"

pretty(::AutoSparseFastDifferentiation) = "FastDifferentiation sparse"
pretty(::AutoSparseFiniteDiff) = "FiniteDiff sparse"
pretty(::AutoSparseForwardDiff) = "ForwardDiff sparse"
pretty(::AutoSparsePolyesterForwardDiff) = "PolyesterForwardDiff sparse"
pretty(::AutoSparseReverseDiff) = "ReverseDiff sparse"
pretty(::AutoSparseZygote) = "Zygote sparse"

function backend_string(backend::AbstractADType)
    bs = pretty(backend)
    if mode(backend) == AbstractFiniteDifferencesMode
        return "$bs (finite)"
    elseif mode(backend) == AbstractForwardMode
        return "$bs (forward)"
    elseif mode(backend) == AbstractReverseMode
        return "$bs (reverse)"
    elseif mode(backend) == AbstractSymbolicDifferentiationMode
        return "$bs (symbolic)"
    else
        error("Unknown mode")
    end
end

function backend_string(backend::SecondOrder)
    return "$(backend_string(outer(backend))) / $(backend_string(inner(backend)))"
end