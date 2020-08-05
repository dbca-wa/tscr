test_that("tsc_msg works", {
  testthat::expect_message(tsc_msg_info("test"))
  testthat::expect_message(tsc_msg_success("test"))
  testthat::expect_message(tsc_msg_noop("test"))
  testthat::expect_warning(tsc_msg_warn("test"))
  testthat::expect_error(tsc_msg_abort("yo"))
})
