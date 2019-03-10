# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.cvs")


project_name <- "Art"
# Function to draw the graph for average amount of money 
# that a backer would give to a project in a given specific category
#draw_backer_project_relationship <- function(project_name) {
  project_name_convert <- rlang::sym(project_name)
  count_rows <- kickstarter %>%
    filter(main_category == project_name) %>%
    nrow()
  
  select_project <- kickstarter %>%
    filter(main_category == project_name) %>%
    mutate(average_each_one = usd_pledged_real / backers) %>%
    group_by(main_category, average_each_one, name, ID, category, usd_goal_real, backers, state, usd_pledged_real) %>%
    summarise(the_final_average = sum(average_each_one) / count_rows)
  
  draw_graph <- plot_ly(
    select_project, x = ~the_final_average, y = ~backers,
    # Hover text:
    text = ~paste0("ID: ", ID,
                   "project name: ", name,
                   "specific category: ", category,
                   "their usd goal: ", usd_goal_real,
                   "their final pledged :", usd_pledged_real,
                   "their state: ", state),
    color = ~the_final_average, size = ~the_final_average
  )
  
  #return(select_project)
# }

