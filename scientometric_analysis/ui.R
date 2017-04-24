#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinythemes)
library(leaflet)


# Define UI for application that draws a histogram
#,theme = shinytheme("cosmo")
shinyUI(navbarPage("Scinetometric Analysis: interpreting domain", id="nav", collapsable = T,
  # Application title
  # titlePanel("Geospatial location of lead authors"),
    
  # Sidebar with a slider input for number of bins 
  
  tabPanel("Interactive map",
           # h4("GeoSpatial Location of Lead Authors"),
           div(class="outer",
               tags$head(
                 # Include our custom CSS
                 includeCSS("./static/style.css"),
                 includeScript("./static/gomap.js")
                  
               ),#tag$head
           leafletOutput("map", width="100%", height="100%")
           ) # div
  ), # tabPanel:Interactive map
  
  tabPanel("Topical Analysis",
           h4("WordCloud in Interpreting Journal"),
           verticalLayout(
             plotOutput("wordCloud"),
             p("World Cloud: Tweaks"),
             wellPanel(
               sliderInput("max_words", "Maximum number of words", min= 30, max = nrow(words), value = 50),
               sliderInput("min_freq", "Minimum Weight of words", min = 1, max= max(words$count), value=2)
             )    
           ) # verticalayout
                    
  ), #tabPanel: Topical Analysis
  tabPanel("Data explorer",

           
           hr(),
           DT::dataTableOutput("datatable")
  )
)) # navbar shiny UI


