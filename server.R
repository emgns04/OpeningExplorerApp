library(shiny)
library(bigchess)
library(dplyr)
library(varhandle)

shinyServer(function(input, output) {
  #defining the variables here so they are global
  chessGames <- NULL
  me <- NULL
  moveSequence <- NULL
  depth <- NULL
  columns <- NULL
  nextMove <- NULL
  gameData <- NULL

  
  
  #finds most common move tree. works recursively.
  pathSelect = function(columns, data) {
    if(length(columns) == 0) {
      return(data)
    }
    mostCommon = names(table(chessGames[columns[1]]) %>% sort(decreasing = TRUE))[1]
    filterbyCommon = data %>% filter(data[columns[1]] == mostCommon)
    pathSelect(columns[-1],filterbyCommon)
  }
  
  observeEvent(input$select, {print(paste("selected", input$select, "depth: ", depth))})
  
#  output$games = renderDataTable({
#    infile = input$file
#    chessGames <<- read.pgn(infile$datapath)
#    attach(chessGames)
#    me <<- names(table(White) %>% sort(decreasing = TRUE))[1]
#    depth <<- as.numeric(input$select)
#    columns <<- (10:(depth*2+10-1))
#    nextMove <<- depth*2+10
#    gameData <<- pathSelect(columns, chessGames)
#    moveSequence <<- gameData[columns] %>% unique %>% unfactor() %>% as.character()
   
    
#})
  
  output$barchart = renderPlot({
    
    infile = input$file
    chessGames <<- read.pgn(infile$datapath)
    attach(chessGames)
    me <<- names(table(White) %>% sort(decreasing = TRUE))[1]
    depth <<- as.numeric(input$select)
    columns <<- (10:(depth*2+10-1))
    nextMove <<- depth*2+10
    gameData <<- pathSelect(columns, chessGames)
    moveSequence <<- gameData[columns] %>% unique %>% unfactor() %>% as.character()
    
    return(barplot(table(gameData[,nextMove]), main = moveSequence))
    
  })
  
  
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({ paste("Move Depth:", input$select) })
  
})