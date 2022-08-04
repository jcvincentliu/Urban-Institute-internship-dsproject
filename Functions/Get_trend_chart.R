

library(tidyverse)
library(httr)
library(plotly)
library(urbnthemes)

set_urbn_defaults()

# year filter should be done first??

nonprofit_trend <- function(data, year) {
  
  year = lapply(year, as.numeric)
  
 # ggplotly(
    data %>%
      mutate(Year = as.numeric(Year)) %>%
      filter(Year %in% year) %>% 
      select(!5:6) %>% # Number !5:6, Perc !2:4 
      pivot_longer(2:4, names_to = "Type", values_to = "Count") %>%
       
      ggplot(aes(x = Year, y= Count, 
                 color=Type, 
                 group=Type)) +
      geom_line(size=1.5) +
      geom_point(size = 2) +
      ggtitle("Number of 501c(3) Nonprofits over Years") +
      labs(x= NULL, y= NULL) +
      scale_x_continuous(expand = c(0,0),
                       limits = c(min(unlist(year)) -1, max(unlist(year)) + 1),
                       breaks = c(seq(min(unlist(year)) , max(unlist(year)),1))) +
      scale_y_continuous(expand = c(0, 0),
                         limits = c(0, 1610000), 
                         breaks = c(0, 100000, seq(500000, 1500000, 500000))) +
      theme(axis.line.y = element_blank(),
            axis.ticks = element_blank()) +
      theme(legend.position="right", 
            legend.direction = "vertical")
 # ) %>% # end plotly
    
   # layout(legend = list(orientation = "h",
   #                      x = 0.015, 
   #                      y = -0.15), 
     #      hoverlabel = list(bgcolor = "white"))
  
} # end function

