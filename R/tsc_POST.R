#' Send a POST request to TSC's API
#'
#'
#' \lifecycle{stable}
#'
#' @param data (JSON) A list of lists (JSON) to post to TSC.
#' @template param-serializer
#' @param query (list) A list of POST parameters,
#'   default: `list(format="json")`.
#' @param encode The parameter `encode` for `\link{httr::POST}`,
#'   default: "json".
#'   Other options: `c("multipart", "form", "json", "raw")`.
#' @template param-auth
#' @template param-verbose
#' @template return-tsc-api-response
#' @export
#' @family api
#' @examples
#' \dontrun{
#' # One by one
#' gj <- "public:herbie_hbvnames_public" %>% kmi_getFeature()
#' props <- purrr::map(gj[["features"]], "properties")
#' tsc_POST(props[[1]], serializer = "names")
#'
#' # All in batch
#' "public:herbie_hbvnames_public" %>%
#'   gs_getWFS() %>%
#'   upsert_geojson(serializer = "names", verbose = T)
#' }
tsc_POST <- function(data,
                     serializer,
                     query = list(format = "json"),
                     encode = "json",
                     api_url = get_tsc_api_url(),
                     api_token = get_tsc_api_token(),
                     verbose = get_tsc_verbose()) {
  ua <- httr::user_agent("http://github.com/dbca-wa/tscr")
  url_parts <- httr::parse_url(api_url)
  url_parts["path"] <- glue::glue("{url_parts['path']}{serializer}/")
  url <- httr::build_url(url_parts)
  auth <- httr::add_headers(c(Authorization = api_token))

  "[tsc_POST] {url}" %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  res <- httr::POST(url, auth, ua, encode = encode, body = data, query = query)

  handle_http_status(res, verbose = verbose)

  text <- httr::content(res, as = "text", encoding = "UTF-8")

  if (httr::http_type(res) == "application/json") {
    res_parsed <- jsonlite::fromJSON(
      text,
      flatten = FALSE,
      simplifyVector = FALSE
    )
  } else {
    res_parsed <- text
  }

  "[tsc_POST] {res$status}" %>%
    glue::glue() %>%
    tsc_msg_success(verbose = verbose)

  structure(
    list(
      data = res_parsed,
      serializer = serializer,
      url = res$url,
      date = res$headers$date,
      status_code = res$status_code
    ),
    class = "tsc_api_response"
  )
}

# usethis::use_test("tsc_POST")  # nolint
