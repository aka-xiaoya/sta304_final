library(haven)
library(tidyverse)
setwd("Desktop/sta304-final_project")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("2019 Canadian Election Study - Online Survey v1.0.dta")
raw_data <- labelled::to_factor(raw_data)
raw_data
reduced_data <- 
  raw_data %>% 
  select(cps19_ResponseId ,cps19_votechoice,cps19_yob, cps19_gender,cps19_education, cps19_v_likely,
         cps19_province, cps19_fed_gov_sat)
reduced_data<-
  reduced_data %>%
  mutate(vote_Justin = 
           ifelse(cps19_votechoice=="Liberal Party", 1, 0)) %>%
  mutate(vote_Andrew = 
           ifelse(cps19_votechoice=="Conservative Party", 1, 0))
reduced_data$cps19_yob <- as.numeric(reduced_data$cps19_yob)
reduced_data$age <- 2019 - (reduced_data$cps19_yob+ 1919)
summary(reduced_data)

write_csv(reduced_data, "survey_data1.csv")
