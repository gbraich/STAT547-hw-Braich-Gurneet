library(ggplot2)
library(dplyr)

#Import our cleaned lotr data from Step 2
lotr_data <- read.delim("lotr_clean.tsv")

#Check the structure to make sure factor levels are still intact
str(lotr_data)
levels(lotr_data$Race)

lotr_data <-
	within(lotr_data, {
		Race <- factor(as.character(Race), levels = unique(Race))
		Film <- factor(as.character(Film), levels = unique(Film))
	})


#Filter to show total words spoken by the Nine Companions
fellowship <- c("Gandalf", "Aragorn", "Merry", "Pippin", "Frodo", "Sam", "Gimli", "Legolas", "Boromir")
characterwords <- lotr_data %>% 
	filter(Character %in% fellowship) %>% 
	group_by(Character, Film) %>% 
	summarize(sum(Words))

#for each Film, write a plot to file of words by fellowship member
plyr::d_ply(characterwords, ~Film, function(p){
	the_film <- p$Film[1]
	R <- ggplot(p, aes(Character, `sum(Words)`))+ 
		geom_col() +
		theme(axis.text.x=element_text (angle=270)) +
		labs(y="Total Words Spoken", x= "Nine Companions")+
		ggtitle(the_film)
	print(R)
	the_film <- gsub(" ", "-", the_film)
	ggsave(paste0("Images/barchart_words-by-companion_", the_film, ".png"))
})


## write the total words by Companion to file
write.table(plyr::ddply(characterwords, ~Character, summarize, total_words=sum(`sum(Words)`)),
			"total-words-by-Companion.tsv", quote = FALSE,
			sep = "\t", row.names = FALSE)


