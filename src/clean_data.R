## start from raw, clean things up, save to model data
library(magrittr)
library(dplyr)

anes <- read.csv("~/lab-1-team-no-l-s/data/raw/anes_pilot_2024_raw.csv")

# Adding column "party_group" to categorize voters broadly
data_transformed <- anes %>%
  filter(votereg=="Yes" & (voteturn_saveface=="Definitely voted" | voteturn_lookup=="I voted")) %>%
  mutate(
    party_group = case_when(
      pid7 %in% c("Lean Democrat", "Not very strong Democrat", "Strong Democrat") ~ "Democrat",
      pid7 %in% c("Lean Republican", "Not very strong Republican", "Strong Republican") ~ "Republican",
      pid7 == "Independent" ~ "Independent",
      pid7 == "Not sure" ~ "Not sure",
      TRUE ~ NA_character_
    )
  )

write.csv(data_transformed, "~/lab-1-team-no-l-s/data/modelling/anes_pilot_2024_transformed.csv", row.names = FALSE)

# Democrat Voters - pid7: Lean Democrat, Not very strong Democrat, Strong Democrat

democrat_voters <- data_transformed %>%
                   filter(party_group == "Democrat")

write.csv(democrat_voters, "~/lab-1-team-no-l-s/data/modelling/democrat_voters.csv", row.names = FALSE)

# Republican Voters - pid7: Lean Republican, Not very strong Republican, Strong Republican

republican_voters <- data_transformed %>%
                     filter(party_group == "Republican")

write.csv(republican_voters, "~/lab-1-team-no-l-s/data/modelling/republican_voters.csv", row.names = FALSE)

# Republican + Democrat Voters combined

dem_rep_cmbnd <- data_transformed %>%
  filter(party_group %in% c("Democrat", "Republican"))

write.csv(dem_rep_cmbnd, "~/lab-1-team-no-l-s/data/modelling/democrats_republican_cmbnd.csv", row.names = FALSE)
  