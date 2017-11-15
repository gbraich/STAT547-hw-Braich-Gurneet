# Stat547 Homework 07 Submission for G.Braich
***

### What's in the Directory?

* [Makefile](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Makefile)
* [Step 1 Download Data](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step01-DownloadData.R)
* [Step 2 Tidy Data](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step02-DataTidying.R)
* [Step 3 Aggregate Plots] (https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step03-AggregatingPlots.R)
* [Step 4 LOTR Report Rmd] (https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step04-lotrreport.Rmd)
* [Step 4 LOTR Report md] (https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step04-lotrreport.md)
* [Step 4 LOTR Report html] (https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw07/Step04-lotrreport.html)

***
### How the pipeline works
* Step01-DownloadData.R
	* `Downloader` is used to download the raw tsv file from a url
* Step02-DataTidying.R
	* Raw data from Step01 is loaded, and tidied in the following ways: rearrange factors, added columns, dropped variables, changed factor order etc.
	* Plot of words spoken by race by film
	* Write cleaned data to file
* Step03-AggregatingPlots.R
	* Imported cleaned data and made sure the factor levels were preserved
	* Filtered to look specifically at the Nine Companions of the Lord of the Rings
	* Used d_ply to split dataframe and generate different plots for the three different films
* Step04-Create R Markdown file presenting the original data, the statistical summaries and all figures generated
* Makefile- Runs all scripts in sequence

***
### But I want to aim higher!
* For a challenge I used non-Gapminder data, specifically Lord of the Rings data provided by Jenny
* This meant more time spent data cleaning (Step2) including:
    * changing the factor order
    * dropping some variables in races
    * splitting the chapter variable into two: number and name using str_split and cbind (in case I wanted to analyze something about words spoken by chapter, but I didn't in the end)
	* renaming some variables
	* Running different data aggregration (eg. looking at words spoken by fellowship members by film which involved dplyr functions)
* I embedded a pre-existing figure into the Rmarkdown file
* I ran R script and a rendered Rmarkdown file using Make in the shell
* I also installed package manager `homebrewer` so I could install `make2filegraph` and `pandoc`
* I used Pandoc 2.0 for Markdown to HTML conversion: This caused some problems that other people also [had](https://github.com/rstudio/rmarkdown/issues/1120) but was solved by reinstalling rstudio/rmarkdown using dev tools
	
***
### Reporting the process
- It took a while to get my head wrapped around the structure of a make file, and especially on how to use make with the shell command
- It seemed rather silly but loading `plyr` before `dplyr` interferred with my use of the summarize function and caused a great deal of consternation! I thought I had dplyr functions downpat but it was a good lesson to learn!
- Version control for Pandoc, Rstudio etc. is all very important and can interfere with your analysis



