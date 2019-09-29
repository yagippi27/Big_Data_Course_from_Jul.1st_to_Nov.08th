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

#네이버 댓글 최신순 정렬을 하여 1페이지부터 봄

#영화 코코(2018.01.11) 네이버 영화 크롤링

url_main1 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=151728&type=after&onlyActualPointYn=N&order=newest&page="

list_reply1 = character()
list_score1 = numeric()
list_replytime1 = numeric()


for(url_page1 in 1:500){
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

write.csv(df_Coco, "코코_리뷰.csv", sep="", row.names=FALSE)

#평균 작업

mean(as.numeric(list_score1))

#WordCloud 작업

data1 = readLines('코코_리뷰.csv')
data2 = sapply(data1, extractNoun, USE.NAMES = F)
head(unlist(data2), 30)

data3 = unlist(data2)
data3 = Filter(function(a) {nchar(a)>=2}, data3)

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


data3 = gsub("하게", "", data3)
data3 = gsub("픽사는", "픽사", data3)
data3 = gsub("리멤버", "리멤버미", data3)
data3 = gsub("뭔가", "", data3)

write(unlist(data3), "movie_coco.txt")
data4 = read.table("movie_coco.txt")             

nrow(data4)

wordcount1 = table(data4)
wordcount1 = head(sort(wordcount1, decreasing = T), 200)
wordcount1


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount1 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')



# 보스 베이비(2017.05.03 개봉) 네이버 영화 크롤링

url_main2 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=129094&type=after&onlyActualPointYn=N&order=newest&page="

list_reply2 = character()
list_score11 = numeric()
list_replytime2 = numeric()


for(url_page2 in 1:500){
  url_Bossbaby = paste(url_main2, url_page2, sep = "")
  content = read_html(url_Bossbaby, encoding = "euc_kr")
  
  
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

df_Bossbay = data.frame(list_reply2, list_score2, list_replytime2)
colnames(df_Bossbay) = c("리뷰", "점수", "응답한 시간")

df_Bossbay

write.csv(df_Bossbay, "보스베이비_리뷰.csv", sep="", row.names=FALSE)

#평균작업

mean(as.numeric(list_score2))



#WordCloud 작업

data11 = readLines('보스베이비_리뷰.csv')
data12 = sapply(data11, extractNoun, USE.NAMES = F)
head(unlist(data12), 30)

data13 = unlist(data12)
data13 = Filter(function(b) {nchar(b)>=2}, data13)

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

write(unlist(data13), "movie_bossbaby.txt")
data14 = read.table("movie_bossbaby.txt")             

nrow(data14)

wordcount2 = table(data14)
wordcount2 = head(sort(wordcount2, decreasing = T), 200)
wordcount2


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount2 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')


#러빙 빈센트(2017.11.09 개봉, 2018.12.13 재개봉) 네이버 영화 크로링 

url_main3 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=144379&type=after&onlyActualPointYn=N&order=newest&page="

list_reply3 = character()
list_score3 = numeric()
list_replytime3 = numeric()


for(url_page3 in 1:500){
  url_Vincent = paste(url_main3, url_page3, sep = "")
  content = read_html(url_Vincent, encoding = "euc_kr")
  
  
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

df_Vincent = data.frame(list_reply3, list_score3, list_replytime3)
colnames(df_Vincent) = c("리뷰", "점수", "응답한 시간")


write.csv(df_Vincentm, "러빙빈센트_리뷰.csv", sep="", row.names=FALSE)


#평균작업 


mean(as.numeric(list_score3))

#WordCloud 작업

data21 = readLines('러빙빈센트_리뷰.csv')
data22 = sapply(data21, extractNoun, USE.NAMES = F)
head(unlist(data22), 30)

data23 = unlist(data22)
data23 = Filter(function(c) {nchar(c)>=2}, data23)

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

write(unlist(data23), "movie_vincent.txt")
data24 = read.table("movie_vincent.txt")             

nrow(data24)

wordcount3 = table(data24)
wordcount3 = head(sort(wordcount3, decreasing = T), 200)
wordcount3


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount3 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')


#페르디난드(2018.01.03) 네이버 영화 크롤링


url_main4 = "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=160491&type=after&onlyActualPointYn=N&order=newest&page="

list_reply4 = character()
list_score4 = numeric()
list_replytime4 = numeric()


for(url_page4 in 1:110){
  url_Ferdinand = paste(url_main4, url_page4, sep = "")
  content = read_html(url_Ferdinand, encoding = "euc_kr")
  
  
  node_31 = html_nodes(content, ".score_reple p")
  node_32 = html_nodes(content, ".score_result .star_score em")
  node_33 = html_nodes(content, ".score_reple em" )
  
  
  reply4 = html_text(node_31)
  score4 = html_text(node_32)
  reply_time4 = html_text(node_33[2])
  
  list_reply4 = append(list_reply4, reply4)
  list_score4 = append(list_score4, score4)
  list_replytime4 = append(list_replytime4, reply_time4)
  
  trim( c(list_reply4, list_score4, list_replytime4))
}

df_Ferdinand = data.frame(list_reply4, list_score4, list_replytime4)
colnames(df_Ferdinand) = c("리뷰", "점수", "응답한 시간")

df_Ferdinand

write.csv(df_Ferdinand, "페르디난드_리뷰.csv", sep="", row.names=FALSE)


# 평균 작업


mean(as.numeric(list_score4))



#WordCloud 작업

data31 = readLines('페르디난드_리뷰.csv')
data32 = sapply(data31, extractNoun, USE.NAMES = F)
head(unlist(data32), 30)

data33 = unlist(data32)
data33 = Filter(function(d) {nchar(d)>=2}, data33)

data33 = gsub("\\d","", data33)
data33 = gsub("\\s","", data33)
data33 = gsub("\\W","", data33)
data33 = gsub("\\t","", data33)
data33 = gsub("[A-Z]", "", data33)
data33 = gsub("[a-z]", "", data33)
data33 = gsub("영화", "", data33)
data33 = gsub("관람객", "", data33)
data33 = gsub("들이", "", data33)
data33 = gsub("애니", "", data33)
data33 = gsub("애니메이션", "", data33)
data33 = gsub("에니", "", data33)
data33 = gsub("에니메이션", "", data33)
data33 = gsub("메이션","", data33)
data33 = gsub("극장", "", data33)
data33 = gsub("상영관", "", data33)
data33 = gsub("관람", "", data33)
data33 = gsub("더빙", "", data33)
data33 = gsub("평점", "", data33)


data33

write(unlist(data33), "movie_ferdinand.txt")
data34 = read.table("movie_ferdinand.txt")             

nrow(data34)

wordcount4 = table(data34)
wordcount4 = head(sort(wordcount4, decreasing = T), 200)
wordcount4


windowsFonts(malgun=windowsFont("맑은 고딕"))

wordcloud2(data = wordcount4 , size = 0.5, color= "random-light", backgroundColor = "dark", fontFamily = "맑은 고딕", shape = 'cardioid')

