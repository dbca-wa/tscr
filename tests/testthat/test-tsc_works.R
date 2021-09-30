test_that("tsc_works errors on missing API token", {
  testthat::expect_message(
    tsc_works(api_url = tscr::get_tsc_api_url(), api_token = NULL)
  )
})

test_that("tsc_works returns FALSE if HTTP status is other than 200", {
  expect_true(tsc_works(api_url = "http://httpstat.us/200"))
  expect_false(tsc_works(api_url = "http://httpstat.us/401"))
})
