
library(shiny)
library(thematic)
library(quantmod)
library(PerformanceAnalytics)
library(dygraphs)
library(plotly)
library(bslib)
library(shinydashboard)
library(bslib)

source("funcs.R")

thematic_shiny(font = "auto")

# Define server logic 
shinyServer(function(input, output) {

    output$stock_plot <- renderUI({
       in_list <- input$stock_pick
       lapply(1:NROW(in_list), function(i){
        fig <-  get_stock_recent_plot( in_list[i],input$slider)
         output[[paste0("plot_",i)]] <- renderPlotly(ggplotly(fig))
         wellPanel( br(),h3(in_list[i]),plotlyOutput(paste0("plot_",i)))
       })
       
    })

})

