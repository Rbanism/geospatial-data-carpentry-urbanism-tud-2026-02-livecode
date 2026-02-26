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

assign("has_internet_via_proxy", TRUE, environment)

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()



