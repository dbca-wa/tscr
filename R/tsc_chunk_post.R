#' POST data to a TSC API serializer in chunks
#'
#' @param data Data to post to the serializer
#' @param serializer A TSC API serializer, e.g. "occ-taxon-point"
#' @param query An optional query for `tsc_POST`,
#'   default: `list()`.
#' @param chunksize The number of records to post at a time, default: 1000.
#' @param encode The parameter `encode` for `httr::POST`, default: "json".
#'   Other options: `c("multipart", "form", "json", "raw")`.
#' @template param-auth
#' @template param-verbose
#'
#' @return The `tsc_api_response` of the last batch of data.
#' @export
#' @family api
#'
#' @examples
#' \dontrun{
#' # chunk_post examples from ETL scripts
#' }
tsc_chunk_post <- function(data,
                           serializer,
                           query = list(),
                           chunksize = 1000,
                           encode = "json",
                           api_url = get_tsc_api_url(),
                           api_token = get_tsc_api_token(),
                           verbose = get_tsc_verbose()) {
  "[chunk_post][{Sys.time()}] Updating {api_url}{serializer}..." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  len <- nrow(data)
  res <- NULL
  for (i in seq_len(ceiling(len / chunksize))) {
    start <- (i - 1) * chunksize + 1
    end <- min(start + chunksize - 1, len)

    "[chunk_post][{Sys.time()}][{i}] Processing feature {start} to {end}" %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)

    res <- data[start:end, ] %>%
      tsc_POST(.,
        serializer = serializer,
        query = query,
        encode = encode,
        api_url = api_url,
        api_token = api_token,
        verbose = verbose
      )
  }

  "[chunk_post][{Sys.time()}] Finished, {len} records created/updated." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)
  res
}

# use_test("tsc_chunk_post")  # nolint
