#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

# Silence R CMD CHECK warning: Use lifecycle somewhere in package
lifecycle::deprecate_soft

# CMD check silencer
utils::globalVariables(
  c(
    "."
    )
)