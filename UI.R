fluidPage(
  
  title = "Shakespearean words",
  
  headerPanel("Words in Shakespeare's plays"),
  br(),
  
  fluidRow(column(12, 
                  textInput("focus_word", "Which word do you want to know about?")
                  )
           ),
  hr(),
  fluidRow(column(12, 
                  textOutput("word_total"),
                  textOutput("word_frequency"),
                  textOutput("word_playtype")
                  )
           ),
  hr(),
  fluidRow(column(12, 
                  textOutput("random_line")
  )
  )
  
    )