library(tidyverse)
library(sf)

boundary_Delft <- st_read("data/delft-boundary.shp", quiet=TRUE)

boundary_Delft

st_geometry_type(boundary_Delft)

st_crs(boundary_Delft)
st_bbox(boundary_Delft)

boundary_Delft <- st_transform(boundary_Delft, crs=28992) # transforms and overwrites object

st_crs(boundary_Delft) # examine new EPSG code
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$epsg

st_bbox(boundary_Delft) # bounding box

st_crs(boundary_Delft)$units_gdal

boundary_Delft

# Plot the boundary of Delft:
ggplot(data=boundary_Delft) +
  geom_st(size=3,)
  
  