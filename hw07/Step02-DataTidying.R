library(ggplot2)
library(dplyr)
library(stringr)

#Load lotr_raw from Step 1
lotr_data <- read.delim("lotr_raw.tsv")

glimpse(lotr_data)

# Make Chapter column into two columns (number and name)
# Rename columns after binding together
lotr_data_split <- data.frame(do.call(rbind, strsplit(as.vector(lotr_data$Chapter), split = ":")))
names(lotr_data_split) <- c("Chapter_Number", "Chapter_Name")
lotr_data_clean_split <- cbind(lotr_data$Film, lotr_data_split, lotr_data$Character, lotr_data$Race, lotr_data$Words)
ldcs2<- plyr::rename(lotr_data_clean_split, c("lotr_data$Film"="Film", "lotr_data$Character"="Character", "lotr_data$Race"="Race", "lotr_data$Words"="Words"))
ldcs2

#reoder Film factor levels
old_levels <- levels(ldcs2$Film)
j_order <- sapply(c("Fellowship", "Towers", "Return"),
				  function(x) grep(x, old_levels))
new_levels <- old_levels[j_order]


# apply new factor levels to Film
# change names of races (eg. Ainur to wizard, Men to Man)
# drop races that are less frequent
# reorder Race based on words spoken
# arrange data on Race, Film, Words
lotr_data_clean <- ldcs2 %>% 
	mutate("Film" = factor(as.character(Film), new_levels),
		   "Race" = plyr::revalue(Race, c(Ainur="Wizard", Men="Man"))) %>% 
	filter(!(Race %in% c("Gollum", "Orc", "Ent", "Dead", "Nazgul"))) %>% 
	mutate(Race = reorder(Race, Words, sum)) %>% 
	arrange(Race,Film, Words) %>% 
	droplevels
glimpse(lotr_data_clean)

##Make a plot about which race does the most talking by film

plot1 <- lotr_data_clean %>% 
	ggplot(aes(Race, Words)) + 
	geom_col() +
	facet_wrap(~Film) +
	labs(y="Total Words Spoken") 
ggsave("barchart_total_words_by_race_by_film.png", plot1)

#write data to file
write.table(lotr_data_clean, "lotr_clean.tsv", quote=FALSE,
			sep="\t", row.names=FALSE)
