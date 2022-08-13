# The function takes year as an input and processes the data to include `expense level` and 
# `NTEE category`. Specifically, the function first loads the data with the `process_corefile()`
# function. It then classifies the data based on the type of the organization (PC/PF) as well as
# add one new column: Year. The function returns a ready-to-used dataset for the portal's 
# Organization Type page.


library(tidyverse)
library(httr)

setwd("C:/Users/liu00/Downloads/Urban Internship/Nonprofit Sector In Brief/Functions")

source("Process_core_file.R")
source("classify.R")

get_pc_finance_data <- function(year) { # require there is a local data named pc_year
  pc_fin <- process_corefile(year, "PC")
  pc_fin <- classify(pc_fin, "PC")
  pc_fin  <- pc_fin %>%
    add_column(Year = as.character(year), .after = "EIN") %>%
    select(Year, NTEEGRP, EXPCAT, ASS_EOY, EXPS, TOTREV, STATE, ZIP5)
 return(pc_fin) 
}

get_pf_finance_data <- function(year) {
  pf_fin <- process_corefile(year, "PF")
  pf_fin <- classify(pf_fin, "PF")
  pf_fin  <- pf_fin %>%
    add_column(Year = as.character(year), .after = "EIN") %>%
    select(Year, P1TOTREV, P1TOTEXP, P2TOTAST, NTEEGRP, EXPCAT, STATE, ZIP5)
return(pf_fin)
  
}
  
 