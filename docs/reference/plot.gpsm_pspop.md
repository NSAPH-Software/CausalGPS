# Extend generic plot functions for gpsm_erf class

A wrapper function to extend generic plot functions for gpsm_erf class.

## Usage

``` r
# S3 method for gpsm_pspop
plot(x, ...)
```

## Arguments

- x:

  A gpsm_erf object.

- ...:

  Additional arguments passed to customize the plot.

## Value

Returns a ggplot2 object, invisibly. This function is called for side
effects.

## Details

### Additional parameters

- *include_details*: If set to TRUE, the plot will include run details
  (Default = FALSE).
