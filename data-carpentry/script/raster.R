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





