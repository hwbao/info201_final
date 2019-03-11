library("shiny")
library("plotly")
library("dplyr")
library("lubridate")
library(collection)

ks_data <- read.csv("data/ks-projects-201801.csv", stringsAsFactors = F)

category_data2 <- ks_data %>% 
  select(category, main_category, state, deadline) %>% 
  filter(main_category == "Art") %>% 
  group_by(category) %>% 
  summarise(count = n())

category_data <- ks_data %>% 
  select(category, main_category, state, deadline)
  #format(as.Date(category_data$deadline, format="%Y-%m-%d"), "%Y")

find_rate <- function(data, input_category, input_year){
  col_name <- deparse(substitute(input_category))
  modified_df <- data %>% 
    select(col_name, state, deadline) %>% 
    mutate(deadline = substring(deadline, 1, 4)) %>% 
    group_by(col_name) %>% 
    filter(deadline == input_year) %>% 
    mutate(total_count = n()) %>% 
    filter(state == "successful") %>%
    mutate(success = n()) %>% 
    mutate(success_rate = round(success / total_count * 100, 1)) %>% 
    select(col_name, success_rate) %>% 
    unique(by = col_name)
}

test_df <- find_rate(ks_data, "main_category", "2017")



p <- plot_ly(
  main_cat,
  x = ~main_category,
  y = ~success_rate,
  name = "Race chart",
  type = "bar"
  #marker = list(color = input$colors)
) %>%
  layout(
    title = paste("Population of Each Race at"),
    yaxis = list(title = "Population (thousand)"),
    xaxis = list(title = "Race")
  )
p








