library(gutenbergr)
library(data.table)
library(tidytext)
library(dplyr)
library(shiny)

# Play types

comedies <- c("The Comedy of Errors", "The Taming of the Shrew", "The Two Gentlemen of Verona",
            "Love's Labour's Lost", "A Midsummer Night's Dream", "The Merchant of Venice", 
            "The Merry Wives of Windsor", "Much Ado about Nothing", "As You Like It",
            "Twelfth Night; Or, What You Will", "The Winter's Tale", "The Tempest")
histories <- c("King Henry VI, First Part", "History of King Henry the Sixth, Second Part", 
             "The History of King Henry the Sixth, Third Part", "The Tragedy of King Richard III",
             "King John", "The Tragedy of King Richard the Second", "King Henry IV, the First Part",
             "King Henry IV, Second Part", "The Life of King Henry V", "The Life of Henry the Eighth")
tragedies <- c("The Tragedy of Titus Andronicus", "Romeo and Juliet", "Julius Caesar", "Hamlet, Prince of Denmark",
             "Othello, the Moor of Venice", "The Tragedy of King Lear", "Macbeth", "Antony and Cleopatra",
             "The Tragedy of Coriolanus", "The Life of Timon of Athens", "Cymbeline")


# Obtain the metadata for Shakespeare plays

shake_metadata <- as.data.table(gutenberg_works(author == "Shakespeare, William") %>%
                                  filter(gutenberg_id >= 1500 & gutenberg_id <= 1541 & gutenberg_id != 1505 & gutenberg_id != 1525))

# Download plays

shake_plays <- as.data.table(gutenberg_download(shake_metadata$gutenberg_id, meta_fields = "title")) # 181,648 rows

shake_words <- unnest_tokens(shake_plays, word, text)


all_words <- shake_words[, .N, by = title]
setnames(all_words, "N", "total_words")
all_words[, type := ifelse(title %in% comedies, "Comedies", 
                           ifelse(title %in% histories, "Histories", 
                                  ifelse(title %in% tragedies, "Tragedies", "Problem plays")
                                  )
                           )]

all_type_words <- all_words[, sum(total_words), by = type]

shake_sentence <- unnest_tokens(shake_plays, sentence, text, token = "sentences", to_lower = FALSE)

shake_sentence <- shake_sentence[!grepl("^\\[", sentence) & !grepl("^[A-Z]{2,}", sentence)]

