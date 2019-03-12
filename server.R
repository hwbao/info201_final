library(dplyr)
library(plotly)

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
  
  output$rate <- renderPlotly({ 
    find_rate(data, input$rate_main_category, as.numeric(input$year))
  }) 
  
})