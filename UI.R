body <- dashboardBody(

  textInput("focus_word", "The most lamentable tragedy of "),
  infoBoxOutput("word_frequency"),
  infoBoxOutput("word_proportional"),
  textOutput("random_line")
  
)

dashboardPage(
  dashboardHeader(title = "Words in Shakespeare"),
  dashboardSidebar(),
  body
)