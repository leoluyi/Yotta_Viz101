library(magrittr)
library(dplyr)
library(readr)
library(tidyr)
library(stringr)
library(ggplot2)
library(ggthemes)
library(directlabels)

# Load data ---------------------------------------------------------------

df <- read_csv("./dataset/labor_productivity.csv", 
               col_types = cols(.default = "c"))
df <- df %>% mutate(
  growth_frontier = growth_frontier %>% as.numeric,
  growth_others = growth_others %>% as.numeric
)


# tidying -----------------------------------------------------------------

df <- df %>% 
  gather(firm, growth, -year) %>% 
  mutate(firm = firm %>% str_extract("(?<=_)(.+)$"))
  

# Plot --------------------------------------------------------------------

p <- df %>% 
  ggplot(aes(year, growth, color = firm)) +
  geom_line(aes(group = firm), size = 2) +
  scale_y_continuous(
    breaks = seq(0, 0.40, 0.10),
    limits = c(0, 0.4),
    labels = scales::percent) +
  scale_color_few(labels = c("「前沿企業」", "其他企業")) +
  ggtitle("最具生產力企業與其他企業的落差漸增",
          "勞工生產力的變化百分率 (index, 2001=0)") +
  labs(caption = "SOURCE:《未來生產力》OECD, 2015") +
  guides(color = guide_legend(title=NULL)) +
  theme_tufte(base_size = 14, base_family = "STHeiti") +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
        plot.caption = element_text(hjust = 0),
        legend.justification=c(0, 1), legend.position=c(0, 1))
p
p %>% direct.label("top.bumpup")
