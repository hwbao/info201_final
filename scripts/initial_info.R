library(dplyr)


data <- read.csv("./data/ks_projects_201801.csv")

category_success <- data %>%
  group_by(main_category) %>%
  count(state == "successful", sort = T)

num_rows <- function(data) {
  HTML(nrow(data))
}


