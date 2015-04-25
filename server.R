library(shiny) 
library(weatherData)
library(ggplot2)
library(lubridate)
library(reshape)

#Global functions to gather information needed to render plots

#Checks to see if the city code entered is valid
checkData <- function(station_id, check_date){
      checkDataAvailability(station_id, check_date, station_type = "airportCode")
}

#Retrieves weather information for the given city on the date provided
getWeather <- function(station_id, date){
  getDetailedWeather(station_id, date, station_type = "airportCode",opt_warnings = FALSE)
}

shinyServer(
  function(input, output) {
       
       #Reactive output
       x<-reactive({input$city})
       
       output$cityValue <- renderPrint({
           x()
         })
    
    output$validity <- renderText({
      if(checkData(input$city,input$date)==0)
        "No data is entered yet or the data entered is invalid. Please enter the correct information and press Submit"
      else
        "The city airport code entered is valid. To view the graphs please enter the date and press Submit"
    })
     
    output$graph1 <- renderPlot({
     if(input$Submit==1){
        weatherdf <- getWeather(input$city,input$date)
        ggplot(weatherdf, aes(Time, TemperatureF)) + geom_point() + xlab("") + ylab("Mean Temp deg F") + ggtitle("Average Daily Temperatures")
     }
     else
       "Enter data and press submit to view visualizations"
     })
    
    output$graph2 <- renderPlot({
      if(input$Submit==1){
        date <- year(input$date)
        weatherYear<- getWeatherForYear(input$city,date)
        weatherYearFormatted <- melt(weatherYear, id.vars=c("Date"))
       
        ggplot(weatherYearFormatted, aes(x=Date, y=value)) + geom_point(aes(color=variable)) +  
          facet_grid(.~variable) + ggtitle("Annual Temperatures (Average/Min/Max)") + xlab("") + ylab("Mean Temp deg F") 
      }
      else
        print("Enter data and press submit to view visualizations")
    })
         
  }
)
