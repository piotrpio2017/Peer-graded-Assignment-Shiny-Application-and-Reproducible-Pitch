#
# This is the server logic of a Shiny web application. 
#

library(shiny)
library(MASS)

# Define server logic
shinyServer(function(input, output) {
   
  # Regression models definitions
  model1 <- lm(mpg ~ wt + qsec + am, data = mtcars)
  model2 <- rlm(mpg ~ wt + qsec + am, data = mtcars, method = "MM")
  
  # Prediction using Ordinary Regression Model
  model1pred <- reactive({
    amInput <- input$sliderMPG
    predict(model1, newdata = data.frame(wt = amInput, qsec = amInput, am = amInput))
    
  })
  
  # Calculation Residual Standard Error of Ordinary Regression Model
  model1rse <- reactive({
    summary(model1)$sigma
    
  })
  
  # Prediction using Robust Regression Model
  model2pred <- reactive({
    amInput <- input$sliderMPG
    predict(model2, newdata = data.frame(wt = amInput, qsec = amInput, am = amInput))
  })
  
  # Calculation Residual Standard Error of Robust Regression Model
  model2rse <- reactive({
    summary(model2)$sigma
    
  })
    
    # Create a plot of the relationship between Miles per Gallon and Transmission type and MPG prediction using regression models
    output$plot1 <- renderPlot({
      amInput <- input$sliderMPG
      
      plot(mtcars$am, mtcars$mpg, xlab = "Transmission", ylab = "Miles Per Gallon", bty = "n", pch = 16, ylim = c(9,18))
      if(input$showModel1){
        model1lines <- predict(model1, newdata = data.frame(wt = 0:1, qsec = 0:1, am = 0:1))
        lines(0:1, model1lines, col = "red", lwd = 2)
      }
      if(input$showModel2){
        model2lines <- predict(model2, newdata = data.frame(wt = 0:1, qsec = 0:1, am = 0:1))
        lines(0:1, model2lines, col = "blue", lwd = 2)
      }
      legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, col = c("red", "blue"), bty = "n", cex = 1.2)
      points(amInput, model1pred(), col = "red", pch = 16, cex = 2)
      points(amInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    # Create output for Residual Standard Errors
    output$rse1 <- renderText({
      model1rse()
    })
    
    output$rse2 <- renderText({
      model2rse()
    })
})
