#Makefile for World City Rankings and Weather

all: finalcitydata.csv

ranking.csv popdata.csv uspopdata.csv jppopdata.csv swisspopdata.csv grpopdata.csv:
	Rscript 00_DownloadFiles.R

finalcitylist.csv:ranking.csv popdata.csv uspopdata.csv jppopdata.csv swisspopdata.csv grpopdata.csv
	Rscript 01_CleanData.R
	

finalcitydata.csv:finalcitylist.csv
	Rscript 02_AddWeatherData.R

clean:
	rm -rf *.csv

test: all
	$(MAKE) -Bnd | make2graph | dot -Tpng -o makefile2citydata.png
	PATH=.:$(PATH) makefile2graph
