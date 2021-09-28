#' Upsert GeoJSON into TSC API endpoints
#'
#' @param gj_featurecollection (list) A GeoJSON featurecollection as list
#' @template param-serializer
#' @param chunksize (int) The number of features to upload simultaneously,
#'   default: 1000.
#' @template param-auth
#' @template param-verbose
#' @export
#' @family wacensus
upsert_geojson <- function(gj_featurecollection,
                           serializer = "names",
                           chunksize = 1000,
                           api_url = get_tsc_api_url(),
                           api_token = get_tsc_api_token(),
                           verbose = get_tsc_verbose()) {
  "Posting to {api_url}{serializer}..." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)
  props <- purrr::map(gj_featurecollection[["features"]], "properties")
  # purrr::map(props, wastd_POST, api_url = api_url)
  # One by one - very slow. Faster:
  len <- length(props)
  for (i in 0:(len / chunksize)) {
    start <- (i * chunksize) + 1
    end <- min((start + chunksize) - 1, len)
    "Processing feature {start} to {end}..." %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)
    props[start:end] %>%
      purrr::map(., purrr::flatten) %>%
      tsc_POST(.,
                 serializer = serializer,
                 api_url = api_url,
                 api_token = api_token,
                 verbose = verbose
      )
  }
  "Finished. {len} records updated." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)
}

# usethis::use_test("upsert_geojson")
