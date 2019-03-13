# load package 
library(dplyr)
library(plotly)

# Function to draw the graph for average amount of money 
# that a backer would give to a project in a given specific category
draw_backer_project_relationship <- function(data, project_name) {
  
  select_project <- kickstarter %>%
    filter(main_category == project_name) %>%
    select(name, category, main_category, backers, usd_pledged_real, state) %>% 
    group_by(category) %>% 
    summarize(total_pledged = sum(usd_pledged_real),
              total_backers = sum(backers)) %>% 
    mutate(avg = round(total_pledged / total_backers), 
           description = paste0(category,
                                "'s average pledge from each backer is $",
                                avg)
           ) %>% 
    arrange(-avg)
  
  select_project$category <- factor(select_project$category, 
                        levels = c(as.character(select_project$category)))
  
  draw_each_sub <- plot_ly(select_project,
                          x = ~category,
                          y = ~avg,
                          text = ~description,
                          type = "bar",
                          name = ~category) %>%
                   layout(title = "Backer's average investment",
                          font = list(color = "#C0C0C0"),
                          yaxis = list(title = "average pledged"),
                          paper_bgcolor = "black",
                          plot_bgcolor = "black",
                          showlegend = TRUE)
} 

