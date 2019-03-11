library(dplyr)
library(lubridate)

data <- read.csv("./data/ks_projects_201801.csv")

category_success <- data %>% 
  group_by(main_category) %>% 
  count(state == "successful", sort = T)

date <- head(data,10) %>% 
  select(name, deadline, state) 

  #format(as.Date(data$deadline, format="%Y-%m-%d"), "%Y")

year = floor_date(as.Date(date$deadline, format = "%Y-%m-%d"))

by_year <- date %>%
  group_by(
    year = floor_date(as.Date(date$deadline, format = "%Y-%m-%d"),
                       unit = "year"
    )
  ) %>%
  count()