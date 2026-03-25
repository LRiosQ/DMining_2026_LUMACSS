# A. LOAD LIBRARIES
# Libraries must be reload in every new script
library(tidyverse)

# B. LOAD THE PREVIOUSLY SAVED DATA
# Instead of downloading again, we read the Master File we created in script 01
# Make sure the path matches where you saved the CSV
master_df <- read.csv("data_preprocessed/gender_care_economy_master.csv")

# 8. DATA CLEANING: FILTERING FOR MOST RECENT VALUE (MRV) -------------------

# Not all the countries have the same data, so
# we want the latest available data point for each country 
# to ensure our cross-country comparison is as up-to-date as possible.

mrv_data <- master_df %>%
  filter(!is.na(care_work_val)) %>% # Remove rows where care data is missing
  group_by(countryiso3code) %>%     # Group by country
  filter(date == max(date)) %>%     # Keep only the most recent year per country
  ungroup()

# Check how many countries we have now
nrow(mrv_data)

# 9. INITIAL VISUALIZATION (Care Work vs Labor Participation) ---

# Let's create a scatter plot to see the correlation
# Research Question: How is unpaid care related to economic participation?

ggplot(mrv_data, aes(x = care_work_val, y = labor_part_val)) +
  geom_point(aes(size = family_work_val), color = "steelblue", alpha = 0.7) +
  geom_smooth(method = "lm", color = "tomato", se = FALSE) + # Add a trend line
  labs(
    title = "Unpaid Care Work vs. Female Labor Participation",
    subtitle = "Most Recent Value (MRV) per country",
    x = "Time spent on unpaid care (% of day)",
    y = "Female Labor Force Participation (%)",
    size = "Contributing Family Workers (%)",
    caption = "Source: World Bank Gender Data API"
  ) +
  theme_minimal()

# Save your first plot for your Master's presentation
ggsave("plots/care_vs_labor_mrv.png", width = 10, height = 7)