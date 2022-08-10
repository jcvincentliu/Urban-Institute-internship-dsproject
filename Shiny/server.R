#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
  
  ##################################################
  ### 3rd Page
  ##################################################            
   pc19_reactive <- reactive({
     if (input$Format == "Number") {
       select(pc19_category, !c(8:12))
    } else if (input$Format == "Percentage") {
      select(pc19_category, !c(3:7))
   }
}) # end reactive

   ##################################################
   ### 1st Page: General/Summary/Overview
   ##################################################           
   trend_reactive <- reactive({
     if (input$Trend_Format == "Number")
     {nonprofit_trend(data = size, year = input$Trend_Year)}
     else if (input$Trend_Format == "Percentage")
       {nonprofit_trend_perc(data = size, year = input$Trend_Year)}
   })  # end reactive


   trend_data_reactive <- reactive({
     if (input$Trend_Format == "Number")
     { select(size, !c(5:6)) }
     else if (input$Trend_Format == "Percentage")
     { select(size, !c(2:4)) }
   })
   
   # NEED TO ADD PC/PF, MSA
   
   ##################################################
   ### 2nd Page: General/Summary/Overview
   ##################################################           
   # pc_year_reactive <- reactive( {
   #   filter(pc, pc$Year %in% input$fin_Year) 
   # })
   
   pc_finance_reactive <- reactive({
     pc_finance <- pc_finance %>% 
       filter(Year %in% input$fin_Year)
     
     if (input$fin_info == "Category") {
       data <- pc_finance_category(pc_data = pc_finance, 
                                   states = input$fin_states)
     } else if (input$fin_info == "Expense Level") {
       data <- pc_finance_expense(pc_finance,
                                  input$fin_states)
     }
     data
  }) # end reactive
   
   pc_finance_plot_reactive <- reactive({
     if (input$fin_type == "Number") {
       t = "Number"
            }  else if (input$fin_type == "Percentage") {
              t = "Percentage"
            } else if (input$fin_type == "Total Assets") {
              t = "Total Assets"
            }   else if (input$fin_type == "Total Revenue")  {
              t = "Total Revenue"
   }
     })
   
   ##################################################
   ### 2nd Page: General/Summary/Overview
   ##################################################  
   output$finance_barchart <- renderPlotly({
   #  type <- input$fin_type
     
     if (input$fin_type == "Number") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Number")
        } else if (input$fin_info == "Expense_Level") {
          p <- finance_chart_expense(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Number")
        }
     } else if (input$fin_type == "Percentage") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Percentage")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Percentage")
       }
       
     } else if (input$fin_type == "Total Assets") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Assets")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Assets")
       }
     } else if (input$fin_type == "Total Assets (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Assets (%)")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Assets (%)")
       }
     }  else if (input$fin_type == "Total Expenses") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Expenses")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Expenses")
       }
     } else if (input$fin_type == "Total Expenses (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Expenses (%)")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Expenses (%)")
       }
     } else if (input$fin_type == "Total Revenue") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Revenue")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Revenue")
       }
     } else if (input$fin_type == "Total Revenue (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Revenue (%)")
       } else if (input$fin_info == "Expense_Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Revenue (%)")
       }
     }
     
          ggplotly(p) %>%
            layout(hoverlabel = list(bgcolor = "white")) 
   } # end renderPlotly}
   ) # end renderPlotly
   
  output$finance_table <- renderDT({pc_finance_reactive()},
                                   rownames=FALSE, 
                                   options = list(
                                     paging = FALSE))
  
  ##################################################
  ### 1st Page: General/Summary/Overview
  ################################################## 
  output$size_map <- renderLeaflet({
    create_size_map(all_size, input$Trend_Year)
    
  })
  
  output$trendshiny <- renderPlotly(
    ggplotly({trend_reactive()}) %>%
      layout(legend = list(orientation = "h",
                           x = 0.2,
                           y = -0.15),
             hoverlabel = list(bgcolor = "white"))
    ) 
 
  output$trendtable <- renderDT({trend_data_reactive()},
                               rownames=FALSE, 
                               options = list(
                                 paging = FALSE))
  
  ##################################################
  ### 3rd Page
  ##################################################   
  output$pctable19 <-  renderDT({pc19_reactive()},
                               rownames=FALSE, 
                               options = list(
                                 autoWidth = TRUE, 
                                 pageLength=15
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

