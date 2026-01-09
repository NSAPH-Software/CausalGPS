# Extend generic plot functions for cgps_cw class

A wrapper function to extend generic plot functions for cgps_cw class.

## Usage

``` r
# S3 method for class 'cgps_cw'
plot(x, ...)
```

## Arguments

- x:

  A cgps_cw object.

- ...:

  Additional arguments passed to customize the plot.

## Value

Returns a ggplot2 object, invisibly. This function is called for side
effects.

## Details

Additional parameters:

- *every_n*: Puts label to ID at every n interval (default = 10)

- *subset_id*: A vector of range of ids to be included in the plot
  (default = NULL)
