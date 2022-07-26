#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shinyWidgets)
library(leaflet)
library(DT)
library(tidyverse)
library(urbnthemes)


navbarPage("Nonprofit Sector In Brief Dashboard",
  
    tabPanel("Summary", 
             fluidPage(theme = shinytheme("cerulean")), 
             collapsible = TRUE,
             HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit Density</a>'), 
             id="nav",
             tabPanel("Dashboard",
                      div(class="outer",
                          tags$head(includeCSS("www/styles.css")),
                          
                          sidebarLayout(
                            sidebarPanel(
                              span( div( img(src="Urban logo.png",
                                             height="45%", 
                                             width="90%", 
                                             align="center")) ),
                              
                        #      selectInput("Year", label = "Year", 
                         #                 choices = list("2019" = 2019, "2018" = 2018, "2017" = 2017,
                          #                               "2016" = 2016, "2015" = 2015, "2014" = 2014, 
                           #                              "2013" = 2013, "2012" = 2012, "2011" = "2011", 
                             #                            "2010" = 2010, "2009" = 2009), #possible more years in the future?
                            #              selected = 2019, multiple = FALSE)),
                            
                            pickerInput(inputId = "Year", 
                                        label = "Year", 
                                        choices = c("2019", "2018", "2017", "2016", "2015", "2014", 
                                                       "2013", "2012", "2011", "2010", "2009"), 
                                        selected = c("2019"), 
                                        multiple = FALSE),
                            
                             pickerInput(inputId = "Format", 
                                         labels = "Format", 
                                         choices = c("Number", "Percentage"),
                                         selected = c("Number"), 
                                         multiple=FALSE)
                                )
                            ),
                            mainPanel(DTOutput('pctable19')) 
             )
      )
  )
)