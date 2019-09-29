setwd('d:/RS_WP')
install.packages('rvest')
install.packages("stringr")
install.packages("KoNLP")
install.packages("wordcloud")
library(rvest)
library(stringr)

#네이버 금융 페이지 중 많이 본 뉴스 웹크롤링하기 19년 7월 1일부터 3일까지(페이지 1~10까지)
#참고 Minsub Won, suyeonii
main_url = 'https://finance.naver.com/news/news_list.nhn?mode=RANK'
date_url = '&date='
page_url = '&page='

news_list = character()
press_list = character()

trim = function(x)gsub("^\\s+|\\s+$", "", x)

for (d in 20190701:20190703){
  for(p in 1:10){
    
    news_url = paste(main_url, date_url, d, page_url, p,  sep="")
    content = read_html(news_url, encoding="euc-kr")
    
    node_1 = html_nodes(content, ".simpleNewsList a")
    node_2 = html_nodes(content, ".press")
    best_news = html_text(node_1)
    press = html_text(node_2)

  
    news_list = append(news_list, best_news)
    press_list = append(press_list, press)
    
    trim(news_list)
  }

}

news_url

df= data.frame(news_list, press_list)
colnames(df) = c("기사명", "언론사")

write.csv(df, "네이버금융많이본뉴스웹크롤링.csv", sep="", row.names=FALSE)

#Word Cloud 작업 부분

library(KoNLP)
library(wordcloud)
useSejongDic()


data1 = readLines("네이버금융많이본뉴스웹크롤링.csv")
data2 = sapply(data1, extractNoun,USE.NAMES = F)


head(unlist(data2), 30)
data3 = unlist(data2)
data3 = Filter(function(x) {nchar(x)>=2}, data3)

data3 = gsub("\\d", "", data3)
data3 = gsub("\\s", "", data3)
data3 = gsub("\\W", "", data3)
data3 = gsub("\\t", "", data3)
data3 = gsub("이데일리", "", data3)
data3 = gsub("파이낸셜", "", data3)
data3 = gsub("목표가", "", data3)
data3 = gsub("비즈니스", "", data3)
data3 = gsub("기사", "", data3)
data3 = gsub("언론사", "", data3)
data3 = gsub("투데이", "", data3)
data3 = gsub("증시", "", data3)
data3 = gsub("종목", "", data3)
data3 = gsub("마감", "", data3)
data3 = gsub("머니", "", data3)
data3 = gsub("매일", "", data3)
data3 = gsub("서울경제", "", data3)
data3 = gsub("경제", "", data3)
data3 = gsub("일보", "", data3)
data3 = gsub("SBS", "", data3)
data3 = gsub("시황", "", data3)
data3 = gsub("일서울경제", "", data3)
data3 = gsub("p", "", data3)
data3 = gsub("Q", "", data3)
data3 = gsub("G", "", data3)
data3 = gsub("p에", "", data3)
data3 = gsub("vs", "", data3)
data3 = gsub("뉴스", "", data3)
data3 = gsub("연합", "", data3)
data3 = gsub("현재", "", data3)
data3 = gsub("오늘", "", data3)
data3 = gsub("조선", "", data3)
data3 = gsub("출발", "", data3)
data3 = gsub("오후", "", data3)
data3 = gsub("에스", "", data3)
data3 = gsub("MBN", "", data3)
data3 = gsub("한국", "", data3)
data3 = gsub("코스", "", data3)
data3 = gsub("아시", "", data3)


write(unlist(data3), "naverfinancenews.txt")
data4 = read.table("naverfinancenews.txt")

data4
nrow(data4)
wordcount = table(data4)
wordcount
head(sort(wordcount, decreasing=T), 20)
data3 = gsub("한국경제", "", data3);data3

library(RColorBrewer)
palete = brewer.pal(9,"Set3")
wordcloud(names(wordcount), freq=wordcount, scale=c(5,1), rot.per=0.25, min.freq = 1, random.order = F, random.color = T, colors = palete)
legend(0.3, 1 , "네이버 금융 많이 본 뉴스 워드클라우드", cex=0.8, fill=NA, border=NA, bg="white", text.col="red", text.font=2, box.col="red")
