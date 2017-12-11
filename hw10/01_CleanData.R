library(readr)
library(dplyr)
library(data.table)

#Load and clean up ranking data so we only have the columns we need to work with
ranking <- read_csv("ranking.csv")

ranking <-ranking %>% 
select(`2016 Rank`, City, Country) %>% 
  plyr::rename(replace = c("2016 Rank" = "Quality of Living Ranking")) 


#Load and clean up popdata so we only have the details we need.  Remove first row, rename columns
popdata<- read.csv("popdata.csv")

popdata <- popdata[-1,]
popdata <- plyr::rename(popdata, c("X1"="City", "X2"="Population"))

grpopdata<- read.csv("grpopdata.csv")
grpopdata1 <- grpopdata %>%
  select(City, X2015.Estimate)%>% 
  plyr::rename(replace = c("X2015.Estimate" = "Population"))
  
jppopdata <- read.csv("jppopdata.csv")
jppopdata1 <- jppopdata %>% 
  select(City..Special.Ward., Population) %>% 
  plyr::rename(replace = c("City..Special.Ward." = "City"))

uspopdata<- read.csv("uspopdata.csv")
uspopdata <- uspopdata[-1,]
uspopdata <- plyr::rename(uspopdata, c("X1"="City", "X2"="Population"))

swisspopdata <- read.csv("swisspopdata.csv")
swisspopdata1 <-swisspopdata %>% 
  select(City, Population)


#Bind all the population data into a master list and add a few that are missing
masterpop <- rbind(popdata, uspopdata, jppopdata1, swisspopdata1, grpopdata1)
masterpop1 <- masterpop
masterpop1$City[masterpop1$City == "Washington Dc"] <- "Washington, D.C."
masterpop1$City[masterpop1$City == "Tokyo Ward AASpecial wards of Tokyo"] <- "Tokyo"

City <- c('Luxembourg','Nuremberg','Singapore')
Population <- c('582,972', '501,072', '5,607,000')
remaining.cities <- data.frame(City, Population)
masterpop1 <- rbind(masterpop1, remaining.cities)
  

#Left-join with Mercer ranking list and export csv
finalcitylist <-left_join(ranking,masterpop1, by="City")
finalcitylist <-finalcitylist[-14,]
finalcitylist <-finalcitylist[-19,]
finalcitylist <-finalcitylist[-8,]
finalcitylist <-finalcitylist[-46,]

write_csv(finalcitylist, "finalcitylist.csv")
