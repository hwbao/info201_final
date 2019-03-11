# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

project_name <- "Art"
# Function to draw the graph for average amount of money 
# that a backer would give to a project in a given specific category
draw_backer_project_relationship <- function(project_name) {
  project_name_convert <- rlang::sym(project_name)
  
  select_project <- kickstarter %>%
    filter(main_category == project_name) %>%
    select(name,category,main_category, backers,pledged, state) %>% 
    group_by(category) %>% 
    summarize(total_pledged = sum(pledged), total_backers = sum(backers)) %>% 
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
}  



temp <- draw_backer_project_relationship("Art")
################################################################################  
  
  draw_graph <- plot_ly(type = "sankey",
                        domain = list(
                          x =  c(0,1),
                          y =  c(0,1)
                        ),
                        orientation = "h",
                        valueformat = ".0f",
                        valuesuffix = "TWh",
                        node = list(
                          label = kickstarter$main_category,
                          color = ~kickstarter$main_category,
                          pad = 15,
                          thickness = 15,
                          line = list(color = "black",
                                      width = 0.5
                          )
                        ),
                        link = list(source = kickstarter$main_categroy,
                                    target = kickstarter$category,
                                    value =  kickstarter$usd_plegged_real
                        )
                      ) %>% 
    layout(
      title = "Backer's Total Donate to each category and their sub category",
      font = list(
        size = 11
      ),
      xaxis = list(showgrid = F, zeroline = F),
      yaxis = list(showgrid = F, zeroline = F)
    )
  
  #return(select_project)
# }
