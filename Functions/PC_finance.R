

library(tidyverse)
library(httr)
library(usmap)

pc_finance_category <- function(pc_data, states) {
  
    new_data <- 
      statepop %>% 
      select(abbr, full) %>%
      rename(STATE = abbr, STATE_NAME = full) %>%
      left_join(pc_data, by = "STATE") %>%
      rename(Category = NTEEGRP, Expense_Level = EXPCAT)
    
    summary_data <- new_data %>%
   #   filter(STATE_NAME %in% states) %>%   #FOR Full STATE NAME
      filter(STATE %in% states) %>% # For state abbreviations
      group_by(Category) %>%
      summarize( 
        Number = n(),
        "Total Expenses" = round(
          (sum(EXPS, na.rm =TRUE)/1000000000), 
          digits =2),
        "Total Assets" = round((
          sum(ASS_EOY, na.rm =TRUE))/1000000000, 
          digits=2),
        "Gross Income" = round(
          (sum(GRREC, na.rm =TRUE))/1000000000, 
          digits=2),
        "Total Revenue" = round(
          (sum(TOTREV, na.rm =TRUE))/1000000000, 
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
        "Gross Income (%)" = round(
          ((`Gross Income`/sum(`Gross Income`))*100),
          digits=1),
        "Total Revenue (%)" = round((
          (`Total Revenue`/sum(`Total Revenue`))*100),
          digits=1)
      ) 
    return(summary_data)
}

  pc_finance_expense <- function(pc_data, states) {
      
      new_data <- 
        statepop %>% 
        select(abbr, full) %>%
        rename(STATE = abbr, STATE_NAME = full) %>%
        left_join(pc_data, by = "STATE") %>%
        rename(Category = NTEEGRP, Expense_Level = EXPCAT, YEAR = Year)
      
      summary_data <- new_data %>%
        filter(STATE_NAME %in% states) %>%
        group_by(Expense_Level) %>%
        summarize( 
          Number = n(),
          "Total Expenses" = round(
            (sum(EXPS, na.rm =TRUE)/1000000000), 
            digits =2),
          "Total Assets" = round((
            sum(ASS_EOY, na.rm =TRUE))/1000000000, 
            digits=2),
          "Gross Income" = round(
            (sum(GRREC, na.rm =TRUE))/1000000000, 
            digits=2),
          "Total Revenue" = round(
            (sum(TOTREV, na.rm =TRUE))/1000000000, 
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
          "Gross Income (%)" = round(
            ((`Gross Income`/sum(`Gross Income`))*100),
            digits=1),
          "Total Revenue (%)" = round((
            (`Total Revenue`/sum(`Total Revenue`))*100),
            digits=1)
        )   
  return(summary_data)
}