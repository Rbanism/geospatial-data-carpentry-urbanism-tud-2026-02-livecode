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

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building")

