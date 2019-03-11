function(input, output, session) {
  
  focus_word <- reactive({tolower(input$focus_word)})
  
  word_in_plays <- reactive({
    word_in_plays <- shake_words[word == focus_word(), .N, by = title][order(-N)]
  setnames(word_in_plays, "N", "focus_word_freq")
  return(word_in_plays)
  })
  
  # Total number of times the word is used
  
  output$word_total <- renderUI({
    req(input$focus_word != "")
    HTML(paste0("<div id='mydiv'>", "Shakespeare used the word \"", input$focus_word, "\" ",
           "<f><font size = 5><b>", 
           prettyNum(shake_words[word == focus_word(), .N], big.mark = ","), "</f></font></b>",
           ifelse(shake_words[word == focus_word(), .N] == 1, " time", " times") , " in his plays.", "</div>")
    )
  })

# Find play that uses word most
  
top_plays <- reactive({
  top_plays <- copy(word_in_plays())[focus_word_freq == max(focus_word_freq), title]
  return(top_plays)
})

output$word_frequency <- renderUI({
  req(input$focus_word != "")
  req(focus_word() %in% shake_words$word)
  if(length(top_plays()) == 1) {
    HTML(paste0("<div id='mydiv'>", "The play that uses the word \"", input$focus_word, "\" most often is ",
                "<f><font size = 5><b>", top_plays(), "</f></font></b>", ", which uses it ", 
                "<f><font size = 5><b>", prettyNum(word_in_plays()[, focus_word_freq][1], big.mark = ","), 
                "</f></font></b>", ifelse(word_in_plays()[, focus_word_freq][1] == 1, " time.", " times.") , "</div")
    )
  } else {
    HTML(paste0("<div id='mydiv'>", "The plays that use the word \"", input$focus_word, "\" most often are ",
                "<f><font size = 5><b>", paste0(top_plays(), collapse = "</f></font></b> & <f><font size = 5><b>"), 
                "</f></font></b>", ", which use it ", 
                "<f><font size = 5><b>", prettyNum(word_in_plays()[, focus_word_freq][1], big.mark = ","), 
                "</f></font></b>", ifelse(word_in_plays()[, focus_word_freq][1] == 1, " time.", " times.") , "</div")
    )
  }
})

# Find play type that uses word most

focus_type <- reactive({
  word_in_type <- copy(word_in_plays())[, type := ifelse(title %in% comedies, "Comedies", 
                                                       ifelse(title %in% histories, "Histories", 
                                                              ifelse(title %in% tragedies, "Tragedies", "Problem plays")
                                                       )
  )]
  word_in_type <- word_in_type[, total := sum(focus_word_freq), by = type]
  word_in_type <- merge(word_in_type, all_type_words, by = "type")
  word_in_type <- word_in_type[, proportion := total/V1][order(-proportion)][1]
  return(word_in_type$type)
})


output$word_playtype <- renderUI({
  req(input$focus_word != "")
  req(focus_word() %in% shake_words$word)
  HTML(paste0("<div id='mydiv'>", "<f><font size = 5><b>", focus_type(), 
              "</f></font></b>", " most often use the word \"", input$focus_word, "\", relative to their total number of words.")
  )
})

# Generate a random line using word

output$random_line <- renderUI({
  req(input$focus_word != "")
  req(focus_word() %in% shake_words$word)
  sentences_with_word <- copy(shake_sentence)[grepl(paste0("\\b", input$focus_word, "\\b"), sentence, ignore.case = T)]
  select_sentence <- sentences_with_word[sample(nrow(sentences_with_word), 1)]
  random_sentence <- HTML(paste0('"', select_sentence[, sentence], "<br /><font size = 4> - ", select_sentence[, title]))
  return(random_sentence)
})

}

