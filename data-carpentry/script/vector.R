library(tidyverse)
library(sf)

boundary_Delft <- st_read("data/delft-boundary.shp", quiet=TRUE)

boundary_Delft

st_geometry_type(boundary_Delft)

st_crs(boundary_Delft)
st_bbox(boundary_Delft)
