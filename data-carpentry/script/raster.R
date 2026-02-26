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
