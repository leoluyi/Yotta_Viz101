library(magrittr)
library(ggplot2)
library(dplyr)
library(reshape2)

df <- data_frame(
  var = c(rep("f1", 6), rep("f2", 6)),
  x = c(0, 2, 4, 6, 8, 10, 0, 2, 4, 6, 8, 10),
  y = c(0, 0.23, 0.95, 2, 5.47, 9.75, 
        1, 1.12, 1.68, 2.67, 6.04, 10.0)
)

ggplot(df, aes(x, y, color = var)) +
  geom_line()

df2 <- df %>% 
  dcast(x ~ var, value.var = "y") %>% 
  mutate(diff = f2 - f1)

ggplot(df2, aes(x, diff)) +
  geom_line() +
  scale_x_continuous(breaks = seq(0, 10, 2)) +
  ylab("diff (f2 - f1)")

