library(tidyverse)
library(janitor)

cbsas <- 
  read_xlsx("CBSAs/Data/CBSAs 2023-07.xlsx", skip = 2) %>%
  clean_names() %>%
  head(-3) %>%
  rename(
    cbsa_name = cbsa_title,
    metro_or_micro_sa = metropolitan_micropolitan_statistical_area) %>%
  mutate(
    ct_code = as.numeric(str_c(fips_state_code, fips_county_code)), 
    ct_name = str_c(county_county_equivalent, ", ", state_name),
    msa = 
      if_else(metro_or_micro_sa == "Metropolitan Statistical Area", 1, 0)) %>%
  select(cbsa_code, cbsa_name, ct_code, ct_name, msa) %>%
  arrange(cbsa_code, ct_code)
write_csv(cbsas, "CBSAs/Data/CBSAs 2023-07.csv")
