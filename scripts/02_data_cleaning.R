# A. LOAD LIBRARIES
# Libraries must be reload in every new script
library(tidyverse)
install.packages("ggrepel")
library(ggrepel) # To handle overlapping text labels

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

# To see the 5 counties with more "Contributing Family Workers"
mrv_data %>%
  select(countryiso3code, family_work_val, care_work_val, labor_part_val) %>%
  arrange(desc(family_work_val)) %>%
  head(5)

# --- DATA VISUALIZATION WITH SMART LABELS ---

# 1. Prepare the data for selective labeling
# Arrange by 'family_work_val' to identify the extremes (highest and lowest)
mrv_data <- mrv_data %>%
  arrange(desc(family_work_val)) %>%
  # Create a temporary rank column (1 = highest family work, etc.)
  mutate(label_priority = row_number()) %>% 
  # Create a new column 'country_label'
  # If it's in the Top 5 or Bottom 5, keep the ISO3 code; otherwise, leave it blank ("")
  mutate(country_label = ifelse(label_priority <= 5 | label_priority > (n() - 5), 
                                countryiso3code, ""))

# 3. Generate the Scatter Plot
ggplot(mrv_data, aes(x = care_work_val, y = labor_part_val)) +
  # Points: size depends on contributing family work, color is dark blue, and they are semi-transparent
  geom_point(aes(size = family_work_val), color = "midnightblue", alpha = 0.5) +
  
  # Add a trend line (Linear Model) in orange to see the correlation
  geom_smooth(method = "lm", color = "darkorange", se = TRUE) +
  
  # Add the smart labels using ggrepel
  # This automatically moves the text so it doesn't overlap with points or other labels
  geom_text_repel(aes(label = country_label), 
                  size = 3.5, 
                  fontface = "bold",
                  box.padding = 0.5, 
                  point.padding = 0.5) +
  
  # Add professional titles and axis labels
  labs(
    title = "Unpaid Care Work vs. Female Labor Participation",
    subtitle = "Labels: 5 countries with highest and 5 with lowest family work share",
    x = "Unpaid care work (% of 24h day)",
    y = "Female Labor Force Participation Rate (%)",
    size = "Contributing Family Workers (%)"
  ) +
  
  # Use a clean, professional theme for the Master's project
  theme_minimal()
