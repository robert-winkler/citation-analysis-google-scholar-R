library('scholar')
## Define the id for Robert Winkler
id <- 'fyMS1UQAAAAJ'

## Get his profile
l <- get_profile(id)

## Print name and affliation
l$name
l$affiliation

## Print H-factor and i10
l$h_index
l$i10_index

## Get publications (a large data frame)
pubs <- get_publications(id)
head(pubs, 3)
write.csv(pubs, 'robert-winkler_publications-google-scholar.csv')
pubs_clean <- na.omit(pubs)

pubs_clean[["cites"]]
pubs_clean[["year"]]

actual_year <- 2022

rel_publ_time <- actual_year - pubs_clean[["year"]]
rel_publ_time

cites_year <- pubs_clean[["cites"]]/rel_publ_time

cites_year

pubs_analysis <- data.frame(cites_year,pubs_clean[["year"]],pubs_clean[["cites"]],pubs_clean[["title"]],pubs_clean[["author"]],pubs_clean[["journal"]])
pubs_analysis

write.csv(pubs_analysis,'robert-winkler_citation-analysis.csv')

## Get his citation history, i.e. citations to his work in a given year
ct <- get_citation_history(id)

## Plot citation trend
library(ggplot2)
pdf(file='robert-winkler-citations-graph.pdf')
ggplot(ct, aes(year, cites)) + geom_line() + geom_point()
dev.off()

# Be careful with specifying too many coauthors as the visualization of the
# network can get very messy.
coauthor_network <- get_coauthors('fyMS1UQAAAAJ&hl', n_coauthors = 1000)

coauthor_network

pdf(file='robert-winkler-coauthor-network.pdf')
plot_coauthors(coauthor_network, size_labels=1)
dev.off()
