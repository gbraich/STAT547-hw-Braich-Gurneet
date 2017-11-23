#
library(shiny)
library(tidyverse)
library(plotly)


shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("City Selector: Where in world should you live?")),
  
  sidebarPanel(h3("What should we consider?"),
               br(),
               "When picking a city to live in, like any other decision in life, we should weigh the options and look at the data.",
               br(),
               br(),
               "For the cities in the top 51 of the",
               a(href="https://en.wikipedia.org/wiki/Mercer_Quality_of_Living_Survey", "Mercer Quality of Living Rankings,"),
               "I have also included population and weather data.  This website can be used to find a city that fits in that Goldilocks zone of being",
               em("just right"),
               br(),
               br(),
               sliderInput("rankingIn", "Mercer Quality of Living Ranking",
                           min=1, max=51, 
                           value= c(1,10), pre="RANK"),
               sliderInput("populationIn", "City Population",
                           min=300000, max=12000000, 
                           value= c(500000,1000000)),
               sliderInput("prcpIn", "Mean Daily Precipitation",
                           min=0, max=8, 
                           value= c(1,3), post="mm"),
               sliderInput("tminIn", "Mean Daily Minimum Temperature",
                           min=-6, max=27, 
                           value= c(1,10), post="C"),
               sliderInput("tmaxIn", "Mean Daily Maximum Temperature",
                           min=0, max=30, 
                           value= c(10,20), post="C"),
  			 downloadLink('downloadData', 'Download')),
  
  mainPanel(plotlyOutput("distplot"),
  		  br(),br(),
  		  textOutput("answertext"),
  		  br(),br(),
            tableOutput("table_head"),
            br(),
            "When I designed this dataset and website I drew inspiration from a recent",
            a(href="https://xkcd.com/1916/", "xkcd comic"),
            br(),
            br(),
            img(src='xkcd.png', align = "centre", height = 600, width = 600))))

