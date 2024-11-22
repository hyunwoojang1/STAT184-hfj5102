# STAT184-HW-Template
 STAT184 Github Day 1 HW Template

# Introduction
This repository was created for analyzing the **U.S. Armed Forces personnel data**.  
The goal is to clean and visualize the data to analyze the distribution of military personnel by gender and rank.  
Dataset used: **US Armed Forces (6_2024) - Sheet1.csv**.  
The dataset includes the number of personnel by rank and gender across various branches (Army, Navy, Marine Corps, Air Force, and Space Force).

---

## Implementation
The following tasks were completed for this project:
- Data cleaning and transformation using R, including renaming columns and reshaping the data for analysis.
- Grouping and summarizing data by gender and branch.
- Generating frequency tables and calculating percentages for male and female personnel distributions.
- Used the `tidyverse` and `janitor` R packages to streamline the data wrangling process.

### Example Code
Below is an example of how the data was transformed:
```R
library(tidyverse)
library(janitor)

armed_forces_data <- read_csv("US Armed Forces (6_2024) - Sheet1.csv", col_names = FALSE)

colnames(armed_forces_data) <- c(
  "Pay_Grade",
  "Army_Male", "Army_Female", "Army_Total",
  "Navy_Male", "Navy_Female", "Navy_Total",
  "Marine_Corps_Male", "Marine_Corps_Female", "Marine_Corps_Total",
  "Air_Force_Male", "Air_Force_Female", "Air_Force_Total",
  "Space_Force_Male", "Space_Force_Female", "Space_Force_Total",
  "Total_Male", "Total_Female", "Total_Personnel"
)

tidy_data <- armed_forces_data %>%
  pivot_longer(
    cols = -Pay_Grade,
    names_to = c("Branch", "Sex"),
    names_pattern = "(.*)_(.*)",
    values_to = "Total_Personnel"
  ) %>%
  mutate(Sex = if_else(Sex == "Male", "M", "F")) '''


#### Contact
hfj5102@psu.edu







