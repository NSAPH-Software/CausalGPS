##      author:  Naeem Khoshnevis
##      created: March 2024 (Updated: September 2024)
##      purpose: Reproducing examples in the paper.


# Load libraries
library(ggplot2)
library(CausalGPS)


# Load gps object
load("data_with_gps_normal.RData")

data_with_gps_normal_tr <- trim_it(data_with_gps_normal, c(0.05, 0.95), "w")

cw_weighting_object <- compute_counter_weight(gps_obj = data_with_gps_normal_tr,
                                              ci_appr = "weighting")


pdf("figure_paper_3_weighting_data.pdf")
plot(cw_weighting_object)
dev.off()

save(cw_weighting_object, file = "cw_weighting_object.RData")


