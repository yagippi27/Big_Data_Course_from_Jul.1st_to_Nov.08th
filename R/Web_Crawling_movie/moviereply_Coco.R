
install.packages("extrafont")
install.packages("wordcloud2")

library(rvest)
library(stringr)
library(dplyr)
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(extrafont)
library(wordcloud2)
useSejongDic()


font_import()
y

trim <- function(x) gsub("^\\s+|\\s+$", "", x)

#네이버 영화 페이지에 영화 코코 리뷰 크롤링

url_main1 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=151728&type=after&onlyActualPointYn=N&order=newest&page="

list_reply1 = character()
list_score1 = numeric()
list_replytime1 = numeric()
  
  
for(url_page1 in 1:600){
    url_Coco = paste(url_main1, url_page1, sep = "")
    content = read_html(url_Coco, encoding = "euc_kr")
   
    
    node_1 = html_nodes(content, ".score_reple p")
    node_2 = html_nodes(content, ".score_result .star_score em")
    node_3 = html_nodes(content, ".score_reple em" )


    reply1 = html_text(node_1)
    score1 = html_text(node_2)
    reply_time1 = html_text(node_3[2])
    
    list_reply1 = append(list_reply1, reply1)
    list_score1 = append(list_score1, score1)
    list_replytime1 = append(list_replytime1, reply_time1)
    
    trim( c(list_reply1, list_score1, list_replytime1))
    }

df_Coco = data.frame(list_reply1, list_score1, list_replytime1)
colnames(df_Coco) = c("리뷰", "점수", "응답한 시간")

df_Coco

write.csv(df_Coco, "코코영화리뷰.csv", sep="", row.names=FALSE)

#WordCloud 작업

data1 = readLines('코코영화리뷰.csv')
data2 = sapply(data1, extractNoun, USE.NAMES = F)
head(unlist(data2), 30)

data3 = unlist(data2)
data3 = Filter(function(y) {nchar(y)>=2}, data3)

data3 = gsub("\\d","", data3)
data3 = gsub("\\s","", data3)
data3 = gsub("\\W","", data3)
data3 = gsub("\\t","", data3)
data3 = gsub("[A-Z]", "", data3)
data3 = gsub("[a-z]", "", data3)
data3 = gsub("영화", "", data3)
data3 = gsub("관람객", "", data3)
data3 = gsub("들이", "", data3)
data3 = gsub("애니", "", data3)
data3 = gsub("애니메이션", "", data3)
data3 = gsub("에니", "", data3)
data3 = gsub("에니메이션", "", data3)
data3 = gsub("메이션","", data3)
data3 = gsub("극장", "", data3)
data3 = gsub("상영관", "", data3)
data3 = gsub("관람", "", data3)
data3 = gsub("더빙", "", data3)
data3 = gsub("평점", "", data3)


data3

write(unlist(data3), "movie_coco.txt")
data4 = read.table("movie_coco.txt")             

nrow(data4)

wordcount1 = table(data4)
wordcount1 = head(sort(wordcount1, decreasing = T), 200)
wordcount1


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')

#내가 분석 하고 싶은 것. 
#1. 리뷰 갯수 -> 얼마나 많은 사람들이 올렸나. 시간이 갈 수록 리뷰가 올라가는 갯수의 모양(점점더 증가하는가? 감소하는가?)
# 3개의 애니메이션 비교? (장편 애니메이션상 수상작 비교 픽사->코코(2018), 디즈니-> 주토피아(2017), 소니픽쳐스->스파이더맨: 뉴 유니버스(2019))


#주토피아

url_main2 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=130850&type=after&onlyActualPointYn=N&order=newest&page="


list_reply2 = character()
list_score2 = numeric()
list_replytime2 = numeric()


for(url_page2 in 1:600){
  url_Zootopia = paste(url_main2, url_page2, sep = "")
  content = read_html(url_Zootopia, encoding = "euc_kr")
  
  
  node_11 = html_nodes(content, ".score_reple p")
  node_12 = html_nodes(content, ".score_result .star_score em")
  node_13 = html_nodes(content, ".score_reple em" )
  
  
  reply2 = html_text(node_11)
  score2 = html_text(node_12)
  reply_time2 = html_text(node_13[2])
  
  list_reply2 = append(list_reply2, reply2)
  list_score2 = append(list_score2, score2)
  list_replytime2 = append(list_replytime2, reply_time2)
  
  trim( c(list_reply2, list_score2, list_replytime2))
}

df_Zootopia = data.frame(list_reply2, list_score2, list_replytime2)
colnames(df_Zootopia) = c("리뷰", "점수", "응답한 시간")

df_Zootopia

write.csv(df_Zootopia, "쥬토피아영화리뷰.csv", sep="", row.names=FALSE)

#WordCloud 작업

data11 = readLines('쥬토피아영화리뷰.csv')
data12 = sapply(data11, extractNoun, USE.NAMES = F)
head(unlist(data12), 30)

data13 = unlist(data12)
data13 = Filter(function(y) {nchar(y)>=2}, data13)

data13 = gsub("\\d","", data13)
data13 = gsub("\\s","", data13)
data13 = gsub("\\W","", data13)
data13 = gsub("\\t","", data13)
data13 = gsub("[A-Z]", "", data13)
data13 = gsub("[a-z]", "", data13)
data13 = gsub("영화", "", data13)
data13 = gsub("관람객", "", data13)
data13 = gsub("들이", "", data13)
data13 = gsub("애니", "", data13)
data13 = gsub("애니메이션", "", data13)
data13 = gsub("에니", "", data13)
data13 = gsub("에니메이션", "", data13)
data13 = gsub("메이션","", data13)
data13 = gsub("극장", "", data13)
data13 = gsub("상영관", "", data13)
data13 = gsub("관람", "", data13)
data13 = gsub("더빙", "", data13)
data13 = gsub("평점", "", data13)


data13

write(unlist(data13), "movie_Zootopia.txt")
data14 = read.table("movie_Zootopia.txt")             

nrow(data14)

wordcount2 = table(data14)
wordcount2 = head(sort(wordcount2, decreasing = T), 200)
wordcount2


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount2 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')

#스파이더맨:뉴유니버스

url_main3 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=173123&type=after&onlyActualPointYn=N&order=newest&page="


list_reply3 = character()
list_score3 = numeric()
list_replytime3 = numeric()


for(url_page3 in 1:600){
  url_Spiderman = paste(url_main3, url_page3, sep = "")
  content = read_html(url_Spiderman, encoding = "euc_kr")
  
  
  node_21 = html_nodes(content, ".score_reple p")
  node_22 = html_nodes(content, ".score_result .star_score em")
  node_23 = html_nodes(content, ".score_reple em" )
  
  
  reply3 = html_text(node_21)
  score3 = html_text(node_22)
  reply_time3 = html_text(node_23[2])
  
  list_reply3 = append(list_reply3, reply3)
  list_score3 = append(list_score3, score3)
  list_replytime3 = append(list_replytime3, reply_time3)
  
  trim( c(list_reply3, list_score3, list_replytime3))
}

df_Spiderman = data.frame(list_reply3, list_score3, list_replytime3)
colnames(df_Spiderman) = c("리뷰", "점수", "응답한 시간")

df_Spiderman

write.csv(df_Spiderman, "스파이더맨영화리뷰.csv", sep="", row.names=FALSE)

#WordCloud 작업

data21 = readLines('스파이더맨영화리뷰.csv')
data22 = sapply(data21, extractNoun, USE.NAMES = F)
head(unlist(data22), 30)

data23 = unlist(data22)
data23 = Filter(function(y) {nchar(y)>=2}, data23)

data23 = gsub("\\d","", data23)
data23 = gsub("\\s","", data23)
data23 = gsub("\\W","", data23)
data23 = gsub("\\t","", data23)
data23 = gsub("[A-Z]", "", data23)
data23 = gsub("[a-z]", "", data23)
data23 = gsub("영화", "", data23)
data23 = gsub("관람객", "", data23)
data23 = gsub("들이", "", data23)
data23 = gsub("애니", "", data23)
data23 = gsub("애니메이션", "", data23)
data23 = gsub("에니", "", data23)
data23 = gsub("에니메이션", "", data23)
data23 = gsub("메이션","", data23)
data23 = gsub("극장", "", data23)
data23 = gsub("상영관", "", data23)
data23 = gsub("관람", "", data23)
data23 = gsub("더빙", "", data23)
data23 = gsub("평점", "", data23)


data23

write(unlist(data23), "movie_Spiderman.txt")
data24 = read.table("movie_Spiderman.txt")             

nrow(data24)

wordcount3 = table(data24)
wordcount3 = head(sort(wordcount3, decreasing = T), 200)
wordcount3


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount3 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')

