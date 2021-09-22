#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

#' Silence R CMD CHECK warning: Use lifecycle somewhere in package
#' @keywords internal
lifecycle_warning_muffler <- function() {
  lifecycle::last_warnings()
}

# CMD check silencer
utils::globalVariables(
  c(
    "."
  )
)
