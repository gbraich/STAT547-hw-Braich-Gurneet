# Stat547 Homework 07 Submission for G.Braich
***

### What's in the Directory?

* [Shiny App-City Selector](https://gbraich.shinyapps.io/City_Selector/)
* [Makefile](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Makefile)
* [00_DownloadFiles.R](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw08/Makefile)
* [01_CleanData.R](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw08/01_CleanData.R)
* [02_AddWeatherData.R](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw08/02_AddWeatherData.R)
* [Shiny App UI and Server](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/tree/master/hw08/Choosingacity)

***
### Build a Shiny App!
* For a challenge I created my own dataset which was a lot of work!  I was inspired by the comic below and wanted to try out some new packages and start working with weather data
* For the App I added several sliders to change around population size, ranking and weather
* Other specifications I made included adding html elements, labels etc, render text etc
* I did alot of research into making my plot more informative using the links below and used plotly to have 'hover' data and some other tricks to make quadrants, add labels etc.
	*[Plotly](https://stackoverflow.com/questions/38917101/how-do-i-show-the-y-value-on-tooltip-while-hover-in-ggplot2)
	*[Quadrants](https://stackoverflow.com/questions/24190431/adding-quadrants-to-r-scatterplots-and-lines-pointing-from-plots-to-their-respe)
	*[Shiny Tutorial](http://shiny.rstudio.com/tutorial/)
![](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw08/Choosingacity/www/xkcd.png)

***
### How the pipeline works
* 00_DownloadFiles.R
	* Scrap data of websites to get city rankings and population data
* 01_CleanData.R
	* Raw data from Step01 is loaded and tidied into a final list with cities,ranking and population
	* Write cleaned data to file
* 02_AddWeatherData.R
	* Imported cleaned data
	* Using geocode package to add longitude and lattitude for each city
	* Used rnoaa package to lookup nearest weather stations based on lat/lon
	* Pulled 10 years of daily precipitation and temperature data for all 51 cities
	* Took means of data and bound everything together into a final csv for export to be used in the shiny app
* Makefile- Runs all scripts in sequence
	
***
### Reporting the process
- It was good to have already had the makefile lessons, it was a real help to use it for this analysis
- It was fun to make my own dataset based on information I found interesting
- I hope to use makefile more to tinker around and do some other neat analysis!
