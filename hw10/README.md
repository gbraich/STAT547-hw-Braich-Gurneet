# Stat547 Homework 07 Submission for G.Braich
***

### What's in the Directory?

* [Makefile](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/Makefile)
* [Step 1 Download Data](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/00_DownloadFiles.R)
* [Step 2 Tidy Data](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/01_CleanData.R)
* [Step 3 Add Data with APIs](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/02_AddWeatherData.R)
* [Step 4 Hw 10 Analysis Rmd](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/Hw10%20Data%20Analysis.Rmd)
* [Step 4 Hw 10 Analysis md](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw10/Hw10_Data_Analysis.md)

***
### How the pipeline works
* Step01-Download Data
	* `rvest` used to scrape tables from Wikipedia and other websites
	* Sources used:
	          - [City Rankings](https://en.wikipedia.org/wiki/Mercer_Quality_of_Living_Survey)
	          - [World Populations](http://worldpopulationreview.com/world-cities/)
	          - [City Populations Japan](https://en.wikipedia.org/wiki/List_of_cities_in_Japan)
	          - [City Populations Switzerland](https://en.wikipedia.org/wiki/List_of_places_in_Switzerland)
	          - [City Populations Germany](https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population)
	          
	          
* Step02-Clean Data
	* Raw data from Step01 is loaded, and tidied in the following ways: renamed columns, dropped rows, bind multiple lists with rbind, join dataframes
	* Write cleaned data to file
	
* Step03- Add Weather Data
	* Imported cleaned data
	* Used [geocodes](https://www.rdocumentation.org/packages/ggmap/versions/2.6.1/topics/geocode) package which is a google maps API to retrieve latitude and longitude
	* Used [rnoaa](https://cran.r-project.org/web/packages/rnoaa/index.html) package which uses the National Climate Data Centres API to retrieve weather station IDs based on lat/lon and pull precipitation and temperature data for up to 60 years (I used 10 years of daily data which was averaged)
	* Bind ranking, city, population, geolocation and weather data into a final dataframe
	* Write cleaned data to file
	
* Step04-Create R Markdown file analyzing the final dataset and generate plots

* Makefile- Runs all scripts in sequence


***
### Reporting the process
* For a challenge I used non-Gapminder data and utlized a combination of webscraping multiple sites and R packaged wrapped APIs
* I really enjoyed the problem solving that went with webscraping. To make this most useful for me in the future I tried to use websites and packages I will need later for my thesis work
* I did several examples with httr and I enjoyed the using the developer view to find the nodes and classes
* I found some difficult in finding apis that gave a suitable amount of information for free, most charged for historical data
* There was alot of interesting data that I was going to look at or add to my dataframe but the issue was that it was in a pdf document and not always in a readable form.  I did find a [pdftoolpackage](https://ropensci.org/blog/2016/03/01/pdftools-and-jeroen/) which I have been experimenting with as well as one specifically for [pdftables](https://cran.r-project.org/web/packages/pdftables/pdftables.pdf)
* As I am going to work with large datasets in the future that are mostly historical climate and agriculture data, I think the tools learned from the "Data from the Web" lectures will be very handy!
