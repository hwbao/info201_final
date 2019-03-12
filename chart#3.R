library("shiny")
library("plotly")
library("dplyr")
library(collection)

ks_data <- read.csv("./data/ks_projects_201801.csv", stringsAsFactors = F)

find_rate <- function(data, input_category, input_year){
  modified_df <- data %>% 
    select(input_category, state, deadline) %>% 
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>% 
    group_by_(input_category) %>% 
    filter(deadline == input_year) %>% 
    mutate(total_count = n()) %>% 
    filter(state == "successful") %>%
    mutate(success = n()) %>% 
    mutate(success_rate = round(success / total_count * 100, 1)) %>% 
    select(input_category, success_rate) %>% 
    unique(by = input_category) %>% 
    arrange(success_rate)
}

test_df <- find_rate(ks_data, "main_category", 2016)

find_line <- function(data, sub_category){
  modified_df <- data %>% 
    select(category, state, deadline) %>% 
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>% 
    group_by(deadline) %>% 
    filter(category == sub_category) %>% 
    mutate(total_count = n()) %>% 
    filter(state == "successful") %>%
    mutate(success = n()) %>% 
    mutate(success_rate = round(success / total_count * 100, 1)) %>% 
    select(category, success_rate, deadline) %>% 
    unique(by = deadline) %>% 
    ungroup(deadline) %>% 
    arrange(deadline)
}

test_line <- find_line(ks_data, "Drinks")

p1 <- plot_ly(
  test_df,
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
p1

p2 <- plot_ly(
  test_line, 
  x = ~deadline, 
  y = ~success_rate, 
  type = 'scatter', 
  mode = 'lines+markers')
p2







