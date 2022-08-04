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
           
           ##################################################
           ### 1st Page: General/Summary/Overview
           ##################################################           
           tabPanel("Summary", 
                    fluidPage(theme = shinytheme("cerulean")), 
                    collapsible = TRUE,
                    HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
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
                                     
                                      pickerInput(inputId = "Trend_Format", 
                                                  label = "Select Format", 
                                                  choices = c("Number", "Percentage"),
                                                  selected = c("Number"), 
                                                  multiple=FALSE),
                                     
                                     pickerInput(inputId = "Trend_Year", 
                                                 label = "Select IRS Filing Year (Minimum Three)", 
                                                 choices = c("2022", "2020", "2019", "2018", "2017", "2016", "2015", "2014", 
                                                             "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006",
                                                             "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998",
                                                             "1997", "1996", "1995", "1989"), 
                                                 options = list(
                                                      `actions-box` = TRUE, 
                                                       size = 10,
                                                      `selected-text-format` = "Circle All"),
                                                 selected = c("2019"), 
                                                 multiple = TRUE)
                       
                                     
                                   ), # end sidebarPanel
                                   
                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Plot", plotlyOutput('trendshiny',
                                                          width = "95%",
                                                          height = 600 )),
                                       tabPanel("Data", DTOutput('trendtable',
                                                      width = "90%"))
                                     ) # end tabsetPanel
                                   ) # end mainpanel
                              
                                   
                                 ) # end sidebarLayout
                                 
                             ) # end div
                    ) # end inner tab panel
           ),  # end tab panel
           
           ###################################################
           ### 2nd Page: ?????
           ###################################################
           tabPanel("Nonprofit Finance", 
                    fluidPage(theme = shinytheme("cerulean")),
                    collapsible = TRUE,
                    HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
                    id="nav",
                    tabPanel("Dashboard",
                             div(class="outer",
                                 tags$head(includeCSS("www/styles.css")),
                                 
                                 sidebarLayout(
                                   sidebarPanel(
                                     span( div( 
                                       img(src="Urban logo.png",
                                                    height="45%", 
                                                    width="90%", 
                                                    align="center")
                                       )),
                                     
                                      pickerInput(inputId = "fin_Year", 
                                                  label = "Select IRS Filing Year", 
                                                  choices = c(
                                                 "2019", "2018", "2017", "2016", "2015",  
                                                  "2014","2013", "2012", "2011", "2010" 
                                                          #      "2009", "2008", "2007", "2006",
                                                           #   "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998",
                                                           #   "1997", "1996", "1995", "1989"
                                                    ), 
                                                  options = list(
                                                    `actions-box` = TRUE, 
                                                    size = 10,
                                                    `selected-text-format` = "Circle All"),
                                                  selected = "2019", 
                                                  multiple = TRUE),
                                     # pickerInput(inputID = "org_type",
                                     #             label = "Choose Organization Type",
                                     #             choices = c("All", "Public Charity", "Private Foundation"),
                                     #             selected = c("All"),
                                     #             multiple=FALSE),
                                     pickerInput(inputID = "fin_states",
                                                 label = "Select State(s) (Multiple Choice)",
                                                 
                                                 choices = c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL",
                                                             "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA",
                                                             "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE",
                                                             "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI",
                                                             "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV",
                                                             "WY"),
                                                 # choices = c("Alabama", "Alaska", "Arizona", "Arkansas", "California", 
                                                 #             
                                                 #             "Colorado", "Connecticut", "Delaware",
                                                 #             "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho",
                                                 #             
                                                 #             "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", 
                                                 #             
                                                 #             "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan",
                                                 #             
                                                 #             "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska",
                                                 #             
                                                 #             "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York",
                                                 #             
                                                 #             "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
                                                 #             
                                                 #             "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
                                                 #             
                                                 #             "Texas",  "Utah", "Vermont","Virginia", "Washington",
                                                 #             
                                                 #             "West Virginia", "Wisconsin", "Wyoming"),

                                                 options = list(
                                                   `actions-box` = TRUE, 
                                                    size = 10,
                                                   `selected-text-format` = "Circle All"),
                                                 selected = "AK",
                                                 multiple= TRUE),
                                     
                                     # prettyRadioButtons(inputID = "fin_info",
                                     #                    label = "Choose Category Type",
                                     #                    choices = c("Category", "Expense_Level"),
                                     #                    shape = "round", "outline"=TRUE, 
                                     #                    bigger=TRUE,inline= TRUE),
                                     
                                      pickerInput(inputID = "fin_info",
                                                  label = "Choose Category Type",
                                                  choices = c("Category", "Expense_Level"),
                                                  selected = c("Category")),
                               
                                     prettyRadioButtons(inputID = "fin_type",
                                                        label = "Choose number or finance information",
                                                        choices = c("Number",          "Percentage", 
                                                                    "Total Assets", "Total Assets (%)",
                                                                    "Total Expenses", "Total expenses (%)",
                                                                    "Gross Income", "Gross Income (%)",
                                                                    "Total Revenue", "Total Revenue (%)"),
                                                        shape = "round", "outline"=TRUE, 
                                                        bigger=TRUE,inline= TRUE)
                               
                                     # pickerInput(inputID = "fin_type",
                                     #             label = "Choose number or finance information",
                                     #             choices = c("Number",          "Percentage", 
                                     #                         "Total Assets", "Total Assets (%)",
                                     #                         "Total Expenses", "Total expenses (%)",
                                     #                         "Gross Income", "Gross Income (%)",
                                     #                         "Total Revenue", "Total Revenue (%)"),
                                     #             selected = c("Number")
                                   
                                   ), # end sidebarPanel
                                   
                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Plot", plotlyOutput('finance_barchart',
                                                                     width = "95%",
                                                                     height = 600 )),
                                       tabPanel("Data", DTOutput('finance_table',
                                                                 width = "90%"))
                                     ) # end tabsetPanel
                                   ) # end mainpanel
                                   

                                 ) # end sidebarLayout
                                 
                             ) # end div
                    ) # end inner tab panel
           ), # end outer tabpanel
  
      ###################################################
      ### 3rd Page:
      ###################################################  
      tabPanel("Public Charity", 
               fluidPage(theme = shinytheme("cerulean")), 
               collapsible = TRUE,
               HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
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
                              
                              pickerInput(inputId = "Year", 
                                          label = "Select IRS Filing Year", 
                                          choices = c("2019", "2018", "2017", "2016", "2015", "2014", 
                                                         "2013", "2012", "2011", "2010", "2009"), 
                                          selected = c("2019"), 
                                          multiple = FALSE),
                              
                               pickerInput(inputId = "Format", 
                                           label = "Select Format", 
                                           choices = c("Number", "Percentage"),
                                           selected = c("Number"), 
                                           multiple=FALSE)
                                  ), # end sidebarPanel
                          
                          mainPanel(DTOutput('pctable19',  width = "95%"))
                          
                              ) # end sidebarLayout
         
              ) # end div
                ) # end innter tab panel
            ) # end tabpanel
) # end navbarpage