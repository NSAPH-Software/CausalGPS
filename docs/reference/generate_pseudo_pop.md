# Generate pseudo population

Generates pseudo population data set based on user-defined causal
inference approach. The function uses an adaptive approach to satisfies
covariate balance requirements. The function terminates either by
satisfying covariate balance or completing the requested number of
iteration, whichever comes first.

## Usage

``` r
generate_pseudo_pop(
  .data,
  cw_obj,
  covariate_col_names,
  covar_bl_trs = 0.1,
  covar_bl_trs_type = "maximal",
  covar_bl_method = "absolute"
)
```

## Arguments

- .data:

  A data.frame of observation data with `id` column.

- cw_obj:

  An S3 object of counter_weight.

- covariate_col_names:

  A list of covariate columns.

- covar_bl_trs:

  Covariate balance threshold

- covar_bl_trs_type:

  Type of the covariance balance threshold.

- covar_bl_method:

  Covariate balance method.

## Value

Returns a pseudo population (gpsm_pspop) object that is generated or
augmented based on the selected causal inference approach (ci_appr). The
object includes the following objects:

- params

  - ci_appr

  - params

- pseudo_pop

- adjusted_corr_results

- original_corr_results

- best_gps_used_params

- effect size of generated pseudo population

## Examples

``` r
# \donttest{

set.seed(967)

m_d <- generate_syn_data(sample_size = 200)
m_d$id <- seq_along(1:nrow(m_d))

m_xgboost <- function(nthread = 4,
                      ntrees = 35,
                      shrinkage = 0.3,
                      max_depth = 5,
                      ...) {SuperLearner::SL.xgboost(
                        nthread = nthread,
                        ntrees = ntrees,
                        shrinkage=shrinkage,
                        max_depth=max_depth,
                        ...)}

data_with_gps_1 <- estimate_gps(
  .data = m_d,
  .formula = w ~ I(cf1^2) + cf2 + I(cf3^2) + cf4 + cf5 + cf6,
  sl_lib = c("m_xgboost"),
  gps_density = "normal")
#> Error in get(library$library$predAlgorithm[s], envir = env): object 'm_xgboost' not found

cw_object_matching <- compute_counter_weight(gps_obj = data_with_gps_1,
                                             ci_appr = "matching",
                                             bin_seq = NULL,
                                             nthread = 1,
                                             delta_n = 0.1,
                                             dist_measure = "l1",
                                             scale = 0.5)
#> 2026-01-08 20:23:25.757004 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS log_system_info INFO:  System name: Darwin, OS type: unix, machine architecture: arm64, user: naeemkhoshnevis, R version 4.5.2 (2025-10-31), detected cores: 14
#> Error: object 'data_with_gps_1' not found

pseudo_pop <- generate_pseudo_pop(.data = m_d,
                                  cw_obj = cw_object_matching,
                                  covariate_col_names = c("cf1", "cf2",
                                                          "cf3", "cf4",
                                                          "cf5", "cf6"),
                                  covar_bl_trs = 0.1,
                                  covar_bl_trs_type = "maximal",
                                  covar_bl_method = "absolute")
#> 2026-01-08 20:23:25.778731 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS log_system_info INFO:  System name: Darwin, OS type: unix, machine architecture: arm64, user: naeemkhoshnevis, R version 4.5.2 (2025-10-31), detected cores: 14
#> Error: object 'cw_object_matching' not found

# }
```
