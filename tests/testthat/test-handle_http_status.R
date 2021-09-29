test_that("handle_http_status warns about HTTP error", {
  tsc_setup(verbose = TRUE)

  expect_warning(handle_http_status(httr::GET("http://httpstat.us/401")))
  expect_warning(handle_http_status(httr::GET("http://httpstat.us/404")))
  expect_warning(handle_http_status(httr::GET("http://httpstat.us/500")))

  expect_warning(
    tsc_GET("area", max_records = 1, verbose = TRUE, format = "csv")
  )
})
# usethis::use_r("handle_http_status")  # nolint
