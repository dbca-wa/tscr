test_that("gs_getWFS returns a list", {
  # skip if KMI GeoServer is offline or unreachable
  x <- gs_getWFS()
  expect_equal(class(x), "list")
})


# usethis::use_r("gs_getWFS")   # nolint
