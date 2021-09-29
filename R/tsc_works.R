#' Check whether API token is set and TSC is online
#'
#' \lifecycle{stable}
#' @template param-auth
#'
#' @family helpers
#' @export
tsc_works <- function(api_url = get_tsc_api_url(),
                      api_token = get_tsc_api_token()) {
  if (is.null(api_token)) {
    "API token not set, see vignette setup" %>%
      tsc_msg_abort()
  }
  auth <- httr::add_headers(c(Authorization = api_token))
  res <- httr::GET(api_url, auth)
  return(res$status_code == 200)
}

# use_test("tsc_works")  # nolint
