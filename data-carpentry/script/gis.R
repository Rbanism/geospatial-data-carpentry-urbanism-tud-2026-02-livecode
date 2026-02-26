#Working with OSM data

library(tidyverse)
library(sf)
#install.packages("osmdata")
library(osmdata)

bb <- getbb("Brielle")
bb

#Avoid ambiguous names
bb <- getbb("Brielle, NL")
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

st_transform(crs



