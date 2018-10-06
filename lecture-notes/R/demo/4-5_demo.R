library(magrittr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(readr)
library(stringr)

# Load data ---------------------------------------------------------------

df <- read_csv("http://bit.ly/labor-productivity")
df <- df %>% 
  gather(key = "firm", value = "growth", 
         growth_frontier, growth_others) %>% 
  mutate(firm = firm %>% str_extract("(?<=_)(.+)$")) %>% 
  mutate(year = year %>% as.character())


# ggplot2 -----------------------------------------------------------------

df %>% 
  ggplot(aes(x = year, y = growth, color = firm)) +
  geom_line(aes(group = firm)) +
  scale_y_continuous(
    breaks = seq(0, 0.4, 0.1),
    limits = c(0, 0.4),
    labels = scales::percent
  ) +
  scale_color_few(
    labels = c("前沿企業", "其他企業")
  ) +
  ggtitle(
    "最具生產力企業與其他企業的落差漸增",
    subtitle = "勞工生產力的變化百分率 (index, 2001=0)"
  ) +
  labs(caption = "SOURCE:《未來生產力》OECD, 2015") +
  guides(color = guide_legend(title = NULL)) +
  theme_tufte() +
  theme(
    text = element_text(family = "STHeiti"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    plot.caption = element_text(hjust = 0),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )
 

