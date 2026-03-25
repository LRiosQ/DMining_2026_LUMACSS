# --- 02_DATA_ANALYSIS_TARGETED.R ---

# 1. Load necessary libraries
library(tidyverse)
library(ggrepel)

# 2. Load the data from your preprocessed folder
# Make sure the file exists in this path
mrv_data <- read.csv("data_preprocessed/gender_care_economy_master.csv")

# 3. Define the list of countries for your research (ISO3 codes)
target_countries <- c("CHE", "MEX", "CRI", "URY", "CHL", "COL", "ARG")

# 4. Create the labels for the plot
# We only fill 'country_label' if the country is in our target list
mrv_data <- mrv_data %>%
  mutate(country_label = ifelse(countryiso3code %in% target_countries, 
                                countryiso3code, ""))

# 5. Generate the Plot
final_plot <- ggplot(mrv_data, aes(x = care_work_val, y = labor_part_val)) +
  # Points with size based on Family Workers
  geom_point(aes(size = family_work_val), color = "midnightblue", alpha = 0.5) +
  
  # Trend line (Linear Regression)
  geom_smooth(method = "lm", color = "darkorange", se = TRUE) +
  
  # Smart labels for your 7 specific countries
  geom_text_repel(aes(label = country_label), 
                  size = 4, 
                  fontface = "bold",
                  box.padding = 0.8, 
                  point.padding = 0.5,
                  segment.color = "grey50") +
  
  # Titles and axis names
  labs(
    title = "Care Economy and Labor Participation: Regional Focus",
    subtitle = "Highlighting Switzerland and selected Latin American countries",
    x = "Unpaid care work (% of 24h day)",
    y = "Female Labor Force Participation Rate (%)",
    size = "Family Workers (%)"
  ) +
  theme_minimal()

# 6. Display the plot in RStudio
print(final_plot)

# 7. Save the final version as a high-quality image
ggsave(filename = "data_preprocessed/plot_targeted_countries.png", 
       plot = final_plot,
       width = 10, height = 7, dpi = 300)

message("Process complete! Check the 'Plots' tab and your 'data_preprocessed' folder.")