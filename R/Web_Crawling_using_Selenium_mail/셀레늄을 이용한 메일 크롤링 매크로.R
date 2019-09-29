install.packages("RSelenium")
install.packages("rvest")
library(RSelenium)
library(rvest)
library(stringr)

trim <- function(x) gsub("^\\s+|\\s+$","", x)

remDr <- remoteDriver(remoteServerAddr="localhost", port=4445L, browserName="chrome")
remDr$open()

remDr$navigate("https://nid.naver.com/nidlogin.login")
# 셀레늄은 class와 id값밖에 찾지 못하기 때문에, 
# id 또는 class로 using값을 입력해야함.
txt_id <- remDr$findElement(using ="id", value = "id")
txt_pw <- remDr$findElement(using ="id", value = "pw")
login_btn <- remDr$findElement(using ="class", value = "btn_global")

txt_id$setElementAttribute("value", "hamelinlacam")
txt_pw$setElementAttribute("value", "yagippi27!@#")
login_btn$clickElement()

btn_upload <- remDr$findElement(using = "class", value = "btn_upload") #span class였음에도 불구하고 class로 받아들여졌음. 신기쓰
btn_upload$clickElement()
btn_maintain <- remDr$findElement(using = "class", value = "btn_maintain") #위와 상동
btn_maintain$clickElement()



remDr$navigate("https://mail.naver.com/")
mail_texts <- remDr$findElement(using = "id", value = "list_for_view") #div id여도 id가 됨

mail_texts
mail_texts <- mail_texts$getElementText()
tmp <- str_split(mail_texts, '\n') %>% .[[1]]

sender <- c()
subject <- c()
time <- c()
for (i in 1:20) {
  sender <- c(sender, tmp[4*i-3])
  subject <- c(subject, tmp[4*i-2])
  time <- c(time, tmp[4*i-1])
}

df_mail <- data.frame(sender=sender, subject=subject, time= time)
df_mail

remDr$close()
