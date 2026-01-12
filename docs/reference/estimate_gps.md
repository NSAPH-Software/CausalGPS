# Estimate generalized propensity score (GPS) values

Estimates GPS value for each observation using normal or kernel
approaches.

## Usage

``` r
estimate_gps(
  .data,
  .formula,
  gps_density = "normal",
  sl_lib = c("SL.xgboost"),
  ...
)
```

## Arguments

- .data:

  A data frame of observed continuous exposure variable and observed
  covariates variable. Also includes `id` column for future references.

- .formula:

  A formula specifying the relationship between the exposure variable
  and the covariates. For example, w ~ I(cf1^2) + cf2.

- gps_density:

  Model type which is used for estimating GPS value, including `normal`
  (default) and `kernel`.

- sl_lib:

  A vector of prediction algorithms to be used by the SuperLearner
  packageg.

- ...:

  Additional arguments passed to the model.

## Value

The function returns a S3 object. Including the following:

- `.data `: `id`, `exposure_var`, `gps`, `e_gps_pred`, `e_gps_std_pred`,
  `w_resid`

- `params`: Including the following fields:

  - gps_mx (min and max of gps)

  - w_mx (min and max of w).

  - .formula

  - gps_density

  - sl_lib

  - fcall (function call)

## Examples

``` r
# \donttest{
m_d <- generate_syn_data(sample_size = 100)
data_with_gps <- estimate_gps(.data = m_d,
                              .formula = w ~ cf1 + cf2 + cf3 + cf4 + cf5 + cf6,
                              gps_density = "normal",
                              sl_lib = c("SL.xgboost")
                             )
# }
```
