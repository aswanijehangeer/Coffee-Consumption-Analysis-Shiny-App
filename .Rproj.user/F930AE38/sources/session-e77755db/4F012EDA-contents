# Installing and Loading required packages.

# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("janitor")


library(tidyverse)
library(readxl)
library(janitor)

# Importing the dataset (In current working directory)
coffee_data <- read_xlsx("Coffee Caffeine Content.xlsx")

# Cleaning Names
coffee_data <- coffee_data |> 
  clean_names()


#### Theme set ----
theme_set(theme_minimal(base_size = 12, base_family = "Open Sans"))

#### Theme update ----
theme_update(
  axis.ticks = element_line(color = "grey9"),
  axis.ticks.length = unit(0.5, "lines"),
  panel.grid.minor = element_blank(),
  legend.title = element_text(size = 12),
  legend.text = element_text(color = "grey9"),
  plot.title = element_text(size = 18, face = "bold"),
  plot.subtitle = element_text(size = 12, color = "grey9"),
  plot.caption = element_text(size = 9, margin = margin(t = 15))
)

