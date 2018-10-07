library(magrittr)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)

## 7-11

store <- read_csv("http://bit.ly/711-stores")
store %>% View


## 不同縣市的店家

store %>% 
  ggplot(aes(city_name)) +
  geom_bar() +
  coord_flip() +
  theme(text = element_text(family = "Noto Sans CJK TC"))

## 縣市 vs (isATM, isHotDog)

store %>% 
  ggplot(aes(city_name, fill = isATM)) +
  geom_bar() +
  coord_flip() +
  theme(text = element_text(family = "Noto Sans CJK TC"))

store %>% 
  ggplot(aes(city_name, fill = isHotDog)) +
  geom_bar() +
  coord_flip() +
  theme(text = element_text(family = "Noto Sans CJK TC"))

## unpivot (gather)

d <- store %>% 
  select(city_name, starts_with("is")) %>% 
  gather(key = "is_cols", value = "yn", -city_name) %>% 
  mutate(yn = yn %>% recode(Y = 1, N = 0)) %>% 
  group_by(city_name, is_cols) %>% 
  summarise(prop = mean(yn))

d %>% 
  ggplot(aes(x = city_name, y = is_cols, fill = prop)) +
  geom_tile() +
  scale_fill_distiller(direction = 1) +
  scale_x_discrete(NULL, position = "top") +
  theme(
    text = element_text(family = "Noto Sans CJK TC"),
    axis.text.x = element_text(angle = 90, hjust = 1)
  ) +
  ggtitle("各縣市店家設備比例")

## Movie

movie <- read_csv("http://bit.ly/movie-main") %>% 
  mutate(movie_id = movie_id %>% as.character)

genre <- read_csv("http://bit.ly/movie-genre") %>% 
  mutate(movie_id = movie_id %>% as.character,
         genre_id = genre_id %>% as.character) %>% 
  rename(genre_name = name)

## histogram

movie %>% 
  filter(duration > 1) %>% 
  ggplot(aes(duration)) +
  geom_histogram(binwidth = 10, color = "white") +
  scale_x_continuous(breaks = seq(0, 220, 30))

movie %>% 
  filter(duration > 1) %>% 
  ggplot(aes(imdb_score)) +
  geom_histogram(binwidth = 1, color = "white") +
  scale_x_continuous(breaks = seq(0, 10, 1))




genre %>% 
  group_by(genre_name) %>% 
  tally(sort = TRUE) %>% 
  ggplot(aes(genre_name, n)) +
  geom_bar(stat = "identity") +
  theme(text = element_text(family = "Noto Sans CJK TC"))



d <- movie %>% 
  filter(duration > 1) %>% 
  select(movie_id, duration) %>% 
  inner_join(
    (genre %>% 
       select(movie_id, genre_name)),
    by = "movie_id"
  ) %>% 
  group_by(genre_name) %>% 
  summarise(
    min_duration = min(duration),
    max_duration = max(duration),
    mean_duration = mean(duration)
  ) %>% 
  mutate(genre_name = genre_name %>% reorder(mean_duration))

d %>% 
  gather(key = "stat", value = "value", -genre_name) %>% 
  mutate(stat = stat %>% str_extract("^.+(?=_)")) %>% 
  ggplot() +
  geom_segment(
    data = d,
    aes(x = min_duration, xend = max_duration,
        y = genre_name, yend = genre_name),
    color = "lightgrey", size = 3
  ) +
  geom_point(aes(y = genre_name, x = value, color = stat),
             size = 3, shape = 15) +
  scale_x_continuous(breaks = seq(0, 220, 30)) +
  theme(text = element_text(family = "Noto Sans CJK TC"))























