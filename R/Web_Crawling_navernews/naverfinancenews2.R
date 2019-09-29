library(rvest)
library(stringr)
library(dplyr)

trim <- function(x) gsub("^\\s+|\\s+$", "", x)

url <- 'https://finance.naver.com/news/news_list.nhn?mode=RANK&page='

page <- read_html(url, encoding="euc-kr")
page
page2 <- html_nodes(page, 'body div#wrap div#newarea div#contentarea div#contentarea_left div ul li ul.simpleNewsList li a')
page2
page3 <- html_attr(page2, 'title')
page3
page4 <- data.frame(page3)
page4
page5 = list()
for (i in 1:4) {
  url <- paste('https://finance.naver.com/news/news_list.nhn?mode=RANK&page=', i, sep='')
  page5[[i]] <- read_html(url, encoding='euc-kr') %>% 
    html_nodes('body div#wrap div#newarea div#contentarea div#contentarea_left div ul li ul.simpleNewsList li a') %>% 
    html_attr('title')
}
page5
write.table(unlist(page5), 'data.txt')
