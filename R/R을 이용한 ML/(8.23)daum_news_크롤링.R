
setwd("D:/workspace/PROJECT/R_project/")

# Crawling Package

install.packages('rvest')
library(rvest)
## rvest
### read_html()
### html_nodes()
### html_text()
### html_attr()

install.packages("stringr")
library(stringr)



title_css = "#mArticle .tit_thumb .link_txt"
press_time_css = ".info_news"
header_css = ".desc_thumb .link_txt"

base_url = "https://news.daum.net/breakingnews/?page="

TITLE = c()
PRESS = c()
TIME = c()
HEADER = c()


for (i in 1:5){
  news_url = paste0(base_url, i)
  
  hdoc = read_html(news_url, encoding ="euc_kr" )
  node_title = html_nodes(hdoc, title_css)
  node_press_time = html_nodes(hdoc, press_time_css)
  node_header = html_nodes(hdoc, header_css)
  
  title = html_text(node_title)
  press_time = html_text(node_press_time[1])
  header = html_text(node_header)
  
  time = str_sub(press_time, -5)
  press = str_sub(press_time, end=-9)
  
  headerA = gsub("\n", "", header)
  headerB = str_trim(headerA, side = 'both')
  
  
  TITLE = c(TITLE, title)
  PRESS = c(PRESS, press)
  TIME = c(TIME, time)
  HEADER = c(HEADER, headerB)
  
  
}

df_news = data.frame(TITLE, TIME, PRESS, HEADER)
colnames(df_news) = c("제목", "시간", "언론사", "기사")
news

write.csv(df_news, "daum_news.csv", sep="", row.names=FALSE)
