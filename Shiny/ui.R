
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
                                     

                                     shinyWidgets::prettyRadioButtons(inputId = "Trend_Format",
                                                                      label = "Select Data Format",
                                                                      choices = c("Number", "Percentage"),
                                                                      shape = "round", inline = TRUE),
                                     
                                     pickerInput(inputId = "Trend_Year", 
                                                 label = "Select IRS Filing Year (Minimum 3 for the plot and 1 for the table)", 
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
           ### 2nd Page: Organization Type
           ###################################################
       navbarMenu("Organization Type",
                  ###################################################
                  ### 2-1 Page: PC
                  ###################################################
             tabPanel("Public Charity",   # alternative title: Type
                    fluidPage(theme = shinytheme("cerulean")),
                    collapsible = TRUE,
                    HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
                    id="nav",
                      tabPanel("Dashboard",
                               div(class="outer",
                                   tags$head(includeCSS("www/styles.css")),

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
                                                    label = "Choose IRS Filing Year(s)", 
                                                    choices = c(
                                                   "2019", "2018", "2017", "2016", "2015",  
                                                    "2014","2013", "2012", "2011", "2010"), 
                                                    options = list(
                                                      `actions-box` = TRUE, 
                                                      size = 10,
                                                      `selected-text-format` = "Circle All"),
                                                    multiple = TRUE),
                                       pickerInput(inputId = "fin_states",
                                                   label = "Choose State(s)",
                                                   multiple = TRUE,
                                                   choices = c(state.abb, "DC"),
                                                   options = list(
                                                     `actions-box` = TRUE,
                                                     size = 10,
                                                     `selected-text-format` = "Circle All"
                                                   )),
                                       
                                       shinyWidgets::prettyRadioButtons(inputId = "fin_info",
                                                                        label = "Choose Topic",
                                                                        choices=c("Category", "Expense Level"),
                                                                        shape = "round", inline = TRUE),
                                       
                                       shinyWidgets::prettyRadioButtons(inputId = "fin_type",
                                                                        label = "Choose Financial Information",
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
           ### 2-2 Page: PF
           ###################################################
           tabPanel("Private Foundation",   # alternative title: Type
                    fluidPage(theme = shinytheme("cerulean")),
                    collapsible = TRUE,
                    HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
                    id="nav",
                    tabPanel("Dashboard",
                             div(class="outer",
                                 tags$head(includeCSS("www/styles.css")),
                             
                                 sidebarLayout(
                                   sidebarPanel(
                                     style = "height: 90vh; overflow-y: auto;",
                                     span( div( 
                                       img(src="Resized_Urban_logo.png",
                                           height="45%", 
                                           width="90%", 
                                           align="center")
                                     )),
                                     
                                     pickerInput(inputId = "pf_fin_Year", 
                                                 label = "Choose IRS Filing Year(s)", 
                                                 choices = c(
                                                   "2019","2015", "2014","2013", "2012",
                                                   "2011", "2010", "2009", "2008", "2007"), 
                                                 options = list(
                                                   `actions-box` = TRUE, 
                                                   size = 10,
                                                   `selected-text-format` = "Circle All"),
                                                 multiple = TRUE),
                                     pickerInput(inputId = "pf_fin_states",
                                                 label = "Choose State(s)",
                                                 multiple = TRUE,
                                                 choices = c(state.abb, "DC"),
                                                 options = list(
                                                   `actions-box` = TRUE,
                                                   size = 10,
                                                   `selected-text-format` = "Circle All"
                                                 )),
                       
                                     shinyWidgets::prettyRadioButtons(inputId = "pf_fin_info",
                                                                      label = "Choose Topic",
                                                                      choices=c("Category", "Expense Level"),
                                                                      shape = "round", inline = TRUE),
                                     shinyWidgets::prettyRadioButtons(inputId = "pf_fin_type",
                                                                      label = "Choose Financial Information",
                                                                      choices = c("Number", "Percentage",
                                                                                  "Total Assets", "Total Assets (%)",
                                                                                  "Total Revenue", "Total Revenue (%)",
                                                                                  "Total Expenses", "Total Expenses (%)"),
                                                                      shape = "round",
                                                                      inline = TRUE)
                                     
                                   ), # end sidebarPanel
                                   
                                   mainPanel(
                                     tabsetPanel(
                                       tabPanel("Plot", plotlyOutput('pf_finance_barchart',
                                                                     width = "95%",
                                                                     height = 600)),
                                       tabPanel("Data", DTOutput('pf_finance_table', width = "90%"),
                                                style = 
                                                  "height:500px;overflow-y: scroll;overflow-x: scroll;"
                                       )
                                     ) # end tabsetPanel
                                   ) # end mainpanel
                                   
                                   
                                 ) # end sidebarLayout
                                 
                             ) # end div
                    ) # end inner tab panel
           ) # end outer tabpanel
           
       ), # end navbarMenu
  
      ###################################################
      ### 3rd Page:
      ###################################################  
      tabPanel("About", icon = icon("bars"),
               fluidPage(theme = shinytheme("cerulean")), 
               collapsible = TRUE,
               HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">U.S. Nonprofit</a>'), 
               id="nav",
               tabPanel("Dashboard",
                        div(class="outer",
                            tags$head(includeCSS("www/styles.css")),
                            
                            sidebarLayout(
                              sidebarPanel(
                                p("The Nonprofit Sector In Brief Dashboard is created by developers at the ", 
                                a("National Center for Charitable Statistics (NCCS)",
                                  href = "https://nccs.urban.org/", target= "_blank"), 
                                ", which is hosted by Urban Institute's ",
                                a("Center on Nonprofits and Philanthropy.",
                                  href="https://www.urban.org/policy-centers/center-nonprofits-and-philanthropy",
                                  target="_blank"), 
                                  " "), 
                                br(), 
                                textInput("from", "From:", value=""),  
                                textInput("to", "To:", value="NCCS@urban.org"),
                                textInput("subject", "Subject:", value=""),
                                actionButton("send", "Send mail")
                                  ), # end sidebarPanel
                          
                          mainPanel(aceEditor("message", value="Write your message here"))
                          
                              ) # end sidebarLayout
         
              ) # end div
                ) # end innter tab panel
            ) # end tabpanel
      
  #  hr(style = "border-color: #cbcbcb;"),
  #  p("The app is developed by ", tags$a(href = "https://nccs.urban.org/about", 'National Center for Charitable Statistics', target = '_blank'), " in August 2022", HTML("&bull;"),
  #  p("You can find the code on Github:", tags$a(href = "https://github.com/Nonprofit-Open-Data-Collective/npsdashboard", tags$i(class = 'fa fa-github', style = 'color:#5000a5'), target = '_blank'), style = "font-size: 85%"),
  #  p("For any questions or concerns, please send an email ", tags$a(href = "mailto:NCCS@urban.org", tags$i(class = 'fa fa-envelope', style = 'color:#990000'), target = '_blank'), style = "font-size: 85%"),
 #   p(tags$em("Last updated: August 2022"), style = 'font-size:75%'))
  #  footer = "Copyright 2022 Urban Institute"
 
 
) # end navbarpage
