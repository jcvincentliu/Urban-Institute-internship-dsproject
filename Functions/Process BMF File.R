### This function retrieves a IRS-administered BMF (Business Master File) data file from 
### the NCCS Data website and loads it to R. Given the large data size, only a few variables 
### that are of the most significance to analysis and visualizations are selected.

library(tidyverse)
library(httr)

# https://nccs-data.urban.org/dl.php?f=bmf/2020/bmf.bm2004.csv
# https://nccs-data.urban.org/dl.php?f=bmf/1999/bmf.bm9912.csv

process_bmf <- function(year, month) {
  
  year = as.character(year)
  yr = stringr::str_sub(year, 1, 2)
  
  path = paste("https://nccs-data.urban.org/dl.php?f=bmf/", year, "/bm/bmf", yr, month, ".csv")
  
  
  colspec <- cols_only( 
             EIN = col_character(),
             NAME = col_character(),
             
             NTEECC = col_character(),
             OUTNCCS = col_character(), 
             SUBSECCD = col_character(),
             FNDNCD = col_character(),

             CFINSRC = col_character(),
             CTAXPER = col_character(),
             CTOTREV = col_double(),
             CASSETS = col_double(),
             NTEEFINAL = col_character(),
             
             ADDRESS = col_character(),
             CITY = col_character(),
             STATE = col_character(), 
             ZIP5 = col_double())
  
  file <- read_csv(path, col_types = colspec)
  
  return (file)
}
