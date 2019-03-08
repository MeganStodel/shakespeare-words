fluidPage(
  title = "Words in Shakespeare's plays",

  textInput("focus_word", "Which word do you want to know about?"),
  hr(),
  textOutput("word_total"),
  textOutput("word_frequency"),
  textOutput("word_proportional"),
  hr(),
  textOutput("random_line")

)