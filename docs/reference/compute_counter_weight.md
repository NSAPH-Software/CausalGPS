# Compute counter or weight of data samples

Computes counter (for matching approach) or weight (for weighting)
approach.

## Usage

``` r
compute_counter_weight(gps_obj, ci_appr, nthread = 1, ...)
```

## Arguments

- gps_obj:

  A gps object that is generated with `estimate_gps` function. If it is
  provided, the number of iteration will forced to 1 (Default: NULL).

- ci_appr:

  The causal inference approach. Possible values are:

  - "matching": Matching by GPS

  - "weighting": Weighting by GPS

- nthread:

  An integer value that represents the number of threads to be used by
  internal packages.

- ...:

  Additional arguments passed to different models.

## Value

Returns a counter_weight (cgps_cw) object that includes `.data` and
`params` attributes.

- `.data`: includes `id` and `counter_weight` columns. In case of
  `matching` the `counter_weight` column is integer values, which
  represent how many times the provided observational data was mached
  during the matching process. In case of `weighting` the column is
  double values.

- `params`: Include related parameters that is used for the process.

## Details

### Additional parameters

#### Causal Inference Approach (ci_appr)

- if ci_appr = 'matching':

  - *bin_seq*: A sequence of w (treatment) to generate pseudo
    population. If `NULL` is passed the default value will be used,
    which is `seq(min(w)+delta_n/2,max(w), by=delta_n)`.

  - *dist_measure*: Matching function. Available options:

    - l1: Manhattan distance matching

  - *delta_n*: caliper parameter.

  - *scale*: a specified scale parameter to control the relative weight
    that is attributed to the distance measures of the exposure versus
    the GPS.

## Examples

``` r
# \donttest{
m_d <- generate_syn_data(sample_size = 100)
gps_obj <- estimate_gps(.data = m_d,
                        .formula = w ~ cf1 + cf2 + cf3 + cf4 + cf5 + cf6,
                        gps_density = "normal",
                        sl_lib = c("SL.xgboost"))

cw_object <- compute_counter_weight(gps_obj = gps_obj,
                                    ci_appr = "matching",
                                    bin_seq = NULL,
                                    nthread = 1,
                                    delta_n = 0.1,
                                    dist_measure = "l1",
                                    scale = 0.5)
#> 2026-01-08 20:23:22.626996 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS log_system_info INFO:  System name: Darwin, OS type: unix, machine architecture: arm64, user: naeemkhoshnevis, R version 4.5.2 (2025-10-31), detected cores: 14
#> 2026-01-08 20:23:22.652181 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS compile_pseudo_pop INFO:  Starting compiling pseudo population  (original data size: 100) ... 
#> 2026-01-08 20:23:22.656708 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -6.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.657113 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -6.05212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.65748 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.95212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.657837 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.85212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.658194 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.75212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.658544 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.65212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.658894 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.55212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.659254 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.45212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.65961 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.35212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.659976 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.25212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.660329 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.660688 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -5.05212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.661046 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.95212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.661413 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.85212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.661757 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.75212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.662103 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.65212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.662449 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.55212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.662799 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.45212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.663758 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.25212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.664107 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.664448 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -4.05212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.664789 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.95212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.665133 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.85212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.66548 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.75212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.665833 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.65212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.666201 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.55212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.66655 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.45212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.666896 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.35212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.667241 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.25212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.667586 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -3.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.668489 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.95212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.668848 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.85212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.669208 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.75212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.669563 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.65212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.669918 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.55212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.670274 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.45212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.670627 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.35212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.671567 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -2.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.673162 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.85212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.673507 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.75212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.673841 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.65212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.674179 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.55212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.674526 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.45212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.674858 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.35212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.675194 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.25212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.675514 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.15212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.675843 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -1.05212932972485 in  0.05  radius.
#> 2026-01-08 20:23:22.676171 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.952129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.676492 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.852129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.676829 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.752129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.677166 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.652129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.6775 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.552129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.677843 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.452129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.679328 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.152129329724849 in  0.05  radius.
#> 2026-01-08 20:23:22.679655 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  -0.0521293297248491 in  0.05  radius.
#> 2026-01-08 20:23:22.679979 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.0478706702751515 in  0.05  radius.
#> 2026-01-08 20:23:22.681336 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.347870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.681662 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.447870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.681984 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.547870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.682309 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.647870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.682634 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.747870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.682965 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  0.847870670275151 in  0.05  radius.
#> 2026-01-08 20:23:22.684394 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.14787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.68472 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.685035 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.34787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.685357 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.685688 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.686033 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.64787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.686941 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.84787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.687334 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  1.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.688702 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.68904 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.34787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.689871 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.690202 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.64787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.690524 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.74787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.691359 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  2.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.691684 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.04787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.692033 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.14787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.692935 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.34787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.69331 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.693679 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.694511 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.74787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.694837 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  3.84787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.695654 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.04787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.69666 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.697731 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.698147 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.698517 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.64787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.699917 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  4.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.700248 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.04787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.700576 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.14787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.700901 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.701747 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.702086 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.703527 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  5.84787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.704351 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.04787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.704674 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.14787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.705001 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.706016 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.720792 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.721221 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.64787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.721542 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.74787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.722541 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  6.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.722881 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  7.04787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.72484 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  7.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.725168 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  7.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.726456 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  7.84787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.72679 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  7.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.727607 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  8.14787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.727931 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  8.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.728776 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  8.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.730094 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  8.74787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.730952 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  8.94787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.732324 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.24787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.732672 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.34787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.732981 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.44787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.73329 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.54787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.734094 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.74787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.734416 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  9.84787067027515 in  0.05  radius.
#> 2026-01-08 20:23:22.735719 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  10.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.736581 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  10.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.736906 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  10.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.737723 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  10.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.739528 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  11.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.739852 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  11.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.742239 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  11.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.74322 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  11.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.743558 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  11.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.743897 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.744743 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.746593 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.746917 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.74726 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.747574 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  12.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.747891 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  13.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.748234 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  13.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.749107 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  13.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.749996 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  13.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.752708 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.753028 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.753341 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.754135 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.754454 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.755264 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.755599 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.755932 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  14.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.75627 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.756611 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.756953 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.757758 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.75808 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.758395 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.758711 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.75951 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  15.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.760813 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.761133 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.76145 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.762311 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.762656 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.762981 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.763304 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  16.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.764122 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.764456 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.764799 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.76515 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.765496 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.766371 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.766702 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.767027 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  17.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.767351 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.76821 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.768562 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.76945 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.769805 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.770151 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.771049 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  18.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.771412 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.771759 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.772103 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.772427 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.772786 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.773124 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.773463 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.773804 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.77416 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.774523 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  19.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.775476 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.77583 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.776172 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.776517 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.776877 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.777222 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.777564 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.777908 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.778236 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  20.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.778578 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.778918 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.779258 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.7796 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.779962 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.780327 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.780685 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.781048 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.781411 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.781778 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  21.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.782146 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.782489 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.782841 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.7832 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.783557 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.783921 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.784319 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.784675 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.78562 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  22.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.785985 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.786349 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.786711 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.78708 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.3478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.787443 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.4478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.787803 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.5478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.788166 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.6478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.788528 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.7478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.78889 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.8478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.789261 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  23.9478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.789626 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  24.0478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.789988 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  24.1478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.790355 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS FUN WARN:  There is no data to match with  24.2478706702752 in  0.05  radius.
#> 2026-01-08 20:23:22.889498 HUIT-HUITADMINs-MacBook-Pro 89651 CausalGPS compile_pseudo_pop INFO:  Finished compiling pseudo population  (Pseudo population data size: 100)
# }
```
