# Nonprofit Sector In Brief Shiny Dashboard

## To view the Shiny portal:
- Go to http://127.0.0.1:6664/. (Note: this method is untested)
- In R: Clone the repository, open `ui.R`, and press the Run App button 
- In R: Set the working directory as the previous repository (`npsdashboard`) and run 
> `runApp("Shiny")`


## Directory
- `ui.R`: User Interface of the Shiny Dashboard
- `server.R`: R Server 
- `global.R`: Packages, data, and functions that will be used throughout `ui.R` and `server.R`

- Data: Subdirectory to store all the data as well as markdown files that were used to create these data and test functions
- www: Subdirectory to set up webpage 

## To work on: 
1. Resize Urban Logo
2. Lines (commented out) to add footer in `ui.R` are not working. Future researchers need to figure out how to build the footer
3. For graphs on the Organization Type page, only data of the 10 most recent years on the [NCCS Data Archive](https://nccs-data.urban.org/data.php?ds=core) webpage is deployed. 
More data needs to be processed and loaded to make the page comprehensive
5. Titles can be added to graphs and tables 
6. Portal layout could be improved depending on the need and requirement
7. Need to figure out how to publish the portal so that it's sharable
