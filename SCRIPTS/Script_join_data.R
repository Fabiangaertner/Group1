library(tidyverse)

#henter frem nytt datasett fra fillagert, mappe "DATA"
join_data <- read_delim(
  here("DATA", "exam_abm_joindata.txt")
)

#explore nytt datasett
view(join_data)
head(join_data)
tail(join_data)
summary(join_data)
glimpse(join_data)
skimr::skim(join_data)
naniar::gg_miss_var(join_data)

#joiner gammelt ryddig dataset, med nytt sett (kalt "join_data"), ved å joine id-variablene sammen
full_data <- data_tidy %>%
  full_join(join_data, join_by("id"))


#nytt sett inneholder variablene "id" og "csf_gluc". Begge disse hadde vi fra før, 
#men vi observerer at "csf_gluc" ikke står beskrevet i kodeboken for det første settet. 
#Antar det muligens er en feil at det er tilsynelatende helt like data i begge settene.
#Men vi klarte hvert fall å joine settene :) 

# Explore and comment on the missing variables.
naniar::gg_miss_var(join_data)
skimr::skim(join_data)
#127 missing på "csf_gluc

#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
#Vi grupperer basert på kjønn-som-faktor-variabelen, og får utregnet mean- og sd-verdier for csf_wbc for menn (0) og for kvinner (1).

full_data %>%
  group_by(sex_as_factor) %>%
  summarise(mean(csf_wbc, na.rm=T), sd(csf_wbc, na.rm=T))

#Vi stratifiserer igjen basert på kjønn-som-faktor, og rappoerterer minimum og maksimum verdier for csf_wbc
full_data %>%
  group_by(sex_as_factor) %>%
  summarise(min(csf_wbc, na.rm=T), max(csf_wbc, na.rm=T))

#- Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!

#  Ser på kun personer med `blood_cult == 0`, stratifiserer for kjønn, og får opp minimum og maksimum verdier, mean og sd for csf_wbc.
full_data %>% 
  filter(blood_cult == 0) %>%
  group_by(sex_as_factor) %>% 
  summarise(min(csf_wbc, na.rm=T), max(csf_wbc, na.rm=T), mean(csf_wbc, na.rm=T), sd(csf_wbc, na.rm=T))
  
# Filtrerer for kvinner aleine, med blood-cult==0. 
full_data %>% 
  filter(blood_cult == 0) %>%
  filter(sex_as_factor==1) %>% 
  summarise(min(csf_wbc, na.rm=T), max(csf_wbc, na.rm=T), mean(csf_wbc, na.rm=T), sd(csf_wbc, na.rm=T))

# Filtrerer for personer over 45 år (age-variabel), grupperer på kjønn og oppgir min, max verdier, samt mean og sd.
full_data %>%
  filter(age > 45) %>%
  group_by(sex_as_factor) %>% 
  summarise(min(csf_wbc, na.rm=T), max(csf_wbc, na.rm=T), mean(csf_wbc, na.rm=T), sd(csf_wbc, na.rm=T))

# Filtrerer for personer med rase "black" og blood_gluc over 120
full_data %>% 
  filter(blood_gluc > 120) %>%
  filter(race == "black") %>% 
  summarise(min(csf_wbc, na.rm=T), max(csf_wbc, na.rm=T), mean(csf_wbc, na.rm=T), sd(csf_wbc, na.rm=T))

#Lager tabell av to kategorier: kjønn (sex_as_factor) og acute_bacterial_meningitis, som begge er kategoriske med verdier 0, 1 (eller NA)
  
test_table <- table(full_data$sex_as_factor, full_data$acute_bacterial_meningitis)

#navngir kolonner og rader
colnames(test_table) <- c("non-bacterial meningitis", "bacterial meningitis")
rownames(test_table) <- c("male", "female")

#viser ny tabell med navn
test_table

#Lagring av fil, gir først filnavn, string, og så lagrer i DATA-mappen
fileName <- paste0("full_data_tidy_", Sys.Date(), ".txt")
write_delim(full_data, 
            file = here("DATA", fileName), delim="\t")

  
