library(dplyr)
library(plotly)
# loading related documents and library, read in dataset
source("scripts/backer.R")
source("scripts/chart#3.R")
source("scripts/average goal.R")
source("scripts/initial_info.R")
source("scripts/total_backer.R")
data <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Start shinyServer
shinyServer(function(input, output) {
  # show main categories in drop down menu
  output$categories <- renderUI({
    selectInput(
      "selected_main_category",
      label = "Please choose the category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })
  
  # show main categories in drop down menu
  output$backer_ui <- renderUI({
    selectInput(
      "type_project",
      label = "Please choose the category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })

  # show main categories in drop down menu
  output$line_ui1 <- renderUI({
    selectInput(
      "line_main_category",
      label = "Please choose the main category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })

  # show sub categories in drop down menu
  output$line_ui2 <- renderUI({
    selectInput(
      "line_sub_category",
      label = "Please choose the sub category you are interested in",
      choices = as.list((sub_cat_list(data, input$line_main_category)))
    )
  })

  output$num_rows <- renderText({
    num_rows(data)
  })

  # return babble chart
  output$rate <- renderPlotly({
    find_rate(data)
  })

  # return line plot
  output$line_rate <- renderPlotly({
    line_plot(data, input$line_sub_category)
  })

  # return bar chart
  output$mean_goal_main_category <- renderPlotly({
    main_category_analysis(data)
  })

  # return bar chart
  output$mean_goal_sub_category <- renderPlotly({
    sub_category_analysis(data, input$selected_main_category)
  })
  
  # return bar chart
  output$backers <- renderPlotly({
    draw_backer_project_relationship(data, input$type_project)
  })
  
  # return sankey chart
  output$sankey <- renderPlotly({
    draw_sankey_graph(data)
  })
})