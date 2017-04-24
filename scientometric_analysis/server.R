#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# libraries
library(shiny)
library(leaflet)
library(wordcloud)
library(RColorBrewer)
library(dplyr)

# datasets
data = read.csv("./dataset/Geocoded_final.csv")
words = read.csv("./dataset/TopWords_WithCounts.csv")

#ggplot way
#map = qmap(location = "world", zoom=5, source="osm")
#map <- get_map(location="world", source="osm", crop=FALSE)

# Define server logic required
shinyServer(function(input, output,session) {
   
  #points <- eventReactive(input$recalc, {
  #  cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  #}, ignoreNULL = FALSE)
  #points
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap.Mapnik
                      #,options = providerTileOptions(noWrap = TRUE) 
      ) %>%
      setView(lng = 0, lat = 37.45, zoom = 2)%>%
      addCircleMarkers(data =sapply(data[c("geo_longitude", "geo_latitude")], as.numeric), clusterOptions = markerClusterOptions())
  })
  
  output$wordCloud <- renderPlot({
    pal <- brewer.pal(9,"YlGnBu")
    wordcloud(words$words, words$count, min.freq= input$min_freq, max.words = input$max_words, colors=pal)
    
  }) # output$wordCloud 
    
  
  
  
  showZipcodePopup <- function(affiliation, lat, lng) {
    #selectedPaper <- data[allzips$zipcode == zipcode,]
    print(affiliation)
    content <- as.character(tagList(
      tags$h4("location:", affiliation)
      #tags$h4("Score:", as.integer(selectedZip$centile)),
      #tags$strong(HTML(sprintf("%s, %s %s",
      #                         selectedZip$city.x, selectedZip$state.x, selectedZip$zipcode
      #))), tags$br(),
      #sprintf("Median household income: %s", dollar(selectedZip$income * 1000)), tags$br(),
      #sprintf("Percent of adults with BA: %s%%", as.integer(selectedZip$college)), tags$br(),
      #sprintf("Adult population: %s", selectedZip$adultpop)
    ))
    leafletProxy("map") %>% addPopups(lng, lat, content, layerId = lng)
  }
  
  
  
  observe({
    leafletProxy("map") %>% clearPopups()
    event <- input$map_shape_click
    if (is.null(event))
      return()
    
    isolate({
      showZipcodePopup(event$affiliation, event$lat, event$lng)
    })
  })
  
  
  observe({
    if (is.null(input$goto))
      return()
    isolate({
      map <- leafletProxy("map")
      map %>% clearPopups()
      dist <- 0.5
      affiliation <- input$goto$affiliation
      lat <- input$goto$lat
      lng <- input$goto$lng
      print(affiliation)
      showZipcodePopup(affiliation, lat, lng)
      map %>% fitBounds(lng - dist, lat - dist, lng + dist, lat + dist)
    })
  })
  
  output$datatable <- DT::renderDataTable({
    df <- select(data, Authors, Title, Year, Affiliations.1, geo_latitude, geo_longitude  ) %>%
      
      mutate( Action = paste('<a class="go-map" href="" data-lat="', geo_latitude, '" data-long="', geo_longitude,  '" data-affiliation="', Affiliations.1,'">', "map",'</a>', sep=""))
    action <- DT::dataTableAjax(session, df)
    
    DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  })
  #output$geoplot <- renderPlot({
  #  tmap<-map + geom_point(data=data, aes(y=geo_latitude, x=geo_longitude))
  #  tmap
  #}) #geoplot
 # leaflet(sapply(data[c("geo_longitude", "geo_latitude")], as.numeric)) %>% addTiles() %>% addCircleMarkers()
  
})
