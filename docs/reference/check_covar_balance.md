# Check covariate balance

Checks the covariate balance of original population or pseudo
population.

## Usage

``` r
check_covar_balance(
  w,
  c,
  ci_appr,
  counter_weight = NULL,
  covar_bl_method = "absolute",
  covar_bl_trs = 0.1,
  covar_bl_trs_type = "mean"
)
```

## Arguments

- w:

  A vector of observed continuous exposure variable.

- c:

  A data.frame of observed covariates variable.

- ci_appr:

  The causal inference approach.

- counter_weight:

  A weight vector in different situations. If the matching approach is
  selected, it is an integer data.table of counters. In the case of the
  weighting approach, it is weight data.table.

- covar_bl_method:

  Covariate balance method. Available options: - 'absolute'

- covar_bl_trs:

  Covariate balance threshold.

- covar_bl_trs_type:

  Covariate balance type (mean, median, maximal).

## Value

output object:

- corr_results

  - absolute_corr

  - mean_absolute_corr

- pass (TRUE,FALSE)

## Examples

``` r
# \donttest{
set.seed(422)
n <- 100
mydata <- generate_syn_data(sample_size=n)
year <- sample(x=c("2001","2002","2003","2004","2005"),size = n,
              replace = TRUE)
region <- sample(x=c("North", "South", "East", "West"),size = n,
                replace = TRUE)
mydata$year <- as.factor(year)
mydata$region <- as.factor(region)
mydata$cf5 <- as.factor(mydata$cf5)

m_xgboost <- function(nthread = 1,
                      ntrees = 35,
                      shrinkage = 0.3,
                      max_depth = 5,
                      ...) {SuperLearner::SL.xgboost(
                        nthread = nthread,
                        ntrees = ntrees,
                        shrinkage=shrinkage,
                        max_depth=max_depth,
                        ...)}

data_with_gps <- estimate_gps(.data = mydata,
                              .formula = w ~ cf1 + cf2 + cf3 + cf4 + cf5 +
                                             cf6 + year + region,
                              sl_lib = c("m_xgboost"),
                              gps_density = "kernel")
#> Loading required package: nnls
#> Error in get(library$library$predAlgorithm[s], envir = env): object 'm_xgboost' not found


cw_object_matching <- compute_counter_weight(gps_obj = data_with_gps,
                                             ci_appr = "matching",
                                             bin_seq = NULL,
                                             nthread = 1,
                                             delta_n = 0.1,
                                             dist_measure = "l1",
                                             scale = 0.5)
#> 2026-01-08 20:23:20.966891 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS log_system_info INFO:  System name: Darwin, OS type: unix, machine architecture: arm64, user: naeemkhoshnevis, R version 4.5.2 (2025-10-31), detected cores: 14
#> Error: object 'data_with_gps' not found

pseudo_pop <- generate_pseudo_pop(.data = mydata,
                                  cw_obj = cw_object_matching,
                                  covariate_col_names = c("cf1", "cf2", "cf3",
                                                          "cf4", "cf5", "cf6",
                                                          "year", "region"),
                                  covar_bl_trs = 0.1,
                                  covar_bl_trs_type = "maximal",
                                  covar_bl_method = "absolute")
#> 2026-01-08 20:23:20.992059 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS log_system_info INFO:  System name: Darwin, OS type: unix, machine architecture: arm64, user: naeemkhoshnevis, R version 4.5.2 (2025-10-31), detected cores: 14
#> Error: object 'cw_object_matching' not found


adjusted_corr_obj <- check_covar_balance(w = pseudo_pop$.data[, c("w")],
                                         c = pseudo_pop$.data[ ,
                                         pseudo_pop$params$covariate_col_names],
                                         counter = pseudo_pop$.data[,
                                                     c("counter_weight")],
                                         ci_appr = "matching",
                                         covar_bl_method = "absolute",
                                         covar_bl_trs = 0.1,
                                         covar_bl_trs_type = "mean")
#> Error: object 'pseudo_pop' not found
# }
```
