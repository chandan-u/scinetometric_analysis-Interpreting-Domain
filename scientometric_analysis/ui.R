#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(navbarPage("Scinetometric Analysis: interpreting domain", id="nav",
  
  # Application title
  #titlePanel("Geospatial location of lead authors"),
    
  # Sidebar with a slider input for number of bins 
  
  tabPanel("Interactive map",
           div(class="outer",
               
               tags$head(
                 # Include our custom CSS
                 includeCSS("./static/style.css")
                  
               ),#tag$head
           leafletOutput("map", width="100%", height="100%")
           )
    #actionButton("recalc", "New points")
  )#tabPanel:Interactive map
  
))
