# Check Weighted Covariate Balance Using Absolute Approach

Checks covariate balance based on absolute weighted correlations for
given data sets.

## Usage

``` r
absolute_weighted_corr_fun(w, vw, c)
```

## Arguments

- w:

  A vector of observed continuous exposure variable.

- vw:

  A vector of weights.

- c:

  A data.table of observed covariates variable.

## Value

The function returns a list saved the measure related to covariate
balance `absolute_corr`: the absolute correlations for each pre-exposure
covairates; `mean_absolute_corr`: the average absolute correlations for
all pre-exposure covairates.

## Examples

``` r
set.seed(639)
n <- 100
mydata <- generate_syn_data(sample_size=100)
year <- sample(x=c("2001","2002","2003","2004","2005"),size = n,
               replace = TRUE)
region <- sample(x=c("North", "South", "East", "West"),size = n,
                 replace = TRUE)
mydata$year <- as.factor(year)
mydata$region <- as.factor(region)
mydata$cf5 <- as.factor(mydata$cf5)
cor_val <- absolute_weighted_corr_fun(mydata[,2],
                                      runif(n),
                                      mydata[, 3:length(mydata)])
print(cor_val$mean_absolute_corr)
#> [1] 0.1409821
```
