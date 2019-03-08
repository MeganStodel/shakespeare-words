library(gutenbergr)
library(data.table)
library(tidytext)
library(dplyr)
library(shiny)
library(rio)

# Obtain the metadata for Shakespeare plays

shake_metadata <- as.data.table(gutenberg_works(author == "Shakespeare, William") %>%
                                  filter(gutenberg_id >= 1500 & gutenberg_id <= 1541 & gutenberg_id != 1505 & gutenberg_id != 1525))

# Download plays

shake_plays <- as.data.table(gutenberg_download(shake_metadata$gutenberg_id, meta_fields = "title")) # 181,648 rows

shake_words <- unnest_tokens(shake_plays, word, text)

all_words <- shake_words[, .N, by = title]
setnames(all_words, "N", "total_words")

shake_sentence <- unnest_tokens(shake_plays, sentence, text, token = "sentences")

shake_sentence[, sentence := paste0(toupper(substr(sentence, 1, 1)), substr(sentence, 2, nchar(sentence)))]

shake_sentence[, sentence := gsub("i ", "I ", sentence)]