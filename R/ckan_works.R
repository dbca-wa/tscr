#' Check whether CKAN is accessible with given credentials
#'
#' \lifecycle{stable}
#' @param url The CKAN URL. Set through `ckanr::ckanr_setup()`.
#' @param key The CKAN API key. Set through `ckanr::ckanr_setup()`.
#' @template param-verbose
#' @return Logical (TRUE/FALSE) whether the configured CKAN works with the
#'   given credentials.
#' @family ckan
#' @export
ckan_works <- function(url = ckanr::get_default_url(),
                       key = ckanr::get_default_key(),
                       verbose = get_tsc_verbose()) {
  if (is.null(key) || key == "") {
    tsc_msg_info("CKAN API key not set", verbose = verbose)
    return(FALSE)
  }

  ckan_res <- try(ckanr::ckan_version(url = url, key = key), silent = TRUE)
  return(class(ckan_res) != "try-error")
}

# use_test("ckan_works")  # nolint
