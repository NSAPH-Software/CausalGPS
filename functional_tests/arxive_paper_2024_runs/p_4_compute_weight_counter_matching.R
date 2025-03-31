##      author:  Naeem Khoshnevis
##      created: March 2024 (Updated: September 2024)
##      purpose: Reproducing examples in the paper.


# Load libraries
library(ggplot2)
library(CausalGPS)


# Load gps object
load("data_with_gps_normal.RData")

data_with_gps_normal_tr <- trim_it(data_with_gps_normal, c(0.05, 0.95), "w")

cw_matching_object <- compute_counter_weight(gps_obj = data_with_gps_normal_tr,
                                             ci_appr = "matching",
                                             bin_seq = NULL,
                                             nthread = 6,
                                             delta_n = 0.1,
                                             dist_measure = "l1",
                                             scale = 1)

pdf("figure_paper_4_matching_data.pdf")
plot(cw_matching_object)
dev.off()


save(cw_matching_object, file = "cw_matching_object.RData")
