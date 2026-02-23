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

# we can also examine unique values by transforming the
# variable into a factor
factor(lines_Delft$highway) |> levels()
factor(lines_Delft$highway) |> head()

point_Delft

head(point_Delft, 10)

na.omit(point_Delft$leisure) |> head(10)

factor(point_Delft$leisure) |> 
  levels() |> 
  head(3)

# subsetting the data
cycleway_Delft <- lines_Delft |> 
  filter(highway == "cycleway")

nrow(cycleway_Delft)
nrow(lines_Delft)

unique(lines_Delft$highway)

slow_Delft <- lines_Delft |> 
  filter(highway %in% c("cycleway", "footway"))
nrow(slow_Delft)
unique(slow_Delft$highway)

cycleway_Delft <- cycleway_Delft |> 
  mutate(length = st_length(geometry))

cycleway_Delft |> 
  summarise(total_length = sum(length))

# plot the cycleways
ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(
    title = "Slow mobility newtork in Delft",
    subtitle = "Cycleways"
  ) +
  coord_sf(datum = st_crs(28992))

# cusotmize plots
unique(lines_Delft$highway)

road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft |> 
  filter(highway %in% road_types) |>
  mutate(highway = factor(highway, levels = road_types))

road_colors <- c("blue", "green", "navy", "purple")

ggplot(data = lines_Delft_selection) + 
  geom_sf(aes(color = highway)) +
  scale_color_manual(values = road_colors) +
  labs(
    color = "Road Type",
    title = "Mobilitt network in Delft",
    subtitle = "Main Roads & Cycleways"
  ) +
  coord_sf(datum = st_crs(28992))

