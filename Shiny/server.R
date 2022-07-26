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
library(DT)
library(tidyverse)

setwd("Shiny")
getwd()

pc19_category_num <- readRDS("R Data/pc19_category_number.rds")
pc19_category_percent <- readRDS("R Data/pc19_category_percent.rds")


# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
    if (input$Format == "Number") {
    pc19catgeory =  pc19_category_num
    
    } else if (input$Format == "Format") {
      pc19category =  pc19_category_percent
    }
  
  output$pctable19 =  renderDT(pc19catgeory,
                               rownames=FALSE, 
                               options = list(
                                 autoWidth = TRUE, pageLength=10, buttons=c('print', 'csv', 'pdf')))
  }
)
