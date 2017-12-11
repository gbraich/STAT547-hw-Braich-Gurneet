library(rnoaa)
library(dplyr)
library(purrr)
library(ggplot2)
library(magrittr)
library(readr)
library(ggmap)


#Load data from previous R script

finalcitylist <- read_csv("finalcitylist.csv")


#Find geocodes for each of our cities using an R package that wraps an API (google geocodes api in ggmap package)

gcfunction <-geocode(finalcitylist$City, output = "latlon")

finalcitylistgeo <-cbind(finalcitylist, gcfunction)

finalcitylistgeo <- finalcitylistgeo %>% 
  plyr::rename(replace = c("lat" = "latitude", "lon" = "longitude"))

#Use rnoaa package wrapped API to look up nearest weather station id based on latitude and longtitude of city weather stations

citysubset<- finalcitylistgeo %>% 
  plyr::rename(replace = c("City" = "id"))
  
cityweather <- meteo_nearby_stations(lat_lon_df=citysubset, lat_colname = "latitude",
                      lon_colname = "longitude", station_data = ghcnd_stations(), var = c("PRCP", "SNOW", "TMAX", "TMIN", "TAVG", "PSUN"),
                      year_min = 2010, year_max = 2016, limit = 1)

#Extract variables of interest using map and bind to original table

(citystationid <- map_df(cityweather, extract, c("id", "longitude", "latitude")))

fclga<- finalcitylistgeo %>% 
  arrange(City) %>% 
  select(`Quality of Living Ranking`, City, Country, Population)

fclga<-cbind(fclga, citystationid)

#Some weather stations were not working so changed them out for others

fclga$id[fclga$id == "ASN00023000"] <- "ASN00023090"
fclga$id[fclga$id == "ASN00040911"] <- "ASN00040913"
fclga$id[fclga$id == "ASN00070247"] <- "ASN00070015"
fclga$id[fclga$id == "ASN00066006"] <- "ASN00066062"
fclga$id[fclga$id == "CA006158350"] <- "CA006158751"
fclga$id[fclga$id == "FIE00142235"] <- "FIE00142101"
fclga$id[fclga$id == "NLE00101920"] <- "NLE00102114"
fclga$id[fclga$id == "SWE00137598"] <- "SWE00138866"
fclga$id[fclga$id == "SWE00138886"] <- "SWM00002485"
fclga$id[fclga$id == "US1DCDC0019"] <- "USC00186350"
fclga$id[fclga$id == "US1NYKN0025"] <- "USC00283704"
fclga$id[fclga$id == "US1MASF0001"] <- "USW00014739"
fclga$id[fclga$id == "CA1AB000012"] <- "CA003031092"
fclga$id[fclga$id == "USC00510211"] <- "USC00111550"
fclga$id[fclga$id == "US1WAKG0204"] <- "USW00024234"

#Based on station id, pull data on daily precipitation, minimum temperatures, maximum temperatures and average temperature for the past 10 years

monitors <- as.vector(fclga$id)

dailydata <- meteo_pull_monitors(monitors, keep_flags = FALSE, date_min="2006-01-01", date_max ="2016-12-31", var = c("PRCP", "TMIN","TMAX", "TAVG"))

#Get mean values for PRCP and TAVG by writing a function

aggdailyweather <- dailydata %>%
  group_by(dailydata$id) %>%
  summarise_each(funs(mean(., na.rm=TRUE)), -date)

aggdailyweather[30, 3] = 25.107531
aggdailyweather[45, 3] = 35.813721

#Join to our original table, select columns of interest
finalweather <- aggdailyweather %>% 
  select(`dailydata$id`, prcp, tmax, tmin) %>% 
  plyr::rename(replace = c("dailydata$id" = "id"))

finalcitydata <- full_join(fclga, finalweather, by="id")

#adjust celcius data
finalcitydata$tmax <- finalcitydata$tmax/10
finalcitydata$tmin <- finalcitydata$tmin/10
finalcitydata$prcp <- finalcitydata$prcp/10

#now we have city data with mercer rankings, populations, geocodes, and weather

write_csv(finalcitydata, "finalcitydata.csv")  



