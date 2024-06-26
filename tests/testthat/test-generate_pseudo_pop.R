test_that("generate_pseudo_pop works as expected.", {

  data.table::setDTthreads(1)
  set.seed(4321)
  n <- 500
  mydata <- generate_syn_data(sample_size=n)
  year <- sample(x=c("2001","2002","2003","2004","2005"),
                 size = n, replace = TRUE)
  region <- sample(x=c("North", "South", "East", "West"),
                   size = n, replace = TRUE)

  mydata$year <- as.factor(year)
  mydata$region <- as.factor(region)
  mydata$cf5 <- as.factor(mydata$cf5)

  mydata$id <- seq_along(1:nrow(mydata))

  m_xgboost <- function(nthread = 4,
                        ntrees = 35,
                        shrinkage = 0.3,
                        max_depth = 5,
                        ...) {SuperLearner::SL.xgboost(
                          nthread = nthread,
                          ntrees = ntrees,
                          shrinkage=shrinkage,
                          max_depth=max_depth,
                          ...)}

  assign("m_xgboost", m_xgboost, envir = .GlobalEnv)

  data_with_gps_1 <- estimate_gps(
      .data = mydata,
      .formula = w ~ I(cf1^2) + cf2 + I(cf3^2) + cf4 + cf5 + cf6,
      sl_lib = c("m_xgboost"),
      gps_density = "normal")

  cw_object_matching <- compute_counter_weight(gps_obj = data_with_gps_1,
                                               ci_appr = "matching",
                                               bin_seq = NULL,
                                               nthread = 1,
                                               delta_n = 0.1,
                                               dist_measure = "l1",
                                               scale = 0.5)

   ps_pop1 <- generate_pseudo_pop(.data = mydata,
                                  cw_obj = cw_object_matching,
                                  covariate_col_names = c("cf1", "cf2",
                                                          "cf3", "cf4",
                                                          "cf5", "cf6"),
                                  covar_bl_trs = 0.1,
                                  covar_bl_trs_type = "maximal",
                                  covar_bl_method = "absolute")

  expect_equal(class(ps_pop1),"cgps_pspop")
  expect_false(ps_pop1$params$passed_covar_test)
  expect_equal(nrow(ps_pop1$.data), 500)
  expect_equal(ps_pop1$params$adjusted_corr_results$mean_absolute_corr,
               0.2225003,
               tolerance = 0.000001)

  # Test if all required attributes are included in the final object.
  expect_true((".data" %in% names(ps_pop1)))
  expect_true(("adjusted_corr_results" %in% names(ps_pop1$params)))
  expect_true(("original_corr_results" %in% names(ps_pop1$params)))
  expect_true(("fcall" %in% names(ps_pop1$params)))
  expect_true(("passed_covar_test" %in% names(ps_pop1$params)))
  expect_true(("ci_appr" %in% names(ps_pop1$params)))
  expect_true(("covariate_col_names" %in% names(ps_pop1$params)))

  })

#   ps_pop2 <- generate_pseudo_pop(mydata[, c("id", "w")],
#                                  mydata[, c("id", "cf1","cf2","cf3","cf4","cf5",
#                                           "cf6","year","region")],
#                                  ci_appr = "matching",
#                                  gps_density = "normal",
#                                  exposure_trim_qtls = c(0.04,0.96),
#                                  sl_lib = c("m_xgboost"),
#                                  covar_bl_method = "absolute",
#                                  covar_bl_trs = 0.1,
#                                  covar_bl_trs_type = "mean",
#                                  max_attempt = 1,
#                                  dist_measure = "l1",
#                                  delta_n = 1,
#                                  scale = 0.5,
#                                  nthread = 1)
#
#   expect_equal(class(ps_pop2),"gpsm_pspop")
#   expect_false(ps_pop2$passed_covar_test)
#   expect_equal(nrow(ps_pop2$pseudo_pop), 460)
#   expect_equal(ps_pop2$adjusted_corr_results$mean_absolute_corr,
#                0.2241794,
#                tolerance = 0.000001)
#
#   # expect error with wrong ci_appr
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[c("id", "cf1","cf2","cf3","cf4","cf5",
#                                             "cf6","year","region")],
#                                    ci_appr = "grounding",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#   # expect error with wrong gps_density
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1","cf2","cf3",
#                                               "cf4","cf5",
#                                               "cf6","year","region")],
#                                    ci_appr = "matching",
#                                    gps_density = "half-parametric",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#   # expect error with wrong max attempt
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1", "cf2", "cf3", "cf4",
#                                               "cf5", "cf6", "year", "region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = "five",
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#   # expect error with wrong covar_bl_method
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1","cf2","cf3","cf4",
#                                               "cf5",
#                                               "cf6","year","region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "nonabsolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#
#   # expect error with wrong scale
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1","cf2","cf3","cf4","cf5",
#                                             "cf6","year","region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 1.5,
#                                    nthread = 1))
#
#   #expect error with wrong answer in using cove transform.
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[c("id","cf1","cf2","cf3","cf4","cf5",
#                                             "cf6","year","region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    use_cov_transform = "YES",
#                                    transformers = list("pow2","pow3"),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 4,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#
#   #expect error with wrong transformers.
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1", "cf2", "cf3",
#                                               "cf4", "cf5",
#                                               "cf6", "year", "region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    use_cov_transform = TRUE,
#                                    transformers = numeric(),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 4,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#
#   # expect error with missing parameter
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("id", "cf1", "cf2", "cf3",
#                                               "cf4", "cf5", "cf6", "year",
#                                               "region")],
#                                    ci_appr = "matching",
#                                    gps_density = "normal",
#                                    exposure_trim_qtls = c(0.04,0.96),
#                                    use_cov_transform = TRUE,
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1))
#
#   # Test on weighting
#   ps_pop3 <- generate_pseudo_pop(mydata[, c("id", "w")],
#                                  mydata[, c("id", "cf1", "cf2", "cf3",
#                                             "cf4", "cf5", "cf6", "year",
#                                             "region")],
#                                  ci_appr = "weighting",
#                                  gps_density = "normal",
#                                  exposure_trim_qtls = c(0.04,0.96),
#                                  sl_lib = c("m_xgboost"),
#                                  covar_bl_method = "absolute",
#                                  covar_bl_trs = 0.1,
#                                  covar_bl_trs_type = "mean",
#                                  max_attempt = 1,
#                                  dist_measure = "l1",
#                                  delta_n = 1,
#                                  scale = 0.5,
#                                  nthread = 1)
#
#   expect_equal(class(ps_pop3),"gpsm_pspop")
#   expect_false(ps_pop3$passed_covar_test)
#   expect_equal(nrow(ps_pop3$pseudo_pop), 460)
#   expect_equal(ps_pop3$adjusted_corr_results$mean_absolute_corr,
#                0.3750209,
#                tolerance = 0.001)
#
#   ps_pop4 <- generate_pseudo_pop(mydata[, c("id", "w")],
#                                  mydata[, c("id", "cf1","cf2","cf3","cf4","cf5",
#                                           "cf6","year","region")],
#                                  ci_appr = "matching",
#                                  gps_density = "normal",
#                                  exposure_trim_qtls = c(0.04,0.96),
#                                  use_cov_transform = TRUE,
#                                  transformers = list("pow2","pow3"),
#                                  sl_lib = c("m_xgboost"),
#                                  covar_bl_method = "absolute",
#                                  covar_bl_trs = 0.1,
#                                  covar_bl_trs_type = "mean",
#                                  max_attempt = 4,
#                                  dist_measure = "l1",
#                                  delta_n = 1,
#                                  scale = 0.5,
#                                  nthread = 1)
#
#   expect_equal(class(ps_pop4),"gpsm_pspop")
#   expect_false(ps_pop4$passed_covar_test)
#   expect_equal(nrow(ps_pop4$pseudo_pop), 460)
#   expect_equal(ps_pop4$adjusted_corr_results$mean_absolute_corr,
#                0.2209775,
#                tolerance = 0.000001)
#
#
#   ps_pop5 <- generate_pseudo_pop(mydata[, c("id", "w")],
#                                  mydata[, c("id", "cf1","cf2","cf4")],
#                                  ci_appr = "matching",
#                                  gps_density = "normal",
#                                  exposure_trim_qtls = c(0.04,0.96),
#                                  use_cov_transform = TRUE,
#                                  transformers = list("pow2","pow3"),
#                                  sl_lib = c("m_xgboost"),
#                                  covar_bl_method = "absolute",
#                                  covar_bl_trs = 0.02,
#                                  covar_bl_trs_type = "mean",
#                                  max_attempt = 7,
#                                  dist_measure = "l1",
#                                  delta_n = 1,
#                                  scale = 0.5,
#                                  nthread = 1)
#
#   expect_equal(class(ps_pop5),"gpsm_pspop")
#   expect_false(ps_pop5$passed_covar_test)
#   expect_equal(nrow(ps_pop4$pseudo_pop), 460)
#   expect_equal(ps_pop5$adjusted_corr_results$mean_absolute_corr,
#                0.1076907,
#                tolerance = 0.000001)
#
#   set.seed(382)
#   ps_pop6 <- generate_pseudo_pop(mydata[, c("id", "w")],
#                                  mydata[, c("id", "cf1","cf2","cf3","cf4","cf5",
#                                           "cf6","year","region")],
#                                  ci_appr = "matching",
#                                  gps_density = "kernel",
#                                  exposure_trim_qtls = c(0.01,0.99),
#                                  sl_lib = c("m_xgboost"),
#                                  covar_bl_method = "absolute",
#                                  covar_bl_trs = 0.1,
#                                  covar_bl_trs_type = "mean",
#                                  max_attempt = 1,
#                                  dist_measure = "l1",
#                                  delta_n = 1,
#                                  scale = 0.5,
#                                  nthread = 1,
#                                  include_original_data = TRUE)
#
#
#   expect_equal(length(ps_pop6$original_data), 10)
#   expect_equal(nrow(ps_pop6$original_data), 500)
#
# })
#
#
# test_that("generate_pseudo_pop catches errors.", {
#   skip_on_cran()
#   data.table::setDTthreads(1)
#   set.seed(897)
#   n <- 500
#   mydata <- generate_syn_data(sample_size=n)
#   year <- sample(x=c("2001","2002","2003","2004","2005"),
#                  size = n, replace = TRUE)
#   region <- sample(x=c("North", "South", "East", "West"),
#                    size = n, replace = TRUE)
#
#   mydata$year <- as.factor(year)
#   mydata$region <- as.factor(region)
#   mydata$cf5 <- as.factor(mydata$cf5)
#
#   mydata$id <- seq_along(1:nrow(mydata))
#
#   expect_error(generate_pseudo_pop(mydata[, c("w")],
#                                    mydata[, c("id", "cf1", "cf2", "cf3",
#                                               "cf4", "cf5", "cf6", "year",
#                                               "region")],
#                                    ci_appr = "matching",
#                                    gps_density = "kernel",
#                                    exposure_trim_qtls = c(0.01,0.99),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1),
#                regexp = "w should include id column.")
#
#   expect_error(generate_pseudo_pop(mydata[, c("id", "w")],
#                                    mydata[, c("cf1", "cf2", "cf3",
#                                               "cf4", "cf5", "cf6", "year",
#                                               "region")],
#                                    ci_appr = "matching",
#                                    gps_density = "kernel",
#                                    exposure_trim_qtls = c(0.01,0.99),
#                                    sl_lib = c("m_xgboost"),
#                                    covar_bl_method = "absolute",
#                                    covar_bl_trs = 0.1,
#                                    covar_bl_trs_type = "mean",
#                                    max_attempt = 1,
#                                    dist_measure = "l1",
#                                    delta_n = 1,
#                                    scale = 0.5,
#                                    nthread = 1),
#                regexp = "c should include id column.")
#
# })
