library("wordcloud")
library("tm")
library(httr)
library(twitteR)
api_key='254QuM8bwXiCq6MNYw65HlDCE'
api_secret='9ACTyUv4eeTd6WG1GidCHvxpr25mDHO3luKjnmTq4tuQfGjChQ'
access_token='2874875581-B6mI6oP6BsMNBgYLAoSopu7fDAioHw3MzWckJPB'
access_token_secret='pZ1dV20DZhNjqQX18dAOzxfumEQP8UpOw5lQOq10KU4h8'
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
tweets <- searchTwitter('#success', n=150) 
#tweets.df <- do.call(rbind, lapply(tweets, as.data.frame))
#write.csv(tweets.df, "/home/atom/workspace/r/...")
tweets.text <- sapply(tweets, function(x) x$getText())
tweets.text <- tolower(tweets.text)
tweets.text <- gsub("rt", "", tweets.text)
tweets.text <- gsub("@\\w+", "", tweets.text)
# Remove punctuation
tweets.text <- gsub("[[:punct:]]", "", tweets.text)
# Remove links
tweets.text <- gsub("http\\w+", "", tweets.text)
# Remove tabs
tweets.text <- gsub("[ |\t]{2,}", "", tweets.text)
# Remove blank spaces at the beginning
tweets.text <- gsub("^ ", "", tweets.text)
# Remove blank spaces at the end
tweets.text <- gsub(" $", "", tweets.text)
tweets.text.corpus <- Corpus(VectorSource(tweets.text))
#clean up by removing stop words
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x)removeWords(x,stopwords()))
#generate wordcloud
wordcloud(tweets.text.corpus,min.freq = 2, scale=c(7,0.5),colors=brewer.pal(8, "Dark2"),  random.color= TRUE, random.order = FALSE, max.words = 150)
