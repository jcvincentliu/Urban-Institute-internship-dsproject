#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)
library(plotly)
library(DT)
library(tidyverse)

#setwd("Shiny")
#getwd()

pc19_category <- readRDS("Data/pc19_category.rds")
size <- readRDS("Data/nonprofit_size_table.rds")
pc <- readRDS("Data/pc_finance.rds")

source("../Functions/Get_trend_chart.R")
source("../Functions/Get_trend_chart_perc.R")
source("../Functions/PC_finance.R")
source("../Functions/Get)finance_chart.R")

#pc19_category_percent <- readRDS("Data/pc19_category_percent.rds")


# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
 
   pc19_reactive <- reactive(
     if (input$Format == "Number") {
       select(pc19_category, !c(8:12))
    } else if (input$Format == "Percentage") {
      select(pc19_category, !c(3:7))
   }
) # end reactive

   trend_reactive <- reactive(
     if (input$Trend_Format == "Number")
     {nonprofit_trend(data = size, year = input$Trend_Year)}
     else if (input$Trend_Format == "Percentage")
       {nonprofit_trend_perc(data = size, year = input$Trend_Year)}
   )  # end reactive


   trend_data_reactive <- reactive(
     if (input$Trend_Format == "Number")
     { select(size, !c(5:6)) }
     else if (input$Trend_Format == "Percentage")
     { select(size, !c(2:4)) }
   )
   
   # NEED TO ADD PC/PF, MSA
   
   pc_year_reactive <- reactive(
     filter(pc, pc$Year %in% input$fin_Year)
   )
   
   pc_finance_info_reactive <- reactive(
     if (input$fin_info == "Category") {
       pc_finance_category(pc_data = pc_year_reactive(), states = input$fin_states)
     }  else if (input$fin_info == "Expense_Level") {
       pc_finance_expense(pc_data = pc_year_reactive(), states = input$fin_states)
     }
   ) # end reactive
   
   pc_finance_plot_reactive <- reactive(
     if (input$fin_info == "Category") {
       finance_chart_category(data = pc_finance_info_reactive(), input$fin_type)
     }  else if (input$fin_info == "Expense_Level") {
       finance_chart_expense(data = pc_finance_info_reactive(), input$fin_type) }
   ) 
   
   output$finance_barchart <- renderPlotly(
     ggplotly(pc_finance_plot_reactive) %>%
       layout(legend = list(orientation = "h",
                            x = 0.2,
                            y = -0.2),
              hoverlabel = list(bgcolor = "white"))
   )
   
  output$finance_table <- renderDT(pc_finance_info_reactive(),
                                   rownames=FALSE, 
                                   options = list(
                                     autoWidth = TRUE, 
                                     pageLength= 15,
                                     buttons = 
                                       list('copy', 'print', list(
                                         extend = 'collection',
                                         buttons = c('csv', 'excel', 'pdf'),
                                         text = 'Download'))
                                     ))
   
  output$trendshiny <- renderPlotly(
    ggplotly(trend_reactive()) %>%
      layout(legend = list(orientation = "h",
                           x = 0.2,
                           y = -0.15),
             hoverlabel = list(bgcolor = "white"))
    ) 
 
  output$trendtable <- renderDT(trend_data_reactive(),
                               rownames=FALSE, 
                               options = list(
                                 autoWidth = TRUE, 
                                 pageLength= 15,
                                 buttons = 
                                   list('copy', 'print', list(
                                     extend = 'collection',
                                     buttons = c('csv', 'excel', 'pdf'),
                                     text = 'Download'))
                                 ))
  
    
  output$pctable19 <-  renderDT(pc19_reactive(),
                               rownames=FALSE, 
                               options = list(
                                 autoWidth = TRUE, 
                                 pageLength=15,
                                 buttons = 
                                   list('copy', 'print', list(
                                     extend = 'collection',
                                     buttons = c('csv', 'excel', 'pdf'),
                                     text = 'Download'))
                                 ))
  } # end function
) # end ShinyServer


###################################################
## Reusable Functions
###################################################

# v_trend <- reactiveValues(data = NULL)
# 
# observeEvent(input$num, {
#   v_trend$data <- nonprofit_trend(data = size, 
#                                   year = input$Trend_Year)
# })
# 
# observeEvent(input$perc, {
#   v_trend$data <- nonprofit_trend_perc(data = size, 
#                                   year = input$Trend_Year)
# })

