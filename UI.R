fluidPage(
  
  title = "Shakespearean words",
  
  headerPanel("Words in Shakespeare's plays"),
  br(),
  textInput("focus_word", "Which word do you want to know about?"),
  hr(),
  textOutput("word_total"),
  textOutput("word_frequency"),
  textOutput("word_playtype"),
  hr(),
  textOutput("random_line")
    )