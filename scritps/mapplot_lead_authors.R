library("ggmap")
data = read.csv("dataset/geocoded_locations.csv", stringsAsFactors = TRUE)


names(data)

map = qmap(location = "world map", source="google", zoom=1)

map 

tmap<-map + geom_point(data=data[ data$geo_latitude != "ZERO_VALUES"], aes(y=geo_latitude, x=geo_longitude))
tmap
 