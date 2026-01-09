# Estimate hat (fitted) values

Estimates the fitted values based on bandwidth value

## Usage

``` r
estimate_hat_vals(bw, matched_w, w_vals)
```

## Arguments

- bw:

  The bandwidth value.

- matched_w:

  A vector of continuous exposure variable in the matched set.

- w_vals:

  A vector of values that you want to calculate the values of the ERF
  at.

## Value

Returns fitted values, or the prediction made by the model for each
observation.
