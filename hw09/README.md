# Stat547 Homework 09 Submission for G.Braich
***

### What's in the Package Directory?

* [agconversions package](https://github.com/gbraich/agconversions)
  * Contains README, vignettes, test, R scripts, NAMESPACE, DESCRIPTION & LICENSE

* Instruction on how to download the package from the [course website](http://stat545.com/hw09_package_onramp-peer-review.html)

* Homework 09 [README](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw09/README.md)


***
### Reporting the process
- I wasn't that interested in the `powers` package so I decided to make my own!  My research is mostly with agriculture and climate data so it was in my own self-interest to write an simple package to do some easy unit conversions.  All of the functions involve converting area/weight/temperature data into metric/SI units instead of imperial ones

- I used an internal function like `pow` which I called `multi` as a multiplier for `x` against various conversion ratios

- I tried to add some extras by including some new .Rd formatting tags and roxygen tags

- To get used to writing a package, I included 5 different functions for different conversions to metric/SI

- Getting rid of the insta/doc from the gitignore was more trouble than I thought!  I used `nano` in terminal to open gitignore and remove the file

- This assignment made me realize that package writing is an important tool, and also helped me get more comfortable with function writing too!

- I used a couple of resources including:
        - [Vincenzo's powers package](https://github.com/vincenzocoia/powers)
        - [Jenny's foofactors package](https://github.com/jennybc/foofactors)
        - [Extra information on testing](http://r-pkgs.had.co.nz/tests.html)
        - [Package Development Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/06/devtools-cheatsheet.pdf)
        
        

