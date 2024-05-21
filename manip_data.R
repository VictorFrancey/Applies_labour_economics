# Packages ----

# install.packages("tidyverse")
#install.packages("tidyquant")
# install.packages("lubridate")
# install.packages("haven")

library(tidyverse)
library(tidyquant)
library(lubridate)
library(haven)
library(readr)


# 1 - Création des bases contenant les personnes d'intérêt parmi celles ayant réalisé le type de stage réalisé ----

# Garder les stagiaires de notre catégorie de 2017 ayant travaillé en 2022, pour lesquels on a le salaire à temps plein,
# réalisé année par année

# 2017

data_renfor_2017_tbl <- read.csv(file = "Applied_labor/brest_MMO_siret_2017.csv")
MMO_2022_tbl <- read.csv(file = "Applied_labor/MMO_2022.csv")

data_renfor_2017_tbl <- data_renfor_2017_tbl %>% filter(salaire_base_mois_complet == 1) 

id_force_renfo_2017 <- data_renfor_2017_tbl %>% select(id_force)

stagiaires_2017_in_MMO_2022 <- id_force_renfo_2017 %>%  left_join(MMO_2022_tbl , by=c("id_force"="id_force"))

stagiaires_2017_in_MMO_2022 <-  stagiaires_2017_in_MMO_2022 %>% filter(salaire_base_mois_complet ==1)


stagiaires_2017_in_MMO_2022  <- stagiaires_2017_in_MMO_2022 %>% mutate(FinCTT = case_when(
   FinCTT == "" ~ "2022-12-31",
   TRUE ~ FinCTT
 ))

 stagiaires_2017_in_MMO_2022  <- stagiaires_2017_in_MMO_2022 %>% mutate(FinCTT = as.Date(FinCTT), DebutCTT = as.Date(DebutCTT))

 stagiaires_2017_in_MMO_2022 <- stagiaires_2017_in_MMO_2022 %>% filter(Salaire_Base>1000)

 stagiaires_2017_in_MMO_2022 %>% group_by(Quali_Salaire_Base) %>%  summarize(count=n())


stagiaires_2017_in_MMO_2022 <- stagiaires_2017_in_MMO_2022 %>% filter (Quali_Salaire_Base == 7)
 stagiaires_2017_in_MMO_2022 <- stagiaires_2017_in_MMO_2022 %>%  group_by(id_force) %>% mutate(mean_salary_2022 = mean(Salaire_Base)) %>% filter(row_number()==1) %>% ungroup()
 write.csv(stagiaires_2017_in_MMO_2022, "Applied_labor/stagiaires_2017_in_MMO_2022.csv")


# # 2018
# 
# data_renfor_2018_tbl <- read.csv(file = "Applied_labor/brest_MMO_siret_2018.csv")
# MMO_2022_tbl <- read.csv(file = "Applied_labor/MMO_2022.csv")
# 
# data_renfor_2018_tbl <- data_renfor_2018_tbl %>% filter(salaire_base_mois_complet == 1)

# id_force_renfo_2018 <- data_renfor_2018_tbl %>% select(id_force)
# 
# stagiaires_2018_in_MMO_2022 <- id_force_renfo_2018 %>%  left_join(MMO_2022_tbl , by=c("id_force"="id_force"))
# 
# stagiaires_2018_in_MMO_2022 <-  stagiaires_2018_in_MMO_2022 %>% filter(salaire_base_mois_complet ==1)
# 
# stagiaires_2018_in_MMO_2022  <- stagiaires_2018_in_MMO_2022 %>% mutate(FinCTT = case_when(
#   FinCTT == "" ~ "2022-12-31",
#   TRUE ~ FinCTT
# ))
# 
# stagiaires_2018_in_MMO_2022  <- stagiaires_2018_in_MMO_2022 %>% mutate(FinCTT = as.Date(FinCTT), DebutCTT = as.Date(DebutCTT)) 
# 
# stagiaires_2018_in_MMO_2022 <- stagiaires_2018_in_MMO_2022 %>% filter(Salaire_Base>1000)

# stagiaires_2018_in_MMO_2022 <- stagiaires_2018_in_MMO_2022 %>% filter (Quali_Salaire_Base == 7)
# stagiaires_2018_in_MMO_2022 <- stagiaires_2018_in_MMO_2022 %>%  group_by(id_force) %>% mutate(mean_salary_2022 = mean(Salaire_Base)) %>% filter(row_number()==1) %>% ungroup()
# write.csv(stagiaires_2018_in_MMO_2022, "Applied_labor/stagiaires_2018_in_MMO_2022.csv")


# 2019

 # data_renfor_2019_tbl <- read.csv(file = "Applied_labor/brest_MMO_siret_2019.csv")
 # MMO_2022_tbl <- read.csv(file = "Applied_labor/MMO_2022.csv")
 # 
 # data_renfor_2019_tbl <- data_renfor_2019_tbl %>% filter(salaire_base_mois_complet == 1)
 # 
 # id_force_renfo_2019 <- data_renfor_2019_tbl %>% select(id_force)
 # 
 # stagiaires_2019_in_MMO_2022 <- id_force_renfo_2019 %>%  left_join(MMO_2022_tbl , by=c("id_force"="id_force"))
 # 
 # stagiaires_2019_in_MMO_2022 <-  stagiaires_2019_in_MMO_2022 %>% filter(salaire_base_mois_complet ==1)
 # 
 # stagiaires_2019_in_MMO_2022  <- stagiaires_2019_in_MMO_2022 %>% mutate(FinCTT = case_when(
 #   FinCTT == "" ~ "2022-12-31",
 #   TRUE ~ FinCTT
 # ))
 # 
 # stagiaires_2019_in_MMO_2022  <- stagiaires_2019_in_MMO_2022 %>% mutate(FinCTT = as.Date(FinCTT), DebutCTT = as.Date(DebutCTT))
 # 
 # stagiaires_2019_in_MMO_2022 <- stagiaires_2019_in_MMO_2022 %>% filter(Salaire_Base>1000)
 # 
 # stagiaires_2019_in_MMO_2022 <- stagiaires_2019_in_MMO_2022 %>% filter (Quali_Salaire_Base == 7)
 # stagiaires_2019_in_MMO_2022 <- stagiaires_2019_in_MMO_2022 %>%  group_by(id_force) %>% mutate(mean_salary_2022 = mean(Salaire_Base)) %>% filter(row_number()==1) %>% ungroup()
 # write.csv(stagiaires_2019_in_MMO_2022, "Applied_labor/stagiaires_2019_in_MMO_2022.csv")





# 2- Manip similaire parmi ceux qui n'ont pas fait ce stage - 2019

#MMO_2022_in_2019 <- read.csv("Applied_labor/MMO_2022_in_2019.csv")
#MMO_2019_in_2022 <- read.csv("Applied_labor/MMO_2019_in_2022.csv")
# 
# stagiaires_2019_in_MMO_2022 <- read.csv("Applied_labor/stagiaires_2019_in_MMO_2022.csv")
# 
#  brest_17_21 <-read.csv("Applied_labor/brest2_1721.csv")
#  MMO_2019 <- read.csv("Applied_labor/MMO_2019.csv")
#  MMO_2022 <- read.csv("Applied_labor/MMO_2022.csv")
# # 
# MMO_2019_no_BREST <- anti_join(MMO_2019, brest_17_21, by="id_force")
# # rm(brest_17_21)
# # rm(MMO_2019)
# # 
# # 
# MMO_2022 <- MMO_2022 %>% filter(salaire_base_mois_complet == 1)
# # 
#  MMO_2019_no_BREST <- MMO_2019_no_BREST %>% filter(salaire_base_mois_complet == 1)
# # 
#  MMO_2019_in_2022 <- semi_join(MMO_2019_no_BREST, MMO_2022, by=c("id_force" = "id_force"))
#  
#  MMO_2022_in_2019 <- semi_join(MMO_2022, MMO_2019_no_BREST, by=c("id_force" = "id_force"))
# 
# MMO_2019_in_2022 <- MMO_2019_in_2022 %>% filter(Salaire_Base > 1000)
# MMO_2022_in_2019 <- MMO_2022_in_2019 %>% filter(Salaire_Base > 1000)
# 
# 
# MMO_2019_in_2022 <- MMO_2019_in_2022 %>% group_by(id_force) %>% mutate(salaire_2019_moyen = mean(Salaire_Base)) %>% ungroup()
#  MMO_2022_in_2019 <- MMO_2022_in_2019 %>% group_by(id_force) %>% mutate(salaire_2022_moyen = mean(Salaire_Base)) %>% ungroup()

# MMO_2019_in_2022 <- MMO_2019_in_2022 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup()
# MMO_2022_in_2019 <- MMO_2022_in_2019 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup()
# 
# MMO_2019_in_2022 <- MMO_2019_in_2022 %>% filter(count == 1)
# MMO_2022_in_2019 <- MMO_2022_in_2019 %>% filter(count == 1)
# # 
# write.csv(MMO_2019_in_2022, "Applied_labor/MMO_2019_in_2022.csv")
# write.csv(MMO_2022_in_2019, "Applied_labor/MMO_2022_in_2019.csv")
