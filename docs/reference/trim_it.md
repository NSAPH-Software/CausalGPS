# Trim a data frame or an S3 object

Trims a data frame or an S3 object's `.data` attributs.

## Usage

``` r
trim_it(data_obj, trim_quantiles, variable)
```

## Arguments

- data_obj:

  A data frame or an S3 object containing the data to be trimmed. For a
  data frame, the function operates directly on it. For an S3 object,
  the function expects a `.data` attribute containing the data.

- trim_quantiles:

  A numeric vector of length 2 specifying the lower and upper quantiles
  used for trimming the data.

- variable:

  The name of the variable in the data on which the trimming is to be
  applied.

## Value

Returns a trimmed data frame or an S3 object with the \$.data attribute
trimmed, depending on the input type.

## Examples

``` r
# Example usage with a data frame
df <- data.frame(id = 1:10, value = rnorm(100))
trimmed_df <- trim_it(df, c(0.1, 0.9), "value")

# Example usage with an S3 object
data_obj <- list()
class(data_obj) <- "myobject"
data_obj$.data <- df
trimmed_data_obj <- trim_it(data_obj, c(0.1, 0.9), "value")
```
