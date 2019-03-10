# Load the libraries that needed
library("shiny")
library("plotly")

shinyUI(
  navbarPage("Kickstarter information",
             theme = ("style.css"),
             
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
                          p("test")
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
             tabPanel("Countries", 
                      # Give the page a title
                      titlePanel("Countries"),
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
                          p("test")
                        )
                      )
             )
             #-------------------------------------------------------------#
             

  )
)

