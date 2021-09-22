test_that("lifecycle_shim does nothing as expected", {
  testthat::capture_warning(tscr:::lifecycle_shim())
  testthat::expect_true(TRUE)
})