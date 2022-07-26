
# The function takes a year of interest and return that year's total number of nonprofits,
# filtered by nonprofit type. The function should be used in conjuncture with the `process_bmf` 
# function in `Process BMF File.R`. To make the function works, all BMF data in the local 
# environment must be named following the bmf+year fashion. Year is the only input needed. 

library(tidyverse)
library(httr)

get_size <- function(year) {
  
  data.name <- paste0("bmf", year) # a string of the object's name we are searching for
  data <- get(data.name) # get the data based on the name

  t1 <- data %>%  # All IRS registered nonprofits
    filter((OUTNCCS != "OUT")) %>% 
    summarize(
      Year = as.character(year), 
      "All registered nonprofits" = n()) # total number
  
  t2 <- data %>%  # PC
    filter((FNDNCD != "02" & FNDNCD!= "03" & FNDNCD != "04"), (SUBSECCD %in% c("03", "3")), (OUTNCCS == "IN")) %>%
    summarize(
      Year = as.character(year),
      "501(c)(3) public charities" = n()
    )
  
  t3 <- data %>% #PF
    filter(FNDNCD %in% c("02", "03", "04"), (SUBSECCD %in% c("03", "3")), (OUTNCCS == "IN")) %>%
    summarize(
      Year = as.character(year),
      "501(c)(3) private foundations" = n()
    )
  
  combined <- t1 %>% # Join three data together, so we are getting a 1*4 dataset 
    left_join(t2, by = "Year") %>%
    left_join(t3, by = "Year")
  
  return(combined)
}