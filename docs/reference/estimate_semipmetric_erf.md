# Estimate semi-exposure-response function (semi-ERF).

Estimates the smoothed exposure-response function using a generalized
additive model with splines.

## Usage

``` r
estimate_semipmetric_erf(formula, family, data, ...)
```

## Arguments

- formula:

  a vector of outcome variable in matched set.

- family:

  a description of the error distribution (see ?gam).

- data:

  dataset that formula is build upon Note that there should be a
  `counter_weight` column in this data.).

- ...:

  Additional parameters for further fine tuning the gam model.

## Value

returns an object of class gam

## Details

This approach uses Generalized Additive Model (gam) using mgcv package.
