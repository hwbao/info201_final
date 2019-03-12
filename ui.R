# Load the libraries that needed
library("shiny")
library("plotly")

source("backer.R")
source("chart#3.R")
source("average goal.R")

shinyUI(
  navbarPage(img(src='ar.png', width = "80px", height = "60px",align = "top"),
             #includeCSS("style.css"),
             tags$head(tags$link(href = "style.css", rel = "stylesheet")),
             
             tabPanel("Home", 
                      titlePanel("Home"),
                     
                      sidebarLayout(
                        # Set all the choices that user can make, and how
                        # each button work, and their names
                        sidebarPanel(
                          # The user input of different type of project
                          selectInput("type_project",
                                      label = "Choose the Type of project",
                                      choices = list(
                                        
                                      )
                          )
                        ),
                        
                        mainPanel(
                          tags$p("test"),
                          tags$div(class="header", checked=NA,
                                   tags$p("Ready to take the Shiny tutorial? If so"),
                                   tags$a(href="shiny.rstudio.com/tutorial", "Click Here!")
                          )
                          
                        )
                      )
             ),
             
             #--------------------------Success Rate----------------#
             tabPanel("Success Rate", 
                      titlePanel("Success Rate"),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("rate_main_category",
                                      label = "Please Choose the Category You are interested in",
                                      choices = list(
                                        "All Category" = "main_category"
                                      )
                          ),
                          sliderInput("year", 
                                      label = "Please Choose the <em>Year</em> You are interested in",
                                      min = 2009, max = 2017,
                                      value = 2009
                          )
                        ),
                        
                        mainPanel(
                          plotlyOutput("rate")
                        )
                      )
             ),
             #-------------------------------------------------------------#
             tabPanel("Goals", 
                      # Give the page a title
                      titlePanel("Average Goals"),
                      # Create The side bar layout
                      sidebarLayout(
                        # Set all the choices that user can make, and how
                        # each button work, and their names
                        sidebarPanel(
                          # The user input of different type of project
                          selectInput("main_category",
                                      label = "Please Choose the Category You are interested in",
                                      choices = list(
                                        "All Category" = "main_category"
                                      )
                          )
                        ),
                        
                        mainPanel(
                          plotlyOutput("mean_goal_main_category"),
                          plotlyOutput("mean_goal_sub_category")
                        )
                      )
             ),
             
             #----------------------------------------Celia----------------#
             tabPanel("Backer's Investment", 
                      # Give the page a title
                      titlePanel("Backer's Investment Information"),
                      # Create The side bar layout
                      sidebarLayout(
                        # Set all the choices that user can make, and how
                        # each button work, and their names
                        sidebarPanel(
                          # The user input of different type of project
                          selectInput("type_project",
                                      label = "Choose the Type of project",
                                      choices = list(
                                        
                                      )
                          )
                        ),
                        
                        mainPanel(
                          p("test")  #plotly_graph
                        )
                      )
             )
             #-------------------------------------------------------------#
  )
)

