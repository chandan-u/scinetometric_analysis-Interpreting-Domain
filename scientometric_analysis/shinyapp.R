library(shiny)
library(wordcloud)
words = read.csv("./dataset/TopWords_WithCounts.csv")
droplist <<- list("Title" = "title",
                  "Author" = "author"
)
ui <- fluidPage(
  # Application title
  titlePanel("Word Cloud"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      
      
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 2,  max = 2610, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 2,  max = 500,  value = 100)
    ),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$freq
    # ...but not for anything else
    #isolate({
    # withProgress({
    #  setProgress(message = "Processing corpus...")
    # getTermMatrix(input$selection)
    #})
  })
  
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(words$words, words$count, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}

shinyApp(ui = ui, server = server)