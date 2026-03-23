# install.packages("httr")
# install.packages("jsonlite")
# install.packages("tidyverse")

library(httr)      # Facilitates HTTP connections
library(jsonlite)  # Handles JSON data format
library(tidyverse) # For all

getwd() # to see where R is looking currently and verify will work with GH

# --- API CONNECTION SETUP ---

# 1. Define the base URL for the World Bank API
# We are requesting data for all countries, for a specific gender indicator, in JSON format.
# Add "per_page=30000" to get all the information and not only the first
api_url <- "https://api.worldbank.org/v2/en/country/all/indicator/SL.FAM.WORK.FE.ZS?format=json&per_page=30000"
#https://data.worldbank.org/indicator/SL.FAM.WORK.FE.ZS



# 2. Make the GET request to the API
# This 'hits' the URL and brings back the information
library(httr)
raw_response <- GET(api_url)

# 3. Check the status of the connection
# A status of 200 means "Success"!
status_code(raw_response)

# --- SAVING THE RAW DATA ---

# 1. Extract the content from the response as text
raw_content <- content(raw_response, as = "text")

# 2. Save it as a .json file in the raw data folder
# This is our "original" backup
write(raw_content, file = "data_raw/women_parliament_raw.json")

message("Original data successfully saved in data_raw/!")
# Reading the JSON
raw_json_data <- fromJSON("data_raw/women_parliament_raw.json")

#Converting JSON to Data Frame
raw_table <- as.data.frame(raw_json_data[[2]])
str(raw_table)

#see what I have to make shure
head(raw_table, 11)

#view
