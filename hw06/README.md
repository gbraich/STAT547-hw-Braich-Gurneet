# Stat545 Homework 05 Submission for G.Braich
***

### What's in the Directory?

* Because of visualization issues in the Rmd and md files I also included the [html file](https://cdn.rawgit.com/gbraich/STAT547-hw-Braich-Gurneet/18fc7514/hw06/hw06.html) run thorugh rawgit so some of the extra features (str viewer, leaflet etc) can be viewed instead of being a huge mess which is what they look like in the rmd and md formats 

* Homework 06 [Rmd](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw06/hw06.Rmd) and [md](https://github.com/gbraich/STAT547-hw-Braich-Gurneet/blob/master/hw06/hw06.md) files


***
### Reporting the process
- The exercises in R for Data Science: Strings were very useful, I hope to go back in my freetime and do more exercises from other chapters

- Using map functions are really helpful to simplfy code, I used both map and an lapply function to find the geocodes of artists and map was a lot easier to read and compute and made a much easier to use dataframe of nested lists.  Map also let me decided what the output would be formatted as

- Messy data is a headache.  I tried to clean up the `city` variable in singer_locations the best I could but it was simply too messy and inconsistent in how data was entered.  Using str_subset was good to find some nested data

- Leaflet is great!

- Visualizing results works fine in Rstudio and the knit html document but looked terrible for many parts of the assignment when the rmd and md file were loaded to github.  I was quite sure to fix this so instead I used raw git so the html file could be visualized with all the components working!
