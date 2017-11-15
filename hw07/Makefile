#Makefile for LOTR Words Analysis

all: Step04-lotrreport.html

lotr_raw.tsv:
	Rscript Step01-DownloadData.R

lotr_clean.tsv barchart_total_words_by_race_by_film.png Step02-DataTidying.html:Step02-DataTidying.R lotr_raw.tsv
	Rscript -e "rmarkdown::render('$<')"
	
total-words-by-Companion.tsv: lotr_clean.tsv Step03-AggregatingPlots.R
	Rscript Step03-AggregatingPlots.R
	rm Rplots.pdf

Step04-lotrreport.html: Step04-lotrreport.Rmd lotr_raw.tsv barchart_total_words_by_race_by_film.png
	Rscript -e "rmarkdown::render('$<')"

clean:
	rm -rf *.tsv *.png 0*.md *.html Step_04-lotr_report_files

test: all
	$(MAKE) -Bnd | ./make2graph | dot



