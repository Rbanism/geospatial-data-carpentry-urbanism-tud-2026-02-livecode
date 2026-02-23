# our first function in r (YEY!)
1 + 1

# Install packages 
install.packages("here")

# Loading packages
library(tidyverse)
library(here)

here()
here("data")

x <- 5
x

y <- x + 2
y
sqrt(y)

# download data
download.file(
  "https://bit.ly/geospatial_data",
  here("data", "gapminder-data.csv")
)

# Explore the data
gapminder <- read.csv(here("data", "gapminder-data.csv"))
View(gapminder)
str(gapminder)

logical_vector <- c(TRUE, FALSE, TRUE, TRUE)
str(logical_vector)
