library(tidyverse)
library(here)

#lese inn ny full tidy dataset created 12.09
full_data <- read_delim(
  here("DATA", "full_data_tidy_2024-09-12.txt")
)

#Start with creating plots to answer the following questions:

#Does the glucose level in blood depend on sex?

boxplot(blood_gluc ~ sex, data = full_data,
        main = "Does glucose level depend on sex?",
        ylab = "Blood glucose level, mg/dl",
        xlab = "sex",
        col = "orange")

t.test(blood_gluc ~ sex, data = full_data)
wilcox.test(blood_gluc ~ sex, data = full_data)
#Blood glukose does not depend on sex.

#Does the glucose level in blood depend on race?

boxplot(blood_gluc ~ race, data = full_data,
        main = "Does glucose level depend on race?",
        ylab = "Blood glucose level, mg/dl",
        xlab = "race",
        col = "orange")

kruskal.test(blood_gluc ~ race, data = full_data)
#Blood glukose does not depend on race


#Does the glucose level in CSF (cerebrospinal fluid) depend on race?

boxplot(csf_gluc.x ~ race, data = full_data,
        main = "Does glucose level in CSF depend on race?",
        ylab = "CSF glucose level, mg/dl",
        xlab = "race",
        col = "orange")

kruskal.test(csf_gluc.x ~ race, data = full_data)
# CSF-gluc does not depend on race


#Does the glucose level in CSF (cerebrospinal fluid) depend on sex?

boxplot(csf_gluc.x ~ sex, data = full_data,
        main = "Does CSF-glucose level depend on sex?",
        ylab = "CSF glucose leve, mg/dl",
        xlab = "sex",
        col = "orange")

kruskal.test(csf_gluc.x ~ sex, data = full_data)
#CSF-gluc is not associated with sex
 
