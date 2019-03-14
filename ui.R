library("shiny")
library("plotly")
library("shinythemes")

shinyUI(
  navbarPage(
    img(id = "logo", src = "ar_white.png"),
    theme = shinytheme("cyborg"),

    tags$head(
      tags$style(HTML("
      html, body {
            min-height:100%;
            overflow:auto;
      }      
      #sidebar{
            background-color: transparent;
            text-align: left;
      }
      .sliderInput {
            background-color: red;
      }
      #logo {
            width : 60px;
            height : 60px;
            align : top;
            padding-top: 0;
            padding-bottom: 20px;
      }

      #sankey {
        position:relative;
        min-height: 1500px;
        margin-bottom: -142px; 
        layout.autosize: true;
        margin: 0 auto;
      }

      .navbar { 
            font-family: 'Roboto';
            font-size: 11pt;
            color: rgb(178, 178, 178) ;
            height: 80px;
            padding-top: 15px;
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
      #graph_desc {
            font-size:10pt;
            max-width: 520px;
      }
      #container {
           min-height: 100%; /* will cover the 100% of viewport */
           overflow: hidden;
           display: block;
           position: relative;
           padding-bottom: 100px; /* height of your footer */
      }

      #node rect {
          cursor: move;
          fill-opacity: .9;
          shape-rendering: crispEdges;
      }
      #node text {
          color: white;
          pointer-events: none;
          text-shadow: 0 1px 0 #fff;
      }

    "))
    ),


    tabPanel("Home",
      icon = icon("home"),
      titlePanel(tags$h5("Home")),

      tags$div(
        id = "intro",
        tags$div(
          id = "container",

          tags$a(href = "https://www.kickstarter.com", "Kickstarter"),
          "is a global crowdfunding platform that focuses on 
              creativity and merchandising. Kickstarter has reportedly received 
              more than $4 billion in pledges from 15.5 million backers to fund 
              257,000 creative projects, such as films, music, video games, etc. 
              We have found our dataset about Kickstarter from the",
          tags$a(href = "https://www.kaggle.com/kemical/kickstarter-projects", "Kaggle Platform"),
          ".",
          tags$div(
            id = "intro",
            "This data includes total of 378661 observations from 2009 to 2018 including 
              different features such as name of the kickstarter project, category of the 
              project, goals for fundraising, duration of the fundraising process, amount of 
              money raised, and the status of the project(successful, fail, cancel, etc.)"
          ),
          tags$div(
            id = "intro",
            "Through our team's analysis, we have analyzed this data in terms of the 
              relationship and the trend of the successful rate with different category over 
              years, the average fundraising goal of a project, and the average amount of 
              money a backer would be willing to give. 
              We have created this website to proudly present our finding about the 
              kickstarter dataset."
          ),
          HTML("<p>  &nbsp </p>"), img(src = "ar_white.png", width = "60px", height = "40px"), tags$h5("About us"),
          tags$div(
            id = "intro",
            "We are Ar Analysis from INFO 201, section BC. 
              "
          ),
          tags$div(id = "intro", "Our group members: "),
          tags$div(id = "intro", "  -- Haowen Bao,
                       Zexin Lyu, Ruijun Guo, Yutian Lei")
        )
      )
    ),

    #--------------------------Success Rate----------------#
    tabPanel("Success Rate",
      icon = icon("star-half-alt"),
      tags$div(
        id = "container", titlePanel(tags$h5("Success Rate")),

        sidebarLayout(
          sidebarPanel(
            id = "sidebar",
            tags$div(id = "intro", HTML("This interactive timeline provides the information 
                     about the <b>successful rate</b> for each <b>different category</b> of <i>Kickstarter projects</i> in each years")),

            HTML("<br/> <br/> <br/> <br/> <br/> <br/> <br/> <br/> 
                               <br/> <br/> <br/> <br/> <br/> <br/> <br/>"),
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
    tabPanel("Goals",
      icon = icon("dollar-sign"),

      sidebarLayout(

        sidebarPanel(
          id = "sidebar",
          tags$h5("Average Goals"),
          tags$div(HTML("This bar graph provides the information about the average goal(USD) 
          for each main category.  <br/> 
          Categories like <b>technology</b>, <b>films and videos</b> and <b>games</b> have relatively high average goal
          while other categories like <b>dance</b>, <b>crafts</b> and <b>music</b> have a relatively lower average goal.


 <br/> <br/> <br/> <br/> <br/> 
<br/> <br/> <br/> <br/> <br/> ")),
          uiOutput("categories")
        ),

        mainPanel(
          plotlyOutput("mean_goal_main_category"),
          plotlyOutput("mean_goal_sub_category")
        ),
        position = "left"
      )
    ),

    #-------------------------------------------------------------#
    tabPanel("Investment Flows",
      icon = icon("location-arrow"),
      tags$div(
        id = "sankey",
        titlePanel(tags$h5("Where do the backers' investment go?")),
        tags$div(id = "intro", HTML("This sankey diagram provides the information 
        about the <b>flow</b> of the backers' investment. 
        The left side of the graph shows the main category, the right of the graph
        shows 3 different subcategories that received most amount of investment under each main category.
        The width of the strips that's connecting each main and sub category represents the amount of investment.")),

        plotlyOutput("sankey")
      )
    ),

    #-------------------------------------------------------------#
    tabPanel("Backer's Investment",
      icon = icon("hand-holding-usd"),
      tags$div(
        id = "container",
        titlePanel(tags$h5("Backer's Investment Information")),
        sidebarLayout(
          sidebarPanel(
            id = "sidebar",
            tags$div(id = "intro", HTML("This bar graph provides the information 
            of the average amount of money that a backer would give to a project 
            in specific category according to the user's input<br/><br/>")),
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