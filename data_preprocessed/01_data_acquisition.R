# --- PACKAGE INSTALLATION (Run only if needed) ---
# install.packages("httr")
# install.packages("jsonlite")
# install.packages("tidyverse")

library(httr)      # Facilitates HTTP connections
library(jsonlite)  # Handles JSON data format
library(tidyverse) # For data manipulation and piping

# Check working directory to ensure it matches your Project/GitHub structure
getwd() 

# --- 1. API CONNECTION SETUP ---

# Define URLs for all relevant indicators
# per_page=30000 ensures we retrieve all available records in one request

# Indicator 1: Contributing family workers, female (% of female employment)
api_url_family <- "https://api.worldbank.org/v2/en/country/all/indicator/SL.FAM.WORK.FE.ZS?format=json&per_page=30000"

# Indicator 2: Unpaid domestic and care work, female (% of 24 hour day)
api_url_care <- "https://api.worldbank.org/v2/en/country/all/indicator/SG.TIM.UWRK.FE?format=json&per_page=30000"

# Indicator 3: Labor force participation rate, female (% of female population ages 15-64)
api_url_labor <- "https://api.worldbank.org/v2/en/country/all/indicator/SL.TLF.CACT.FE.ZS?format=json&per_page=30000"


# --- 2. DATA ACQUISITION AND STORAGE (RAW DATA) ---

# Fetching and saving Indicator 1 (Family Workers)
res_family <- GET(api_url_family)
cont_family <- content(res_family, as = "text")
write(cont_family, file = "data_raw/women_family_workers_raw.json")

# Fetching and saving Indicator 2 (Unpaid Care)
res_care <- GET(api_url_care)
cont_care <- content(res_care, as = "text")
write(cont_care, file = "data_raw/unpaid_care_raw.json")

# Fetching and saving Indicator 3 (Labor Participation)
res_labor <- GET(api_url_labor)
cont_labor <- content(res_labor, as = "text")
write(cont_labor, file = "data_raw/labor_force_raw.json")

# Verify the last connection status (200 = Success)
status_code(res_labor)
message("All raw data successfully saved in data_raw/ folder!")


# --- 3. LOADING AND CONVERTING JSON TO DATAFRAMES ---

# Convert Indicator 1 to Data Frame
# Extracting the second element [[2]] which contains the actual observations
df_family <- fromJSON("data_raw/women_family_workers_raw.json")[[2]] %>% as.data.frame()

# Convert Indicator 2 to Data Frame
df_care <- fromJSON("data_raw/unpaid_care_raw.json")[[2]] %>% as.data.frame()

# Convert Indicator 3 to Data Frame
df_labor <- fromJSON("data_raw/labor_force_raw.json")[[2]] %>% as.data.frame()


# --- 4. PRELIMINARY DATA INSPECTION ---

# Checking structures
str(df_family)
str(df_care)
str(df_labor)

# Preview the data to ensure accuracy
head(df_care, 11)

# View the main indicator table in a spreadsheet-like viewer
view(df_care)
