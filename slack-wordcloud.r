setwd("/slackexport")

#Obviously these need to be installed!
library(jsonlite)
library(tm)
library(wordcloud)

output.filename <- "/export/wordcloud.png"

files <- list.files('.',"*.json", recursive=T)
 
json <- sapply(files, fromJSON)
 
texts <- sapply(json, function(f){if ('subtype' %in% names(f)) f$text[is.na(f$subtype)] else f$text})
 
flat <- unlist(texts)

removeUsernames <- function(doc) {
    gsub("<@[0-9a-zA-Z]*>", "", doc)
}

removeCharacters <- function (doc, characters)  {
    pattern <- paste(characters, collapse = "|")
    gsub(pattern, "", doc, perl = TRUE)
}

corpus <- Corpus(VectorSource(flat))

# Remove slack username identifiers
corpus <- tm_map(corpus, removeUsernames)

# general cleaning
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, content_transformer(tolower))
# corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)

# Remove a unicode apostrophe
corpus <- tm_map(corpus, removeCharacters, c('\u2019'))

# Remove a unicode ...
corpus <- tm_map(corpus, removeCharacters, c('\u2026'))

# Remove some stopwords
corpus <- tm_map(corpus, removeWords, stopwords('english'))
corpus <- tm_map(corpus, removeWords, c('just', 'like', 'can', 'get', 'scalar', 'will', 'pk', 'paul', 'need',
                                        "also", "article", "sure", "dont", "etc", "thats", 
                                        "download", "figure", "weed", "joint", "fuck", "shit",
                                        "fig", "groups", "however", "good", "ill", "want",
                                        "high", "human", "levels", "cibc", "ive",
                                        "larger", "may", "number", "havent", "red", "hat",
                                        "shown", "study", "studies", "this", "channel",
                                        "using", "two", "the", "isnt", "didnt", "youre", "rogers", "bell",
                                        "view", "View", "the", "biol", "cory",
                                        "kyle", "mike", "mimo", "aly", "shea", "tim", "daniyal", "jacob", "aaren", "aren", "kayla", "hart", "phil", "roman", "victor",
                                        "via", "image", "doi", "one", "hes", "tel"))
# Generate the wordcloud and save it to a png
png(output.filename, height=800, width=800)
# wordcloud(corpus, scale=c(7,.2), max.words=400, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(9, "BuGn"))
wordcloud(corpus, scale=c(7,.4), max.words=400, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(6, "Blues"))
dev.off()
