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

