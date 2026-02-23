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
summary(gapminder)

summary(gapminder$lifeExp)

# Create object with path to gapminder
path_to_gapminder <- here("data", "gapminder-data.csv")
path_to_gapminder
gapminder <- read.csv(path_to_gapminder)
str(gapminder)

# Selecting columns 
year_country_gdp <- select(gapminder, year, country, gdpPercap)
str(year_country_gdp)

year_country_gdp <- gapminder |>
  select(year, country, gdpPercap)
str(year_country_gdp)

# Filter rows
year_country_gdp_euro <- gapminder |> 
  filter(continent == "Europe") |> 
  head()
str(year_country_gdp_euro)

# Without head (selecting the first 6 observations)
year_country_gdp_euro <- gapminder |> 
  filter(continent == "Europe")
head(year_country_gdp_euro)
str(year_country_gdp_euro)

year_country_gdp_noteuro <- gapminder |> 
  filter(continent != "Europe") |> 
  dplyr::select(year, country, gdpPercap) #dplyr:: for using the function select from dplyr
head(year_country_gdp_noteuro)

year_country_gdp_noteuro2000 <- gapminder |> 
  filter(continent != "Europe" & year >= 2000) |> 
  select(year, country, gdpPercap)
head(year_country_gdp_noteuro2000)
summary(year_country_gdp_noteuro2000)

year_country_gdp_noteuroasia <- gapminder |> 
  filter(continent != "Europe" & continent != "Asia") |> 
  select(year, country, gdpPercap)
summary(year_country_gdp_noteuroasia)
head(year_country_gdp_noteuroasia)

year_country_gdp_euroasia <- gapminder |> 
  filter(continent == "Europe" | continent == "Asia") |> 
  select(year, country, gdpPercap)
head(year_country_gdp_euroasia)

gapminder |> 
  group_by(continent) |> 
  summarize(avg_gdpPercap = mean(gdpPercap))

# Create an object
avg_continent_gdpPercap <- gapminder |> 
  group_by(continent) |> 
  summarize(avg_gdpPercap = mean(gdpPercap))
head(avg_continent_gdpPercap)

# challenge: country longest and shortest life expectancy
# Calculate the life expectancy by country. Use min() and max(). 
gapminder |> 
  group_by(country) |> 
  summarize(avg_life = mean(lifeExp)) |> 
  filter(avg_life == min(avg_life) |
           avg_life == max(avg_life))

# Filter for a specific year
gapminder |> 
  filter(year == 2000) |> 
  summarize(avg_life = mean(lifeExp)) |> 
  filter(avg_life == min(avg_life) |
           avg_life == max(avg_life))

gapminder |> filter(year == 2000)
summary(gapminder)

gapminder |> 
  filter(year == 1952) |> 
  group_by(country) |>
  summarize(avg_life = mean(lifeExp, na.rm = TRUE)) |> 
  filter(avg_life == min(avg_life) |
           avg_life == max(avg_life))

# Mutate
gapminder_gdp <- gapminder |> 
  mutate(gdpBillion = gdpPercap * pop / 10^9)
head(gapminder_gdp)

# visualisation
library(tidyverse)
ggplot(
  data = gapminder,
  aes(x = lifeExp)
) +
  geom_histogram()

gapminder |> 
  filter(year == 2007 & continent == "Americas") |> 
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_col()

gapminder |> 
  filter(year == 2007 & continent == "Americas") |> 
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()

# Ordering countries
gapminder |> 
  filter(year == 2007 & continent == "Americas") |> 
  mutate(country = fct_reorder(country, gdpPercap)) |> 
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()

# Put some colour
gapminder |> 
  filter(year == 2007 & continent == "Americas") |> 
  mutate(country = fct_reorder(country, gdpPercap)) |> 
  ggplot(aes(
    x = country,
    y = gdpPercap,
    fill = lifeExp
  )) +
  geom_col() +
  coord_flip()

# Different color gradient 
p <- gapminder |> 
  filter(year == 2007 & continent == "Americas") |> 
  mutate(country = fct_reorder(country, gdpPercap)) |> 
  ggplot(aes(
    x = country,
    y = gdpPercap,
    fill = lifeExp
  )) +
  geom_col() +
  coord_flip() +
  scale_fill_viridis_c()

p

# Save the nice plot
ggsave(
  plot = p,
  filename = here("fig_output", "plot_americas_2007.pdf")
)
ggsave(
  plot = p,
  filename = here("fig_output", "plot_americas_2007.jpeg")
)
