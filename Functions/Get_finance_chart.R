# The functions takes a dataset and returns a graph about NTEE categories or expense level.  
# The function takes in one more input: `finance_info`, the specific financial information 
# that the user cares about. The returned graph is static and can be used with `ggplot()`
# to get an interactive plot.

# Note: To use the function, the format should be (finance_info is a string): 
# finance_chart_category(data_name, data_name$finance_info)

library(tidyverse)
library(httr)
library(plotly)
library(urbnthemes)

set_urbn_defaults()


finance_chart_category <- function(data, finance_info) {
  p_finance <- data %>%
    mutate(Category = factor(Category))
    
  p <- 
    ggplot(p_finance, aes(x = reorder(Category, finance_info), 
               y = finance_info)) +
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
    
    return(p)
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
