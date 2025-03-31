library(CausalGPS)
library(data.table)
library(SuperLearner)
library(foreach) # Install this package.
library(doParallel)

# Load dataset
load("study_data.RData")
confounders <- c("cf1", "cf2", "cf3", "cf4", "cf5", "cf6")

# Define covariate transformation formulas
formulas <- list(
  "w ~ I(cf1^2) + cf2 + I(cf3^2) + cf4 + cf5 + cf6",
  "w ~ cf1 + cf2 + cf3 + cf4 + cf5 + cf6",
  "w ~ I(cf1^2) + I(cf2^2) + cf3 + cf4 + cf5 + cf6"
)

# Define xgboost hyperparameters
xgboost_params <- expand.grid(
  ntrees = c(25, 35),
  shrinkage = c(0.1, 0.3),
  max_depth = c(4, 6),
  minobspernode = c(1, 5),
  stringsAsFactors = FALSE
)

# Setup parallel backend
num_cores <- parallel::detectCores() - 1
cl <- makeCluster(num_cores)
registerDoParallel(cl)

# Create combination grid
param_grid <- expand.grid(
  formula_idx = seq_along(formulas),
  xgb_idx = seq_len(nrow(xgboost_params)),
  stringsAsFactors = FALSE
)

# Sweep in parallel
results <- foreach(i = seq_len(nrow(param_grid)),
                   .combine = rbind,
                   .packages = c("CausalGPS",
                                 "SuperLearner",
                                 "data.table")) %dopar% {

  f_idx <- param_grid$formula_idx[i]
  xgb_i <- param_grid$xgb_idx[i]

  # Get formula and xgboost params
  formula_str <- formulas[[f_idx]]
  xgb_par <- xgboost_params[xgb_i, ]

  # Create wrapper
  m_xgboost <- function(...) {
    SuperLearner::SL.xgboost(
      nthread = 4,
      ntrees = xgb_par$ntrees,
      shrinkage = xgb_par$shrinkage,
      max_depth = xgb_par$max_depth,
      minobspernode = xgb_par$minobspernode,
      verbose = 0,
      ...
    )
  }

  assign("m_xgboost", m_xgboost, envir = .GlobalEnv)

  # Estimate GPS
  gps_obj <- tryCatch({
    estimate_gps(
      .data = data,
      .formula = as.formula(formula_str),
      sl_lib = c("m_xgboost"),
      gps_density = "normal"
    )
  }, error = function(e) return(NULL))
  if (is.null(gps_obj)) return(NULL)

  # Compute counter weight
  cw_obj <- tryCatch({
    compute_counter_weight(
      gps_obj = gps_obj,
      ci_appr = "matching",
      bin_seq = NULL,
      nthread = 4,
      delta_n = 0.1,
      dist_measure = "l1",
      scale = 1
    )
  }, error = function(e) return(NULL))
  if (is.null(cw_obj)) return(NULL)

  # Trim data
  trimmed_df <- tryCatch({
    trim_it(data, c(0.05, 0.95), "w")
  }, error = function(e) return(NULL))
  if (is.null(trimmed_df)) return(NULL)

  # Generate pseudo population
  pseudo_pop <- tryCatch({
    generate_pseudo_pop(
      .data = trimmed_df,
      cw_obj = cw_obj,
      covariate_col_names = confounders,
      covar_bl_trs = 0.1,
      covar_bl_trs_type = "maximal",
      covar_bl_method = "absolute"
    )
  }, error = function(e) return(NULL))
  if (is.null(pseudo_pop)) return(NULL)

  # Extract performance metric
  max_corr <- pseudo_pop$params$adjusted_corr_results$maximal_absolute_corr

  data.table::data.table(
    formula = formula_str,
    ntrees = xgb_par$ntrees,
    shrinkage = xgb_par$shrinkage,
    max_depth = xgb_par$max_depth,
    minobspernode = xgb_par$minobspernode,
    maximal_absolute_corr = max_corr
  )
}

# Stop cluster
stopCluster(cl)

# Save and show best config
data.table::fwrite(results, "xgb_hyperparam_sweep_results.csv")
best_combo <- results[which.min(results$maximal_absolute_corr)]
print(best_combo)
