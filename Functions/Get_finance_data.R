
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
    select(Year, NTEEGRP, EXPCAT, ASS_EOY, EXPS, GRREC, TOTREV, STATE, ZIP5)
 return(pc_fin) 
}