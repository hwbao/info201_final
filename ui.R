# Load the libraries that needed
library("shiny")
library("plotly")

shinyUI(
  navbarPage(img(src='ar.png', width = "80px", height = "60px",align = "top"),
             includeCSS("style.css"),
             
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
                      # Give the page a title
                      titlePanel("Success Rate"),
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
                          p("test")
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
                          selectInput("type_project",
                                      label = "Choose the Type of project",
                                      choices = list(
                                        
                                      )
                          )
                        ),
                        
                        mainPanel(
                          p("test")
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

