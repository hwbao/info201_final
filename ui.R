library("shiny")
library("plotly")
library("shinythemes")

shinyUI(
  
  navbarPage(
    
    
    img(id = "kickstart_logo" , src='ar_white.png', width = "70px",
                 height = "50px", align = "top"),
                 theme = shinytheme("cyborg"),
    
    tags$head(
      tags$style(HTML("
      html, body {
            min-height:100%;
            overflow:auto;
      }      

      #snakey {
        position:relative;
        min-height: 1000px;
        /* equal to footer height */
        margin-bottom: -142px; 
      }

      .navbar { 
            font-family: 'Roboto';
            color: rgb(178, 178, 178) ;
      }
      body {
            min-height:100%;
            max-width: 1500px;
            margin: 0 auto;
            letter-spacing: 2.5px;
            font-size : 12pt;
            color:rgb(178, 178, 178);
            
      }
      footer {
            font-family: 'Roboto';
            margin-top: 100px;
            position: -ms-page;
            bottom:0;
            height:60px;
            text-align: right;
      }
      #intro {
            max-width: 624px;
      }
      #container {
           min-height: 100%; /* will cover the 100% of viewport */
           overflow: hidden;
           display: block;
           position: relative;
           padding-bottom: 100px; /* height of your footer */
      }

    "))
    ),
             
  
            tabPanel( "Home", icon = icon("home"), 
                    titlePanel(tags$h5("Home")),
                     
            tags$div(id = "intro",
              tags$div(id = "container", 
              
              tags$a(href = "https://www.kickstarter.com", "Kickstarter"),
              "is a global crowdfunding platform that focuses on 
              creativity and merchandising. Kickstarter has reportedly received 
              more than $4 billion in pledges from 15.5 million backers to fund 
              257,000 creative projects, such as films, music, video games, etc. 
              We have found our dataset about Kickstarter from the",
              tags$a(href = "https://www.kaggle.com/kemical/kickstarter-projects", "Kaggle Platform"), 
              "."
              ,tags$div(id = "intro",
              "This data includes total of 378661 observations from 2009 to 2018 including 
              different features such as name of the kickstarter project, category of the 
              project, goals for fundraising, duration of the fundraising process, amount of 
              money raised, and the status of the project(successful, fail, cancel, etc.)")
              
              ,tags$div(id = "intro",
              "Through our team's analysis, we have analyzed this data in terms of the 
              relationship and the trend of the successful rate with different category over 
              years, the average fundraising goal of a project, and the average amount of 
              money a backer would be willing to give. 
              We have created this website to proudly present our finding about the 
              kickstarter dataset.")
              ,HTML("<p>  &nbsp </p>")
              ,tags$h5("About us"),
              img(id = "ar_logo" , src='ar_white.png', width = "60px",
                  height = "40px", align = "left"),
              tags$div(id = "intro",
              "We are Ar Analysis from INFO 201, section BC.")
            
            )
            )
            ),
             
             #--------------------------Success Rate----------------#
             tabPanel("Success Rate", icon = icon("star-half-alt"),
                      tags$div(id = "container", titlePanel(tags$h5("Success Rate")),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("year", 
                                      label = "Please choose the year you are interested in",
                                      min = 2009, max = 2017,
                                      value = 2009
                          ),
                          uiOutput("line_ui1"),
                          uiOutput("line_ui2")
                          ),
                        mainPanel(
                          plotlyOutput("rate"),
                          plotlyOutput("line_rate")
                        )
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
                     tags$div(id = "snakey",
                     titlePanel(tags$h5("Where do the backers' investment go?")),
                     
                       mainPanel(
                         plotlyOutput("sankey")
                       )
                     
                     )
            ),
             
             #-------------------------------------------------------------#
             tabPanel("Backer's Investment", icon = icon("hand-holding-usd"),
                      tags$div(id = "container",
                      titlePanel(tags$h5("Backer's Investment Information")),
                      sidebarLayout(
                        sidebarPanel(
                          uiOutput("backer_ui")
                        ),
                        
                        mainPanel(
                          plotlyOutput("backers")
                        )
                      )
                      )
             ),
             #-------------------------------------------------------------#
            tags$footer(
              HTML("<p> Made By Ar Analysis  &copy 2019 </p>")
            )
  )
  
  
)

