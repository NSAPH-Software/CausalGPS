# Check estimate_gps function arguments

Checks estimate_gps function arguments to make sure that the required
additional arguments are provided.

## Usage

``` r
check_args_estimate_gps(gps_density, ...)
```

## Arguments

- gps_density:

  Model type which is used for estimating GPS value, including `normal`
  and `kernel`.

- ...:

  Additional arguments to successfully run the process.

## Value

Returns True if passes all checks, successfully. Otherwise raises ERROR.
