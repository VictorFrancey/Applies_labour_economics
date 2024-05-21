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


##1 Réduction de BREST par année de début de formation et au type de formation souhaité ----

# brest_tbl <- read.csv("Applied_labor/brest2_1721.csv")
# brest_tbl <- brest_tbl %>% mutate(DATE_FIN = ymd(DATE_FIN)) 

#2017 
# brest_2017_tbl <- brest_tbl %>% filter(ANNEE_ENTREE == 2017)
# brest_2017_tbl <- brest_2017_tbl %>% mutate(DATE_FIN = as.Date(DATE_FIN, "%d/%m/%y"))
# brest_2017_tbl <- brest_2017_tbl %>% mutate(DATE_FIN = ymd(DATE_FIN)) %>% mutate(ANNEE_FIN = year(DATE_FIN))
# brest_2017_tbl <- brest_2017_tbl %>% filter(ANNEE_FIN < 2022)
# brest_2017_tbl <- brest_2017_tbl %>% filter(OBJECTIF_STAGE == "7- perfectionnement, élargissement des compétences")
# 

#2018 


# brest_2018_tbl <- brest_tbl %>% filter(ANNEE_ENTREE == 2018)
# brest_2018_tbl <- brest_2018_tbl %>% mutate(DATE_FIN = as.Date(DATE_FIN, "%d/%m/%y"))
# brest_2018_tbl <- brest_2018_tbl %>% mutate(DATE_FIN = ymd(DATE_FIN)) %>% mutate(ANNEE_FIN = year(DATE_FIN))
# brest_2018_tbl <- brest_2018_tbl %>% filter(ANNEE_FIN < 2022)
# brest_2018_tbl <- brest_2018_tbl %>% filter(OBJECTIF_STAGE == "7- perfectionnement, élargissement des compétences")
# 
# brest_2019_tbl <- brest_tbl %>% filter(ANNEE_ENTREE == 2019)
# brest_2019_tbl <- brest_2019_tbl %>% mutate(DATE_FIN = as.Date(DATE_FIN, "%d/%m/%y"))
# brest_2019_tbl <- brest_2019_tbl %>% mutate(DATE_FIN = ymd(DATE_FIN)) %>% mutate(ANNEE_FIN = year(DATE_FIN))
# brest_2019_tbl <- brest_2019_tbl %>% filter(ANNEE_FIN < 2022)
# brest_2019_tbl <- brest_2019_tbl %>% filter(OBJECTIF_STAGE == "7- perfectionnement, élargissement des compétences")
# 

# 2019


# write.csv(brest_2017_tbl, "Applied_labor/brest_2017_renfo_comp.csv")
# write.csv(brest_2018_tbl, "Applied_labor/brest_2018_renfo_comp.csv")
# write.csv(brest_2019_tbl, "Applied_labor/brest_2019_renfo_comp.csv")

##2 Jonction avec les MM0 de la même année ----

# 2017
# MMO_2017_tbl <- read.csv("Applied_labor/MMO_2017.csv")
# 
# MMO_BREST_2017 <- brest_2017_tbl %>% left_join(MMO_2017_tbl, by = c("id_force" = "id_force"))
# write.csv(MMO_BREST_2017, "Applied_labor/MM0_BREST_2017.csv")
# rm(MMO_2017_tbl

## 2018
#MMO_2018_tbl <- read.csv("Applied_labor/MMO_2018.csv")
# 
# MMO_BREST_2018 <- brest_2018_tbl %>% left_join(MMO_2018_tbl, by = c("id_force" = "id_force"))
# write.csv(MMO_BREST_2018, "Applied_labor/MM0_BREST_2018.csv")
# rm(MMO_2018_tbl)

#2019

# MMO_2019_tbl <- read.csv("Applied_labor/MMO_2019.csv")
# 
# MMO_BREST_2019 <- brest_2019_tbl %>% left_join(MMO_2019_tbl, by = c("id_force" = "id_force"))
# write.csv(MMO_BREST_2019, "Applied_labor/MM0_BREST_2019.csv")
# rm(MMO_2019_tbl)


# 


##3 Jonction avec le SIRET ----

# #2017
# 
# siret_2017_tbl <- read.csv("Applied_labor/siret_2017.csv")
# 
# brest_MMO_siret_2017 <- MMO_BREST_2017 %>% left_join(siret_2017_tbl, by = c("siret_AF" = "SIRET"))
# write.csv(brest_MMO_siret_2017, "Applied_labor/brest_MMO_siret_2017.csv")
# rm(MMO_BREST_2017)
# 
# #2018
# 
# siret_2018_tbl <- read.csv("Applied_labor/siret_2018.csv")
# 
# brest_MMO_siret_2018 <- MMO_BREST_2018 %>% left_join(siret_2018_tbl, by = c("siret_AF" = "SIRET"))
# write.csv(brest_MMO_siret_2018, "Applied_labor/brest_MMO_siret_2018.csv")
# rm(MMO_BREST_2018)
# 
# #2019

# siret_2019_tbl <- read.csv("Applied_labor/siret_2019.csv")
# MMO_BREST_2019 <- read.csv("Applied_labor/MM0_BREST_2019.csv")
# brest_MMO_siret_2019 <- MMO_BREST_2019 %>% left_join(siret_2019_tbl, by = c("siret_AF" = "SIRET"))
# write.csv(brest_MMO_siret_2019, "Applied_labor/brest_MMO_siret_2019.csv")
# rm(MMO_BREST_2019)
