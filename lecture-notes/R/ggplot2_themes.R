library(magrittr)
library(magrittrot2)
library(reshape2)
library(ggthemes)

data <- data.frame(
  Conpany = c("Apple", "Google", "Facebook", "Amozon", "Tencent"),
  "2015" = c(5000, 3500, 2300, 2100, 3100),
  "2016" = c(5050, 3800, 2900, 2500, 3300),
  check.names = FALSE
)

mydata <- data %>% 
  melt(id.vars = "Conpany", variable.name = "Year", value.name = "Sale")

ggplot(mydata,aes(Conpany,Sale,fill=Year)) +
  geom_bar(stat="identity",position="dodge") +
  ggtitle("Sales of Tech Compacies") +
  scale_fill_wsj() +
  theme_wsj()
