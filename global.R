library(feather)
library(data.table)
library(tidytext)
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


# Download datasets

shake_plays <- as.data.table(read_feather("shake_plays.feather")) # 181,648 rows
shake_sentence <- as.data.table(read_feather("shake_sentence.feather"))
shake_words <- as.data.table(read_feather("shake_words.feather"))
all_words <- as.data.table(read_feather("all_words.feather"))
all_type_words <- as.data.table(read_feather("all_type_words.feather"))
