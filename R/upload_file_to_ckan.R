#' Upload a file to an existing CKAN resource ID or skip if file is missing
#'
#' This function can be used to update an existing CKAN file resource with a
#' compiled Rmd workbook (i.e a HTML file).
#'
#' This function is a wrapper around `ckanr::resource_update()` with contingencies
#' for missing files.
#'
#' @param rid An existing CKAN resource ID.
#' @param fn The file to upload as the CKAN file resource.
#' @template param-verbose
#' @return NULL if the file is missing, or the resource ID.
#' @export
#' @family ckan
#' @examples
#' \dontrun{
#' ckanr::ckanr_setup(
#'   url = Sys.getenv("CKAN_URL"), key = Sys.getenv("CKAN_API_KEY")
#' )
#' upload_file_to_ckan("1b5e6401-82fe-4728-83be-f3f8ea4b5876", "EDA_flora.html")
#' }
upload_file_to_ckan <- function(rid, fn, verbose = get_tsc_verbose()) {
  if (!fs::file_exists(fn)) {
    "File {fn} does not exist, skipping." %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)
    return(NULL)
  }

  "Uploading {fn} to data catalogue..." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  r <- ckanr::resource_update(rid, fn)

  "Updated {r$name} at\n{r$url}" %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)

  r$id
}

# use_test("upload_file_to_ckan")  # nolint
