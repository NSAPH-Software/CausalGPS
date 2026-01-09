# Estimate smoothed exposure-response function (ERF) for pseudo population

Estimate smoothed exposure-response function (ERF) for matched and
weighted data set using non-parametric models.

## Usage

``` r
estimate_npmetric_erf(
  m_Y,
  m_w,
  counter_weight,
  bw_seq,
  w_vals,
  nthread,
  kernel_appr = "locpol"
)
```

## Arguments

- m_Y:

  A vector of outcome variable in the matched set.

- m_w:

  A vector of continuous exposure variable in the matched set.

- counter_weight:

  A vector of counter or weight variable in the matched set.

- bw_seq:

  A vector of bandwidth values.

- w_vals:

  A vector of values that you want to calculate the values of the ERF
  at.

- nthread:

  The number of available cores.

- kernel_appr:

  Internal kernel approach. Available options are `locpol` and
  `kernsmooth`.

## Value

The function returns a gpsm_erf object. The object includes the
following attributes:

- params

- m_Y

- m_w

- bw_seq

- w_vals

- erf

- fcall

## Details

Estimate Functions Using Local Polynomial kernel regression.
