function(input, output, session) {
  
  word_in_plays <- reactive({
    word_in_plays <- shake_words[word == input$focus_word, .N, by = title][order(-N)]
  setnames(word_in_plays, "N", "focus_word_freq")
  return(word_in_plays)
  })

# Find play that uses word most

output$word_frequency <- renderInfoBox({
  infoBox(
    title = paste0("Play that uses ", input$focus_word, " most often"),
    word_in_plays()[, title][1]
    )
})


# Find play that proportionally uses word most

output$word_proportional <- renderInfoBox({
  word_props <- merge(all_words, word_in_plays(), all.x = T)
  word_props <- word_props[is.na(focus_word_freq), focus_word_freq := 0]
  word_props <- word_props[, focus_word_prop := focus_word_freq/total_words*100][order(-focus_word_prop)]
  infoBox(
    title = paste0("Play in which ", input$focus_word, " is used most densely"),
    word_props[, title][1]
  )
})


# Generate a random line using word

output$random_line <- renderText({
  sentences_with_word <- shake_sentence[grepl(input$focus_word, sentence)]
  random_sentence <- sentences_with_word[sample(nrow(sentences_with_word), 1), sentence]
  return(random_sentence)
})

}