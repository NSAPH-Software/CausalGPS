# Estimate Exposure Response Function

Estimates the exposure-response function (ERF) for a matched and
weighted dataset using parametric, semiparametric, and nonparametric
models.

## Usage

``` r
estimate_erf(.data, .formula, weights_col_name, model_type, w_vals, ...)
```

## Arguments

- .data:

  A data frame containing an observed continuous exposure variable,
  weights, and an observed outcome variable. Includes an `id` column for
  future reference.

- .formula:

  A formula specifying the relationship between the exposure variable
  and the outcome variable. For example, Y ~ w.

- weights_col_name:

  A string representing the weight or counter column name in `.data`.

- model_type:

  A string representing the model type based on preliminary assumptions,
  including `parametric`, `semiparametric`, and `nonparametric` models.

- w_vals:

  A numeric vector of values at which you want to calculate the ERF.

- ...:

  Additional arguments passed to the model.

## Value

Returns an S3 object containing the following data and parameters:

- .data_original \<- result_data_original

- .data_prediction \<- result_data_prediction

- params
