test_that("ckan_works warns on missing credentials", {
  expect_message(ckan_works(key = ""))
  expect_message(ckan_works(key = NULL))
})

test_that("ckan_works returns FALSE with non-CKAN url", {
  expect_false(ckan_works(url = "http://httpstat.us/200", key = ""))
  expect_false(ckan_works(url = "http://httpstat.us/401", key = ""))
})

test_that("ckan_works returns FALSE with a public CKAN url", {
  expect_true(ckan_works(url = "https://data.ontario.ca/", key = "test"))
})

# use_r("ckan_works")  # nolint
