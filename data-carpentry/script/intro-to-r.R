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

# Creating vectors
logical_vector <- c(TRUE, FALSE, TRUE, TRUE)
str(logical_vector)
numeric_vector <- c(1, 2, 3, 4, 5)
str(numeric_vector)
mix_vector <- c(logical_vector, numeric_vector)
str(mix_vector)
string_vector <- c("Amsterdam", "Delft", "'s-Gravenhague")
str(string_vector)
mix_vector_2 <- c(string_vector, numeric_vector)
str(mix_vector_2)
y <- x
rm(x)