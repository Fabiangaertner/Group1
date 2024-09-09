library(tidyverse)
library(here)

#lese inn datasetet og lager objekt dataset
read_delim(
  here("DATA", "abm_exam_data.txt")
  )
dataset <- read_delim(
  here("DATA", "abm_exam_data.txt") 
)

#explore the data:
head(dataset)
tail(dataset)
summary(dataset)
glimpse(dataset)
skimr::skim(dataset)
naniar::gg_miss_var(dataset)

# Variablene "feature type" og "feature value" endres til "sex" og "race", med dette unngå vi dobbelføring og reduserer antall n fra 1162 til 581 
dataset %>% 
  pivot_wider(names_from = `feature type`, values_from = feature_value) 

#lager nytt objekt "data_tidy" med de nye variablene sex og race
data_tidy <- dataset %>% 
  pivot_wider(names_from = `feature type`, values_from = feature_value)

#explore the new dataset called data_tidy:
head(data_tidy)
tail(data_tidy)
summary(data_tidy)
glimpse(data_tidy)
skimr::skim(data_tidy)
naniar::gg_miss_var(data_tidy)

