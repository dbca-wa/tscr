test_that("tsc_msg works", {
  tsc_setup(verbose = TRUE)
  testthat::expect_message(tsc_msg_info("test"))
  testthat::expect_message(tsc_msg_success("test"))
  testthat::expect_message(tsc_msg_noop("test"))
  testthat::expect_warning(tsc_msg_warn("test"))
  testthat::expect_error(tsc_msg_abort("yo"))

  tsc_setup(verbose = FALSE)
  testthat::expect_silent(tsc_msg_info("test"))
  testthat::expect_silent(tsc_msg_success("test"))
  testthat::expect_silent(tsc_msg_noop("test"))
  testthat::expect_silent(tsc_msg_warn("test"))
  testthat::expect_error(tsc_msg_abort("yo"))

  testthat::expect_message(tsc_msg_info("test", verbose = TRUE))
  testthat::expect_message(tsc_msg_success("test", verbose = TRUE))
  testthat::expect_message(tsc_msg_noop("test", verbose = TRUE))
  testthat::expect_warning(tsc_msg_warn("test", verbose = TRUE))
  testthat::expect_error(tsc_msg_abort("yo"))

  tsc_setup(verbose = TRUE)
})
