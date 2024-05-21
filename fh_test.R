
library(tidyverse)
library(tidyquant)
library(lubridate)
library(haven)
library(readr)


#("COMMANDITAIRE", "TYPE_REMUNERATION",  "DUREE_FORMATION_HEURES_REDRESSEE", 
  #                                                         "AGE_ENTREE_STAGE", "SEXE.x", "salaire_moyen_pre_stage", "AGE_ENTREPRISE", "REGION_HABITATION",
  #                                                          "PUBLIC_PIC",  "NIV_DIPLOME", "A21_ET")



fh_tbl <- read.csv("Applied_labor/fh_de_tempo.csv")
stagiaires_2019_tbl <- read.csv("Applied_labor/stagiaires_2019_2022.csv")
other_2019_tbl <- read.csv("Applied_labor/prob_emploi_stagiaires_2019_2022.csv") %>% select(id_force, mois_travailles_2019, mois_travailles_2022)
stagiaires_2019_tbl <- left_join(stagiaires_2019_tbl, other_2019_tbl, by=c("id_force" = "id_force"))
MMO_no_BREST_2019_2022 <- read.csv("Applied_labor/MMO_no_BREST_2019_2022.csv")

MMO_2019 <- read.csv("Applied_labor/MMO_2019.csv")
SIRET_2019 <- read.csv("Applied_labor/siret_2019.csv")

SIRET_2019 <- SIRET_2019 %>% select(SIRET, A21_ET, REGION_ET, AGE_ENTREPRISE)

MMO_2019 <- left_join(MMO_2019, SIRET_2019, by=c("siret_AF" = "SIRET"))

MMO_2019_complment <- read.csv("Applied_labor/MMO_2019_complement_age.csv")

MMO_no_BREST_2019_2022 <- left_join(MMO_no_BREST_2019_2022, SIRET_2019, by=c("siret_AF.x" = "SIRET"))
MMO_no_BREST_2019_2022 <- left_join(MMO_no_BREST_2019_2022, MMO_2019_complment, by=c("id_force" = "?..id_force"))

MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% mutate(age_2019 = 2019 - annee_naissance)
MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>%  mutate(categorie_age = case_when(
  age_2019 < 20 ~ "<20",
  age_2019>=20 & age_2019 <25 ~ "20-24",
  age_2019>=25 & age_2019 <30 ~ "25-29",
  age_2019>=30 & age_2019 <35 ~ "30-34",
  age_2019>=35 & age_2019 <40 ~ "35-39",
  age_2019>=40 & age_2019 <45 ~ "40-44",
  age_2019>=45 & age_2019 <50 ~ "45-49",
  age_2019>=50 & age_2019 <55 ~ "50-54",
  age_2019>=55 & age_2019 <60 ~ "55-59",
  age_2019>=60 & age_2019 <65 ~ "60-64",
  age_2019 <=65 ~ ">=65"
))

MMO_no_BREST_2019_2022 <- MMO_no_BREST_2019_2022 %>% group_by(id_force) %>% mutate(count=n()) %>% filter(count ==1) %>% ungroup()

write.csv(MMO_no_BREST_2019_2022, "Applied_labor/MMO_no_BREST_2019_2022.csv")

stagiaires_2019_tbl <- stagiaires_2019_tbl %>% mutate(categorie_age = case_when(
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

stagiaires_2019_tbl <- stagiaires_2019_tbl %>% mutate(DUREE_FORMATION_DECILE=case_when(
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
   DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
 ))

# Resultats par catégorie de population
#complte_tbl <- left_join(stagiaires_2019_tbl, fh_tbl, by=c("id_force"="?..id_force"))

#stagiaires 2019 en 2022 - salaire moyen
stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>%  filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(A21_ET) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n()) %>% ungroup() %>%  write.csv("evol_stagiaires_2019_2022/salaire_A21_ET.csv")
 stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>%filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(SEXE.x) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_sexe.csv")

stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(NIV_DIPLOME) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_diplome.csv")
stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(categorie_age) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% filter(count>=6) %>%  ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_age.csv")
stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_duree_formation.csv")


stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(REGION_HABITATION) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% filter(count>=6)%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_region.csv")

stagiaires_2019_evol_type_remuneration <-stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(TYPE_REMUNERATION) %>% summarize(mean_augmentation_2022 = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n())%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_type_remuneration.csv")

stagiaires_2019_evol_commanditaire <-stagiaires_2019_tbl %>% filter(salaire_moyen_2019>quantile(salaire_moyen_2019, 0.05) & salaire_moyen_2019 < quantile(salaire_moyen_2019, 0.95)) %>% filter(mean_salary_2022 < quantile(mean_salary_2022,0.95) & mean_salary_2022 > quantile(mean_salary_2022, 0.05)) %>% group_by(COMMANDITAIRE) %>% summarize(mean_salary_2022 = mean(mean_salary_2022), count =n())%>% ungroup()%>% write.csv("evol_stagiaires_2019_2022/salaires_commanditaire.csv")


stagiaires_2019_mois_2022 <- stagiaires_2019_tbl %>% group_by(mois_travailles_2022) %>% summarize(count=n())%>% ungroup() %>% mutate(proportion = count/sum(count)) %>% write.csv("evol_stagiaires_2019_2022/mois_travailles_2022.csv")
stagiaires_2019_mois_2019 <-stagiaires_2019_tbl %>% group_by(mois_travailles_2019) %>% summarize(count=n())%>% ungroup() %>% mutate(proportion = count/sum(count)) %>% write.csv("evol_stagiaires_2019_2022/mois_travailles_2019.csv")
#MMO_no_BREST_2019_2022 - non stagiaires présents en 2019 et 2022

MMO_no_BREST_2019_2022 %>% filter(salaire_2019_moyen>quantile(salaire_2019_moyen, 0.05) & salaire_2019_moyen < quantile(salaire_2019_moyen, 0.95)) %>%   filter(salaire_2022_moyen < quantile(salaire_2022_moyen,0.95) & salaire_2022_moyen > quantile(salaire_2022_moyen, 0.05)) %>% group_by(categorie_age) %>% summarize(mean_salary_2022 = mean(salaire_2022_moyen), mean_augmentation_202 = mean(augmentation), count=n()) %>% filter(count>=6) %>%ungroup() %>% write.csv("evol_non_stagiaires_2019_2022/salaires_age.csv") 

MMO_no_BREST_2019_2022 %>% filter(salaire_2019_moyen>quantile(salaire_2019_moyen, 0.05) & salaire_2019_moyen < quantile(salaire_2019_moyen, 0.95)) %>%   filter(salaire_2022_moyen < quantile(salaire_2022_moyen,0.95) & salaire_2022_moyen > quantile(salaire_2022_moyen, 0.05)) %>% group_by(A21_ET) %>% summarize(mean_salary_2022 = mean(salaire_2022_moyen), mean_augmentation_202 = mean(augmentation), count=n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("evol_non_stagiaires_2019_2022/salaires_A21_ET.csv")

MMO_no_BREST_2019_2022 %>% filter(salaire_2019_moyen>quantile(salaire_2019_moyen, 0.05) & salaire_2019_moyen < quantile(salaire_2019_moyen, 0.95)) %>%   filter(salaire_2022_moyen < quantile(salaire_2022_moyen,0.95) & salaire_2022_moyen > quantile(salaire_2022_moyen, 0.05)) %>% group_by(REGION_ET) %>% summarize(mean_salary_2022 = mean(salaire_2022_moyen), mean_augmentation_202 = mean(augmentation), count=n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("evol_non_stagiaires_2019_2022/REGION_ET.csv")

MMO_no_BREST_2019_2022 %>% filter(salaire_2019_moyen>quantile(salaire_2019_moyen, 0.05) & salaire_2019_moyen < quantile(salaire_2019_moyen, 0.95)) %>%   filter(salaire_2022_moyen < quantile(salaire_2022_moyen,0.95) & salaire_2022_moyen > quantile(salaire_2022_moyen, 0.05)) %>% group_by(PcsEse.x) %>% summarize(mean_salary_2022 = mean(salaire_2022_moyen), mean_augmentation_202 = mean(augmentation), count=n())%>% filter(count>=6) %>%  ungroup()%>% write.csv("evol_non_stagiaires_2019_2022/salaires_pcs_ese.csv")


MMO_no_BREST_2019_2022 %>% group_by(mois_travailles_2022) %>% summarize(count=n()) %>% ungroup() %>% mutate(proportion = count/sum(count))%>% write.csv("evol_non_stagiaires_2019_2022/mois_travailles_2022.csv") 
MMO_no_BREST_2019_2022 %>% group_by(mois_travailles_2019) %>% summarize(count=n()) %>% ungroup() %>% mutate(proportion = count/sum(count))%>% write.csv("evol_non_stagiaires_2019_2022/mois_travailles_2019.csv")

#####

prob_emploi_non_stagiaries <- read.csv("Applied_labor/prob_emploi_non_stagiaires_2019_2022.csv")


# Statistiques sur les stagiaires 2019 non présents en 2022
stagiaires_2019_ensemble <- read.csv("stagiaires_2017_2019.csv")
stagiaires_2019_ensemble <- stagiaires_2019_ensemble %>% filter(ANNEE_ENTREE == 2019)
stagiaires_2019_non_2022 <- anti_join(stagiaires_2019_ensemble, stagiaires_2019_tbl, by=c("id_force" = "id_force"))

stagiaires_2019_non_2022 <- stagiaires_2019_non_2022 %>% mutate(categorie_age = case_when(
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

stagiaires_2019_non_2022 <- stagiaires_2019_non_2022 %>% mutate(DUREE_FORMATION_DECILE=case_when(
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
))

stagiaires_2019_non_2022 %>% group_by(A21_ET) %>% summarize(count =n()) %>%filter(count>=6)  %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/salaire_A21_ET.csv")

stagiaires_2019_non_2022 %>% group_by(SEXE.x) %>% summarize(count =n())%>%filter(count>=6)  %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/salaires_sexe.csv")


stagiaires_2019_non_2022 %>% group_by(NIV_DIPLOME) %>% summarize(count =n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/niv_diplome.csv")
stagiaires_2019_non_2022 %>% group_by(categorie_age) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/categorie_age.csv")
stagiaires_2019_non_2022 %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/decile_heures_formation.csv")
stagiaires_2019_non_2022 %>% group_by(REGION_HABITATION) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/region_habitation.csv")
stagiaires_2019_non_2022 %>% group_by(TYPE_REMUNERATION) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/type_remuneration.csv")
stagiaires_2019_non_2022 %>% group_by(COMMANDITAIRE) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("evol_stagiaires_2019_non_2022/commanditaire.csv")

# Lien avec la table fh

fh_tbl <- fh_tbl %>% select(?..id_force, DATANN, DATINS)

fh_tbl <- fh_tbl %>% mutate(DATANN = as.Date(DATANN))
fh_tbl <- fh_tbl %>% filter(year(DATANN) >=2019)
fh_tbl <- fh_tbl %>% mutate(DATINS = as.Date(DATINS))
fh_tbl <- fh_tbl %>% filter(year(DATINS) <=2019)

write.csv(fh_tbl, "Applied_labor/sub_fh_tbl.csv")

stagiaires_2019 <- read.csv("Applied_labor/stagiaires_2019_2022.csv")
de_tempo_2019 <- left_join(stagiaires_2019, fh_tbl, by=c("id_force" = "?..id_force"))
de_tempo_2019 <- de_tempo_2019 %>% group_by(id_force) %>% mutate(count=n()) %>% filter(count == 1) %>% ungroup()

# Stats sur les stagiaires 2019 pésents dans la base fh

de_tempo_2019 <- de_tempo_2019 %>% mutate(categorie_age = case_when(
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

de_tempo_2019 <- de_tempo_2019 %>% mutate(DUREE_FORMATION_DECILE=case_when(
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
))


de_tempo_2019 %>% group_by(A21_ET) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n()) %>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022//salaire_A21_ET.csv")
de_tempo_2019 %>% group_by(SEXE.x) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n())%>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/salaires_sexe.csv")
de_tempo_2019 %>% group_by(NIV_DIPLOME) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/niv_diplome.csv")
de_tempo_2019 %>% group_by(categorie_age) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/categorie_age.csv")
de_tempo_2019 %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/decile_heures_formation.csv")
de_tempo_2019 %>% group_by(REGION_HABITATION) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/region_habitation.csv")
de_tempo_2019 %>% group_by(TYPE_REMUNERATION) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/type_remuneration.csv")
de_tempo_2019 %>% group_by(COMMANDITAIRE) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_in_2022/commanditaire.csv")


# Ceux présents en 2019 et 2022 mais pas fh
stagiaires_2019_in_2022_no_de_tempo <- anti_join(stagiaires_2019, de_tempo_2019, by=c("id_force" =  "id_force"))


stagiaires_2019_in_2022_no_de_tempo <- stagiaires_2019_in_2022_no_de_tempo %>% mutate(categorie_age = case_when(
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

stagiaires_2019_in_2022_no_de_tempo <- stagiaires_2019_in_2022_no_de_tempo %>% mutate(DUREE_FORMATION_DECILE=case_when(
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
))


stagiaires_2019_in_2022_no_de_tempo %>% group_by(A21_ET) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022), count =n()) %>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo//salaire_A21_ET.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(SEXE.x) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n())%>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/salaires_sexe.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(NIV_DIPLOME) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/niv_diplome.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(categorie_age) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/categorie_age.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/decile_heures_formation.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(REGION_HABITATION) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/region_habitation.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(TYPE_REMUNERATION) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/type_remuneration.csv")
stagiaires_2019_in_2022_no_de_tempo %>% group_by(COMMANDITAIRE) %>% summarize(augmentation = mean(augmentation), mean_salary_2022 = mean(mean_salary_2022),count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_stagiaires_2019_2022_pas_de_tempo/commanditaire.csv")


stagiaires_2019_ensemble <- read.csv("stagiaires_2017_2019.csv")
stagiaires_2019_ensemble <- stagiaires_2019_ensemble %>% filter(ANNEE_ENTREE == 2019)
stagiaires_2019_non_2022 <- anti_join(stagiaires_2019_ensemble, stagiaires_2019_tbl, by=c("id_force" = "id_force"))


#Stagiaires en 2019, pas dans MMO 2022, mais fh en 2019
de_tempo_2019_stagiaires_pas_2022 <- left_join(stagiaires_2019_non_2022, fh_tbl, by=c("id_force" = "?..id_force"))
de_tempo_2019_stagiaires_pas_2022 <- de_tempo_2019_stagiaires_pas_2022 %>% group_by(id_force) %>% mutate(count=n()) %>% filter(count == 1) %>% ungroup()

de_tempo_2019_stagiaires_pas_2022 <- de_tempo_2019_stagiaires_pas_2022 %>% mutate(categorie_age = case_when(
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

de_tempo_2019_stagiaires_pas_2022 <- de_tempo_2019_stagiaires_pas_2022 %>% mutate(DUREE_FORMATION_DECILE=case_when(
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.1),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.2),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.3),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.4),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.5),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.6),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.7),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.8),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.9),
  DUREE_FORMATION_HEURES_REDRESSEE<quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99) ~ quantile(DUREE_FORMATION_HEURES_REDRESSEE, 0.99),
))


de_tempo_2019_stagiaires_pas_2022 %>% group_by(A21_ET) %>% summarize(count =n()) %>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022//salaire_A21_ET.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(SEXE.x) %>% summarize(count =n())%>%filter(count>=6)  %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/salaires_sexe.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(NIV_DIPLOME) %>% summarize(count =n()) %>% filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/niv_diplome.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(categorie_age) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/categorie_age.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(DUREE_FORMATION_DECILE) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/decile_heures_formation.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(REGION_HABITATION) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/region_habitation.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(TYPE_REMUNERATION) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/type_remuneration.csv")
de_tempo_2019_stagiaires_pas_2022 %>% group_by(COMMANDITAIRE) %>% summarize(count =n()) %>%filter(count>=6) %>% ungroup()%>% write.csv("stats_de_tempo_2019_not_in_2022/commanditaire.csv")