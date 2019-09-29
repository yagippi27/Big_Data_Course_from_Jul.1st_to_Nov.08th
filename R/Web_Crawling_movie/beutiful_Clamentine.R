library(rvest)
library(stringr)

url_Cl = 'https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=37886&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page='

trim <- function(x) gsub("^\\s+|\\s+$", "", x)



list_reply = character()
list_score = numeric()

for(url_page in 1:30){
  
  url_Clementine = paste(url_Cl, url_page, sep="")
  content2 = read_html(url_Clementine, encoding = "euc_kor")
  
  node_11 = html_nodes(content2, ".score_reple p")
  node_12 = html_nodes(content2, ".score_result .star_score em")
  
  reply = html_text(node_11)
  score = html_text(node_12)
  
  list_reply = append(list_reply, reply)
  list_score = append(list_score, score)
  trim(list_reply)
}

df_Cl = data.frame(list_reply, list_score)
colnames(df_Cl) = c('리뷰', '점수')


df_Cl

write.csv(df_Cl, "beutiful_Clamentine.csv", sep=" ", row.names = F)
