#' Create or update a CKAN resource.
#'
#' @details The data will be written to CSV in a directory `data/` with the
#'   resource title in snake_case.
#'   If no resource ID is given, a resource will be created.
#'   The resource ID is returned in either case.
#' @param data A data frame to write to disk.
#' @param resource_title A CKAN resource title.
#' @param dataset_id A CKAN dataset (package) ID.
#' @param resource_id A CKAN resource ID, default: NULL.
#' @template param-verbose
#' @return The resource ID of the created or updated resource.
#' @family ckan
#' @examples
#' \dontrun{
#' ckanr::ckanr_setup(
#'   url = Sys.getenv("CKAN_URL"), key = Sys.getenv("CKAN_API_KEY")
#' )
#' d <- ckanr::package_show("threatened-ecological-communities-database")
#'
#' # Run this once to create resource and retrieve resource ID
#' upload_to_ckan(a_tibble, "Resource title", d$id, resource_id = NULL)
#' # returns "502c74d7-32be-453f-aff6-c50aedd3deed" - paste into resource_id
#'
#' # Re-run this to update resource with new data
#' upload_to_ckan(a_tibble, "Resource title", d$id,
#'   resource_id = "502c74d7-32be-453f-aff6-c50aedd3deed"
#' )
#' }
upload_to_ckan <- function(data,
                           resource_title,
                           dataset_id,
                           resource_id = NULL,
                           verbose = get_tsc_verbose()) {
  resource_filename <- resource_title %>%
    stringr::str_to_lower(.) %>%
    stringr::str_replace_all(., " ", "_") %>%
    paste0(".csv") %>%
    file.path("data", .)

  readr::write_delim(data, resource_filename, delim = ",")

  if (is.null(resource_id)) {
    "No resource ID given, creating a new resource for '{resource_title}':" %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)

    r <- ckanr::resource_create(
      package_id = dataset_id,
      format = "csv",
      name = resource_title,
      upload = resource_filename
    )
  } else {
    "Updating CKAN resource '{resource_title}':" %>%
      glue::glue() %>%
      tsc_msg_info(verbose = verbose)
    r <- ckanr::resource_update(resource_id, resource_filename)
  }
  r$id
}

# use_test("upload_to_ckan")  # nolint
