##      author:  Naeem Khoshnevis
##      created: September 2023 (Updated: March 2025)
##      purpose: Reproducing examples in the paper.


# Load libraries
library(ggplot2)
library(CausalGPS)
library(data.table)

# Load data --------------------------------------------------------------------
data_file <- "study_data.RData"

load(data_file)

# Estimate GPS -----------------------------------------------------------------

## Super learner wrapper
m_xgboost <- function(nthread = 6,
                      ntrees = 50,
                      shrinkage = 0.3,
                      max_depth = 6,
                      minobspernode = 1,
                      verbose = 1,
                      ...) {SuperLearner::SL.xgboost(
                        nthread = nthread,
                        ntrees = ntrees,
                        shrinkage=shrinkage,
                        max_depth=max_depth,
                        mibobspernode=minobspernode,
                        verbose=verbose,
                        ...)}

data_with_gps_kernel <- estimate_gps(
  .data = data,
  .formula = w ~ I(cf1^2) + cf2 + I(cf3^2) + cf4 + cf5 + cf6,
  sl_lib = c("m_xgboost"),
  gps_density = "kernel")

pdf("figure_paper_2_estimating_gps_kernel.pdf")
plot(data_with_gps_kernel)
dev.off()

save(data_with_gps_kernel, file = "data_with_gps_kernel.RData")
