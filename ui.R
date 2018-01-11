#
# This is the user-interface part of a Shiny web application.
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Application to compare regression modeling results for relationship between Miles per Gallon and Transmission type in cars from years 1973-1974"),
  
  # Application manual part
  h3("Application manual"),
  
  p("|mtcars| is a data frame with 32 observations on 11 variables. 
    The data was extracted from the 1974 |Motor Trend US| magazine, 
    and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles.
    |mpg| variable means Miles Per Gallon, |wt| variable means Weight in 1000lbs, |qsec| variable means 1/4 mile time 
    and |am| variable means Transmission, where |am = 0| means Automatic Transmission and |am = 1| means Manual Transmission."),
  p("The application shows how Miles per Galon depends from Transmission type. It contain two linear regression models
    - Ordinary Regression Model and Robust Regression Model. Ordinary Regression Model is calculated using lm(mpg ~ wt + qsec + am) function 
    and Robust Regression Model is calculated using rlm(mpg ~ wt + qsec + am) function."),
  p("User can select Transmission type - Automatic (0) or Manual (1) - thanks to slider located in right part of the application. 
    After select Transmission type, the user can observe values of Residual Standard Errors for Ordinary and Robust Regression Model.
    Additionally, Miles per Gallon versus Transmission are presented as points on graph, which is located in the left part of application. 
    Lines represent results of regression modeling. Red line is for Ordinary Regression Model. Blue line is for Robust Regression Model.
    Each line can be shown or hidden using checkbox located in slider area."),
  tags$a(href="https://github.com/piotrpio2017/Peer-graded-Assignment-Shiny-Application-and-Reproducible-Pitch", "Application server.R and ui.R code on github"),
  tags$br(),
  tags$a(href="http://rpubs.com/piotrpio2017/348465", "Reproducible Pitch Presentation about application on rpubs"),
  
  # Main, interactive part of application
  h3("Core application"),
  
  # Sidebar with a slider input for Transmission type 
  sidebarLayout(position = "right",
    sidebarPanel(
       sliderInput("sliderMPG", "What is the Transmission of the car?", 0, 1, value = 0, step = 1),
       checkboxInput("showModel1", "Show/Hide Ordinary Regression Model", value = TRUE),
       checkboxInput("showModel2", "Show/Hide Robust Regression Model", value = TRUE)
       ),
    
    mainPanel(
      # Show a plot of the relationship between Miles per Gallon and Transmission type and MPG prediction using regression models
      plotOutput("plot1"),
      
      # Calculations results for Residual Standard Errors
      h3("Residual Standard Errors of used regression models"),
      div("RSE for Ordinary Regression Model:"),
      textOutput("rse1"),
      div("RSE for Robust Regression Model:"),
      textOutput("rse2")
    )
  )
))
