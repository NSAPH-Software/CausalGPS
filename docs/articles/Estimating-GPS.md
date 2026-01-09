# Estimating GPS

The propensity score (PS) is the conditional probability of assignment
to a particular treatment given a vector of observed covariates
(Rosenbaum and Rubin 1983). Hirano and Imbens (2004) extended the idea
to studies with continuous treatment (or exposure) and labeled it as the
generalized propensity score (GPS), which is a probability density
function. In this package, we use either a parametric model (a standard
linear regression model) or a non-parametric model (a flexible machine
learning model) to train the GPS model as a density estimation procedure
(Kennedy et al. 2017). After the model training, we can estimate GPS
values based on the model prediction. The machine learning models are
developed using the SuperLearner Package (Van der Laan, Polley, and
Hubbard 2007). For more details on the problem framework and
assumptions, please see Wu et al. (2020).

Whether the prediction models’ performance should be considered the
primary parameter in the training of the prediction model is an open
research question. In this package, the users have complete control over
the hyperparameters, which can fine-tune the prediction models to
achieve different performance levels.

## Available SuperLearner Libraries

The users can use any library in the SuperLearner package. However, in
order to have control on internal libraries we generate customized
wrappers. The following table represents the available customized
wrappers as well as hyperparameters.

| Package name | `sl_lib` name | prefix | available hyperparameters |
|:--:|:--:|:--:|:--:|
| [XGBoost](https://xgboost.readthedocs.io/en/latest/index.html) | `m_xgboost` | `xgb_` | nrounds, eta, max_depth, min_child_weight, verbose |
| [ranger](https://cran.r-project.org/package=ranger) | `m_ranger` | `rgr_` | num.trees, write.forest, replace, verbose, family |

## Implementation

Both `XGBoost` and `ranger` libraries are developed for efficient
processing on multiple cores. The only requirement is making sure that
OpenMP is installed on the system. User needs to pass the number of
threads (`nthread`) in running the `estimate_gps` function.

In the following section, we conduct several analyses to test the
scalability and performance. These analyses can be used to have a rough
estimate of what to expect in different data sizes and computational
resources.

## References

Hirano, Keisuke, and Guido W Imbens. 2004. “The Propensity Score with
Continuous Treatments.” *Applied Bayesian Modeling and Causal Inference
from Incomplete-Data Perspectives* 226164: 73–84.
<https://doi.org/10.1002/0470090456.ch7>.

Kennedy, Edward H, Zongming Ma, Matthew D McHugh, and Dylan S Small.
2017. “Nonparametric Methods for Doubly Robust Estimation of Continuous
Treatment Effects.” *Journal of the Royal Statistical Society. Series B,
Statistical Methodology* 79 (4): 1229.
<https://doi.org/10.1111/rssb.12212>.

Rosenbaum, Paul R, and Donald B Rubin. 1983. “The Central Role of the
Propensity Score in Observational Studies for Causal Effects.”
*Biometrika* 70 (1): 41–55.

Van der Laan, Mark J, Eric C Polley, and Alan E Hubbard. 2007. “Super
Learner.” *Statistical Applications in Genetics and Molecular Biology* 6
(1).

Wu, Xiao, Fabrizia Mealli, Marianthi-Anna Kioumourtzoglou, Francesca
Dominici, and Danielle Braun. 2020. “Matching on Generalized Propensity
Scores with Continuous Exposures.” <https://arxiv.org/abs/1812.06575>.
