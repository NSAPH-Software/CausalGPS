# Compute risk value

Calculates the cross-validated risk for the optimal bandwidth selection
in kernel smoothing approach.

## Usage

``` r
compute_risk(h, matched_Y, matched_w, matched_cw, x_eval, w_vals, kernel_appr)
```

## Arguments

- h:

  A scalar representing the bandwidth value.

- matched_Y:

  A vector of outcome variable in the matched set.

- matched_w:

  A vector of continuous exposure variable in the matched set.

- matched_cw:

  A vector of counter or weight variable in the matched set.

- w_vals:

  A vector of values that you want to calculate the values of the ERF
  at.

- kernel_appr:

  Internal kernel approach. Available options are `locpol` and
  `kernsmooth`.

## Value

returns a cross-validated risk value for the input bandwidth
