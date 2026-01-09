# Put original data into package standard data

This is a temporal function to convert original data into a package
standard data. This function will be removed after addressing issue
\#67: "convert accessing data from column index to column name \#67"

## Usage

``` r
convert_data_into_standard_format(Y, w, c, q1, q2, ci_appr)
```

## Arguments

- Y:

  Output vector

- w:

  Treatment or exposure vector

- c:

  Covariate matrix

- ci_appr:

  Causal Inference approach

## Value

Original data with place holder columns.
