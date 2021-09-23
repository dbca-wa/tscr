#' Return GeoJSON features from a TSC API endpoint
#'
#' \lifecycle{stable}
#'
#' @description Call the TSC API serializer's list view with given GET
#'   parameters, parse the response's features into a nested list.
#'   This function requires the TSC API to return the results in a key
#'   `features` (if GeoJSON) or `data` (if JSON).
#'
#' @template param-serializer
#' @param query (list) A list of GET parameters, default: list().
#'   The \code{format} is specified in a separate top-level param.
#' @param format (chr) The desired API output format, default: "json".
#' @param max_records (int) The maximum number of records retrieved.
#'   If left at default (NULL), all records are returned.
#'   Default: NULL.
#' @param chunk_size (int) The number of records to retrieve in each paginated
#'   response. A specified but smaller \code{limit} will override
#'   \code{chunk_size}.
#'   Adjust \code{chunk_size} down if getting timeouts from the API.
#'   Default: 1000.
#' @template param-auth
#' @template param-verbose
#' @return An S3 object of class 'tsc_api_response' containing:
#'
#'   features: The sent GeoJSON features
#'
#'   serializer: The called serializer, e.g. 'area'
#'
#'   response: The API HTTP response with all metadata
#' @export
#' @family api
#' @examples
#' \dontrun{
#' area_records <- tsc_GET("area")
#' }
tsc_GET <- function(serializer,
                    query = list(),
                    format = "json",
                    max_records = NULL,
                    chunk_size = 1000,
                    api_url = get_tsc_api_url(),
                    api_token = get_tsc_api_token(),
                    verbose = get_tsc_verbose()) {
  # Prep and gate checks
  ua <- httr::user_agent("http://github.com/dbca-wa/tscr")
  url_parts <- httr::parse_url(api_url)
  url_parts["path"] <- paste0(url_parts["path"], serializer)
  url <- httr::build_url(url_parts)
  limit <- ifelse(
    is.null(max_records),
    chunk_size,
    min(max_records, chunk_size)
  )
  query <- c(query, list(format = format, limit = limit))
  auth <- httr::add_headers(c(Authorization = api_token))

  # First batch of results and error handling
  "Fetching {url}" %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  res <- httr::GET(url, auth, ua, query = query)

  handle_http_status(res, verbose = verbose)

  res_parsed <- res %>%
    httr::content(as = "text", encoding = "UTF-8") %>%
    { # nolint
      if (format == "json") {
        jsonlite::fromJSON(., flatten = FALSE, simplifyVector = FALSE)
      } else {
        .
      }
    }

  # GeoJSON serializer returns records as "features"
  # OffsetLimitPagination serializer returns records as "results"
  data_key <- ifelse("features" %in% names(res_parsed), "features", "results")

  if (!(data_key %in% names(res_parsed))) {
    return(
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
    )
  }

  features <- res_parsed[[data_key]]
  next_url <- res_parsed$`next`
  total_count <- length(features)

  # Unless we already have reached our desired max_records in the first page of
  # results, loop over paginated response until we either hit the end of the
  # server side data (next_url is Null) or our max_records.
  if (get_more(total_count, max_records) == TRUE) {
    while (!is.null(next_url) &&
      get_more(total_count, max_records) == TRUE) {
      tsc_msg_info(glue::glue("Fetching {next_url}"))
      next_res <- httr::GET(next_url, auth, ua) %>%
        httr::warn_for_status(.) %>%
        httr::content(., as = "text", encoding = "UTF-8") %>%
        { # nolint
          if (format == "json") {
            jsonlite::fromJSON(., flatten = FALSE, simplifyVector = FALSE)
          } else {
            .
          }
        }

      features <- append(features, next_res[[data_key]])
      next_url <- next_res$`next`
      total_count <- length(features)
    }
  }

  "Done fetching {res$url}" %>%
    glue::glue() %>%
    tsc_msg_success(verbose = verbose)

  structure(
    list(
      data = features,
      serializer = serializer,
      url = res$url,
      date = res$headers$date,
      status_code = res$status_code
    ),
    class = "tsc_api_response"
  )
}

#' @title S3 print method for 'tsc_api_response'.
#' @description Prints a short representation of data returned by
#' \code{\link{tsc_GET}}.
#' @param x An object of class `tsc_api_response` as returned by
#'   \code{\link{tsc_GET}}.
#' @param ... Extra parameters for `print`
#' @export
#' @family api
print.tsc_api_response <- function(x, ...) {
  print(
    glue::glue(
      "<TSC API response \"{x$serializer}\">\n",
      "URL: {x$url}\n",
      "Date: {x$date}\n",
      "Status: {x$status_code}\n",
      "Data: {length(x$data)}\n"
    )
  )
  invisible(x)
}

# usethis::use_test("tsc_GET") # nolint
