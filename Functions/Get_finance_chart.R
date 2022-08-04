
library(tidyverse)
library(httr)
library(plotly)
library(urbnthemes)

set_urbn_defaults()


finance_chart_category <- function(data, finance_info) {
  p_finance <- data %>%
    mutate(Category = factor(Category)) %>%
    
    ggplot(aes(x = reorder(Category, finance_info), y = finance_info)) +
    geom_col(fill = "#73bfe2") +
    labs(x= NULL, y=NULL) +
    coord_flip() +
    theme(axis.line = element_blank(),
            axis.ticks.y = element_blank(),
            panel.grid.major.y = element_blank(),
            panel.grid.minor.y = element_blank(),
            panel.grid.major.x = element_line(color = "gray60", 
                                              size = 0.8, 
                                              linetype = "dashed")
          ) +
    geom_text(aes(label = finance_info),
              position= position_dodge(width=1), 
              vjust =-.1, 
              size=3, 
              angle = 270)
    
    return(p_finance)
}

finance_chart_expense <- function(data, finance_info) {
  p_finance <- data %>%
    
    ggplot(aes(x = Expense_Level, y = finance_info)) +
             geom_col(fill = "#73bfe2") +
             labs(x= NULL, y=NULL) +
             coord_flip() +
             theme(axis.line = element_blank(),
                   axis.ticks.y = element_blank(),
                   panel.grid.major.y = element_blank(),
                   panel.grid.minor.y = element_blank(),
                   panel.grid.major.x = element_line(color = "gray60", 
                                                     size = 0.8, 
                                                     linetype = "dashed")) +
              scale_x_discrete(limits = rev) +
    geom_text(aes(label = finance_info),
              position= position_dodge(width=1), 
              vjust =-.1, 
              size=3, 
              angle = 270)
  
           return(p_finance)
}

# eg to use: finance_chart_expense(pc, pc$`Total Income`) [Don't forget the $ sign]
