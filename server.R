function(input, output, session) {
  
  word_in_plays <- reactive({
    word_in_plays <- shake_words[word == input$focus_word, .N, by = title][order(-N)]
  setnames(word_in_plays, "N", "focus_word_freq")
  return(word_in_plays)
  })
  
  # Total number of times the word is used
  
  output$word_total <- renderText({
    req(input$focus_word != "")
    paste0("Shakespeare used the word ", input$focus_word, " ",
      shake_words[word == input$focus_word, .N], " times in his plays.")
  })

# Find play that uses word most

output$word_frequency <- renderText({
  req(input$focus_word != "")
  req(input$focus_word %in% shake_words$word)
    paste0("The play that uses the word ", input$focus_word, " most often is ",
    word_in_plays()[, title][1], ", which uses it ", word_in_plays()[, focus_word_freq][1], " times.")
})


# Find play that proportionally uses word most

word_props <- reactive({
  req(input$focus_word != "")
  req(input$focus_word %in% shake_words$word)
  word_props <- merge(all_words, word_in_plays(), all.x = T)
  word_props <- word_props[is.na(focus_word_freq), focus_word_freq := 0]
  word_props <- word_props[, focus_word_prop := focus_word_freq/total_words*100][order(-focus_word_prop)]
  return(word_props)
})

output$word_proportional <- renderText({
  req(input$focus_word != "")
  req(input$focus_word %in% shake_words$word)
  paste0("The play in which the word ", input$focus_word, " is used most densely is ",
    word_props()[, title][1], ", which uses it ", 
    word_in_plays()[title == word_props()[, title][1], focus_word_freq], " times in its ",
  all_words[title == word_props()[, title][1], total_words], " words. ")
})


# Generate a random line using word

output$random_line <- renderText({
  req(input$focus_word != "")
  req(input$focus_word %in% shake_words$word)
  sentences_with_word <- shake_sentence[grepl(paste0("\\b", input$focus_word, "\\b"), sentence)]
  random_sentence <- paste0('"', sentences_with_word[sample(nrow(sentences_with_word), 1), sentence], '"\n- ',
                            sentences_with_word[sample(nrow(sentences_with_word), 1), title])
  return(random_sentence)
})

}