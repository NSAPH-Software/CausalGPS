# Match observations

Matching function using L1 distance on single exposure level w

## Usage

``` r
matching_l1(
  w,
  dataset,
  exposure_col_name,
  e_gps_pred,
  e_gps_std_pred,
  w_resid,
  gps_mx,
  w_mx,
  gps_density = "normal",
  delta_n = 1,
  scale = 0.5,
  nthread = 1
)
```

## Arguments

- w:

  the targeted single exposure levels.

- dataset:

  a completed observational data frame or matrix containing (Y, w, gps,
  counter, row_index, c).

- e_gps_pred:

  a vector of predicted gps values obtained by Machine learning methods.

- e_gps_std_pred:

  a vector of predicted std of gps obtained by Machine learning methods.

- w_resid:

  the standardized residuals for w.

- gps_mx:

  a vector with length 2, includes min(gps), max(gps)

- w_mx:

  a vector with length 2, includes min(w), max(w).

- gps_density:

  Model type which is used for estimating GPS value, including `normal`
  (default) and `kernel`.

- delta_n:

  a specified caliper parameter on the exposure (Default is 1).

- scale:

  a specified scale parameter to control the relative weight that is
  attributed to the distance measures of the exposure versus the GPS
  estimates (Default is 0.5).

- nthread:

  Number of available cores.

## Value

`dp`: The function returns a data.table saved the matched points on by
single exposure level w by the proposed GPS matching approaches.
