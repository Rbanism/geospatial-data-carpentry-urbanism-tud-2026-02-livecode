# install.packages("terra")

# Attach packages
library(tidyverse)
library(terra)

# Examine the data before loading it
describe("data/tud-dsm-5m.tif")

# Load the data
DSM_TUD <- rast("data/tud-dsm-5m.tif")

# Shortcut for <- is alt/option + -

# Exploring an object in R
str(DSM_TUD)
View(DSM_TUD)
summary(DSM_TUD)  # but this uses a sample and the min/max might not be accurate
summary(values(DSM_TUD))  # but this will take long for large data

# Visualising the DSM using ggplot
DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)
head(DSM_TUD_df)
str(DSM_TUD_df)
ggplot(data = DSM_TUD_df) +
  geom_raster(aes(x = x, y = y, fill = `tud-dsm-5m`)) +
  scale_fill_viridis_c(option = "turbo") +
  coord_equal()

# Examine the loaded raster
crs(DSM_TUD, proj = TRUE)
minmax(DSM_TUD)
DSM_TUD <- setMinMax(DSM_TUD)
minmax(DSM_TUD)
min(values(DSM_TUD))
max(values(DSM_TUD))
nlyr(DSM_TUD)

# Plot raster data

DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation = cut(`tud-dsm-5m`, breaks = 3))

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation))

custom_bins <- c(-10, 0, 5, 100)

DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation_cb = cut(`tud-dsm-5m`, breaks = custom_bins))

# examining the levels of a factor
levels(DSM_TUD_df$fct_elevation_cb)

# plot the new breaks
ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation_cb))

# plot the map

ggplot() +
  geom_raster(data = DSM_TUD_df,
              aes(x = x,
                  y = y,
                  fill = fct_elevation_cb))+
  coord_equal()

terrain.colors(3)
# colors: "#00A600" "#ECB176" "#F2F2F2"

ggplot() +
  geom_raster(data = DSM_TUD_df,
              aes(x = x,
                  y = y,
                  fill = fct_elevation_cb)) +
  scale_fill_manual(values = terrain.colors(3)) +
  labs(fill = "Elevationnnnnnnnn") +
  # theme(axis.title = element_blank()) +
  theme_void() +
  coord_equal() 

## Challenge solution
DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation_6 = cut(`tud-dsm-5m`, breaks = 6))

my_col <- terrain.colors(6)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(
    x = x,
    y = y,
    fill = fct_elevation_6
  )) +
  scale_fill_manual(values = my_col, name = "Elevation") +
  coord_equal() +
  labs(title = "Elevation Classes of the Digital Surface Model (DSM)")

# Reproject Raster Data
DTM_TUD <- rast("data/tud-dtm-5m.tif")
DTM_TUD_hill <- rast("data/tud-dtm-5m-hill-WGS84.tif")

# Create data frames for plotting
DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DTM_TUD_hill_df <- as.data.frame(DTM_TUD_hill, xy = TRUE)

# Plotting the layers together
ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(
      x = x,
      y = y,
      fill = `tud-dtm-5m`
    )
  ) +
  geom_raster(
    data = DTM_TUD_hill_df,
    aes(
      x = x,
      y = y,
      alpha = `tud-dtm-5m-hill`
    )
  ) +
  scale_fill_gradientn(name = "Elevation",
                       colors = terrain.colors(10)) +
  coord_equal()

# rasters do not align, checking the CRSs of both layers
crs(DTM_TUD)
crs(DTM_TUD_hill)

DTM_TUD_hill_28992 <- project(DTM_TUD_hill, crs())