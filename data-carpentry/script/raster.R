# install.packages("terra")

# Attach packages
library(tidyverse)
library(terra)

# Examine the data before loading it
describe("data/tud-dtm-5m.tif")

# Load the data
rast("data/tud-dsm-5m.tif")