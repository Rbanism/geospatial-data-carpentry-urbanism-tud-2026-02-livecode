library(tidyverse)
library(sf)
library(here)

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
  geom_sf(size=3, color="black", fill="cyan1") +
  labs(title="Delft Administrative Boundary") +
  coord_sf(datum=st_crs(28992)) # display the axis in metres

lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

lines_Delft
ncol(lines_Delft)

names(lines_Delft)

head(lines_Delft)

head(lines_Delft$highway)

unique(lines_Delft$highway)  

# we can also examine unique values by
factor(lines_Delft$highway) |> levels()





