
shinyServer(function(input, output) { 
  
  ##################################################
  ### 3rd Page
  ##################################################            
  
  # n\a for now

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
   ### 2: 2-1 Page: PC
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
   
   
   ##################################################
   ### 2: 2-2 Page: PF
   ################################################## 
   pf_finance_reactive <- reactive({
     pf_finance <- pf_finance %>% 
       filter(Year %in% input$pf_fin_Year)
     
     if (input$pf_fin_info == "Category") {
       data <- pf_finance_category(pf_data = pf_finance, 
                                   states = input$pf_fin_states)
     } else if (input$pf_fin_info == "Expense Level") {
       data <- pf_finance_expense(pf_finance,
                                  input$pf_fin_states)
     }
     data
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
        } else if (input$fin_info == "Expense Level") {
          p <- finance_chart_expense(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Number")
        }
     } else if (input$fin_type == "Percentage") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Percentage")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Percentage")
       }
       
     } else if (input$fin_type == "Total Assets") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Assets")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Assets")
       }
     } else if (input$fin_type == "Total Assets (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Assets (%)")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Assets (%)")
       }
     }  else if (input$fin_type == "Total Expenses") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Expenses")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Expenses")
       }
     } else if (input$fin_type == "Total Expenses (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Expenses (%)")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Expenses (%)")
       }
     } else if (input$fin_type == "Total Revenue") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Revenue")
       } else if (input$fin_info == "Expense Level") {
         p <- finance_chart_expense(data = pc_finance_reactive(), 
                                    pc_finance_reactive()$"Total Revenue")
       }
     } else if (input$fin_type == "Total Revenue (%)") {
       if (input$fin_info == "Category") {
         p <- finance_chart_category(data = pc_finance_reactive(), 
                                     pc_finance_reactive()$"Total Revenue (%)")
       } else if (input$fin_info == "Expense Level") {
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
  ### 2: 2-2 Page: PF
  ################################################## 
  output$pf_finance_table <- renderDT({pf_finance_reactive()},
                                   rownames=FALSE, 
                                   options = list(
                                     paging = FALSE))
  
  output$pf_finance_barchart <- renderPlotly({
    #  type <- input$fin_type
    
    if (input$pf_fin_type == "Number") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Number")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Number")
      }
    } 
    
      else if (input$pf_fin_type == "Percentage") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Percentage")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Percentage")
      }} 
    
    else if (input$pf_fin_type == "Total Assets") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Assets")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Assets")
      }}
    
    else if (input$pf_fin_type == "Total Assets (%)") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Assets (%)")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Assets (%)")
      }}  
    
    else if (input$pf_fin_type == "Total Expenses") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Expenses")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Expenses")
      }}
    
    else if (input$pf_fin_type == "Total Expenses (%)") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Expenses (%)")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Expenses (%)")
      }}
    
    else if (input$pf_fin_type == "Total Revenue") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Revenue")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Revenue")
      }} 
    
    else if (input$pf_fin_type == "Total Revenue (%)") {
      if (input$pf_fin_info == "Category") {
        p2 <- finance_chart_category(data = pf_finance_reactive(), 
                                    pf_finance_reactive()$"Total Revenue (%)")
      } else if (input$pf_fin_info == "Expense Level") {
        p2 <- finance_chart_expense(data = pf_finance_reactive(), 
                                   pf_finance_reactive()$"Total Revenue (%)")
      }}
    
    ggplotly(p2) %>%
      layout(hoverlabel = list(bgcolor = "white")) 
  } # end renderPlotly}
  ) # end renderPlotly
  
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
  observe({
    if(is.null(input$send) || input$send==0) return(NULL)
    from <- isolate(input$from)
    to <- isolate(input$to)
    subject <- isolate(input$subject)
    msg <- isolate(input$message)
    sendmail(from, to, subject, msg)
  })
  
  
  
  } # end function
) # end ShinyServer
