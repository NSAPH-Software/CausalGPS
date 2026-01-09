# Check additional arguments

Checks additional arguments that user needs to provide for different
prediction models.

## Usage

``` r
check_args(
  ci_appr,
  use_cov_transform,
  transformers,
  gps_density,
  trim_quantiles,
  ...
)
```

## Arguments

- ci_appr:

  The causal inference approach.

- use_cov_transform:

  A logical value (TRUE/FALSE) to use covariate balance transforming.

- transformers:

  A list of transformers.

- ...:

  Additional named arguments passed.

## Value

TRUE if requirements are met. Raises error otherwise.
