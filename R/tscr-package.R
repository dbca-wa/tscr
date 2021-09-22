#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

#' Shim to allow Import of lifecycle, required for building docs.
#'
#' HT Jim Hester, Lionel Henry, Jenny Bryan for advice
#' @importFrom lifecycle deprecate_soft
#' @keywords internal
lifecycle_shim <- function() {
  lifecycle::deprecate_soft(when = "1.0", what = "lifecycle_shim()")
}

# CMD check silencer
utils::globalVariables(
  c(
    "."
  )
)
