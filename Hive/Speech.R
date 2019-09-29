library(wordcloud)
library(tm)
library(xlsx)
library(dplyr)
library(wordcloud2)

##### xlsx를 이용해 각각의 데이터 프레임 만들기 #####
file_trump = read.xlsx2('C:/Users/709-01/Desktop/WordCount_raw.xlsx', 1, colIndex = 1:2)
head(file_trump, 10)
file_tony = read.xlsx2('C:/Users/709-01/Desktop/WordCount_raw.xlsx', 1, colIndex = 3:4)
head(file_tony, 10)
file_roosevelt = read.xlsx2('C:/Users/709-01/Desktop/WordCount_raw.xlsx', 1, colIndex = 5:6)
head(file_roosevelt, 10)
file_obama = read.xlsx2('C:/Users/709-01/Desktop/WordCount_raw.xlsx', 1, colIndex = 7:8)
head(file_obama, 10)
file_nixon = read.xlsx2('C:/Users/709-01/Desktop/WordCount_raw.xlsx', 1, colIndex = 9:10)
head(file_nixon, 10)


##### 데이터 프레임 빈칸 제거하기 #####
file_trump = file_trump[!(is.na(file_trump$trump_count)|file_trump$trump_count==""), ]
head(file_trump, 10)
file_tony = file_tony[!(is.na(file_tony$Tony_count)|file_tony$Tony_count==""), ]
head(file_tony, 10)
file_roosevelt = file_roosevelt[!(is.na(file_roosevelt$roosevelt_count)|file_roosevelt$roosevelt_count==""), ]
head(file_roosevelt, 10)
file_obama = file_obama[!(is.na(file_obama$obama_count)|file_obama$obama_count==""), ]
head(file_obama, 10)
file_nixon = file_nixon[!(is.na(file_nixon$nixon_count)|file_nixon$nixon_count==""), ]
head(file_nixon, 10)

##### 두번 이상 사용된 단어만 뽑기 #####
trump = filter(file_trump, trump_count!=1)
tony = filter(file_tony, Tony_count!=1)
head(tony,30)
roosevelt = filter(file_roosevelt, roosevelt_count!=1)
obama = filter(file_obama, obama_count!=1)
nixon = filter(file_nixon, nixon_count!=1)

##### 관사, be동사, 전치사, 일부 대명사, 접속사 기타 등등 제거 #####
rm_trump = trump[!(trump$trump_word=="The"|trump$trump_word=="the"|trump$trump_word=="a"|trump$trump_word=="A"|trump$trump_word=="an"
                   |trump$trump_word=="is"|trump$trump_word=="are"|trump$trump_word=="am"|trump$trump_word=="be"|trump$trump_word=="been"|trump$trump_word=="was"
                   |trump$trump_word=="at"|trump$trump_word=="by"|trump$trump_word=="in"|trump$trump_word=="on"|trump$trump_word=="to"
                   |trump$trump_word=="with"|trump$trump_word=="within"|trump$trump_word=="onto"|trump$trump_word=="of"|trump$trump_word=="for"
                   |trump$trump_word=="from"|trump$trump_word=="up"|trump$trump_word=="For"|trump$trump_word=="In"
                   |trump$trump_word=="and"|trump$trump_word=="And"|trump$trump_word=="but"|trump$trump_word=="But"|trump$trump_word=="so"
                   |trump$trump_word=="as"|trump$trump_word=="or"|trump$trump_word=="because"|trump$trump_word=="As"
                   |trump$trump_word=="this"|trump$trump_word=="that"|trump$trump_word=="those"|trump$trump_word=="--"|trump$trump_word=="there"
                   |trump$trump_word=="This"|trump$trump_word=="these"), ]
head(rm_trump,30)
rm_tony = tony[!(tony$Tony_word=="The"|tony$Tony_word=="the"|tony$Tony_word=="a"|tony$Tony_word=="A"|tony$Tony_word=="an"
                 |tony$Tony_word=="is"|tony$Tony_word=="are"|tony$Tony_word=="am"|tony$Tony_word=="be"|tony$Tony_word=="been"|tony$Tony_word=="was"
                 |tony$Tony_word=="at"|tony$Tony_word=="by"|tony$Tony_word=="in"|tony$Tony_word=="on"|tony$Tony_word=="to"
                 |tony$Tony_word=="with"|tony$Tony_word=="within"|tony$Tony_word=="onto"|tony$Tony_word=="of"|tony$Tony_word=="for"
                 |tony$Tony_word=="from"|tony$Tony_word=="up"|tony$Tony_word=="For"|tony$Tony_word=="In"
                 |tony$Tony_word=="and"|tony$Tony_word=="And"|tony$Tony_word=="but"|tony$Tony_word=="But"|tony$Tony_word=="so"
                 |tony$Tony_word=="as"|tony$Tony_word=="or"|tony$Tony_word=="because"|tony$Tony_word=="As"
                 |tony$Tony_word=="this"|tony$Tony_word=="that"|tony$Tony_word=="those"|tony$Tony_word=="--"|tony$Tony_word=="there"
                 |tony$Tony_word=="This"|tony$Tony_word=="these"), ]
head(rm_tony,30)
rm_roosevelt = roosevelt[!(roosevelt$roosevelt_word=="The"|roosevelt$roosevelt_word=="the"|roosevelt$roosevelt_word=="a"|roosevelt$roosevelt_word=="A"|roosevelt$roosevelt_word=="an"
                           |roosevelt$roosevelt_word=="is"|roosevelt$roosevelt_word=="are"|roosevelt$roosevelt_word=="am"|roosevelt$roosevelt_word=="be"|roosevelt$roosevelt_word=="been"|roosevelt$roosevelt_word=="was"
                           |roosevelt$roosevelt_word=="at"|roosevelt$roosevelt_word=="by"|roosevelt$roosevelt_word=="in"|roosevelt$roosevelt_word=="on"|roosevelt$roosevelt_word=="to"
                           |roosevelt$roosevelt_word=="with"|roosevelt$roosevelt_word=="within"|roosevelt$roosevelt_word=="onto"|roosevelt$roosevelt_word=="of"|roosevelt$roosevelt_word=="for"
                           |roosevelt$roosevelt_word=="from"|roosevelt$roosevelt_word=="up"|roosevelt$roosevelt_word=="For"|roosevelt$roosevelt_word=="In"
                           |roosevelt$roosevelt_word=="and"|roosevelt$roosevelt_word=="And"|roosevelt$roosevelt_word=="but"|roosevelt$roosevelt_word=="But"|roosevelt$roosevelt_word=="so"
                           |roosevelt$roosevelt_word=="as"|roosevelt$roosevelt_word=="or"|roosevelt$roosevelt_word=="because"|roosevelt$roosevelt_word=="As"
                           |roosevelt$roosevelt_word=="this"|roosevelt$roosevelt_word=="that"|roosevelt$roosevelt_word=="those"|roosevelt$roosevelt_word=="--"|roosevelt$roosevelt_word=="there"
                           |roosevelt$roosevelt_word=="This"|roosevelt$roosevelt_word=="these"), ]
head(rm_roosevelt,30)
rm_obama = obama[!(obama$obama_word=="The"|obama$obama_word=="the"|obama$obama_word=="a"|obama$obama_word=="A"|obama$obama_word=="an"
                   |obama$obama_word=="is"|obama$obama_word=="are"|obama$obama_word=="am"|obama$obama_word=="be"|obama$obama_word=="been"|obama$obama_word=="was"
                   |obama$obama_word=="at"|obama$obama_word=="by"|obama$obama_word=="in"|obama$obama_word=="on"|obama$obama_word=="to"
                   |obama$obama_word=="with"|obama$obama_word=="within"|obama$obama_word=="onto"|obama$obama_word=="of"|obama$obama_word=="for"
                   |obama$obama_word=="from"|obama$obama_word=="up"|obama$obama_word=="For"|obama$obama_word=="In"
                   |obama$obama_word=="and"|obama$obama_word=="And"|obama$obama_word=="but"|obama$obama_word=="But"|obama$obama_word=="so"
                   |obama$obama_word=="as"|obama$obama_word=="or"|obama$obama_word=="because"|obama$obama_word=="As"
                   |obama$obama_word=="this"|obama$obama_word=="that"|obama$obama_word=="those"|obama$obama_word=="--"|obama$obama_word=="there"
                   |obama$obama_word=="This"|obama$obama_word=="these"), ]
head(rm_obama,30)
rm_nixon = nixon[!(nixon$nixon_word=="The"|nixon$nixon_word=="the"|nixon$nixon_word=="a"|nixon$nixon_word=="A"|nixon$nixon_word=="an"
                   |nixon$nixon_word=="is"|nixon$nixon_word=="are"|nixon$nixon_word=="am"|nixon$nixon_word=="be"|nixon$nixon_word=="been"|nixon$nixon_word=="was"
                   |nixon$nixon_word=="at"|nixon$nixon_word=="by"|nixon$nixon_word=="in"|nixon$nixon_word=="on"|nixon$nixon_word=="to"
                   |nixon$nixon_word=="with"|nixon$nixon_word=="within"|nixon$nixon_word=="onto"|nixon$nixon_word=="of"|nixon$nixon_word=="for"
                   |nixon$nixon_word=="from"|nixon$nixon_word=="up"|nixon$nixon_word=="For"|nixon$nixon_word=="In"
                   |nixon$nixon_word=="and"|nixon$nixon_word=="And"|nixon$nixon_word=="but"|nixon$nixon_word=="But"|nixon$nixon_word=="so"
                   |nixon$nixon_word=="as"|nixon$nixon_word=="or"|nixon$nixon_word=="because"|nixon$nixon_word=="As"
                   |nixon$nixon_word=="this"|nixon$nixon_word=="that"|nixon$nixon_word=="those"|nixon$nixon_word=="--"|nixon$nixon_word=="there"
                   |nixon$nixon_word=="This"|nixon$nixon_word=="these"), ]
head(rm_nixon,30)

##### 워드 클라우드 #####
library(wordcloud2)
wordcloud2(data.frame(word=rm_trump$trump_word, freq=as.numeric(rm_trump$trump_count)),  
           color = "random-light", backgroundColor = "black", shape="cloud")
wordcloud2(data.frame(word=rm_tony$Tony_word, freq=as.numeric(rm_tony$Tony_count)),  
           color = "random-light", backgroundColor = "black", shape="cloud")
wordcloud2(data.frame(word=rm_roosevelt$roosevelt_word, freq=as.numeric(rm_roosevelt$roosevelt_count)),  
           color = "random-light", backgroundColor = "black", shape="cloud")
wordcloud2(data.frame(word=rm_obama$obama_word, freq=as.numeric(rm_obama$obama_count)),  
           color = "random-light", backgroundColor = "black", shape="cloud")
wordcloud2(data.frame(word=rm_nixon$nixon_word, freq=as.numeric(rm_nixon$nixon_count)),  
           color = "random-light", backgroundColor = "black", shape="cloud")

