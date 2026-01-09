# Preprocess data

Preprocess data to isolate extra details

## Usage

``` r
preprocess_data(w, c, trim_quantiles, exposure_col)
```

## Arguments

- w:

  A data.frame comprised of two columns: one contains the observed
  exposure variable, and the other is labeled as 'id'. The column for
  the outcome variable can be assigned any name as per your
  requirements.

- c:

  A data.frame of includes observed covariate variables. It should also
  consist of a column named 'id'.

- exposure_col:

  Column name that is used for exposure.

## Value

A list with preprocessed and original data.
