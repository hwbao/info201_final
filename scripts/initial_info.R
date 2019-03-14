library(dplyr)


data <- read.csv("./data/ks_projects_201801.csv", stringsAsFactors = F)

category_success <- data %>%
  group_by(main_category) %>%
  count(state == "successful", sort = T)

num_rows <- function(data) {
  HTML(nrow(data))
}

main_cat_list <- function(data) {
  result <- data %>% 
    select("main_category") %>% 
    arrange(main_category) %>% 
    unique() %>% 
    pull()
}

sub_cat_list <- function(data) {
  result <- data %>% 
    select("category") %>% 
    arrange(category) %>% 
    unique() %>% 
    pull()
}


