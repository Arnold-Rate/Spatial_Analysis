#Loading the Required Packages
install.packages("dplyr")
installed.packages("readr")

library(dplyr,readr)


#Read the Downloaded dataset,
haiti_data <- read.csv("~/R/isair_r/data/haiti/haiti-healthsites.csv")
haiti_data


#Selecting relevant columns.
haiti_selected <- haiti_data %>% select(name, adm1_en, adm2_en, total)
haiti_selected


#Filter data for specific regions.
haiti_filtered <- haiti_selected %>% filter(adm1_en %in% c("North", "North-East", "North_West"))
haiti_filtered


#Group by administrative divisions and summarize data.
haiti_summary <- haiti_filtered %>%
  group_by(adm1_en, adm2_en) %>%
  summarise(
    num_health_facilities = n(), #Count number of health facilities
    total_population = first(total) #Take the first value as population count.
  )


#Create a new variable; Population per health facility.
haiti_summary <- haiti_summary %>% 
  mutate(pop_per_health = total_population / num_health_facilities)


#Sorting by population per health facility (descending order)
haiti_sorted <- haiti_summary %>%
  arrange(desc(pop_per_health))


#Extract the top 5 worst-served areas.
top_5_worst <- head(haiti_sorted,5)
