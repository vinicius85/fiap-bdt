#B.1

M <- matrix(0,5,5)

l <- c(1:5)

for(i in seq(1:5)){
  M[i,] <- l^i
}

#Determinante da matriz e sua transposta sao iguais
det(M)
det(t(M))

x <- det(M)
y <- det(t(M))

trunc(x,0) == trunc(y,0)

#B.2
library(gcookbook)

#i
a <- subset(aapl, format(aapl$date, "%Y") == "2010")
mean(a$adj_price)
summary(a)

#ii
data <- aapl
f <- format(data$date, "%m")
data <- cbind(data,f)

v <- c()

for(i in seq(1:12)){
  total_mes <- subset(data, as.numeric(data$f)==i)
  m <- mean(total_mes$adj_price)
  v <- c(v,m)
}

names(v) <- c(1:12)
barplot(v)
abline(h=mean(v))

#iii

