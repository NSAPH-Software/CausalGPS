# Smooth exposure response function

Smooths exposure response function based on bandwidth

## Usage

``` r
smooth_erf(matched_Y, bw, matched_w, matched_cw, x_eval, kernel_appr)
```

## Arguments

- matched_Y:

  A vector of the outcome variable in the matched set.

- bw:

  The bandwidth value.

- matched_w:

  A vector of continuous exposure variable in the matched set.

- matched_cw:

  A vector of counter or weight variable in the matched set.

- kernel_appr:

  Internal kernel approach. Available options are `locpol` and
  `kernsmooth`.

## Value

Smoothed value of ERF
