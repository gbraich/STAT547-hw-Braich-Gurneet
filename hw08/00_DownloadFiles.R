
library(curl)
library(xml2)
library(rvest)
library(readr)

#Let's download some data on cities, specifically on top 50 ranked cities by quality of living.  Let's also get their population data
#Download Mercer quality of living rankings (top50) from Wikipedia
url <- "https://en.wikipedia.org/wiki/Mercer_Quality_of_Living_Survey"
ranking <- url %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="mw-content-text"]/div/table[2]') %>% 
  html_table()
ranking <- ranking[[1]]

write_csv(ranking, "ranking.csv")

#Download city population data
url2 <- "http://worldpopulationreview.com/world-cities/"
popdata <- url2 %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="main-page-content"]/div/div/table') %>% 
  html_table()
popdata <- popdata[[1]]

write_csv(popdata, "popdata.csv")

#Download population data on missing US cities, Japanese, German and Swiss cities
url3 <- "http://worldpopulationreview.com/us-cities/"
uspopdata <- url3 %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="main-page-content"]/div/div/table') %>% 
  html_table()
uspopdata <- uspopdata[[1]]

write_csv(uspopdata, "uspopdata.csv")

url4 <- "https://en.wikipedia.org/wiki/List_of_cities_in_Japan"
jppopdata <- url4 %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="mw-content-text"]/div/table[3]') %>% 
  html_table()
jppopdata <- jppopdata[[1]]
write_csv(jppopdata, "jppopdata.csv")

url5 <- "https://en.wikipedia.org/wiki/List_of_places_in_Switzerland"
swisspopdata <- url5 %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="mw-content-text"]/div/dl/dd/table') %>% 
  html_table()
swisspopdata <- swisspopdata[[1]]
write_csv(swisspopdata, "swisspopdata.csv")

url6 <- "https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population"
grpopdata <- url6 %>% 
  html() %>% 
  html_nodes(xpath='//*[@id="mw-content-text"]/div/table[1]') %>% 
  html_table()
grpopdata <- grpopdata[[1]]
write_csv(grpopdata, "grpopdata.csv")
