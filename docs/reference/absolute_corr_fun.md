# Check covariate balance using absolute approach

Checks covariate balance based on absolute correlations for given data
sets.

## Usage

``` r
absolute_corr_fun(w, c)
```

## Arguments

- w:

  A vector of observed continuous exposure variable.

- c:

  A data.frame of observed covariates variable.

## Value

The function returns a list including:

- `absolute_corr`: the absolute correlations for each pre-exposure
  covariates;

- `mean_absolute_corr`: the average absolute correlations for all
  pre-exposure covariates.

## Examples

``` r
set.seed(291)
n <- 100
mydata <- generate_syn_data(sample_size=100)
year <- sample(x=c("2001","2002","2003","2004","2005"),size = n,
 replace = TRUE)
region <- sample(x=c("North", "South", "East", "West"),size = n,
 replace = TRUE)
mydata$year <- as.factor(year)
mydata$region <- as.factor(region)
mydata$cf5 <- as.factor(mydata$cf5)
cor_val <- absolute_corr_fun(mydata[,2], mydata[, 3:length(mydata)])
print(cor_val$mean_absolute_corr)
#> [1] 0.1760572
```
