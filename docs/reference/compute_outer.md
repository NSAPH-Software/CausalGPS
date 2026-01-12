# Computes distance on all possible combinations

Computes the distance between all combination of elements in two vector.
a is vector of size n, and b is a vector of size m, the result, will be
a matrix of size(n,m)

## Usage

``` r
compute_outer(a, b, op)
```

## Arguments

- a:

  first vector (size n)

- b:

  second vector (size m)

- op:

  operator (e.g., '-', '+', '/', ...)

## Value

A n by m matrix that includes abs difference between elements of vector
a and b.
