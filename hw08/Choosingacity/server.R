
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  city_data <- read_csv("data/finalcitydata.csv")
  
  Filtered_city <-  reactive({
    city_data %>%
      filter(`Quality of Living Ranking` >=input$rankingIn[1],
             `Quality of Living Ranking` <= input$rankingIn[2],
             Population >=input$populationIn[1],
             Population <= input$populationIn[2],
             prcp >=input$prcpIn[1],
             prcp <= input$prcpIn[2],
             tmin >=input$tminIn[1],
             tmin <= input$tminIn[2],
             tmax >=input$tmaxIn[1],
             tmax <= input$tmaxIn[2])
  })
  output$distplot <- renderPlotly({
    Filtered_city() %>% 
      ggplot() +
      aes(prcp) +
      geom_point(aes(y=tmax, colour="tmax", group = City)) +
      geom_point(aes(y=tmin, colour="tmin", group = City)) +
      lims(x=c(0,6.5),y=c(-5,30)) +
      coord_fixed(ratio = 0.1) +
      theme_minimal() +
      geom_vline(xintercept = 2.5) + geom_hline(yintercept = 10)+
      labs(y="Mean Daily Temperature Celcius", title= "Precipitation and MinMax Temperatures of World Cities", x= "Mean Daily Precipitation mm") +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(colour='Mean Daily Temperature')  +
      annotate("text", x = 1, y = 30, label = "Dry and Warm") +
      annotate("text", x = 6, y = 30, label = "Wet and Warm") +
      annotate("text", x = 0.5, y = -5, label = "Dry and Cold") +
      annotate("text", x = 6, y = -5, label = "Wet and Cold")
  })
  output$answertext <- renderText({
  	paste(nrow(Filtered_city()), "cities meet your criteria")
  })
  output$table_head <- renderTable({
    Filtered_city() %>% 
      head()
  }) 
})
