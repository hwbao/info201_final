library("shiny")
library("plotly")

shinyUI(
  navbarPage(img(id = "kickstart_logo" , src='kickstarter.png', width = "250px",
                 height = "50px", align = "top"),
             theme = "style.css",
             
  
            tabPanel("Home",
                    titlePanel("Home"),
                    img(id = "logo" , src='ar.png', width = "80px",
                          height = "60px", align = "top"),
                    
                     
            tags$body(
              tags$a(href = "https://www.kickstarter.com", "Kickstarter"),
              "is a global crowdfunding platform that focuses on 
              creativity and merchandising. Kickstarter has reportedly received 
              more than $4 billion in pledges from 15.5 million backers to fund 
              257,000 creative projects, such as films, music, video games, etc. 
              We have found our dataset about Kickstarter from the",
              tags$a(href = "https://www.kaggle.com/kemical/kickstarter-projects", "Kaggle Platform"),
              
              "This data includes total of 378661 observations from 2009 to 2018 including 
              different features such as name of the kickstarter project, category of the 
              project, goals for fundraising, duration of the fundraising process, amount of 
              money raised, and the status of the project(successful, fail, cancel, etc.)
              Through our team’s analysis, we have analyzed this data in terms of the 
              relationship and the trend of the successful rate with different category over 
              years, the average fundraising goal of a project, and the average amount of 
              money a backer would be willing to give. 
              We have created this website to proudly present our finding about the 
              kickstarter dataset."
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

