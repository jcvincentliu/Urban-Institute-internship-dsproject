

library(tidyverse)
library(httr)
library(leaflet)
library(geojsonio)
library(tigris)

# input years must come in the form of a vector of strings

create_size_map <- function(data, years) {
  
  data <- data %>%
    filter(Year %in% years) %>%
    group_by(STATE_NAME) %>% 
    summarise(COUNT= sum(COUNT))
  
  
  usa_states <- geojsonio::geojson_read(
    "https://rstudio.github.io/leaflet/json/us-states.geojson",
    what = "sp")

  size_by_state <- tigris::geo_join(usa_states,
                                    data,
                                    "name",
                                    "STATE_NAME")

  
  bin_1 = 0
  bin_2 = parse_number(names(table((cut_number(size_by_state$COUNT, 5)))[2]))
  bin_3 = parse_number(names(table((cut_number(size_by_state$COUNT, 5)))[3]))
  bin_4 = parse_number(names(table((cut_number(size_by_state$COUNT, 5)))[4]))
  bin_5 = parse_number(names(table((cut_number(size_by_state$COUNT, 5)))[5]))
  bin_6 = max(size_by_state$COUNT, na.rm = T)
  
  pal <- colorBin( "Blues", #do a space to enhance readability
                   domain = size_by_state$COUNT,
                   bins = c(bin_1, bin_2, bin_3, bin_4, bin_5, bin_6),
                   na.color=NA )

  labels <-
    sprintf(
      "<strong>%s</strong> <br/> Number of Nonprofits: %1.0f",
      size_by_state$STATE_NAME,
      size_by_state$COUNT
    ) %>%
    lapply(htmltools::HTML)
  #print(pal)
#  print(labels)

  
map_leaflet <- leaflet(size_by_state) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles("MapBox",
                   options = providerTileOptions(
                     id = "mapbox.light",
                     accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN'))) %>%
  addPolygons(
    fillColor = ~pal(COUNT),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlightOptions = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal",
                   padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>%
  addLegend(pal = pal,
            values = ~COUNT,
            opacity = 0.7,
            title = "501c(3) Nonprofits in the US",
            position = "bottomright")


  return(map_leaflet)
}

