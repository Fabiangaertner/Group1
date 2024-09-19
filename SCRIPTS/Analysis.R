
#Hente bibliotek
#Lese inn data
library(tidyverse)
library(here)

#Reading the data of the final and making an object
read_delim(
  here("DATA", "full_data_tidy_2024-09-12.txt")
)
dataset <- read_delim(
  here("DATA", "full_data_tidy_2024-09-12.txt") 
)

#Analyse the dataset and answer the following questions:

# 1.Is there a difference in the occurrence of the disease by sex?
# Analyse two catagorical variables, disease and sex
# Chi squared test
# Making a table and therafter the analysis

table_data <- table(dataset$sex_as_factor, dataset$acute_bacterial_meningitis)
table_data

chi_squared_result <- chisq.test(table_data)
chi_squared_result

#Answer; Resultat shows no significanse between sex and disease, p-value 0,25

# 2.Does the occurrence of the disease depend on age?
# Analyse one catogorical variable with a numeric variable
# t- test

t_test_result <- t.test(age ~ acute_bacterial_meningitis, data = dataset)
t_test_result

#Answer; P -value 0,3294. Non significant findings between diagnosis and age

# 3.Is there a difference in the occurrence of the disease by race?
# Analyse two catogorical variable
# Chi squared test
# Making a table and thereafter the analysis

table_data2 <- table(dataset$race, dataset$acute_bacterial_meningitis)
table_data2

chi_squared_result2 <- chisq.test(table_data2)
chi_squared_result2

#Answer; It is significante findings when you compare disase with race. This is probably beacuse of the "none race" data.


# Is there a time trend in the occurrence of the disease?
# Svar: Feedback from courseleader that this question has a bug, and we don*t need to solve it

