#' Post a list of records to TSC API endpoint "occ-observation/bulk_create"
#'
#' @param data A tbl_df of occ-observation records
#' @param obstype The model type of the occ-observation model,
#'   default: "PhysicalSample".
#' @param chunksize The number of records to post at a time, default: 1000.
#' @template param-auth
#' @template param-verbose
#' @export
tsc_occ_obs_post <- function(data,
                             obstype = "PhysicalSample",
                             chunksize = 100,
                             api_url = get_tsc_api_url(),
                             api_token = get_tsc_api_token(),
                             verbose = get_tsc_verbose()) {
  "[{Sys.time()}] Uploading {nrow(data)} {obstype}s to  TSC {api_url}" %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  res <- tsc_chunk_post(
    data,
    serializer = "occ-observation/bulk_create",
    query = list(obstype = obstype),
    api_url = api_url,
    api_token = api_token,
    chunksize = chunksize
  )

  if ("created_count" %in% names(res$data)) {
    "[{Sys.time()}] Done, created {res$data$created_count} records." %>%
      glue::glue() %>%
      tsc_msg_success(verbose = verbose)
  }

  if ("errors" %in% names(res$data) &&
    length(res$data$errors) > 0) {
    "[{Sys.time()}] Got {length(res$data$errors)} errors." %>%
      glue::glue() %>%
      tsc_msg_warn(verbose = verbose)
  }

  res
}

# use_test("tsc_occ_obs_post")  # nolint
