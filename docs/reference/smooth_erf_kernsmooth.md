# Compute smoothed erf with kernsmooth approach

Compute smoothed erf with kernsmooth approach

## Usage

``` r
smooth_erf_kernsmooth(matched_Y, matched_w, matched_cw, x_eval, bw)
```

## Arguments

- matched_Y:

  A vector of outcome value.

- matched_w:

  A vector of treatment value.

- matched_cw:

  A vector of weight or count.

- bw:

  A scaler number indicating the bandwidth.

## Value

A vector of smoothed ERF.
