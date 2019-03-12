library(dplyr)
library(plotly)

source("backer.R")
source("chart#3.R")
source("average goal.R")
source("scripts/initial_info.R")
data <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Start shinyServer
shinyServer(function(input, output) { 
  
  output$categories <- renderUI({
    selectInput(
      "selected_main_category",
      label = "Please choose the category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })
  
  output$num_rows <- renderText({ 
    num_rows(data)
  }) 
  
  output$rate <- renderPlotly({ 
    find_rate(data, input$rate_main_category, as.numeric(input$year))
  }) 
  
  output$mean_goal_main_category <- renderPlotly({ 
    main_category_analysis(data)
  }) 
  
  output$mean_goal_sub_category <- renderPlotly({ 
    sub_category_analysis(data, input$selected_main_category)
  }) 
  
  output$backers <- renderPlotly({
    draw_backer_project_relationship(data, input$type_project)
  })
})