library(ggplot2)
library(dplyr)
library(tidyr)

# displ, hwy
mpg %>% 
  ggplot() +
  geom_point(aes(x = displ, y = hwy, shape = class))

mpg %>% 
  ggplot() +
  geom_point(aes(x = displ, y = hwy, shape = class)) +
  geom_line(aes(x = displ, y = hwy))
  
mpg %>% 
  ggplot(aes(x = class)) +
  geom_bar()

mpg %>% 
  group_by(class) %>% 
  tally %>% 
  ggplot(aes(x = class, y = n)) +
  geom_bar(stat = "identity")


mpg %>% 
  group_by(class) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  ggplot(aes(x = class, y = mean_hwy)) + 
  geom_bar(stat = "identity")

mpg %>% 
  ggplot() +
  geom_point(aes(x = displ, y = hwy)) +
  geom_smooth(aes(x = displ, y = hwy))



mpg %>% 
  ggplot(aes(x = class, fill = class)) +
  geom_bar() +
  facet_wrap(~ manufacturer, ncol = 3) +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


mpg %>% 
  group_by(class, manufacturer) %>% 
  tally() %>%
  ggplot(aes(x = class, y = manufacturer, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n)) +
  scale_fill_distiller(direction = 1) +
  ggtitle("Number of car class by manufacturers")
