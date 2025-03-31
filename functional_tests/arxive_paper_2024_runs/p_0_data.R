library(CausalGPS)
library(data.table)

if (!file.exists("study_data.RData")) {
  set.seed(562)
  data <- generate_syn_data(sample_size = 10000)
  data$id <- seq_along(1:nrow(data))
  data.table::setDF(data)

  save(data, file = "study_data.RData")
} else {
  message("The data is available; skipping regeneration.")
}

