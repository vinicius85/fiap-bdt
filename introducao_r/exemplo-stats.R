#exemplo do pacote stats

library(stats)
wineheart <- read.csv('fiap-bdt/introducao_r/wineheart.txt', sep = '\t')

View(wineheart)

plot(wineheart$Deaths, wineheart$Wine)

cor.test(wineheart$Deaths, wineheart$Wine)

m <- lm(wineheart$Deaths ~ wineheart$Wine)
summary(m)
plot(m)


library(ggplot2)
qplot(Deaths, Wine, data=wineheart) + geom_smooth()