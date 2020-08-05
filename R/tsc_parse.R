#' Parse a \code{tsc_api_response} into a tibble
#'
#' \lifecycle{stable}
#'
#' @description From a \code{tsc_api_response}, turn the key \code{payload}
#'   (default: "features") into a \code{tibble:tibble}, and
#'   \code{tidyr::unnest_wider} the tibble into columns equivalent to the fields
#'   of the TSC API serializer.
#'   If GeoJSON is found, the keys `geometry` (including `coordinates`) will
#'   remain unchanged, but the key `properties` will be unnested.
#' @param tsc_api_response A \code{tsc_api_response} from TSC
#' @param payload (chr) The name of the key containing the parsed
#'   \code{httr::content()} from the TSC API call
#' @return A tibble with one row per record and columns corresponding to each
#'   record's fields.
#' @export
#' @family api
tsc_parse <- function(tsc_api_response, payload = "data") {
  out <- tsc_api_response %>%
    magrittr::extract2(payload) %>%
    tibble::tibble() %>%
    tidyr::unnest_wider(".", names_repair = "universal") %>%
    janitor::clean_names()

  if ("geometry" %in% names(out)) {
    out <- out %>%
      # tidyr::unnest_wider("geometry", names_repair = "universal") %>%
      # tidyr::unnest_wider("coordinates", names_repair = "universal") %>%
      tidyr::unnest_wider("properties", names_repair = "universal") %>%
      janitor::clean_names()
  }
  out
}

# usethis::use_test("tsc_GET") # nolint
