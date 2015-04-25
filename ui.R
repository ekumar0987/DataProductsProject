# The code below designs the layout of the shiny application and contains widgets to input data into the system
library(shiny) 
shinyUI(
    pageWithSidebar(
      headerPanel("Weather Visualization"),
      
      #Side bar panel includes all the widgets and text seen on the side bar of the application on the left
      sidebarPanel(
        img(src='myImage.jpg', width="570", height="275"),
        h1(""),
        h1(""),
        h1(""),
        h4("Weather is on everybody's mind and most times complained about! This application gathers information about the
           weather in various cities across the globe to help understand this data better."),
        h1(""),
        h3("Getting started "),
        h5("To use this application simply enter the 3 character airport code for the city you need to gather weather 
            information for. For example, San Francisco would be \"SFO\". Next enter the date for which you need this data."),
        h1(""),
        h3("Interpreting results"),
        h5("The output consists of 2 visualizations. The first plot depicts mean temperatures at various times during the day
            for the given city on the date provided. The second one plots information for the mean, minimum and maximum 
            temperatures for the given city over the entire year that the date falls in"),
        h3("Computation "),
        h5("The city and date fields listed below will be processed on the server end to derive relevant data for the
           weather. The results of the computations will then be displayed in the blank space on the right hand side of
           this HTML page"),
        
        textInput("city", label = h4("City Airport Code"), 
                  value = "Enter code..."),
        dateInput("date", 
                  label = h4("Date input"), 
                  value = "2014-01-01"),
        
        actionButton("Submit","Submit"),
        h1(""),
        h6("Note: The city code you enter will be displayed in the output field \"Yout entered city..\" on the top right 
           hand side. This has been designed to change as and when you change the city code in the input text field above.
           To view the visualizations however you must hit Submit! 
           The data takes a few seconds to load after Submit is hit....")
        ),
   
      # Main panel is on the right hand side and renders the data visualization plots
      mainPanel(
      h5('You entered the city..'),
      verbatimTextOutput("cityValue"),
      h5('Checking validity...'),
      verbatimTextOutput("validity"),
      plotOutput('graph1'),
      hr(),
      plotOutput('graph2')
  )
))