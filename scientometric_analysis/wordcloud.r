library(tm)

data = read.csv("./dataset/main.csv")
#corpus  <-Corpus(DirS, readerControl = list(blank.lines.skip=TRUE));

corpus <- tm_map(Corpus(VectorSource(data$Abstract)), removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument, language="english")
termsss <-DocumentTermMatrix(corpus,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))
