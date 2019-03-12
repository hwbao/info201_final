library(dplyr)
library(plotly)

source("backer.R")
source("chart#3.R")
source("average goal.R")
source("scripts/initial_info.R")
data <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Start shinyServer
shinyServer(function(input, output) { 
  
  output$county_selction <- renderUI({
    selectInput(
      "county",
      label = "County Name",
      choices = as.list(county_name(input$state))
    )
  })
  
  output$num_rows <- renderText({ 
    num_rows(data)
  }) 
  
  output$rate <- renderPlotly({ 
    find_rate(data, input$rate_main_category, as.numeric(input$year))
  }) 
  
})