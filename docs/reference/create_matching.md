# Create pseudo population using matching casual inference approach

Generates pseudo population based on matching casual inference method.

## Usage

``` r
create_matching(
  .data,
  exposure_col_name,
  matching_fn,
  dist_measure = dist_measure,
  gps_density = gps_density,
  delta_n = delta_n,
  scale = scale,
  bin_seq = NULL,
  nthread = 1
)
```

## Arguments

- .data:

  TBD

- gps_density:

  Model type which is used for estimating GPS value, including `normal`
  (default) and `kernel`.

- bin_seq:

  Sequence of w (treatment) to generate pseudo population. If NULL is
  passed the default value will be used, which is
  `seq(min(w)+delta_n/2,max(w), by=delta_n)`.

- nthread:

  Number of available cores.

## Value

Returns data.table of matched set.
