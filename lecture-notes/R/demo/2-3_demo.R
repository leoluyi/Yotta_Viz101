library(ggplot2)

d <- data.frame(
  x = 1:5,
  y = rnorm(5),
  label = c("一", "二", "三", "四", "五")
)

ggplot(d, aes(x = x, y = y, label = label)) +
  geom_point() +
  geom_text(family = "STHeiti", aes(x = x + 0.1, y = y - 0.1)) +
  ggtitle("中文標題") +
  theme(text = element_text(family = "STHeiti"))
