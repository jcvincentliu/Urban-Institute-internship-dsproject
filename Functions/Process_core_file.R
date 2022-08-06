
# The function combines data gathering and data cleaning. Specifically, it takes in two 
# attributes - file type and year. File type should be a string of either "PC", "CO", or "PF"
# or that a warning will appear and no further action can be made. Year should be a number 
# in a range given by (https://nccs-data.urban.org/data.php?ds=core). The function returns 
# a fully cleaned core data that is ready for analysis (in tidyverse tibble). 

# In the gathering step, the functions reads a file from a remote data path and selects only
# specified variables (`colspec`). In the analysis step, it adjusts the data's variable order
# so that the variables follow the order of EIN - name - classification - finance - geo info.

# For PC data, classify() function in `classify_pc.R` should be used after this one is loaded. 
# With that, three new variables are also added - NTEE final code, derived NTEE group, and
# expenditure level - by inheriting function from source file `classify.R`.

# Note that Type should be in "PC", "CO", or "PF"


library(tidyverse)
library(httr)

#setwd("Functions/")
#getwd()
#source("classify.R")

# https://nccs-data.urban.org/dl.php?f=core/2019/coreco.core2019pf.csv
# https://nccs-data.urban.org/dl.php?f=core/2019/coreco.core2019co.csv
# https://nccs-data.urban.org/dl.php?f=core/2014/nccs.core2014pc.csv
# https://nccs-data.urban.org/dl.php?f=core/1992/nccs.core1992pc.csv
# https://nccs-data.urban.org/dl.php?f=core/2012/nccs.core2012pc.csv
# https://nccs-data.urban.org/dl.php?f=core/1997/coreco.core1997co.csv

process_corefile <- function(year, type) {
  type <- toupper(type)
  
  if (!type %in% c("PC", "CO", "PF")) {
    stop("Please make sure to enter \"pc\" (for public charities), \"pf\" (for private foundations)', or \"co\" (for other 501(c) organizations)")
  
  } else if (year > 2015 | (year <2015 & year == "CO")){
      path <- paste("https://nccs-data.urban.org/dl.php?f=core/",  
                   as.character(year), "/coreco.core", as.character(year),
                   tolower(type), ".csv", sep ="")  # downloadable file path
  } 
    else if (year <=2015 & type != "CO") {
     path <- paste("http://nccs-data.urban.org/dl.php?f=core/", as.character(year), 
                   "/nccs.core", as.character(year), tolower(type), ".csv", sep ="")
    }
  
  if (type %in% c("PC", "CO") ) {
    colspec = cols_only(EIN = col_character(),
                        OUTNCCS = col_character(),
                        SUBSECCD = col_character(),
                        FNDNCD = col_character(), 
                        TOTREV = col_double(), # Total Revenue
                        EXPS = col_double(), # Total Expenditure
                        ASS_EOY = col_double(), # Total Assets at the end of year
                        GRREC = col_double(), # Gross Income
                        
                        NAME = col_character(), # organization name
                        CITY = col_character(),
                        STATE = col_character(),
                        ZIP5 = col_character(), # make zip-code a character, then convert to double(). Only do this because R ignores the 0 at the first place of a number (05105 --> 5105). 
                        PMSA = col_character(),
                        MSA_NECH = col_character(),
                        LONGITUDE = col_double(),
                        LATITUDE = col_double())
  } 
  
  else if (type == "PF") {
    colspec =   # select only a few columns
      cols_only(EIN = col_character(), # Employer Identification number
                OUTNCCS = col_character(),  # Outside NCCS Scope?
                SUBSECCD = col_character(), # Subsection Code
                FNDNCD = col_character(), # Reason for 501(c)(3) status
                NTMAJ12 = col_character(), # 
                P1TOTREV = col_double(), #Total Revenue Per book
                P1TOTEXP = col_double(),  # Total Expenditure Per book
                P2TOTAST = col_double(), # Total Assets Per book
                LEVEL1 = col_character(),  # level 1 metric groups an organization into PC, PF, or others
                NAME = col_character(),
                CITY = col_character(),
                STATE = col_character(),
                ZIP5 = col_character(),
                MSA_NECH = col_character(),
                PMSA = col_character(),
                LONGITUDE = col_double(),
                LATITUDE = col_double())
  } 
  
  file <- read_csv(path, col_types = colspec) # read_csv can read a file from a remote path
  
  if (type == "PF") {
    file <- file %>% filter(LEVEL1 == "PF") %>% select(!LEVEL1) # make sure that the org is in type PF
 #   file <- file[, c(1, 11, 2, 6:7, 13, 3:5, 12, 10, 8:9)] #rearrange column order
  } 
  #   else if (type == "CO") {
 #    file <- file[, c(1,8,2:5, 12, 9:11, 13, 6:7)]
 #    
 #  } else if (type == "PC") {
 #  
 # #   file <- classify(file)
 #    file <- file[, c(1, 8, 11, 2:5, 12, 10, 13,6:7, 9)]
 #    
 #  } else {
 #    stop("Invalid File Type")
 #  }

  return(file)
}
