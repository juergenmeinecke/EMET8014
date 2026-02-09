using Distributions
using LinearAlgebra

#=
EMET 8014 Functions File (Student Version)
==========================================
This file collects all the estimation functions you will build throughout the course.
Fill in the parts marked "YOUR CODE HERE" as you progress through the labs.
=#


"""
    lm_ols(Y, X)

Compute OLS estimates with heteroskedasticity-robust standard errors.

# Arguments
- `Y`: N×1 vector of dependent variable
- `X`: N×K matrix of regressors (should include constant)

# Returns
- `β_hat`: K×1 vector of coefficient estimates
- `Ω_hat_over_N`: K×K estimated asymptotic variance of β̂ (robust)

# Notes
Uses the sandwich formula with degrees-of-freedom correction (HC1):
    Ω̂/N = (N/(N-K)) (X'X)⁻¹ X'DX (X'X)⁻¹
where D = diag(û₁², ..., ûₙ²).
"""
function lm_ols(Y::Vector{Float64}, X::Matrix{Float64})
    N, K = size(X)
    
    # OLS estimator: use backslash for numerical stability
    β_hat = nothing  # YOUR CODE HERE
    
    # Residuals
    u_hat = nothing  # YOUR CODE HERE
    
    # Sandwich formula: bread * meat * bread
    bread = nothing  # YOUR CODE HERE: inv(X' * X)
    meat = nothing   # YOUR CODE HERE: X' * Diagonal(u_hat.^2) * X
    Ω_hat_over_N = nothing  # YOUR CODE HERE: (N / (N - K)) * bread * meat * bread
    
    return β_hat, Ω_hat_over_N
end


"""
    lm_inference(β_hat, Ω_hat_over_N)

Compute standard errors, t-statistics, and p-values from estimates and variance matrix.

# Arguments
- `β_hat`: K×1 vector of coefficient estimates
- `Ω_hat_over_N`: K×K estimated asymptotic variance of β̂

# Returns
- `se`: K×1 vector of standard errors
- `t`: K×1 vector of t-statistics (β̂/se)
- `p`: K×1 vector of p-values (using Normal approximation)
"""
function lm_inference(β_hat::Vector{Float64}, Ω_hat_over_N::Matrix{Float64})
    # Standard errors: square root of diagonal elements
    se = nothing  # YOUR CODE HERE: sqrt.(diag(...))
    
    # t-statistics
    t = nothing  # YOUR CODE HERE: β_hat ./ se
    
    # Two-sided p-values using normal approximation
    p = nothing  # YOUR CODE HERE: 2 * (1 .- cdf.(Normal(), abs.(t)))
    
    return se, t, p
end


"""
    lm_iv(Y, X1, X2, Z1, Z2)

Estimate linear model by IV with heteroskedasticity-robust standard errors.

Model: Y = X1 β₁ + X2 β₂ + u, where X2 is endogenous
Instruments: Z = (Z1, Z2) where Z1 = X1 and Z2 are excluded instruments

# Arguments
- `Y`: N×1 dependent variable
- `X1`: N×K₁ exogenous regressors (including constant)
- `X2`: N×1 endogenous regressor (or N×K₂ matrix)
- `Z1`: N×K₁ included instruments (typically Z1 = X1)
- `Z2`: N×L₂ excluded instruments

# Returns
- `β_hat`: K×1 coefficient estimates, with β₂ (endogenous) at the END
- `Ω_hat_over_N`: K×K estimated asymptotic variance of β̂ (robust)

# Notes
For the just-identified case (dim(Z) = dim(X)), this is the standard IV estimator:
    β̂ = (Z'X)⁻¹ Z'Y
Variance uses the sandwich formula with df correction:
    Ω̂/N = (N/(N-K)) (Z'X)⁻¹ Z'DZ (X'Z)⁻¹
where D = diag(û₁², ..., ûₙ²) and û = Y - Xβ̂.
"""
function lm_iv(Y::Vector{Float64}, X1::Matrix{Float64}, X2::Union{Vector{Float64}, Matrix{Float64}},
               Z1::Matrix{Float64}, Z2::Union{Vector{Float64}, Matrix{Float64}})
    
    # Construct full X and Z matrices (endogenous regressor at end)
    X = Matrix{Float64}(hcat(X1, X2))
    Z = Matrix{Float64}(hcat(Z1, Z2))
    N, K = size(X)
    
    # IV estimator: β = (Z'X)⁻¹ Z'Y
    β_hat = nothing  # YOUR CODE HERE: (Z' * X) \ (Z' * Y)
    
    # Residuals (using original X, not predicted X)
    u_hat = nothing  # YOUR CODE HERE
    
    # Robust variance: bread * meat * bread'
    bread = nothing  # YOUR CODE HERE: inv(Z' * X)
    meat = nothing   # YOUR CODE HERE: Z' * Diagonal(u_hat.^2) * Z
    Ω_hat_over_N = nothing  # YOUR CODE HERE: (N / (N - K)) * bread * meat * bread'
    
    return β_hat, Ω_hat_over_N
end


"""
    lm_2sls(Y, X1, X2, Z1, Z2)

Estimate linear model by Two-Stage Least Squares with robust standard errors.

Model: Y = X1 β₁ + X2 β₂ + u, where X2 is endogenous
Instruments: Z = (Z1, Z2)

# Arguments
- `Y`: N×1 dependent variable
- `X1`: N×K₁ exogenous regressors (including constant)
- `X2`: N×1 endogenous regressor (or N×K₂ matrix)
- `Z1`: N×K₁ included instruments (typically Z1 = X1)
- `Z2`: N×L₂ excluded instruments

# Returns
- `β_hat`: K×1 coefficient estimates, with β₂ (endogenous) at the END
- `Ω_hat_over_N`: K×K estimated asymptotic variance of β̂ (robust)

# Notes
The 2SLS estimator is:
    β̂ = (X'PzX)⁻¹ X'PzY  where Pz = Z(Z'Z)⁻¹Z'
Variance uses the sandwich formula with df correction:
    Ω̂/N = (N/(N-K)) (X'PzX)⁻¹ X'Pz D Pz X (X'PzX)⁻¹
The variance formula uses original residuals û = Y - Xβ̂, not predicted residuals.
Using predicted residuals would understate variance.
"""
function lm_2sls(Y::Vector{Float64}, X1::Matrix{Float64}, X2::Union{Vector{Float64}, Matrix{Float64}},
                 Z1::Matrix{Float64}, Z2::Union{Vector{Float64}, Matrix{Float64}})
    
    # Construct full matrices
    X = Matrix{Float64}(hcat(X1, X2))
    Z = Matrix{Float64}(hcat(Z1, Z2))
    N, K = size(X)
    
    # Compute projections efficiently: avoid forming the N×N matrix Pz = Z(Z'Z)⁻¹Z'
    # Instead, compute X'PzX and X'PzY directly using K×L and L×L matrices
    ZtZ_inv = nothing  # YOUR CODE HERE: inv(Z' * Z)
    XtZ = nothing      # YOUR CODE HERE: X' * Z
    ZtY = nothing      # YOUR CODE HERE: Z' * Y
    
    # 2SLS estimator: β = (X'PzX)⁻¹ X'PzY = (X'Z (Z'Z)⁻¹ Z'X)⁻¹ X'Z (Z'Z)⁻¹ Z'Y
    XtPzX = nothing    # YOUR CODE HERE: XtZ * ZtZ_inv * XtZ'
    XtPzY = nothing    # YOUR CODE HERE: XtZ * ZtZ_inv * ZtY
    β_hat = nothing    # YOUR CODE HERE: XtPzX \ XtPzY
    
    # Residuals (use original X, not X̂)
    u_hat = nothing    # YOUR CODE HERE
    
    # Robust variance: bread * meat * bread
    # meat = X'Pz D Pz X = X'Z (Z'Z)⁻¹ Z'DZ (Z'Z)⁻¹ Z'X
    ZtDZ = nothing     # YOUR CODE HERE: Z' * Diagonal(u_hat.^2) * Z
    meat = nothing     # YOUR CODE HERE: XtZ * ZtZ_inv * ZtDZ * ZtZ_inv * XtZ'
    bread = nothing    # YOUR CODE HERE: inv(XtPzX)
    Ω_hat_over_N = nothing  # YOUR CODE HERE: (N / (N - K)) * bread * meat * bread
    
    return β_hat, Ω_hat_over_N
end


"""
    lm_2sls_ftest(Y, X1, X2, Z1, Z2)

Compute the first-stage F-statistic for testing weak instruments.

Tests H₀: coefficients on excluded instruments Z2 are jointly zero
in the first-stage regression X2 = Z π + v.

# Arguments
- Same as lm_2sls

# Returns
- `F`: F-statistic (should exceed 10 by Stock-Yogo rule of thumb)

# Notes
Uses heteroskedasticity-robust Wald test:
    F = (π₂)' [V₂₂]⁻¹ (π₂) / L₂
where π₂ are the coefficients on excluded instruments and V₂₂ is 
the corresponding block of the variance matrix.
"""
function lm_2sls_ftest(Y::Vector{Float64}, X1::Matrix{Float64}, X2::Union{Vector{Float64}, Matrix{Float64}},
                       Z1::Matrix{Float64}, Z2::Union{Vector{Float64}, Matrix{Float64}})
    
    # Dimensions
    K1 = size(X1, 2)
    L2 = ndims(Z2) == 1 ? 1 : size(Z2, 2)
    
    # Full instrument matrix
    Z = Matrix{Float64}(hcat(Z1, Z2))
    
    # First-stage regression
    X2_vec = X2 isa Vector ? X2 : X2[:, 1]
    π_hat, V = lm_ols(Vector{Float64}(X2_vec), Z)
    
    # Select coefficients on excluded instruments (last L2 elements)
    π2 = π_hat[end-L2+1:end]
    V22 = V[end-L2+1:end, end-L2+1:end]
    
    # F-statistic: (π2)' (V22)⁻¹ (π2) / L2
    F = nothing  # YOUR CODE HERE: (π2' * inv(V22) * π2) / L2
    
    return F
end
