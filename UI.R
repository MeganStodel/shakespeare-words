fluidPage(
  
  theme = "shake_style.css",
  
  title = "Shakespearean words",
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Dancing%20Script');
      
      h1 {
        font-family: 'Dancing Script';
        font-weight: 500;
        line-height: 1.5;
        color: #7b694b;
      }

    "))
  ),
          
  headerPanel(h1("Words in Shakespeare's plays", align = "center")),
  br(),

  fluidRow(column(12, align = "center",
    textInput("focus_word", "Which word do you want to know about?")
  )
    ),
  hr(),
  textOutput("word_total"),
  textOutput("word_frequency"),
  textOutput("word_proportional"),
  hr(),
  textOutput("random_line")

)