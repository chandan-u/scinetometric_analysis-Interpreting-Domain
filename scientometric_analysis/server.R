#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

data = read.csv("./dataset/Geocoded_final.csv")
#ggplot way
#map = qmap(location = "world", zoom=5, source="osm")
#map <- get_map(location="world", source="osm", crop=FALSE)

# Define server logic required to draw a histogram
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
    
  #output$geoplot <- renderPlot({
  #  tmap<-map + geom_point(data=data, aes(y=geo_latitude, x=geo_longitude))
  #  tmap
  #}) #geoplot
 # leaflet(sapply(data[c("geo_longitude", "geo_latitude")], as.numeric)) %>% addTiles() %>% addCircleMarkers()
  
})
