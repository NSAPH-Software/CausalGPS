# Estimate Parametric Exposure Response Function

Estimate a constant effect size for matched and weighted data set using
parametric models

## Usage

``` r
estimate_pmetric_erf(formula, family, data, ...)
```

## Arguments

- formula:

  a vector of outcome variable in matched set.

- family:

  a description of the error distribution (see ?gnm)

- data:

  dataset that formula is build upon (Note that there should be a
  `counter_weight` column in this data.)

- ...:

  Additional parameters for further fine tuning the gnm model.

## Value

returns an object of class gnm

## Details

This method uses generalized nonlinear model (gnm) from gnm package.
