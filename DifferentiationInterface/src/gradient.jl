## Docstrings

"""
    prepare_gradient(f, backend, x) -> extras

Create an `extras` object subtyping [`GradientExtras`](@ref) that can be given to gradient operators.
"""
function prepare_gradient end

"""
    value_and_gradient(f, backend, x, [extras]) -> (y, grad)
"""
function value_and_gradient end

"""
    value_and_gradient!(f, grad, backend, x, [extras]) -> (y, grad)
"""
function value_and_gradient! end

"""
    gradient(f, backend, x, [extras]) -> grad
"""
function gradient end

"""
    gradient!(f, grad, backend, x, [extras]) -> grad
"""
function gradient! end

## Preparation

"""
    GradientExtras

Abstract type for additional information needed by gradient operators.
"""
abstract type GradientExtras <: Extras end

struct NoGradientExtras <: GradientExtras end

struct PullbackGradientExtras{E<:PullbackExtras} <: GradientExtras
    pullback_extras::E
end

function prepare_gradient(f, backend::AbstractADType, x)
    return PullbackGradientExtras(prepare_pullback(f, backend, x))
end

## One argument

function value_and_gradient(
    f, backend::AbstractADType, x, extras::GradientExtras=prepare_gradient(f, backend, x)
)
    return value_and_pullback(f, backend, x, one(eltype(x)), extras.pullback_extras)
end

function value_and_gradient!(
    f,
    grad,
    backend::AbstractADType,
    x,
    extras::GradientExtras=prepare_gradient(f, backend, x),
)
    return value_and_pullback!(f, grad, backend, x, one(eltype(x)), extras.pullback_extras)
end

function gradient(
    f, backend::AbstractADType, x, extras::GradientExtras=prepare_gradient(f, backend, x)
)
    return pullback(f, backend, x, one(eltype(x)), extras.pullback_extras)
end

function gradient!(
    f,
    grad,
    backend::AbstractADType,
    x,
    extras::GradientExtras=prepare_gradient(f, backend, x),
)
    return pullback!(f, grad, backend, x, one(eltype(x)), extras.pullback_extras)
end
