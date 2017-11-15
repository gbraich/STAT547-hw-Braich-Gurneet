#Makefile for LOTR Words Analysis

all: final_lotr_report.html

lotr_raw.tsv:
	Rscript Step_01-Download_Data.R

lotr_clean.tsv barchart_total_words_by_race_by_film.png Step_02-Data_Tidying.html:Step_02-Data_Tidying.R lotr_raw.tsv
	Rscript -e "rmarkdown::render('$<')"
	
total-words-by-Companion.tsv: lotr_clean.tsv Step_03-Aggregating_Plots.R
	Rscript Step_03-Aggregating_Plots.R
	rm Rplots.pdf

Step_04-lotr_report.html: Step_04-lotr_report.Rmd lotr_raw.tsv barchart_total-words-by-race.png
	Rscript -e "rmarkdown::render('$<')"

clean:
	rm -rf *.tsv *.png 0*.md *.html 03_lotr-report_files

test: all
	$(MAKE) -Bnd | ./make2graph | dot



