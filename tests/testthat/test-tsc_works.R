test_that("tsc_works errors on missing API token", {
  testthat::expect_error(
    tsc_works(api_url = tscr::get_tsc_api_url(), api_token = NULL)
  )
})
