#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



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
                             fluid =TRUE,
                             div(class="outer",
                                 tags$head(includeCSS("www/styles.css")),
                                 
                                 sidebarLayout(
                                   sidebarPanel(
                                     style = "height: 90vh; overflow-y: auto;",
                                     span( div( img(src="Resized_Urban_logo.png",
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
                                                             "2013", "2012", "2011", "2010", 
                                                             "2009", "2008", "2007", "2006",
                                                             "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998",
                                                             "1997", "1996", "1995", "1989"), 
                                                 selected = "2022",
                                                 options = list(
                                                      `actions-box` = TRUE, 
                                                       size = 10,
                                                      `selected-text-format` = "Circle All"),
                                                 multiple = TRUE)
                       
                                     
                                   ), # end sidebarPanel
                                   
                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Trend Plot", plotlyOutput('trendshiny',
                                                          width = "95%",
                                                          height = 600 )), 
                                       tabPanel("Size Map", leafletOutput("size_map",   # only 2010 - 2022 available
                                                                          width = "95%",
                                                                          height = 600)),
                                       tabPanel("Data", DTOutput('trendtable',
                                                      width = "90%"), 
                                                style = 
                                                  "height:500px;overflow-y: scroll;overflow-x: scroll;")
                                     ) # end tabsetPanel
                                   ) # end mainpanel
                              
                                   
                                 ) # end sidebarLayout
                                 
                             ) # end div
                    ) # end inner tab panel
           ),  # end tab panel
           
           ###################################################
           ### 2nd Page: ?????
           ###################################################
             tabPanel("Public Charity Finance", 
                    fluidPage(theme = shinytheme("cerulean")),
                    collapsible = TRUE,
                    HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
                    id="nav",
                    tabPanel("Dashboard",
                             div(class="outer",
                                 tags$head(includeCSS("www/styles.css")),
                           #      tags$style(HTML(".sidebar {
                             #                           height: 90vh; overflow-y: auto;
                               #                       }"
                                #    ) # close HTML       
                                #    )            # close tags$style
                                #  ),             # close tags#Head
                                 
                                 sidebarLayout(
                                   sidebarPanel(
                                     style = "height: 90vh; overflow-y: auto;",
                                     span( div( 
                                       img(src="Resized_Urban_logo.png",
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
                                                  multiple = TRUE),
                                     pickerInput(inputId = "fin_states",
                                                 label = "Pick State(s)",
                                                 multiple = TRUE,
                                                 choices = c(state.abb, "DC"),
                                                 options = list(
                                                   `actions-box` = TRUE,
                                                   size = 10,
                                                   `selected-text-format` = "Circle All"
                                                 )),
                                     # pickerInput(inputID = "fin_states",
                                     #             label = "Pick States",
                                     #             choices= c(state.abb, "DC"),
                                     #             multiple = TRUE,
                                     #             options = list(
                                     #               `actions-box` = TRUE, 
                                     #               size = 10,
                                     #               `selected-text-format` = "Circle All")),
                                     shinyWidgets::prettyRadioButtons(inputId = "fin_info",
                                                                      label = "Choose Information",
                                                                      choices=c("Category", "Expense Level"),
                                                                      shape = "round", inline = TRUE),
                                     shinyWidgets::prettyRadioButtons(inputId = "fin_type",
                                                                      label = "Choose Topic",
                                                                      choices = c("Number", "Percentage",
                                                                                  "Total Assets", "Total Assets (%)",
                                                                                  "Total Revenue", "Total Revenue (%)",
                                                                                  "Total Expenses", "Total Expenses (%)"),
                                                                      shape = "round",
                                                                      inline = TRUE)
                            
                                   ), # end sidebarPanel
                                   
                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Plot", plotlyOutput('finance_barchart',
                                                                     width = "95%",
                                                                     height = 600)),
                                       tabPanel("Data", DTOutput('finance_table', width = "90%"),
                                                                 style = 
                                                                       "height:500px;overflow-y: scroll;overflow-x: scroll;"
                                                                     )
                                     ) # end tabsetPanel
                                   ) # end mainpanel
                                   

                                 ) # end sidebarLayout
                                 
                             ) # end div
                    ) # end inner tab panel
           ), # end outer tabpanel
  
      ###################################################
      ### 3rd Page:
      ###################################################  
      tabPanel("Contact", 
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


# tags$head(
#   tags$style(HTML(".sidebar {
#                       height: 90vh; overflow-y: auto;
#                     }"
#   ) # close HTML       
#   )            # close tags$style
# ),             # close tags#Head
