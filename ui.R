#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI 
shinyUI(fluidPage(
          theme =bs_theme(
            bg = "#002B36", fg = "#EEE8D5", primary = "#2AA198",
            # bslib also makes it easy to import CSS fonts
            base_font = bslib::font_google("Pacifico")
          ),


    # Application title
    titlePanel("Stocks App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      
        sidebarPanel(
          box(selectizeInput(inputId = "stock_pick", "Pick a stock to look at", list("AAPL", "LSCC", "MSFT","TSLA"), selected = "TSLA", multiple = TRUE,
                                              options = list(create = TRUE)
          ),),
          
          sliderInput("slider", "Number of observations:",
                      min = 100, max = 3500, value = 300
          )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            uiOutput("stock_plot"),
        )
    )
))
