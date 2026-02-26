# Attach packages
library(tidyverse)
library(sf)
library(here)

# Load the boundary of Delft
boundary_Delft <- st_read("data/delft-boundary.shp", quiet=TRUE)
boundary_Delft

# Examine the properties of the input data

## Geometry type, in this case POLYGON
st_geometry_type(boundary_Delft)

## CRS and bounding box
st_crs(boundary_Delft)
st_bbox(boundary_Delft)

## Project to Amersfoort / RD New
boundary_Delft <- st_transform(boundary_Delft, crs=28992) # transforms and overwrites object

st_crs(boundary_Delft) # examine new EPSG code
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$epsg

st_bbox(boundary_Delft) # bounding box

st_crs(boundary_Delft)$units_gdal

boundary_Delft

# Plot the boundary of Delft
ggplot(data=boundary_Delft) +
  geom_sf(size=3, color="black", fill="cyan1") +
  labs(title="Delft Administrative Boundary") +
  coord_sf(datum=st_crs(28992)) # display the axis in metres

# Load the streets and leisure data
lines_Delft <- st_read(here("data", "delft-streets.shp"))
point_Delft <- st_read(here("data", "delft-leisure.shp"))

# Examine streets data
lines_Delft
ncol(lines_Delft)

names(lines_Delft)

head(lines_Delft)

head(lines_Delft$highway)

# Check unique highway values
unique(lines_Delft$highway)

# we can also examine unique values by transforming the
# variable into a factor
factor(lines_Delft$highway) |> levels()
factor(lines_Delft$highway) |> head()

# Examine leisure data
point_Delft

head(point_Delft, 10)

na.omit(point_Delft$leisure) |> head(10)

factor(point_Delft$leisure) |>
  levels() |>
  head(3)

# Subsetting the data: we only keep cycleways
cycleway_Delft <- lines_Delft |>
  filter(highway == "cycleway")

nrow(cycleway_Delft)
nrow(lines_Delft)

unique(lines_Delft$highway)

# We can also subset multiple values using the %in% operator
slow_Delft <- lines_Delft |>
  filter(highway %in% c("cycleway", "footway"))
nrow(slow_Delft)
unique(slow_Delft$highway)

# Create new variable (data frame column) with mutate()
cycleway_Delft <- cycleway_Delft |>
  mutate(length = st_length(geometry))

# Calculate total length of cycleways
cycleway_Delft |>
  summarise(total_length = sum(length))

# Plot the cycleways
ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(
    title = "Slow mobility newtork in Delft",
    subtitle = "Cycleways"
  ) +
  coord_sf(datum = st_crs(28992))

# Customize plots
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

# Challenge 5 solution: cycleways highlighted on street network

ggplot(data = lines_Delft) +
  geom_sf(linewidth = 0.1) +
  geom_sf(
    data = cycleway_Delft,
    aes(color = highway),
    linewidth = 1
  ) +
  scale_color_manual(values = "magenta") +
  labs(
    title = "Mobility network in Delft",
    subtitle = "Roads dedicated to bikes"
  ) +
  coord_sf(datum = st_crs(28992))

# Plot multiple shapefiles
ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey",
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    linewidth = 1
  ) +
  geom_sf(data = point_Delft) +
  labs(title = "Mobility network of Delft") +
  coord_sf(datum = st_crs(28992))

# Customise point layer
point_Delft$leisure <- factor(point_Delft$leisure)
levels(point_Delft$leisure) |> length()

leisure_colors <- rainbow(15)
leisure_colors

ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey",
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    linewidth = 1
  ) +
  geom_sf(
    data = point_Delft,
    aes(fill = leisure),
    shape = 21
  ) +
  scale_color_manual(
    values = road_colors,
    name = "Road Type"
  ) +
  scale_fill_manual(
    values = leisure_colors,
    name = "Leisure Location"
  ) +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))

# working with data from different sources
municipal_boundary_NL <- st_read("data/nl-gemeenten.shp")

ggplot() +
  geom_sf(data = municipal_boundary_NL) +
  geom_sf(data = boundary_Delft, fill = "purple", color = "purple") +
  labs(title = "Map of contiguous NL municipal boundaries") +
  coord_sf(datum = st_crs(28992))

# Saving a shapefile
st_write(lines_Delft_selection,
         "data/lines-delft-selection.shp",
         driver = "ESRI Shapefile")
