#' Get TSC settings
#'
#' \lifecycle{stable}
#'
#' \code{tsc_setup} sets your production and test settings.
#' @return \code{\link{tsc_settings}} prints your settings.
#' @family settings
#' @export
#' @examples
#' \dontrun{
#' tsc_settings()
#' }
tsc_settings <- function() {
  ops <- list(
    api_url = get_tsc_api_url(),
    api_token = get_tsc_api_token(),
    test_api_url = get_tsc_test_api_url(),
    test_api_token = get_tsc_test_api_token(),
    verbose = get_tsc_verbose()
  )
  structure(ops, class = "tsc_settings")
}

#' @export
print.tsc_settings <- function(x, ...) {
  cat("<TSC settings>", sep = "\n")
  cat("  API URL (Default):   ", x$api_url, "\n")
  cat("  API Token (Default):  see tscr::get_tsc_api_token()\n")
  cat("  API URL (Test):      ", x$test_api_url, "\n")
  cat("  API Token (Test):     see tscr::get_tsc_test_api_token()\n")
  cat("  Verbose:             ", x$verbose, "\n")
}

# -----------------------------------------------------------------------------#
# Setters
#
#' Configure default TSC settings
#'
#' \lifecycle{stable}
#'
#' @details
#' \code{tscr_setup} sets TSC API connection details. \code{tscr}'s
#' functions default to use the default URL, but require an API Token to work.
#' @param api_url A TSC API URL (optional),
#'   default: \code{\link{get_tsc_api_url}}.
#' @param api_token A TSC API token, leading with "Token "
#' @param test_api_url A TSC API URL for tests (optional),
#'   default: \code{\link{get_tsc_test_api_url}}
#' @param test_api_token A TSC API token for tests,
#'   leading with "Token " (character).
#'   Default: \code{\link{get_tsc_api_token}}.
#' @param verbose Verbosity for tscr.
#' @family settings
#' @export
#' @examples
#' # TSC users can access their TSC API Token on their profile page on TSC.
#' # Not specifying the default TSC API URL will reset the TSC URL to its
#' # default "https://tsc.dbca.wa.gov.au/api/1/":
#' tsc_setup(api_token = "Token xxx")
tsc_setup <- function(api_url = NULL,
                      api_token = NULL,
                      test_api_url = NULL,
                      test_api_token = NULL,
                      verbose = NULL) {
  if (!is.null(api_url)) Sys.setenv("TSC_API_URL" = api_url)
  if (!is.null(api_token)) Sys.setenv("TSC_API_TOKEN" = api_token)
  if (!is.null(test_api_url)) Sys.setenv("TSC_TEST_API_URL" = test_api_url)
  if (!is.null(test_api_token)) {
    Sys.setenv("TSC_TEST_API_TOKEN" = test_api_token)
  }
  if (!is.null(verbose)) Sys.setenv("TSC_VERBOSE" = verbose)
}

# -----------------------------------------------------------------------------#
# Getters
#
#' \lifecycle{stable}
#' @export
#' @rdname tsc_settings
get_tsc_api_url <- function() {
  Sys.getenv("TSC_API_URL",
    unset = "https://tsc.dbca.wa.gov.au/api/1/"
  )
}

#' \lifecycle{stable}
#' @export
#' @rdname tsc_settings
get_tsc_api_token <- function() {
  x <- Sys.getenv("TSC_API_TOKEN")
  if (identical(x, "")) {
    tsc_msg_warn("No TSC API Token set. Run tscr::tsc_setup()!")
  }
  x
}

#' \lifecycle{stable}
#' @export
#' @rdname tsc_settings
get_tsc_test_api_url <- function() {
  Sys.getenv("TSC_TEST_API_URL",
    unset = "https://tsc-uat.dbca.wa.gov.au/api/1/"
  )
}

#' \lifecycle{stable}
#' @export
#' @rdname tsc_settings
get_tsc_test_api_token <- function() {
  Sys.getenv("TSC_TEST_API_TOKEN", unset = get_tsc_api_token())
}

#' \lifecycle{stable}
#' @export
#' @rdname tsc_settings
get_tsc_verbose <- function() {
  as.logical(Sys.getenv("TSC_VERBOSE", unset = FALSE))
}

# usethis::use_test("tsc_settings") # nolint
