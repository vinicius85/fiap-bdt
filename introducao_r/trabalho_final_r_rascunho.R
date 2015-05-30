rm(list=ls(all=TRUE))

#Carrega library
library(gcookbook)
library(ggplot2)
library(WDI)
library(psych)
library(plotrix)
library(grid)
library(gridExtra)

#Prepração dos Dados

getwd()
setwd("C:/Users/emiyakawa/Documents/FIAP") # troque o path descrito aqui
getwd()
dados <- read.csv(file="dados.csv",head=TRUE,sep=";")
str(dados)

DF5 <- WDI(country=c("GB","BR"), indicator = "SH.STA.ACSN", start=1960, end=2014)

paises <- countries
str(paises)

#seleciona Brasil e Grã-bretanha no dataset paises

Br_Gbr <- subset(paises, paises$Code == "BRA" | paises$Code == "GBR")
Br_Gbr$Code <- factor(Br_Gbr$Code)
Br_Gbr$Name <- factor(Br_Gbr$Name)

#Muda o nome dos campos de sigla para Code e ano para Year 

names(dados)[names(dados)=="sigla"] <- "Code"
names(dados)[names(dados)=="ano"] <- "Year"

#Cria o subset do data franme dados para os anos de 1960 a 2010.

dados_aux <- subset(dados, dados$Year <= 2010)
DF5_aux <- subset(DF5, DF5$year <= 2010)

names(DF5_aux)[names(DF5_aux)=="year"] <- "Year"
names(DF5_aux)[names(DF5_aux)=="iso2c"] <- "Code"
names(DF5_aux)[names(DF5_aux)=="country"] <- "Name"

DF5_aux$Code[DF5_aux$Code == "BR"] <- "BRA"
DF5_aux$Code[DF5_aux$Code == "GB"] <- "GBR"
DF5_aux$Code = factor(DF5_aux$Code)

DF5_aux <-DF5_aux[order(DF5_aux$Name,DF5_aux$Year),]
DF5_aux$Name <- NULL

#Faz o merge dos bancos de dados

Br_Gbr <- merge(Br_Gbr, dados_aux,  c("Code","Year"))
Br_Gbr <- merge(Br_Gbr, DF5_aux,  c("Code","Year"))

str(Br_Gbr)

reduz_brgbr <- c("Code", "Year","SP.POP.0014.TO.ZS")
brgbr <- Br_Gbr[reduz_brgbr]
br1 <- subset(brgbr, brgbr$Code == "BRA")
gb1 <- subset(brgbr, brgbr$Code == "GBR")

reduz_brgbr <- c("Code", "Year","SP.POP.1564.TO.ZS")
brgbr <- Br_Gbr[reduz_brgbr]
br2 <- subset(brgbr, brgbr$Code == "BRA")
gb2 <- subset(brgbr, brgbr$Code == "GBR")

reduz_brgbr <- c("Code", "Year","SP.POP.65UP.TO.ZS")
brgbr <- Br_Gbr[reduz_brgbr]
br3 <- subset(brgbr, brgbr$Code == "BRA")
gb3 <- subset(brgbr, brgbr$Code == "GBR")


Br_Gbr["Pop_Tot"] = (Br_Gbr$SP.POP.TOTL)/1000000

yearlabels<-c(1960:2010)

ggplot(Br_Gbr, aes(Year, Pop_Tot, color=Name)) + geom_line(stat="identity") +
ggtitle("Population Evolution 1960-2010") + ylim(0,200) + ylab("Pop. in Million")

par(mar=pyramid.plot(br1$SP.POP.0014.TO.ZS,gb1$SP.POP.0014.TO.ZS,
                     top.labels=c("BRA","0-14 YEARS","GBR"),labels=yearlabels,
                     main="Population Pyramid 0-14 Years Evolution",lxcol="blue",rxcol= "red",
                     gap=3,space=0.25, labelcex=0.5,show.values=F))

par(mar=pyramid.plot(br2$SP.POP.1564.TO.ZS,gb2$SP.POP.1564.TO.ZS,
                     top.labels=c("BRA","15-64 YEARS","GBR"),labels=yearlabels,
                     main="Population Pyramid 15-64 Years Evolution",lxcol="blue",rxcol= "red",
                     gap=3,space=0.25, labelcex=0.5,show.values=F))

par(mar=pyramid.plot(br3$SP.POP.65UP.TO.ZS,gb3$SP.POP.65UP.TO.ZS,
                     top.labels=c("BRA","65-UP YEARS","GBR"),labels=yearlabels,
                     main="Population Pyramid 65-UP Years Evolution",lxcol="blue",rxcol= "red",
                     gap=3,space=0.25, labelcex=0.5,show.values=F))

describeBy(Br_Gbr$SP.POP.TOTL, Br_Gbr$Code)

describeBy(Br_Gbr$SP.POP.0014.TO.ZS, Br_Gbr$Code)
describeBy(Br_Gbr$SP.POP.1564.TO.ZS, Br_Gbr$Code)
describeBy(Br_Gbr$SP.POP.65UP.TO.ZS, Br_Gbr$Code)

ggplot(Br_Gbr, aes(Year, GDP, color=Name)) + geom_line(stat="identity") +
ggtitle("GDP per Capita Evolution 1960-2010")
describeBy(Br_Gbr$GDP, Br_Gbr$Code)

Br_Gbr["PERC.HEALTHEXP.GDP"] = (Br_Gbr$healthexp/Br_Gbr$GDP)*100

gh1 <- ggplot(Br_Gbr, aes(Year, healthexp, color=Name))+geom_line(stat="identity") +
  ggtitle("Health Expenditure per Capita Evolution 1995-2010")

gh2 <- ggplot(Br_Gbr, aes(Year, PERC.HEALTHEXP.GDP, color=Name))+geom_line(stat="identity") +
  ggtitle("Percent Health Expenditure per Capita Evolution 199560-2010")

gh3 <- ggplot(Br_Gbr, aes(Year, infmortality , color=Name))+geom_line(stat="identity") +
  ggtitle("Infant mortality per 1000 live births Evolution 1995-2010")

gh4 <- ggplot(Br_Gbr, aes(Year, SP.DYN.LE00.IN , color=Name))+geom_line(stat="identity") +
  ggtitle("Life Expectancy at Birth Evolution 1960-2010")

grid.arrange(gh1, gh2)

describeBy(Br_Gbr$healthexp, Br_Gbr$Code)
describeBy(Br_Gbr$PERC.HEALTHEXP.GDP, Br_Gbr$Code)

ggplot(Br_Gbr, aes(Year, SH.STA.ACSN, color=Name)) +geom_line(stat="identity") +
  ggtitle("Improved Sanitation Facilities 1995-2010")
describeBy(Br_Gbr$SH.STA.ACSN, Br_Gbr$Code)

grid.arrange(gh3, gh4)
describeBy(Br_Gbr$infmortality, Br_Gbr$Code)
describeBy(Br_Gbr$SP.DYN.LE00.IN, Br_Gbr$Code)

