test_that("tsc_setup does not update settings if given NULL", {
  xx <- tsc_settings()

  # This does not change settings
  tsc_setup(
    api_url = NULL,
    api_token = NULL,
    test_api_url = NULL,
    test_api_token = NULL,
    verbose = NULL
  )

  # Get current (unchanged) settings
  x <- tsc_settings()

  # Settings are still the default/test settings
  # If env vars not set, default getters will issue warnings
  testthat::expect_equal(x$api_url, xx$api_url)
  testthat::expect_equal(x$test_api_url, xx$test_api_url)
  testthat::expect_equal(x$api_token, xx$api_token)
  testthat::expect_equal(x$test_api_token, xx$test_api_token)
  testthat::expect_equal(x$tsc_verbose, xx$tsc_verbose)
})

test_that("tsc_settings prints nicely", {
  x <- tsc_settings()
  testthat::expect_equal(class(x), "tsc_settings")

  out <- testthat::capture_output(print(x))
  testthat::expect_match(out, "TSC settings")
})

test_that("tsc_setup updates settings", {
  xx <- tsc_settings()

  # This does change settings
  tsc_setup(
    api_url = "new_api_url",
    api_token = "new_api_token",
    test_api_url = "new_test_api_url",
    test_api_token = "new_test_api_token",
    verbose = TRUE
  )

  # Get current (changed) settings
  x <- tsc_settings()

  # Settings are updated to nonsense
  testthat::expect_equal(x$api_url, "new_api_url")
  testthat::expect_equal(get_tsc_api_url(), "new_api_url")

  testthat::expect_equal(x$api_token, "new_api_token")
  testthat::expect_equal(get_tsc_api_token(), "new_api_token")

  testthat::expect_equal(x$test_api_url, "new_test_api_url")
  testthat::expect_equal(get_tsc_test_api_url(), "new_test_api_url")

  testthat::expect_equal(x$test_api_token, "new_test_api_token")
  testthat::expect_equal(get_tsc_test_api_token(), "new_test_api_token")

  testthat::expect_equal(x$verbose, TRUE)
  testthat::expect_equal(get_tsc_verbose(), TRUE)

  # Restore original settings
  tsc_setup(
    api_url = xx$api_url,
    api_token = xx$api_token,
    test_api_url = xx$test_api_url,
    test_api_token = xx$test_api_token,
    verbose = xx$verbose
  )
  # Get current settings (freshly reset to original)
  x <- tsc_settings()

  # Settings are back to the default/test settings
  testthat::expect_equal(x$api_url, xx$api_url)
  testthat::expect_equal(x$test_api_url, xx$test_api_url)
  testthat::expect_equal(x$api_token, xx$api_token)
  testthat::expect_equal(x$test_api_token, xx$test_api_token)
  testthat::expect_equal(x$tsc_verbose, xx$tsc_verbose)
})

test_that("tsc_setup warns about unset API tokens", {
  xx <- tsc_settings()

  # This does change settings
  tsc_setup(
    api_token = "",
    test_api_token = ""
  )

  # Get current (unchanged) settings
  testthat::expect_warning(x <- tsc_settings())

  testthat::expect_equal(x$api_token, "")
  testthat::expect_warning(testthat::expect_equal(get_tsc_api_token(), ""))


  testthat::expect_equal(x$test_api_token, "")
  testthat::expect_warning(testthat::expect_equal(get_tsc_test_api_token(), ""))


  # Restore original settings
  tsc_setup(
    api_token = xx$api_token,
    test_api_token = xx$test_api_token
  )
  # Get current settings (freshly reset to original)
  x <- tsc_settings()

  # Settings are back to the default/test settings
  testthat::expect_equal(x$api_token, xx$api_token)
  testthat::expect_equal(x$test_api_token, xx$test_api_token)
})
