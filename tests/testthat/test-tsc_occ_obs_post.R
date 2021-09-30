test_that("tsc_occ_obs_post can upload valid example data", {
  testthat::skip_if_not(tsc_works())

  data("phys_sample")

  testthat::expect_message(
    suppressWarnings(
      x <- tsc_occ_obs_post(phys_sample,
        obstype = "PhysicalSample",
        chunksize = 10,
        api_url = get_tsc_test_api_url(),
        api_token = get_tsc_test_api_token(),
        verbose = TRUE
      )
    )
  )

  testthat::expect_s3_class(x, "tsc_api_response")
})

# use_r("tsc_occ_obs_post")  # nolint
