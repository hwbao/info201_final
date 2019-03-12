# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Function to draw the graph for average amount of money 
# that a backer would give to a project in a given specific category
draw_backer_project_relationship <- function(project_name) {
  
  select_project <- kickstarter %>%
    filter(main_category == project_name) %>%
    select(name,category,main_category, backers,pledged, state) %>% 
    group_by(category) %>% 
    summarize(total_pledged = sum(usd_pledged_real), total_backers = sum(backers)) %>% 
    mutate(avg = round(total_pledged / total_backers), 
           description = paste0(category,
                                "'s average pledge from each backer is ",
                                avg)
           )
  
  
  draw_each_sub <- plot_ly(select_project,
                          x = select_project$category,
                          y = select_project$avg,
                          text = ~description,
                          type = "bar",
                          name = select_project$category) %>%
                   layout(yaxis = list(title = "average pledged"))
  return(draw_each_sub)
}  

