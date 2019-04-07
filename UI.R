fluidPage(
  
  title = "Shakespearean words",
  
  headerPanel(h1("Words in Shakespeare's plays", align = "center")),
  br(),
  
  fluidRow(column(12, align = "center",
                  textInput("focus_word", "Which word do you want to know about?")
                  )
           ),
  hr(),
  fluidRow(column(12, align = "center",
                  textOutput("word_total"),
                  textOutput("word_frequency"),
                  textOutput("word_playtype")
                  )
           ),
  hr(),
  fluidRow(column(12, align = "center",
                  textOutput("random_line")
  )
  )
  
    )