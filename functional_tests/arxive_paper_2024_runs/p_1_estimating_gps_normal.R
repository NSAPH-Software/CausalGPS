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
m_xgboost <- function(nthread = 4,
                      ntrees = 25,
                      shrinkage = 0.1,
                      max_depth = 6,
                      minobspernode = 5,
                      verbose = 1,
                      ...) {SuperLearner::SL.xgboost(
                        nthread = nthread,
                        ntrees = ntrees,
                        shrinkage=shrinkage,
                        max_depth=max_depth,
                        mibobspernode=minobspernode,
                        verbose=verbose,
                        ...)}


data_with_gps_normal <- estimate_gps(
  .data = data,
  .formula = w ~ cf1 + cf2 + cf3 + cf4 + cf5 + cf6,
  sl_lib = c("m_xgboost"),
  gps_density = "normal")

pdf("figure_paper_1_estimating_gps_normal.pdf")
plot(data_with_gps_normal)
dev.off()

save(data_with_gps_normal, file = "data_with_gps_normal.RData")
