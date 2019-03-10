library(shiny)
library(plotly)

shinyUI(navbarPage(
  "Kickstarter Crowdfoundraising Analysis",
  tabPanel(
    "home",
    titlePanel("Race distribution at different county in the midwest"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        selectInput(
          "state",
          label = "State Name",
          choices = list(
            "Illinois" = "IL",
            "Indiana" = "IN",
            "Michigan" = "MI",
            "Ohio" = "OH",
            "Wisconsin" = "WI"
          )
        ),
        uiOutput("county_selction")
        
      ),  
      
      mainPanel(
        plotlyOutput("pie")
      )
      
    )
  ),
  
  tabPanel(
    "page1",
    titlePanel("Percentage of Poverty v.s. Percentage of College Education / Profession"),
    
    sidebarLayout(
      
      sidebarPanel(
        selectInput(
          "poverty",
          label = "Poverty Type",
          choices = list(
            "Percentage Below Poverty" = "percbelowpoverty",
            "Percentage of Children in Poverty" = "percchildbelowpovert",
            "Percentage of Adult in Poverty" = "percadultpoverty",
            "Percentage of Elderly in Poverty" = "percelderlypoverty"
          )
        ),
        
        selectInput(
          "condition",
          label = "College Education / Profession",
          choices = list(
            "Percentage of College Educated" = "percollege",
            "Percentage of Profession" = "percprof"
          )
        )
      ),
      
      mainPanel(
        plotlyOutput("scatter")
      )
      
    )
  ),
  
  tabPanel(
    "page2",
    titlePanel("Percentage of Poverty v.s. Percentage of College Education / Profession"),
    
    sidebarLayout(
      
      sidebarPanel(
        selectInput(
          "poverty",
          label = "Poverty Type",
          choices = list(
            "Percentage Below Poverty" = "percbelowpoverty",
            "Percentage of Children in Poverty" = "percchildbelowpovert",
            "Percentage of Adult in Poverty" = "percadultpoverty",
            "Percentage of Elderly in Poverty" = "percelderlypoverty"
          )
        ),
        
        selectInput(
          "condition",
          label = "College Education / Profession",
          choices = list(
            "Percentage of College Educated" = "percollege",
            "Percentage of Profession" = "percprof"
          )
        )
      ),
      
      mainPanel(
        plotlyOutput("scatter")
      )
      
    )
  ),
  
  tabPanel(
    "page3",
    titlePanel("Percentage of Poverty v.s. Percentage of College Education / Profession"),
    
    sidebarLayout(
      
      sidebarPanel(
        selectInput(
          "poverty",
          label = "Poverty Type",
          choices = list(
            "Percentage Below Poverty" = "percbelowpoverty",
            "Percentage of Children in Poverty" = "percchildbelowpovert",
            "Percentage of Adult in Poverty" = "percadultpoverty",
            "Percentage of Elderly in Poverty" = "percelderlypoverty"
          )
        ),
        
        selectInput(
          "condition",
          label = "College Education / Profession",
          choices = list(
            "Percentage of College Educated" = "percollege",
            "Percentage of Profession" = "percprof"
          )
        )
      ),
      
      mainPanel(
        plotlyOutput("scatter")
      )
      
    )
  )
  
))
