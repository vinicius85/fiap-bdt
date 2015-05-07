##PARTE A: Expressões Aritméticas e Lógicas, Funções no R, Vetores, Gráficos com Vetores

#A.1
sqrt(100000 - 3 * 4.5^4)
sqrt(100-5^3)

#A.2
x<-3
y<-2
z<--5
f <- x^3 - 2*x*(y^2) + 3*z + z^2
print(f)

#A.3
x<- c(F,F,T,T)
y<- c(F,T,F,T)
print(x|y)

x<-TRUE
y<-FALSE
print((x & y) | (! (x & y )))

#A.4
x<-T
y<-F
z<-7
w<-1.5
e <- (x & y) | (sqrt(z/2) <= w)
print(e)

#A.5
x<- seq(-2,1999,by = 5)
y <- x>0
y
w<-!y
w

#A.6
x<-c(1:10)
y<-c(5:15)
intersect(x,y)

#A.7
K<-7381
x<-c(1:K)
divisivel_3 <- x%%3 == 0
nao_divisivel_5 <- x%%5 != 0
length(x[divisivel_3==T & nao_divisivel_5==T])

#A.8
x<- sqrt(seq(11,99,2))
x

#A.9
x<-c(43,25,44,36,37,40,43,40,32)
mean(x)

#A.10
x <- seq(-5,5)
x<- x[x != 0]
plot(sin(x)/x, type = 'l')

#A.11
x <-c('Australia','Austria','Belgium','Canada')
y <- c(2.5,3.9,2.9,2.4)
names(y)<- x
mean(y)
barplot(y)