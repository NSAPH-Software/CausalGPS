##      author:  Naeem Khoshnevis
##      created: September 2024
##      purpose: Reproducing examples in the paper.

# Load libraries
library(ggplot2)
library(CausalGPS)

# Load pseudo population object
load("pseudo_pop_matching_object.RData")
data <- pseudo_pop_matching_object$.data
w_vals <- seq(min(data$w), max(data$w), 0.5)

run_and_plot_erf <- function(formula_str,
                             model_type,
                             suffix,
                             extra_args = list()) {
  formula_obj <- as.formula(formula_str)
  erf_obj <- do.call(estimate_erf, c(list(
    .data = data,
    .formula = formula_obj,
    weights_col_name = "counter_weight",
    w_vals = w_vals,
    model_type = model_type,
    .family = "gaussian"
  ), extra_args))

  pdf(paste0("figure_paper_8_erf_obj_", suffix, ".pdf"))
  plot(erf_obj)
  dev.off()
}

# PARAMETRIC MODELS
param_formulas <- c(
  "Y ~ w",
  "Y ~ w + I(w^2)",
  "Y ~ w + I(w^2) + I(w^3)",
  "Y ~ w + I(w^2) + I(w^3) + exp(w)",
  "Y ~ w + I(w^2) + I(w^3) + exp(w) + log(w)"
)

for (i in seq_along(param_formulas)) {
  run_and_plot_erf(param_formulas[i],
                   "parametric", paste0("parametric_", i, "_matching"))
}

# SEMIPARAMETRIC MODELS
semi_formulas <- c(
  "Y ~ w",
  "Y ~ s(w, 3)",
  "Y ~ s(w, 100)"
)

for (i in seq_along(semi_formulas)) {
  run_and_plot_erf(semi_formulas[i],
                   "semiparametric",
                   paste0("semiparametric_",
                          i,
                          "_matching"))
}

# NONPARAMETRIC MODELS
# nonparam_kernels <- c("kernsmooth", "locpol")
#
# for (kernel in nonparam_kernels) {
#   run_and_plot_erf(
#     formula_str = "Y ~ w",
#     model_type = "nonparametric",
#     suffix = paste0("nonparametric_", kernel, "_matching"),
#     extra_args = list(bw_seq = seq(0.2,2,0.2), kernel_appr = kernel)
#   )
# }

erf_kernsmooth <- estimate_erf(
  .data = data,
  .formula = Y ~ w,
  weights_col_name = "counter_weight",
  w_vals = w_vals,
  model_type = "nonparametric",
  bw_seq = seq(0.1, 2.0, 0.01),
  kernel_appr = "kernsmooth",
  nthread = 12
)

pdf(paste0("figure_paper_8_erf_obj_kernsmooth_matching.pdf"))
plot(erf_kernsmooth)
dev.off()
