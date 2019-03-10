# Load the libraries that needed
library("shiny")
library("plotly")

# shinyUI that arrange the user interface
shinyUI(
  # Create a well organized page with navbarPage
  navbarPage("Kickstarter information",
             theme = ("style.css"),
             
             # Create the third page that contains the information about backer
             tabPanel("Backer's Investment Information", 
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
             

  )
)

