#' Check whether API token is set and TSC is online
#'
#' \lifecycle{stable}
#' @template param-auth
#'
#' @family helpers
#' @export
tsc_online <- function(api_url = get_tsc_api_url(),
                       api_token = get_tsc_api_token()) {
  res <- tsc_GET(
    "",
    max_records = 1,
    api_url = api_url,
    api_token = api_token,
    verbose = FALSE
  )

  return(class(res) == "tsc_api_response" && res$status_code == 200)
}
