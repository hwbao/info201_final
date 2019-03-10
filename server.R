library(dplyr)
library(ggplot2)

source("scripts/initial_info.R")


# Start shinyServer
shinyServer(function(input, output) { 
  
  output$county_selction <- renderUI({
    selectInput(
      "county",
      label = "County Name",
      choices = as.list(county_name(input$state))
    )
  })
  
  #output$pie <- renderPlotly({ 
    
  #}) 
  
  
})