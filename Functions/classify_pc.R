
## The classify_pc function classify a PC (Private Charity) by the organization's expenditure
## level and NTEE major group. The function takes in a data and return a tibble that has gone
## through the transformation. The function should be used in conjuncture with the 
## process_corefile function in `Process NCCS Core Fiels.R`. 



library(tidyverse)
library(httr)

classify <- function(dataset) {
  
  nteedocalleins <- read_csv("https://nccs-data.urban.org/dl.php?f=misc/classif.alleins.csv",
                             col_types = cols_only(EIN = col_character(),
                                                   NteeFinal = col_character()
                             )) %>% 
    rename(NTEEFINAL = NteeFinal)
  
  arts <- c("A")
  highered <- c("B4", "B5")
  othered <- c("B")
  envanimals <- c("C", "D")
  hospitals <- c('E20','E21','E22','E23','E24','F31','E30','E31','E32')
  otherhlth <- c("E", "F", "G", "H")
  humanserv <- c("I", "J", "K", "L", "M", "N", "O", "P")
  intl <- c("Q")
  pubben <- c("R", "S", "T", "U", "V", "W", "Y", "Z")
  relig <- c("X")
  
  dataset <- dataset %>%
    left_join(nteedocalleins, by = "EIN") 
  
  exp = dataset$EXPS
  firlet = str_sub(dataset$NTEEFINAL, 1, 1)
  fir2let = str_sub(dataset$NTEEFINAL, 1, 2)
  fir3let = str_sub(dataset$NTEEFINAL, 1, 3)
  
  dataset <- dataset %>%
    mutate(NTEEGRP = "  ") %>%
    mutate(NTEEGRP = case_when(
      firlet %in% arts ~ "Arts",
      firlet %in% othered & !(fir2let %in% highered)  ~ "Other education",
      fir2let %in% highered  ~ "Higher education",
      firlet %in% envanimals ~ "Environment and animals",
      firlet %in% otherhlth & !(fir3let %in% hospitals) ~ "Other health care",
      fir3let %in% hospitals ~ "Hospitals and primary care facilities",
      firlet %in% humanserv ~ "Human services",
      firlet %in% intl ~ "International",
      firlet %in% pubben ~ "Other public and social benefit",
      firlet %in% relig ~ "Religion related")) %>%
    mutate(NTEEGRP = if_else(is.na(NTEEFINAL), "Other public and social benefit", NTEEGRP)) %>%
    
    mutate(EXPCAT = "  ") %>%
    mutate(EXPCAT = case_when(
      exp < 100000 ~ "a. Under $100,000",
      exp >= 100000 & exp < 500000 ~ "b. $100,000 to $499,999",
      exp >= 500000 & exp < 1000000 ~ "c. $500,000 to $999,999",
      exp >= 1000000 & exp < 5000000 ~ "d. $1 million to $4.99 million",
      exp >= 5000000 & exp < 10000000 ~ "e. $5 million to $9.99 million",
      exp >= 10000000 ~ "f. $10 million or more"))
  
  return(dataset)
}

