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

prob_emploi_non_stagiaires_2019_2022 <- read.csv("Applied_labor/prob_emploi_non_stagiaires_2019_2022.csv")

prob_emploi_stagiaires_2019_2022 <- read.csv("Applied_labor/prob_emploi_stagiaires_2019_2022.csv")

# 1 - base stagiaires pertinente et base de comparaison pertinente, ces bases contiendront aussi les stagiaires non présents en 2022, donc différentes des précédentes
# ----

# 
# brest_MMO_siret_2017 <- read.csv("Applied_labor/brest_MMO_siret_2017.csv")
# brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% filter(salaire_base_mois_complet == 1)
# brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% filter(Salaire_Base > 1000)
# brest_MMO_siret_2017 <-  brest_MMO_siret_2017 %>% group_by(id_force) %>% mutate(salaire_moyen_pre_stage = mean(Salaire_Base)) %>% ungroup()
# 
# brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()
# brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% filter(count == 1)
# brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% filter(Quali_Salaire_Base == 7)
# 
# stagiaires_2017_in_MMO_2022 <- read.csv("Applied_labor/stagiaires_2017_in_MMO_2022.csv")
# 
# stagiaires_2017_2022 <- brest_MMO_siret_2017 %>% left_join(stagiaires_2017_in_MMO_2022, by = c("id_force" = "id_force"))
# 
# 
# write.csv(stagiaires_2017_2022, "Applied_labor/stagiaires_2017_2022.csv")



# brest_MMO_siret_2018 <- read.csv("Applied_labor/brest_MMO_siret_2018.csv")
# brest_MMO_siret_2018 <- brest_MMO_siret_2018 %>% filter(salaire_base_mois_complet == 1)
# brest_MMO_siret_2018 <- brest_MMO_siret_2018 %>% filter(Salaire_Base > 1000)
# brest_MMO_siret_2018 <-  brest_MMO_siret_2018 %>% group_by(id_force) %>% mutate(salaire_moyen_pre_stage = mean(Salaire_Base)) %>% ungroup()
# 
# brest_MMO_siret_2018 <- brest_MMO_siret_2018 %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()
# brest_MMO_siret_2018 <- brest_MMO_siret_2018 %>% filter(count == 1)
# brest_MMO_siret_2018 <- brest_MMO_siret_2018 %>% filter(Quali_Salaire_Base == 7)
# 
# stagiaires_2018_in_MMO_2022 <- read.csv("Applied_labor/stagiaires_2018_in_MMO_2022.csv")
# 
# stagiaires_2018_2022 <- brest_MMO_siret_2018 %>% left_join(stagiaires_2018_in_MMO_2022, by = c("id_force" = "id_force"))
# 
# 
# 
# write.csv(stagiaires_2018_2022, "Applied_labor/stagiaires_2018_2022.csv")

brest_MMO_siret_2019 <- read.csv("Applied_labor/brest_MMO_siret_2019.csv")
 brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% filter(salaire_base_mois_complet == 1)
 brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% filter(Salaire_Base > 1000)
 brest_MMO_siret_2019 <-  brest_MMO_siret_2019 %>% group_by(id_force) %>% mutate(salaire_moyen_pre_stage = mean(Salaire_Base)) %>% ungroup()

 brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()
 brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% filter(count == 1)
 brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% filter(Quali_Salaire_Base == 7)

 stagiaires_2019_in_MMO_2022 <- read.csv("Applied_labor/stagiaires_2019_in_MMO_2022.csv")

 stagiaires_2019_2022 <- brest_MMO_siret_2019 %>% left_join(stagiaires_2019_in_MMO_2022, by = c("id_force" = "id_force"))


 MMO_2022_tbl <- read.csv("Applied_labor/MMO_2022.csv")


 write.csv(stagiaires_2019_2022, "Applied_labor/stagiaires_2019_2022.csv")
 
# MMO_2019_in_2022 <- read.csv("Applied_labor/MMO_2019_in_2022.csv")
# MMO_2022_in_2019 <- read.csv("Applied_labor/MMO_2022_in_2019.csv")
# 
# MMO_no_Brest_2019_2022 <- MMO_2019_in_2022 %>% left_join(MMO_2022_in_2019, by=c("id_force" = "id_force"))
# MMO_no_Brest_2019_2022 <- MMO_no_Brest_2019_2022 %>%  filter(is.na(salaire_2022_moyen) == FALSE) %>% filter(Quali_Salaire_Base.x ==7) %>%  filter(Quali_Salaire_Base.y == 7)
# write.csv(MMO_no_Brest_2019_2022, "MMO_no_BREST_2019_2022.csv")
# 
# rm(MMO_2019_in_2022)
# rm(MMO_2022_in_2019)
# rm(MMO_2022_tbl)

# 2 - Calcul des différences de salaires ----

# stagiaires_2019_2022 <- stagiaires_2019_2022 %>% mutate(diff_2019_2022 = mean_salary_2022 - salaire_moyen_pre_stage) %>% mutate(augmentation = diff_2019_2022/salaire_moyen_pre_stage)
# MMO_no_Brest_2019_2022 <-  MMO_no_Brest_2019_2022 %>% mutate(diff_2019_2022 = salaire_2022_moyen - salaire_moyen_pre_stage) %>% mutate(augmentation = diff_2019_2022/salaire_moyen_pre_stage)
# MMO_no_Brest_2019_2022 <-  MMO_no_Brest_2019_2022 %>% filter(salaire_2019_moyen > 1000)
# write.csv(MMO_no_Brest_2019_2022, "Applied_labor/MMO_no_BREST_2019_2022.csv")
# write.csv(stagiaires_2019_2022, "Applied_labor/stagiaires_2019_2022.csv")

# 3 - bases de données pour mesurer la probabilité d'emploi ----

stagiaires_2019_2022 <- read.csv("Applied_labor/stagiaires_2019_2022.csv")

brest_MMO_SIRET_2019 <- read.csv("Applied_labor/")

prob_emploi_stagiaires_2019_2022 <- stagiaires_2019_2022

prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>%  mutate(DebutCTT.x = as.Date(DebutCTT.x), FinCTT.x = as.Date(FinCTT.x))%>% mutate(mois_debut.x = month(DebutCTT.x), mois_fin.x = month(FinCTT.x)) %>% mutate(annee_debut.x = year(DebutCTT.x), annee_fin.x = year(FinCTT.x))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin.x - mois_debut.x) %>% mutate(fin_mois_prec.x = lag(mois_fin.x, k=1))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(fin_mois_prec.x =case_when(is.na(fin_mois_prec.x) ~ 0,
                                                                      TRUE ~ fin_mois_prec.x))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_debut.x = case_when(annee_debut.x <2019 ~ 1,
                                                                                                          TRUE ~ mois_debut.x))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_fin.x = case_when(annee_fin.x > 2019 ~ 12, TRUE ~ mois_fin.x))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(PENALITE.x = case_when(fin_mois_prec.x == mois_fin.x ~ 1,
                                                                    TRUE ~ 0))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_fin.x =case_when(annee_debut.x <=2019 & is.na(annee_fin.x) ~ 12,
                                                                                                       TRUE ~ mois_fin.x))


 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles.x = mois_fin.x - mois_debut.x + 1 - PENALITE.x)
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles_2019 = sum(mois_travailles.x)) %>% ungroup()
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)




 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>%  mutate(DebutCTT.y = as.Date(DebutCTT.y), FinCTT.y = as.Date(FinCTT.y))%>% mutate(mois_debut.y = month(DebutCTT.y), mois_fin.y = month(FinCTT.y)) %>% mutate(annee_debut.y = year(DebutCTT.y), annee_fin.y = year(FinCTT.y))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin.y - mois_debut.y) %>% mutate(fin_mois_prec.y = lag(mois_fin.y, k=1))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(fin_mois_prec.y =case_when(is.na(fin_mois_prec.y) ~ 0,
                                                                                                            TRUE ~ fin_mois_prec.y))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_debut.y = case_when(annee_debut.y <2022 ~ 1,
                                                                                                          TRUE ~ mois_debut.y))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_fin.y = case_when(annee_fin.y > 2022 ~ 12, TRUE ~ mois_fin.y))

 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(PENALITE.y = case_when(fin_mois_prec.y == mois_fin.y ~ 1,
                                                                                                        TRUE ~ 0))
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% mutate(mois_fin.y =case_when(annee_debut.y <=2022 & is.na(annee_fin.y) ~ 12,
                                                                                                       TRUE ~ mois_fin.y))


 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles.y = mois_fin.y - mois_debut.y + 1 - PENALITE.y)
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles_2022 = sum(mois_travailles.y)) %>% ungroup()
 prob_emploi_stagiaires_2019_2022 <- prob_emploi_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)


write.csv(prob_emploi_stagiaires_2019_2022, "Applied_labor/prob_emploi_stagiaires_2019_2022.csv")
# 

#MMO_no_Brest_2019_2022 <- read.csv("Applied_labor/MMO_no_Brest_2019_2022.csv")

#prob_emploi_non_stagiaires_2019_2022 <- MMO_no_Brest_2019_2022
# Pour les non_stagiaires
prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>%  mutate(DebutCTT.x = as.Date(DebutCTT.x), FinCTT.x = as.Date(FinCTT.x))%>% mutate(mois_debut.x = month(DebutCTT.x), mois_fin.x = month(FinCTT.x)) %>% mutate(annee_debut.x = year(DebutCTT.x), annee_fin.x = year(FinCTT.x))
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin.x - mois_debut.x) %>% mutate(fin_mois_prec.x = lag(mois_fin.x, k=1))
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(fin_mois_prec.x =case_when(is.na(fin_mois_prec.x) ~ 0,
                                                                       TRUE ~ fin_mois_prec.x))
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_debut.x = case_when(annee_debut.x <2019 ~ 1,
                                                                                                           TRUE ~ mois_debut.x)) 
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_fin.x = case_when(annee_fin.x > 2019 ~ 12, TRUE ~ mois_fin.x))  
 
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(PENALITE.x = case_when(fin_mois_prec.x == mois_fin.x ~ 1,
                                                                     TRUE ~ 0))
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_fin.x =case_when(annee_debut.x <=2019 & is.na(annee_fin.x) ~ 12,
                                                                                                        TRUE ~ mois_fin.x))
    
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles.x = mois_fin.x - mois_debut.x + 1 - PENALITE.x) %>% mutate(mois_travailles_2019 = sum(mois_travailles.x)) %>% mutate(count = n())%>% ungroup() %>% filter(count == 1)
write.csv(prob_emploi_non_stagiaires_2019_2022, "prob_emploi_non_stagiaires_2019_2022.csv")
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>%  mutate(DebutCTT.y = as.Date(DebutCTT.y), FinCTT.y = as.Date(FinCTT.y))%>% mutate(mois_debut.y = month(DebutCTT.y), mois_fin.y = month(FinCTT.y)) %>% mutate(annee_debut.y = year(DebutCTT.y), annee_fin.y = year(FinCTT.y))
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin.y - mois_debut.y) %>% mutate(fin_mois_prec.y = lag(mois_fin.y, k=1))
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(fin_mois_prec.y =case_when(is.na(fin_mois_prec.y) ~ 0,
                                                                                                                     TRUE ~ fin_mois_prec.y))
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_debut.y = case_when(annee_debut.y <2022 ~ 1,
                                                                                                                   TRUE ~ mois_debut.y)) 
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_fin.y = case_when(annee_fin.y > 2022 ~ 12, TRUE ~ mois_fin.y))  
  
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(PENALITE.y = case_when(fin_mois_prec.y == mois_fin.y ~ 1,
                                                                                                                 TRUE ~ 0))
  prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% mutate(mois_fin.y =case_when(annee_debut.y <=2022 & is.na(annee_fin.y) ~ 12,
                                                                                                                TRUE ~ mois_fin.y))
  
  
prob_emploi_non_stagiaires_2019_2022 <- prob_emploi_non_stagiaires_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles.y = mois_fin.y - mois_debut.y + 1 - PENALITE.y)%>% mutate(mois_travailles_2022 = sum(mois_travailles.y))%>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)

write.csv(prob_emploi_non_stagiaires_2019_2022, "prob_emploi_non_stagiaires_2019_2022.csv")






# 4 - Descriptive statistics about trainees ----


brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% select(-("X.1"))
 
brest_MMO_siret_2019 <- read.csv("Applied_labor/brest_MMO_siret_2019.csv")
brest_MMO_siret_2018 <- read.csv("Applied_labor/brest_MMO_siret_2018.csv")
brest_MMO_siret_2017 <- read.csv("Applied_labor/brest_MMO_siret_2017.csv")
brest_MMO_siret_2019 <- brest_MMO_siret_2019 %>% select(-("X.1"))
stagiaires_2017_2019 <- rbind(brest_MMO_siret_2017, brest_MMO_siret_2018, brest_MMO_siret_2019)
 
stagiaires_2017_2019 <- stagiaires_2017_2019 %>%  group_by(id_force) %>% mutate(count=n()) %>% ungroup() %>% filter(count == 1)
 
write.csv(stagiaires_2017_2019, "stagiaires_2017_2019.csv")
stagiaires_2017_2019 <- read.csv("stagiaires_2017_2019.csv")
 
 stagiaires_2017_2019 <- stagiaires_2017_2019 %>% select("COMMANDITAIRE", "TYPE_REMUNERATION",  "DUREE_FORMATION_HEURES_REDRESSEE", 
                                                         "AGE_ENTREE_STAGE", "SEXE.x", "salaire_moyen_pre_stage", "AGE_ENTREPRISE", "REGION_HABITATION",
                                                          "PUBLIC_PIC",  "NIV_DIPLOME", "A21_ET")
 
 
 statistiques_commanditaire <- stagiaires_2017_2019 %>% group_by(COMMANDITAIRE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_commanditaire.csv")
 statistiques_type_remuneration <- stagiaires_2017_2019 %>% group_by(TYPE_REMUNERATION) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_remuneration.csv")
 
 statistiques_sexe <- stagiaires_2017_2019 %>% group_by(SEXE.x) %>% summarize(count=n()) %>% filter(count>30) %>% ungroup()%>% write.csv("Stats_echantillon_etude/statistiques_sexe.csv")  
 statistiques_region <- stagiaires_2017_2019 %>% group_by(REGION_HABITATION) %>% summarize(count=n()) %>% filter(count>=6) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_region.csv")  
   
   
 statistiques_diplome <- stagiaires_2017_2019 %>% group_by(NIV_DIPLOME) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_diplome.csv")   
   
 statistiques_industrie <- stagiaires_2017_2019 %>% group_by(A21_ET) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_industrie.csv")   
 
 statistiques_public_pic <- stagiaires_2017_2019 %>% group_by(PUBLIC_PIC) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_public_pic.csv") 
   
   
 stagiaires_2017_2019 <- stagiaires_2017_2019 %>% mutate(categorie_age = case_when(
   AGE_ENTREE_STAGE < 20 ~ "<20",
   AGE_ENTREE_STAGE>=20 & AGE_ENTREE_STAGE <25 ~ "20-24",
   AGE_ENTREE_STAGE>=25 & AGE_ENTREE_STAGE <30 ~ "25-29",
   AGE_ENTREE_STAGE>=30 & AGE_ENTREE_STAGE <35 ~ "30-34",
   AGE_ENTREE_STAGE>=35 & AGE_ENTREE_STAGE <40 ~ "35-39",
   AGE_ENTREE_STAGE>=40 & AGE_ENTREE_STAGE <45 ~ "40-44",
   AGE_ENTREE_STAGE>=45 & AGE_ENTREE_STAGE <50 ~ "45-49",
   AGE_ENTREE_STAGE>=50 & AGE_ENTREE_STAGE <55 ~ "50-54",
   AGE_ENTREE_STAGE>=55 & AGE_ENTREE_STAGE <60 ~ "55-59",
   AGE_ENTREE_STAGE>=60 & AGE_ENTREE_STAGE <65 ~ "60-64",
   AGE_ENTREE_STAGE <=65 ~ ">=65",
 ))
 
 statistiques_age <- stagiaires_2017_2019 %>% group_by(categorie_age) %>% summarize(count=n()) %>% ungroup() %>% filter(count>=6) %>%  write.csv("Stats_echantillon_etude/statistiques_age.csv") 
 
 statistiques_age_entreprise <- stagiaires_2017_2019 %>% group_by(AGE_ENTREPRISE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_age_entreprise.csv")
#   
#   
# stagiaires_2017_2019 <- stagiaires_2017_2019 %>% mutate(DUREE_FORMATION_DECILE=case_when(
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
#    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
#  ))
# 
# 
# 
#  statistiques_duree_formation <- stagiaires_2017_2019 %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_duree_formation.csv")
#  statistiques_domaine_formation <- stagiaires_2017_2019 %>% group_by(DOMAINE_FORMATION) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_echantillon_etude/statistiques_domaine_formation.csv")
  
  
  
 # brest_MMO_siret_2017 <- read.csv("Applied_labor/brest_MMO_siret_2017.csv") %>% filter(salaire_base_mois_complet == 1)
 # 
 #  
 # 
 # brest_MMO_siret_2018 <- read.csv("Applied_labor/brest_MMO_siret_2018.csv") %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()%>% filter(count==1) <- brest_MMO_siret_2017 %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()
 # brest_MMO_siret_2017 <- brest_MMO_siret_2017 %>% filter(count==1)
 #  
 #  
 #  
 #   brest_MMO_siret_2018 <- read.csv("Applied_labor/brest_MMO_siret_2018.csv") %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()%>% filter(count==1)
 #  
 #   brest_MMO_siret_2019 <- read.csv("Applied_labor/brest_MMO_siret_2019.csv") %>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()%>% filter(count==1)  %>% select(-("X.1"))
 #  
 #  
 #  full_sample_tbl <- rbind(brest_MMO_siret_2017, brest_MMO_siret_2018, brest_MMO_siret_2019)%>% group_by(id_force) %>% mutate(count=n()) %>% ungroup()%>% filter(count==1)
 #  
 #  
 #  statistiques_commanditaire <- full_sample_tbl %>% group_by(COMMANDITAIRE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_commanditaire.csv")
 #  statistiques_type_remuneration <- full_sample_tbl %>% group_by(TYPE_REMUNERATION) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_remuneration.csv")
 #  
 #  statistiques_sexe <- full_sample_tbl %>% group_by(SEXE.x) %>% summarize(count=n()) %>% rename("SEXE"="SEXE.x") %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_sexe.csv")
 #  statistiques_region <- full_sample_tbl %>% group_by(REGION_HABITATION) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_region.csv")  
 #  
 #  
 #  statistiques_diplome <- full_sample_tbl %>% group_by(NIV_DIPLOME) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_diplome.csv")   
 #  
 #  statistiques_industrie <- full_sample_tbl %>% group_by(A21_ET) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_industrie.csv")   
 #  
 #  statistiques_public_pic <- full_sample_tbl %>% group_by(PUBLIC_PIC) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_public_pic.csv") 
 #  
 #  
 #  full_sample_tbl <- full_sample_tbl %>% mutate(categorie_age = case_when(
 #    AGE_ENTREE_STAGE < 20 ~ "<20",
 #    AGE_ENTREE_STAGE>=20 & AGE_ENTREE_STAGE <25 ~ "20-24",
 #    AGE_ENTREE_STAGE>=25 & AGE_ENTREE_STAGE <30 ~ "25-29",
 #    AGE_ENTREE_STAGE>=30 & AGE_ENTREE_STAGE <35 ~ "30-34",
 #    AGE_ENTREE_STAGE>=35 & AGE_ENTREE_STAGE <40 ~ "35-39",
 #    AGE_ENTREE_STAGE>=40 & AGE_ENTREE_STAGE <45 ~ "40-44",
 #    AGE_ENTREE_STAGE>=45 & AGE_ENTREE_STAGE <50 ~ "45-49",
 #    AGE_ENTREE_STAGE>=50 & AGE_ENTREE_STAGE <55 ~ "50-54",
 #    AGE_ENTREE_STAGE>=55 & AGE_ENTREE_STAGE <60 ~ "55-59",
 #    AGE_ENTREE_STAGE>=60 & AGE_ENTREE_STAGE <65 ~ "60-64",
 #    AGE_ENTREE_STAGE <=65 ~ ">=65",
 #  ))
 #  
 #  statistiques_age <- full_sample_tbl %>% group_by(categorie_age) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_age.csv") 
 #  
 #  statistiques_age_entreprise <- full_sample_tbl %>% group_by(AGE_ENTREPRISE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_age_entreprise.csv")
 #  
 #  
 #  statistiques_domaine_formation <- full_sample_tbl %>% group_by(DOMAINE_FORMATION) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_domaine_formation.csv")
 #   
 #  
 #  
 #  full_sample_tbl <- full_sample_tbl %>% mutate(DUREE_FORMATION_DECILE=case_when(
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
 #    DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
 #  ))
 #  
 #  
 #  
 #  statistiques_duree_formation <- full_sample_tbl %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("Stats_full_sample/statistiques_duree_formation.csv")
  
  
  
  
  
  
  
  
  
  
 siret_2019_tbl <- read.csv("Applied_labor/siret_2019.csv")
 MMO_BREST_2019 <- read.csv("Applied_labor/MM0_BREST_2019.csv")
 stagiaires_2019 <- MMO_BREST_2019 %>% left_join(siret_2019_tbl, by = c("siret_AF" = "SIRET"))

 stagiaires_2019 <- stagiaires_2019 %>%  mutate(DebutCTT = as.Date(DebutCTT), FinCTT = as.Date(FinCTT)) %>% mutate(mois_debut = month(DebutCTT), mois_fin = month(FinCTT)) %>% mutate(annee_debut = year(DebutCTT), annee_fin = year(FinCTT))

 stagiaires_2019 <- stagiaires_2019 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin - mois_debut) %>% mutate(fin_mois_prec = lag(mois_fin, k=1))
 stagiaires_2019 <- stagiaires_2019 %>% mutate(fin_mois_prec =case_when(is.na(fin_mois_prec) ~ 0,
                                                                        TRUE ~ fin_mois_prec))

 stagiaires_2019 <- stagiaires_2019 %>% mutate(mois_debut = case_when(annee_debut <2019 ~ 1, TRUE ~ mois_debut))
 stagiaires_2019 <- stagiaires_2019 %>% mutate(mois_fin = case_when(annee_fin > 2019 ~ 12, TRUE ~ mois_fin))

 stagiaires_2019 <- stagiaires_2019 %>% mutate(PENALITE = case_when(fin_mois_prec == mois_fin ~ 1,
                                                                    TRUE ~ 0))

 stagiaires_2019 <- stagiaires_2019 %>% group_by(id_force) %>% mutate(mois_travailles = mois_fin - mois_debut + 1 - PENALITE)
 stagiaires_2019 <- stagiaires_2019 %>% group_by(id_force) %>% mutate(mois_travailles_2019 = sum(mois_travailles)) %>% ungroup()
 stagiaires_2019 <- stagiaires_2019 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)



MMO_2022 <- read.csv("Applied_labor/MMO_2022.csv")


stagiaires_2019_in_2022 <- stagiaires_2019 %>% left_join(MMO_2022, by=c("id_force"="id_force"))
#stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>%  mutate(DebutCTT = as.Date(DebutCTT), FinCTT = as.Date(FinCTT)) %>% mutate(mois_debut = month(DebutCTT), mois_fin = month(FinCTT))  %>% mutate(annee_debut = year(DebutCTT), annee_fin = year(FinCTT))
# 
# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin - mois_debut) %>% mutate(fin_mois_prec = lag(mois_fin, k=1))
# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% mutate(fin_mois_prec =case_when(is.na(fin_mois_prec) ~ 0,
#                                                                        TRUE ~ fin_mois_prec))
# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% mutate(mois_debut = case_when(annee_debut <2019 ~ 1
#                                                                                       TRUE ~ mois_debut))
# 
# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% mutate(PENALITE = case_when(fin_mois_prec == mois_fin ~ 1,
#                                                                    TRUE ~ 0))

# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% group_by(id_force) %>% mutate(mois_travailles = mois_fin - mois_debut + 1 - PENALITE)
# stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% group_by(id_force) %>% mutate(mois_travailles_2022 = sum(mois_travailles)) %>% ungroup()
 stagiaires_2019_in_2022 <- stagiaires_2019_in_2022 %>% group_by(id_force) %>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)



stagiaires_2019_pas_2022 <- anti_join(stagiaires_2019, stagiaires_2019_in_2022, by="id_force")
statistiques_commanditaire <- stagiaires_2019_pas_2022 %>% group_by(COMMANDITAIRE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("2019_non_2022_commanditaire.csv")
statistiques_commanditaire_2 <- stagiaires_2019_in_2022 %>% group_by(COMMANDITAIRE) %>% summarize(count=n()) %>% ungroup() %>% write.csv("2019_in_2022_commanditaire.csv")


stagiaires_2019_2022_tbl <- read.csv("Applied_labor/stagiaires_2019_2022.csv")
prob_emploi_stagiaires_2019_2022 <- read.csv("Applied_labor/prob_emploi_stagiaires_2019_2022.csv")






MMO_no_BREST_2019_2022 <- read.csv("Applied_labor/MMO_no_BREST_2019_2022.csv")
MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>%  mutate(DebutCTT.y = as.Date(DebutCTT.y), FinCTT.y = as.Date(FinCTT.y))%>% mutate(mois_debut.y = month(DebutCTT.y), mois_fin.y = month(FinCTT.y)) %>% mutate(annee_debut.y = year(DebutCTT.y), annee_fin.y = year(FinCTT.y))

MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>%  group_by(id_force) %>% mutate(diff_mois = mois_fin.y - mois_debut.y) %>% mutate(fin_mois_prec.y = lag(mois_fin.y, k=1))
MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(fin_mois_prec.y =case_when(is.na(fin_mois_prec.y) ~ 0,
                                                                                                                   TRUE ~ fin_mois_prec.y))

MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(mois_debut.y = case_when(annee_debut.y <2022 ~ 1,
                                                                                                                 TRUE ~ mois_debut.y)) 
MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(mois_fin.y = case_when(annee_fin.y > 2022 ~ 12, TRUE ~ mois_fin.y))  

MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(PENALITE.y = case_when(fin_mois_prec.y == mois_fin.y ~ 1,
                                                                                                               TRUE ~ 0))
MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(mois_fin.y =case_when(annee_debut.y <=2022 & is.na(annee_fin.y) ~ 12,
                                                                                                              TRUE ~ mois_fin.y))


MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% group_by(id_force) %>% mutate(mois_travailles.y = mois_fin.y - mois_debut.y + 1 - PENALITE.y)%>% mutate(mois_travailles_2022 = sum(mois_travailles.y))%>% mutate(count = n()) %>% ungroup() %>% filter(count == 1)
write.csv(MMO_no_BREST_2019_2022, "Applied_labor/MMO_no_BREST_2019_2022.csv")
