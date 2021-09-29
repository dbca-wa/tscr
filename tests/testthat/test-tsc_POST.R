test_that("tsc_POST returns HTTP 502 on non-existing serializers", {
  testthat::skip_if_not(tsc_works(), message = "TSC offline or wrong auth")

  expect_warning(
    x <- tsc_POST(
      serializer = "doesnotexist_tscr", data = list(),
      # api_url = "http://localhost:8220/api/1/",
      # api_token = Sys.getenv("WASTDR_API_TOKEN_DEV"),
      verbose = TRUE
    )

    # x <- tsc_POST(
    #   serializer = "area", data=list(),
    #   api_url = "http://localhost:8220/api/1/", verbose = TRUE)
  )
  expect_equal(class(x), "tsc_api_response")
  expect_equal(x$status_code, 404)
})

test_that("tsc_POST errors on authentication failure", {
  testthat::skip_if_not(tsc_works(), message = "TSC offline or wrong auth")

  expect_warning(
    tsc_POST(
      serializer = "",
      data = list(),
      api_token = "",
      verbose = TRUE
    )
  )
})

# usethis::use_r("tsc_POST")   # nolint
