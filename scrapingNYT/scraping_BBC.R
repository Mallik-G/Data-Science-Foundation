require(lubridate)
require(plyr)
require(stringr)
require(XML)
require(RCurl)

url <- 'http://www.bbc.co.uk/search?q=obama&filter=news&suggid='
raw <-  getURL(url)#,encoding="UTF-8") 
PARSED <- htmlParse(raw) #Format the html code d
links<-xpathSApply(PARSED, "//a/@href")
length(links)

links<-xpathSApply(PARSED, '//ol[@class="search-results results"]//a/@href')
length(links)

length(unique(links))
links<-unique(links)

#Function to get links
getBBCLinks <- function(url){
  raw <-  getURL(url,encoding="UTF-8") 
  PARSED <- htmlParse(raw) #Format the html code d
  links<-unique(xpathSApply(PARSED, '//ol[@class="search-results results"]//a/@href'))
  return (links)
}

#Scrape BBC link with search for keywords Obama
url='http://www.bbc.co.uk/search?q=obama'
links <-getBBCLinks(url)
links

#Scrape BBC article newspaper
url <- "http://www.bbc.com/news/world-us-canada-34111860"
SOURCE <-  getURL(url,encoding="UTF-8") # Specify encoding when dealing with non-latin characters
PARSED <- htmlParse(SOURCE)
(xpathSApply(PARSED, "//h1[@class='story-body_h1']",xmlValue))
(xpathSApply(PARSED, "//span[@class='date']",xmlValue))

url <- "http://www.bbc.co.uk/news/world-europe-26333587"
SOURCE <-  getURL(url,encoding="UTF-8") # Specify encoding when dealing with non-latin characters
PARSED <- htmlParse(SOURCE)
(xpathSApply(PARSED, "//h1[@class='story-header']",xmlValue))
(xpathSApply(PARSED, "//span[@class='date']",xmlValue))

