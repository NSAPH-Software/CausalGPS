# Create pseudo population using weighting casual inference approach

Generates pseudo population based on weighting casual inference method.

## Usage

``` r
create_weighting(dataset, exposure_col_name)
```

## Arguments

- dataset:

  A gps object data.

- exposure_col_name:

  The exposure column name.

## Value

Returns a data table which includes the following columns:

- Y

- w

- gps

- counter

- row_index

- ipw

- covariates
