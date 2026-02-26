#Working with OSM data

library(tidyverse)
library(sf)
#install.packages("osmdata")
library(osmdata)

bb <- getbb("Brielle")
bb

#Avoid ambiguous names
bb <- getbb("Naarden, NL")
bb

# extracting features with opq()

# if internet error

assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()

# if timeout error

x <-opq(bbox = bb, timeout = 10000) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()

#explore the result
str(x$osm_polygons)
head(x$osm_polygons)
summary(x$osm_polygons)

## Start mapping old buildings from Brielle!

buildings <- x$osm_polygons |>
  st_transform(crs = 28992)



buildings$start_date <- as.numeric(buildings$start_date)

buildings$build_date <- if_else(
  buildings$start_date < 1900,# the condition
  1900,  #if yes
  buildings$start_date
  )  #if no


# map
ggplot(data = buildings) +
  geom_sf(aes(fill = build_date, colour = build_date)) +
  scale_fill_viridis_c(option = "viridis") +
 scale_colour_viridis_c(option = "viridis") +
coord_sf(datum = st_crs(28992))


# creating a function

extract_and_map_buildings <- function(cityname, year = 1900){
 bb <-getbb(cityname)

 x <- opq(bbox = bb, timeout = 10000) |>
   add_osm_feature(key = "building") |>
    osmdata_sf()

buildings <- x$osm_polygons |>
  st_transform(crs = 28992)

buildings$start_date <- as.numeric(buildings$start_date)

buildings$build_date <- if_else(
  buildings$start_date < year,# the condition
  year,  #if yes
  buildings$start_date
)  #if no

ggplot(data = buildings) +
  geom_sf(aes(fill = build_date, colour = build_date)) +
  scale_fill_viridis_c(option = "viridis") +
  scale_colour_viridis_c(option = "viridis") +
  coord_sf(datum = st_crs(28992))

}


