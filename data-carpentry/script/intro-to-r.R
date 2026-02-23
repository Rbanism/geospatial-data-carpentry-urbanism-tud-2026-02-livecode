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

# Replace values
y <- x
rm(x)

# Ordering of vector types
mix_vector_3 <- c(numeric_vector, string_vector)
str(mix_vector_3)

# Missing values
with_na <- c(1, 2, 1, 1, NA, 3, NA)
str(with_na)

mean(with_na)
mean(with_na, na.rm = TRUE)

is.na(with_na)
!is.na(with_na)

without_na <- with_na[!is.na(with_na)]
str(without_na)

# Subset
with_na[1]
with_na[3]
with_na[1:3]

# Back to our gapminder data
gapminder <- read.csv(here("data", "gapminder-data.csv"))
str(gapminder)

nrow(gapminder)
ncol(gapminder)

head(gapminder)
