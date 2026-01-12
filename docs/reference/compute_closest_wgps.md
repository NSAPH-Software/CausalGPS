# Find the closest data in subset to the original data

A function to compute the closest data in subset of data to the original
data based on two attributes: vector and scalar (vector of size one).

## Usage

``` r
compute_closest_wgps(a, b, c, d, sc, nthread)
```

## Arguments

- a:

  Vector of the first attribute values for subset of data.

- b:

  Vector of the first attribute values for all data.

- c:

  Vector of the second attribute values for subset of data.

- d:

  Vector of size one for the second attribute value.

- sc:

  Scale parameter to give weight for two mentioned measurements.

- nthread:

  Number of available cores.

## Value

The function returns index of subset data that is closest to the
original data sample.
