library(shiny)

fluidPage(
  
  titlePanel("Chess Opening Explorer"),
  # Copy the line below to make a select box 
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Choose PGN file", accept = c(".pgn"))
    ),
    mainPanel(
      tableOutput("contents"),
      plotOutput("barchart")
      )
    ),
  
  
  
  selectInput("select", label = h3("Select Move Depth"), 
              choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4,
                             "5" = 5, "6" = 6, "7" = 7, "8" = 8,
                             "9" = 9, "10" = 10), 
              selected = 1),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"))),
  textOutput("games")
)