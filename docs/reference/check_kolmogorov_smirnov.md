# Check Kolmogorov-Smirnov (KS) statistics

Checks the Kolmogorov-Smirnov (KS) statistics for exposure and
confounders in the pseudo-population

## Usage

``` r
check_kolmogorov_smirnov(w, c, ci_appr, counter_weight = NULL)
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

## Value

output object is list including:

- ks_stat

- maximal_val

- mean_val

- median_val
