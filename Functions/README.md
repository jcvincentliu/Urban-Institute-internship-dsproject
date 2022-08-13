# Helper Functions to Build Shiny Data Portal and Flex Dashboard

## Data Cleaning and Processing
- `Process_BMF_file.R` and `Process_core_file.R`: Functions to retrieve a dataset from the NCCS Databse 
- `classify.R`: Function to classify a nonprofit according to their NTEE category and expense level based on the organization's type (PC/PF/CO)
- `Get_finance_data.R`: Function to process datasets and return nonprofit financial tables

## Data Wrangling
- `PC_finance.R` and `PF_finance.R`: Functions to get NTEE-group/expense-level tables from PC/PF data
- `Get_nonprofit_size.R`: Function to get nonprofit size tables (number of nonprofit organizations nationally by year)

## Data Visualization
- `Get_trend_chart.R` and `Get_trend_chart_perc.R`: Functions to draw (static) trend graphs about the size of the nonprofit sector over a time frame (represented by number/proportion)
- `Get_finance_chart.R`: Function to draw (static) bar charts about the number of nonprofit organizations by user-specified financial information 
- `Get_size_map.R`: Function to draw interactive choropleth maps about the size of the nonprofit sector in each state using **Leaflet**
