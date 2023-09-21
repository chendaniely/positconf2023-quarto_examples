# install.packages("bikeHelpR", repos = "https://packagemanager.rstudio.com/all/latest")

library(bikeHelpR)
library(dplyr)
library(magrittr)

## Get data from API

### Station status

feeds_station_status <-
  bikeHelpR::feeds_urls() %>%
  filter(name == "station_status") %>%
  pull(url) %>%
  bikeHelpR::get_data()

station_status <-
  feeds_station_status %>%
  magrittr::extract2("data") %>%
  dplyr::mutate(time = feeds_station_status$last_updated) %>%
  dplyr::select(
    is_installed,
    num_bikes_available,
    last_reported,
    is_renting,
    eightd_has_available_keys,
    num_docks_available,
    num_docks_disabled,
    is_returning,
    station_id, num_ebikes_available,
    num_bikes_disabled,
    time
  )

glimpse(station_status)

### Station info

# The station information endpoint.
station_information_url <-
  bikeHelpR::feeds_urls() %>%
  filter(name == "station_information") %>%
  pull(url)

# Call the endpoint to obtain the JSON data.
request <- httr2::request(station_information_url)
response <- httr2::req_perform(request)
json_data <- httr2::resp_body_json(response)

# Convert the JSON data into a tibble.
station_info <-
  json_data$data %>%
  as_tibble() %>%
  tidyr::unnest_wider(stations) %>%
  select(station_id, name, lat, lon) %>%
  distinct() %>%
  mutate(
    last_updated = as.POSIXct(
      json_data$last_updated,
      origin = "1970-01-01 00:00:00 UTC"
    )
  )

glimpse(station_info)

## Save data

if (!fs::dir_exists("data")) fs::dir_create("data")

readr::write_csv(station_info, "data/station_info.csv")
readr::write_csv(station_status, "data/station_status.csv")
