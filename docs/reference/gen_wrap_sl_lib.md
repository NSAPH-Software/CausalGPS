# Generate customized wrapper for SuperLearner libraries

The function generates customized wrapper in order to have access to the
external libraries hyperparameters.

## Usage

``` r
gen_wrap_sl_lib(lib_name, params, nthread)
```

## Arguments

- lib_name:

  The library name (e.g., `m_xgboost`).

- params:

  A list that includes key-values for different parameters. Only
  relevant parameters will be extracted, others will be ignored.

- nthread:

  Number of threads available to be used by external libraries (in case
  they can use it).

## Value

Returns a list of TRUE and best used parameters, if the modified library
for the given library is implemented; otherwise, it returns a list of
FALSE. This function is also called for side effects.
