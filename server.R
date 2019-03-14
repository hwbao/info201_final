library(dplyr)
library(plotly)

source("backer.R")
source("chart#3.R")
source("average goal.R")
source("scripts/initial_info.R")
source("total_backer.R")
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

  output$backer_ui <- renderUI({
    selectInput(
      "type_project",
      label = "Please choose the category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })

  output$line_ui1 <- renderUI({
    selectInput(
      "line_main_category",
      label = "Please choose the main category you are interested in",
      choices = as.list((main_cat_list(data)))
    )
  })

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

  output$rate <- renderPlotly({
    find_rate(data, as.numeric(input$year))
  })

  output$line_rate <- renderPlotly({
    line_plot(data, input$line_sub_category)
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

  output$sankey <- renderPlotly({
    draw_sankey_graph(data)
  })
})