
# The function takes in data set and a vector of user selected years and return
# a line chart that maps the data. 

library(tidyverse)
library(httr)
library(plotly)
library(urbnthemes)

set_urbn_defaults()

nonprofit_trend_perc <- function(data, year) {
  
  year = lapply(year, as.numeric)
  
  ggplotly(
    size %>%
      mutate(Year = as.numeric(Year)) %>%
      filter(Year %in% year) %>%
      select(!2:4) %>% 
      pivot_longer(2:3, names_to = "Type", values_to = "Percent (%)") %>%
      
      ggplot(aes(x = Year, y= `Percent (%)`, 
                 color=Type, 
                 group=Type)) +
      geom_line(size=1.5) +
      geom_point(size = 2) +
      ggtitle("A Trend on PC and PF Divide (%)") +
      labs(x= NULL, y = NULL) +
      scale_x_continuous(expand = c(0,0),
                         limits = c(min(unlist(year)) -1, max(unlist(year)) + 1),
                         breaks = c(seq(min(unlist(year)) , max(unlist(year)),1))) +
      scale_y_continuous(expand = c(0, 0),
                         limits = c(0, 85), 
                         breaks = c(0, 5, 10, seq(50,80,10))) +
      theme(axis.line.y = element_blank(),
            axis.ticks = element_blank()) + 
      theme(legend.position="right", 
            legend.direction = "vertical")
  ) %>%  # end ggplotly
  layout(legend = list(orientation = "h",
                       x = 0.2, 
                       y = -0.15), 
         hoverlabel = list(bgcolor = "white"))
  
} # end function

