library(shiny)
library(stats)


ui <- fluidPage(
    headerPanel('Blackbody Spectral Radiance'),
    sidebarPanel(
        selectInput(inputId = "Xaxis", 
                    label = "Choose your X-axis Unit", 
                    choices = c("Wavelength (nm)", "Frequency (THz)")),
        
        sliderInput(inputId = "slider1", 
                    label = "Choose a Temperature (Kelvin)", 
                    value = 5000, min = 0, max = 10000)),
    
    mainPanel(
        h3("Temperature (Kelvin)"),
        h2(textOutput("text0")),
        h3(textOutput("text1")),
        h1(textOutput("text2")),
        h3("Peak Wavelength (nm)"),
        h1(textOutput("text3")),
        h3("Peak Frequency (THz)"),
        h1(textOutput("text4")),
        plotOutput('plot1')
    ))