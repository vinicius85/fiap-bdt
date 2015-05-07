#B.1

M <- matrix(0,5,5)

l <- c(1:5)

for(i in seq(1:5)){
  M[i,] <- l^i
}

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
diff <- c()
for(i in seq(2:12)){
  diff <- c(diff,v[i]-v[i-1])
}
plot(diff, type = 'l', xlab = 'meses', ylab = 'variaçao do preço', col = 'red')
abline(h=0)

#iv
a <- subset(aapl, format(aapl$date, "%Y") == "2010")
plot(a, type = 'l', main = 'Lançamento do ipad (Anunciado em 27/01/2010)', xlab = 'Meses do ano 2010', ylab = 'Preço das açoes')



#B.3
sao_disjuntos <- function(A,B){
  disjuntos <- T
  C <- A %in% B
  if(T %in% C){
    disjuntos <- F
  }
  disjuntos
}

#Teste 1: nao disjuntos
A <- c(1,2,3)
B <- c(3,5,6)

sao_disjuntos(A,B)

#Teste 2: disjuntos
A <- c(1,2,3)
B <- c(4,5,6)

sao_disjuntos(A,B)
