library(magrittr)
library(dplyr)
library(tidyr)
library(readr)

df_wide <- read_csv("http://bit.ly/country-year-wide")
df_wide %>% 
  gather(key = "year", value = "cases", `1999`, `2000`)

df_wide %>% 
  gather(key = "year", value = "cases", -country)

df_long <- read_csv("http://bit.ly/cases-long")
df_long %>% 
  spread(key = type, value = count)

df_to_sep <- read_csv("http://bit.ly/sep-raw")
df_to_sep %>% 
  separate(rate, into = c("cases", "population"), sep="/")


df_to_sep %>% 
  separate(rate, into = c("cases", "population"), sep="/") %>% 
  gather(key = "variable", value = "value", cases, population) %>% 
  select(-variable)


df_to_sep %>% 
  separate_rows(rate, sep = "/")



pew <- read_csv("http://bit.ly/pew-raw")
pew %>% 
  gather(key = "income", value = "frequency", -religion)

pew %>% 
  gather(key = "income", value = "frequency", 
         `<$10k`:`Don't know/refused`)




tb <- read_csv("http://bit.ly/tb-raw")
tb %>% 
  gather(key = "sex_and_age", value = "cases", -c(iso2, year),
         na.rm = TRUE) %>% 
  separate(sex_and_age, into = c("sex", "age"), sep = 1)


weather <- read_csv("http://bit.ly/weather-raw")
weather %>% View

weather %>% 
  gather(key = "day", value = "value", d1:d31, na.rm = TRUE) %>% 
  mutate(day = readr::parse_number(day)) %>% 
  select(id, year, month, day, element, value) %>% 
  arrange(id, year, month, day, element) %>% 
  spread(key = element, value = value)
