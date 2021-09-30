#' Download, extract and open a zipped Access database from a CKAN dataset.
#'
#' The extracted file will be kept in `destdir`.
#' If a file with the expected filename already exists in `destdir`, this file
#' will be used.
#' To force a fresh download, remove or rename the file in `destdir`.
#'
#' @param resource_id The CKAN resource ID of a zipped Access DB.
#' @param destdir The local destination directory for the extracted file,
#'  will be created if not existing. Default: `here::here("data")`.
#' @param dateformat The parameter dateformat for `Hmisc::mdb.get()`,
#'   default: `%Y-%m-%d`.
#' @param as.is The parameter `as.is` for `Hmisc::mdb.get()`, default: TRUE.
#' @returns The `Hmisc::mdb.get` connection.
#' @family ckan
#' @examples
#' \dontrun{
#' ckanr::ckanr_setup(
#'   url = Sys.getenv("CKAN_URL"), key = Sys.getenv("CKAN_API_KEY")
#' )
#' tfa_data <- dl_mdbzip("66efb68d-8f05-4bfc-af14-5d1a381d0cf2", verbose = TRUE)
#' }
dl_mdbzip <- function(resource_id,
                      destdir = here::here("data"),
                      dateformat = "%m-%d-%Y",
                      as.is = TRUE,
                      verbose = get_tsc_verbose()) {
  if (!fs::dir_exists(destdir)) fs::dir_create(destdir, recurse = TRUE)

  r <- ckanr::resource_show(resource_id)
  res_url <- r$url %>% stringr::str_replace("dpaw", "dbca")
  res_fn <- r$url %>% fs::path_file()
  res_fp <- fs::path(fs::path(destdir, res_fn))

  if (!fs::file_exists(res_fp)) {
    "Downloading {r$name} from CKAN to {res_fp}..." %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)

    utils::download.file(res_url, res_fp)
  } else {
    "Retaining {res_fn}, delete file to force fresh download." %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)
  }

  "Extracting {res_fp}..." %>%
    glue::glue() %>%
    tsc_msg_info(verbose = verbose)
  dbfile <- utils::unzip(res_fp, exdir = destdir)
  con <- Hmisc::mdb.get(dbfile, dateformat = dateformat, as.is = as.is)
  tsc_msg_success("Done, returning open db connection.", verbose = verbose)
  con
}

# use_test("dl_mdbzip")  # nolint
