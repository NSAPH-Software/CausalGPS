# Extend generic plot functions for cgps_pspop class

A wrapper function to extend generic plot functions for cgps_pspop
class.

## Usage

``` r
# S3 method for class 'cgps_pspop'
plot(x, ...)
```

## Arguments

- x:

  A cgps_pspop object.

- ...:

  Additional arguments passed to customize the plot.

## Value

Returns a ggplot2 object, invisibly. This function is called for side
effects.

## Details

### Additional parameters

- *include_details*: If set to TRUE, the plot will include run details
  (Default = FALSE).
