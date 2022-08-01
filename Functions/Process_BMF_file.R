# This function retrieves a IRS-administered BMF (Business Master File) data file from 
# the NCCS Data website and loads it to R. Given the large data size, only a few variables 
# that are of the most significance to analysis and visualizations are selected.

library(tidyverse)
library(httr)

# https://nccs-data.urban.org/dl.php?f=bmf/2022/bmf.bm2201.csv
# https://nccs-data.urban.org/dl.php?f=bmf/2020/bmf.bm2004.csv
# https://nccs-data.urban.org/dl.php?f=bmf/1999/bmf.bm9912.csv
# https://nccs-data.urban.org/dl.php?f=bmf/1989/bmf.bmf89.csv

process_bmf <- function(year, month= NULL) { #set month default to NULL because 
                                        #there is no month attached with year 1989
  
  if (year != 1989) {
    year <- as.character(year)
    month <- sprintf("%02d", month) # reformat string, so it will be "01" rather than "1'
    yr <- stringr::str_sub(year, 3, 4)
  
    path <- paste0("https://nccs-data.urban.org/dl.php?f=bmf/", year, "/bmf.bm", yr, month, ".csv")
  } 
  
  else if (year == 1989) {
    path <- "https://nccs-data.urban.org/dl.php?f=bmf/1989/bmf.bmf89.csv"
  }
  
  
  colspec <- cols_only( 
             EIN = col_character(),
             NAME = col_character(),
             
             NTEECC = col_character(),
             OUTNCCS = col_character(), 
             SUBSECCD = col_character(),
             FNDNCD = col_character(),

         #    CFINSRC = col_character(),   not in old BMF data
          #   CTAXPER = col_character(),
           #  CTOTREV = col_double(),
            # CASSETS = col_double(),
            # NTEEFINAL = col_character(),
             
       #      ADDRESS = col_character(),  not in old BMF data
             CITY = col_character(),
             STATE = col_character(), 
             ZIP5 = col_double())
  
  file <- read_csv(path, col_types = colspec)
  
  return (file)
}
