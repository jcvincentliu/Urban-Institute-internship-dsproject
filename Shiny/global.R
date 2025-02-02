
packs = c("shiny", "shinydashboard", "shinythemes", "shinyWidgets", "plotly", 
          "scales", "knitr", "kableExtra", "tidyverse", "readr", "DT", "httr",
          "leaflet", "shinyhelper", "usmap", "shinyAce", "sendmailR")

#invisible(lapply(packs, library, character.only = TRUE))
### Run the following command to verify that the required packages are installed. If some package
# is missing, it will be installed automatically

package.check <- lapply(packs, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
  }
})

## Load Datasets
pc19_category <- readRDS("Data/pc19_category.rds")
size <- readRDS("Data/nonprofit_size_table.rds")
pc_finance <- readRDS("Data/pc_finance.rds")
pf_finance <- readRDS("Data/pf_finance.rds")
all_size <- readRDS("Data/nonprofit_size_by_state.rds")

## Load all functions
source("../Functions/Get_trend_chart.R")
source("../Functions/Get_trend_chart_perc.R")
source("../Functions/PC_finance.R")
source("../Functions/PF_finance.R")
source("../Functions/Get_finance_chart.R")
source("../Functions/Get_size_map.R")
