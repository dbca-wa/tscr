areas <- tsc_GET("area") %>% tsc_parse()
use_data(areas, overwrite = TRUE)

areas_gj <- tsc_GET("area") %>%
  magrittr::extract2("data") %>%
  geojsonio::as.json() %>%
  geojsonsf::geojson_sf()
use_data(areas_gj, overwrite = TRUE)

# Taxon occurrences with their Point representation
tae_res <- tsc_GET("occ-taxon-points", max_records = 10)
use_data(tae_res, overwrite = TRUE)

# Community occurrences with their Polygon representation
cae_res <- tsc_GET("occ-community-areas", max_records = 10)
use_data(cae_res, overwrite = TRUE)
