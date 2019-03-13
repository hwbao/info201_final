library("shiny")
library("plotly")
library("shinythemes")

shinyUI(
  
  navbarPage(
    
    
    img(id = "kickstart_logo" , src='kickstarter_white.png', width = "333px",
                 height = "50px", align = "top"),
                 theme = shinytheme("cyborg"),
    
    tags$head(
      tags$style(HTML("
      
      .navbar { 
            font-family: 'Roboto';
            color: rgb(221, 221, 221) ;
                      }
      body {
            max-width: 1500px;
            margin: 0 auto;
            letter-spacing: 3px;
            color:rgb(221, 221, 221);
      }
      footer {
            margin-top: 100px;
      }
      #intro {
            max-width: 624px;
      }

    "))
    ),
             
  
            tabPanel( "Home", icon = icon("home"), 
                    titlePanel(tags$h5("Home")),
                     
            tags$div( id = "intro",
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
              Through our team's analysis, we have analyzed this data in terms of the 
              relationship and the trend of the successful rate with different category over 
              years, the average fundraising goal of a project, and the average amount of 
              money a backer would be willing to give. 
              We have created this website to proudly present our finding about the 
              kickstarter dataset."
            )            
            ),
             
             #--------------------------Success Rate----------------#
             tabPanel("Success Rate", icon = icon("star-half-alt"),
                      titlePanel(tags$h5("Success Rate")),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("year", 
                                      label = "Please choose the year you are interested in",
                                      min = 2009, max = 2017,
                                      value = 2009
                          ),
                          selectInput("rate_sub_category",
                                      label = "Please choose the sub category you are interested in",
                                      choices = list(
                                        "All Category" = "category"
                                      )
                          )
                          
                        ),
                        
                        mainPanel(
                          plotlyOutput("rate")
                        )
                      )
             ),
             #-------------------------------------------------------------#
             tabPanel("Goals", icon = icon("dollar-sign"),
                      titlePanel(tags$h5("Average Goals")),
                      sidebarLayout(
                        sidebarPanel(
                          uiOutput("categories")
                        ),
                        
                        mainPanel(
                          plotlyOutput("mean_goal_main_category"),
                          plotlyOutput("mean_goal_sub_category")
                        )
                      )
             ),
            
            #-------------------------------------------------------------#
            tabPanel("Pledged Money", icon = icon("dollar-sign"),
                     titlePanel(tags$h5("Where")),
                     sidebarLayout(
                       sliderInput("top_project", 
                                   label = "Please choose the top amount of data you want to see",
                                   min = 0, max = 50,
                                   value = 20
                       ),
                       
                       mainPanel(
                         plotlyOutput("sankey")
                       )
                     )
            ),
             
             #-------------------------------------------------------------#
             tabPanel("Backer's Investment", icon = icon("hand-holding-usd"),
                      titlePanel(tags$h5("Backer's Investment Information")),
                      sidebarLayout(
                        sidebarPanel(
                          uiOutput("backer_ui")
                        ),
                        
                        mainPanel(
                          plotlyOutput("backers")
                        )
                      )
             ),
             #-------------------------------------------------------------#
            tags$footer(
              img(id = "ar_logo" , src='footer.png', width = "414px",
                  height = "45px", align = "right" )
            )
  )
  
  
)

