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

# Variablene "feature type" og "feature value" endres til "sex" og "race", med dette unngC% vi dobbelfC8ring og reduserer antall n fra 1162 til 581 
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


#fix date variable to Year YYYY/MM (Fabian)

data_tidy$date <- ym(data_tidy$date)

data_tidy$date <- format(as.Date(data_tidy$date, "%Y/%m/%d"), "%Y/%m")

view(data_tidy)

#AKM branch----
#rename existing columns to be more intuitive and readable
data_tidy <- data_tidy %>% 
  rename("acute_bacterial_meningitis" = abm)
data_tidy <- data_tidy %>%
  rename("gram_stain_result" = gram)
data_tidy <- data_tidy %>% 
  rename("sampling_date" = date)
data_tidy <- data_tidy %>%
  rename("id" = casenum)

#redusere antall desimaler i variabel "blood_wbc"

data_tidy$blood_wbc <- round(data_tidy$blood_wbc, digits = 2)

#Fortsettelse pC% egne greiner, herved silje

#Endre navn pC% variabel for alder
#Endre til mnder ved <1C%r og C%r ved >1C%r, med 2desimal for mnder
data_tidy <- data_tidy %>%
  rename(age = "1.age")

data_tidy$age <- ifelse(data_tidy$age >= 1, 
  paste(data_tidy$age, "years"), 
  paste(round(data_tidy$age * 12, 2), "months"))

#new_columns
view(data_tidy)

# new column showing whether `blood_neut_pct` is higher than 35 or not/ High/Low
data_tidy <- data_tidy %>% 
mutate(blood_neut_pct_highvslow = if_else(
  blood_neut_pct > 35,
  "high", "low"
    )
)

#- A numeric column showing `blood_cult` as a percentage of highest possible value (11): blood cult / highest blood cult
max_blood_cult <- max(data_tidy$blood_cult, na.rm = TRUE)
data_tidy <- data_tidy %>% 
  mutate(blood_cult_percentage = round(
    blood_cult / max_blood_cult,
    digits = 2
    ))
class(data_tidy$blood_cult)

data_tidy %>% select(blood_cult, blood_cult_percentage)


#Anna  - Create a column showing sex as `0/1` (and `NA` for missing, if any)
##skaper ny numerisk variabel der det er definert nye navn på de tre ulike observasjonene vi har (male, female, none)

data_tidy <- data_tidy %>% 
  mutate(sex_as_factor = case_when(
    sex == "male" ~ 0,
    sex == "female" ~ 1,
    sex == "none" ~ NA))

##den nye numeriske variabelen av kjønn gjøres om til faktor-variabel. Har allerede definerte levels

data_tidy$sex_as_factor <- as.factor(data_tidy$sex_as_factor)

##sjekker at det ble en faktor, hvilke levels som finnes, og at NA ikke er et av disse levels
class(data_tidy$sex_as_factor)
unique(data_tidy$sex_as_factor)
view(data_tidy)

#Anna - Set the order of columns as: `id, age, sex` and other columns
data_tidy <- data_tidy %>% 
  select(id, age, sex, everything())

#Anna - Arrange ID column of your dataset in order of increasing number or alphabetically
data_tidy <- data_tidy %>% 
  arrange(id)
 