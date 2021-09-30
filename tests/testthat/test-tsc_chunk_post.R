test_that("tsc_chunk_post works", {
  testthat::skip_if_not(tsc_works())

  areas <- tsc_GET("area", chunk_size = 10, max_records = 10) %>% tsc_parse()
  testthat::expect_message(
    suppressWarnings(
      x <- tsc_chunk_post(areas,
        "area",
        chunksize = 10,
        api_url = get_tsc_test_api_url(),
        api_token = get_tsc_test_api_token(),
        verbose = TRUE
      )
    )
  )
  testthat::expect_s3_class(x, "tsc_api_response")
})

# use_r("tsc_chunk_post")  # nolint
