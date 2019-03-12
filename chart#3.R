library("shiny")
library("plotly")
library("dplyr")
library("lubridate")

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
    select("input_category", success_rate) %>% 
    unique(by = "input_category") %>% 
    arrange(success_rate)
  
  modified_df$"input_category" <- factor(modified_df$"input_category", 
                          levels = c(as.character(modified_df$"input_category")))
  
  p <- plot_ly(
    modified_df,
    x = "input_category",
    y = ~success_rate,
    name = "Race chart",
    type = "bar"
    #marker = list(color = input$colors)
  ) %>%
    layout(
      title = paste("Success Rate vs. Different Main Category in ", input_year),
      yaxis = list(title = "Success Rate (%)"),
      xaxis = list(title = "Category")
    )
  
  return(p)
}

