# Generate synthetic data for the CausalGPS package

Generates synthetic data set based on different GPS models and
covariates.

## Usage

``` r
generate_syn_data(
  sample_size = 1000,
  outcome_sd = 10,
  gps_spec = 1,
  cova_spec = 1,
  vectorized_y = FALSE
)
```

## Arguments

- sample_size:

  A positive integer number that represents a number of data samples.

- outcome_sd:

  A positive double number that represents standard deviation used to
  generate the outcome in the synthetic data set.

- gps_spec:

  A numerical integer values ranging from 1 to 7. The complexity and
  form of the relationship between covariates and treatment variables
  are determined by the `gps_spec`. Below, you will find a concise
  definition for each of these values:

  - *gps_spec: 1*: The treatment is generated using a normal
    distributionMay 24, 2023
    ([`stats::rnorm`](https://rdrr.io/r/stats/Normal.html)) and a linear
    function of covariates (cf1 to cf6).

  - *gps_spec: 2*: The treatment is generated using a Student's
    t-distribution ([`stats::rt`](https://rdrr.io/r/stats/TDist.html))
    and a linear function of covariates, but is also truncated to be
    within a specific range (-5 to 25).

  - *gps_spec: 3*: The treatment includes a quadratic term for the third
    covariate.

  - *gps_spec: 4*: The treatment is calculated using an exponential
    function within a fraction, creating logistic-like model.

  - *gps_spec: 5*: The treatment also uses logistic-like model but with
    different parameters.

  - *gps_spec: 6*: The treatment is calculated using the natural
    logarithm of the absolute value of a linear combination of the
    covariates.

  - *gps_spec: 7*: The treatment is generated similarly to
    `gps_spec = 2`, but without truncation.

- cova_spec:

  A numerical value (1 or 2) to modify the covariates. It determines how
  the covariates in the synthetic data set are transformed. If
  `cova_spec` equals 2, the function applies non-linear transformation
  to the covariates, which can add complexity to the relationships
  between covariates and outcomes in the synthetic data. See the code
  for more details.

- vectorized_y:

  A Boolean value indicates how Y internally is generated. (Default =
  `FALSE`). This parameter is introduced for backward compatibility.
  vectorized_y = `TRUE` performs better.

## Value

`synthetic_data`: The function returns a data.frame saved the
constructed synthetic data.

## Examples

``` r
set.seed(298)
s_data <- generate_syn_data(sample_size = 100,
                            outcome_sd = 10,
                            gps_spec = 1,
                            cova_spec = 1)
```
