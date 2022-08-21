library(shiny)
library(stats)
# contants
h <- 6.625 * 10^(-34)
k <- 1.380649 * 10^(-23)
c <- 2.99792458 * 10^8
b_λ  <- 2.897771955 *10^(-3)
b_ν <- 5.88 * 10^(10)

# wavelength range in meters
wav_len <- 10^seq(-8, -5.5, 0.01)

# wavelength range in THz (10^12 Hz)
freq_span <- 10^seq(9, 15.3, 0.01)

# Spectral Radiance function
B_λ <- function(x, y) {
    # spectral density function of B with x= wave length and y= temperature
    result <- (2 * h * (c^2)) / (x^(5) * ((exp((h*c) / (x * k * y))) -1))
}
B_v <- function(x, y) {
    # spectral density function of B with x=frequency and y= temperature
    #result <- (2 * h * (c^2)) / (x^(5) * ((exp((h*c) / (x * k * y))) -1))
    result <- (2 * h * (x^3)) / (c^(2) * ((exp((h*x) / (k * y))) -1))
}

server <- function(input, output) {
    
    output$text0 <- renderText(input$slider1)
    
    output$text1 <- renderText({
        
        if (input$Xaxis == "Wavelength (nm)") {
            "Peak Spectral Radiance (W/m^2/sr/nm)"}
        
        else if (input$Xaxis == "Frequency (THz)"){ 
            "Peak Spectral Radiance (W/m^2/sr/THz)"}
    })
    
    output$text2 <- renderText({
        
        if (input$Xaxis == "Wavelength (nm)") {
            (B_λ(b_λ/input$slider1, input$slider1))}
        
        else if (input$Xaxis == "Frequency (THz)"){ 
            (B_v(b_ν * input$slider1, input$slider1))*10^(16)}
    })
    
    output$text3 <- renderText((b_λ/input$slider1 * 10^9))
    output$text4 <- renderText((b_ν * input$slider1) * 10^(-12))
    
    # plot       
    output$plot1 <- renderPlot({
        
        if (input$Xaxis == "Wavelength (nm)") {
            plot(wav_len*10^9, ((B_λ(wav_len, input$slider1))*10^-13), 
                 type="l", 
                 col="blue", 
                 ylab="B, Spectral Radiance, 10^13 * W/m^2/sr/nm", 
                 xlab="Wavelength (nm)")
            abline(v= (b_λ/input$slider1 * 10^9), col="red", lwd=1, lty=1)
            points((b_λ/input$slider1 * 10^9), (B_λ(b_λ/input$slider1, input$slider1)*10^-13), col = "dark red")
            title("Plank's Law and Wien's Law vs Wavelength")}
        
        else if (input$Xaxis == "Frequency (THz)"){ 
            plot(freq_span*10^-12, ((B_v(freq_span, input$slider1))*10^8), 
                 type="l", 
                 col="blue", 
                 ylab="B, Spectral Radiance, 10^8 * W/m^2/sr/THz", 
                 xlab="Frequency (THz)")
            abline(v= (b_ν * input$slider1 * 10^-12), col="red", lwd=1, lty=1)
            points((b_ν * input$slider1* 10^-12), (B_v(b_ν * input$slider1, input$slider1)*10^8), col = "dark red")
            title("Plank's Law and Wien's Law vs Frequency")}}
    )}