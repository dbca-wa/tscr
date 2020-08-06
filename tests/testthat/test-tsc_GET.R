test_that("tsc_GET parses GeoJSON properties", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  area <- tsc_GET("area", max_records = 3, verbose = T) %>% tsc_parse()
  expect_s3_class(area, "tbl_df")
  expect_false("properties" %in% names(area))

  com <- tsc_GET("community", max_records = 3) %>% tsc_parse()
  expect_s3_class(area, "tbl_df")
  expect_false("properties" %in% names(area))
})


test_that("tsc_GET aborts with NULL api_un or api_pw", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  testthat::expect_error(
    res <- tsc_GET("area", api_token = NULL, api_un = NULL)
  )
  testthat::expect_error(
    res <- tsc_GET("area", api_token = NULL, api_pw = NULL)
  )
})


test_that("tsc_GET warns and fails with incorrect api_token", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  at <- get_tsc_api_token()
  tsc_setup(api_token = "invalid")
  expect_equal(get_tsc_api_token(), "invalid")

  tsc_setup(api_token = at)
  expect_equal(get_tsc_api_token(), at)
})

test_that("tsc_GET returns something", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  res <- tsc_GET("")
  expect_equal(res$status_code, 200)
  expect_s3_class(res, "tsc_api_response")
})


test_that("tsc_GET fails if HTTP error is returned", {
  expect_warning(
    tsc_GET("", api_url = "http://httpstat.us/401", query = list())
  )
  expect_warning(
    tsc_GET("", api_url = "http://httpstat.us/500", query = list())
  )
  expect_warning(
    tsc_GET("", api_url = "http://httpstat.us/404", query = list())
  )
})

test_that("tsc_GET works with correct API token", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  ae <- tsc_GET("area", max_records = 3)
  capture.output(print(ae))
  expect_equal(ae$status_code, 200)
})

test_that("tsc_GET respects limit", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")

  # With geojson
  ae <- tsc_GET("area", max_records = 3)
  capture.output(print(ae))
  expect_equal(ae$status_code, 200)
  expect_equal(length(ae$data), 3)

  # With plain json
  x <- tsc_GET("users", max_records = 3)
  capture.output(print(x))
  expect_equal(x$status_code, 200)
  expect_equal(length(x$data), 3)
})


test_that("tsc_GET combines pagination", {
  testthat::skip_if_not(tsc_online(), message = "TSC offline or wrong auth")
  # With geojson
  ae <- tsc_GET("area", max_records = 21, chunk_size = 5)
  capture.output(print(ae))
  expect_equal(ae$status_code, 200)
  expect_true(length(ae$data) >= 21)

  # With plain json
  x <- tsc_GET("users", max_records = 21, chunk_size = 5)
  capture.output(print(x))
  expect_equal(x$status_code, 200)
  expect_true(length(x$data) >= 21)
})

# usethis::use_r("tsc_GET")  # nolint
