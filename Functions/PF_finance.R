
# Function to create a nonprofit category/expense table. The function takes in the dataset name
# (as a string) and state names of the user's interest (as a vector of strings) and returns
# a processed and ready-to-use dataset. 

# Both functions are only for PF data.

library(tidyverse)
library(httr)
library(usmap)

pf_finance_category <- function(pf_data, states) {
  
  new_data <- 
    statepop %>% 
    select(abbr, full) %>%
    rename(STATE = abbr, STATE_NAME = full) %>%
    left_join(pf_data, by = "STATE") %>%
    rename(Category = NTEEGRP, Expense_Level = EXPCAT)
  
  summary_data <- new_data %>%
    #   filter(STATE_NAME %in% states) %>%   #FOR Full STATE NAME
    filter(STATE %in% states) %>% # For state abbreviations
    group_by(Category) %>%
    summarize( 
      Number = n(),
      "Total Expenses" = round(
        (sum(P1TOTEXP, na.rm =TRUE)/1000000000), 
        digits =2),
      "Total Assets" = round(
        (sum(P2TOTAST, na.rm =TRUE))/1000000000, 
        digits=2),
      "Total Revenue" = round(
        (sum(P1TOTREV, na.rm =TRUE))/1000000000, 
        digits=2)
    ) %>% 
    #drop old variables, keep only categories and proportions
    mutate(
      Percentage = round(
        ((Number/sum(Number))*100),
        digits=1),
      "Total expenses (%)" = round(
        ((`Total Expenses`/sum(`Total Expenses`))*100),
        digits=1),
      "Total Assets (%)" = round(
        ((`Total Assets`/sum(`Total Assets`))*100),
        digits=1),
      "Total Revenue (%)" = round((
        (`Total Revenue`/sum(`Total Revenue`))*100),
        digits=1)
    ) 
  return(summary_data)
}

pf_finance_expense <- function(pf_data, states) {
  
  new_data <- 
    statepop %>% 
    select(abbr, full) %>%
    rename(STATE = abbr, STATE_NAME = full) %>%
    left_join(pf_data, by = "STATE") %>%
    rename(Category = NTEEGRP, Expense_Level = EXPCAT, YEAR = Year)
  
  summary_data <- new_data %>%
    filter(STATE %in% states) %>%
    group_by(Expense_Level) %>%
    summarize( 
      Number = n(),
      "Total Expenses" = round(
        (sum(P1TOTEXP, na.rm =TRUE)/1000000000), 
        digits =2),
      "Total Assets" = round(
        (sum(P2TOTAST, na.rm =TRUE))/1000000000, 
        digits=2),
      "Total Revenue" = round(
        (sum(P1TOTREV, na.rm =TRUE))/1000000000, 
        digits=2)
    ) %>% 
    #drop old variables, keep only categories and proportions
    mutate(
      Percentage = round(
        ((Number/sum(Number))*100),
        digits=1),
      "Total expenses (%)" = round(
        ((`Total Expenses`/sum(`Total Expenses`))*100),
        digits=1),
      "Total Assets (%)" = round(
        ((`Total Assets`/sum(`Total Assets`))*100),
        digits=1),
      "Total Revenue (%)" = round((
        (`Total Revenue`/sum(`Total Revenue`))*100),
        digits=1)
    )   
  return(summary_data)
}