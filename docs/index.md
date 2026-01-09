# CausalGPS [![](reference/figures/png/causalgps_logo_01.png)](https://NSAPH-Software.github.io/CausalGPS/)

## Summary

An R package for implementing matching, and weighting on generalized
propensity scores with continuous exposures. We developed an innovative
approach for estimating causal effects using observational data in
settings with continuous exposures, and introduce a new framework for
GPS caliper matching that jointly matches on both the estimated GPS and
exposure levels to fully adjust for confounding bias.

## Features

### Estimating GPS

The generalized propensity scores are computed using various parametric
and/or non-parametric models. The generalized propensity scores are used
for the following causal inference approaches.

### Generating Pseudo Population

Pseudo population dataset is computed based on user-defined causal
inference approaches (e.g., matching or weighting). A covariate balance
test is performed on the pseudo population dataset. Users can specify
covariate balance criteria and activate an adaptive approach and number
of attempts to search for a target pseudo population dataset that meets
the covariate balance criteria.

### Outcome Models

Several outcome models can be achieved using the generated pseudo
population dataset. Users can specify non-/semi-parametric models to
obtain exposure-response curves and parametric models to obtain
regression coefficients of interest.

#### Acknowledgments

Funding was provided by the Health Effects Institute grant
4953-RFA14-3/16-4, Environmental Protection Agency grant 83587201-0,
National Institute of Health grants R01 ES026217, R01 MD012769, R01
ES028033, 1R01 ES030616, 1R01 AG066793-01R01, 1R01 ES029950, R01
ES028033-S1, Alfred P. Sloan Foundation grant G-2020-13946.
