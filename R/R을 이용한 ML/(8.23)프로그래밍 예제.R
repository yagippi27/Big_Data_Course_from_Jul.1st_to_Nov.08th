
## 프로그래밍 예제 01 ##
X = as.numeric(readline('insert number: '))
print(X)
Y = sqrt((X-1)*(X-3)^2* (X-5)^3)
print(Y)


## 프로그래밍 예제 02 ##

X = as.numeric(readline('insert number: '))
Y = as.numeric(readline('insert number: '))

if ((5<= log(X^Y, base = 10)) & (log(X^Y, base = 10)<=10)) {
  print("참입니다.")
} else {
  print('거짓입니다.')
}

## 프로그래밍 예제 03 ##

N = as.integer(readline("insert Positive integer: "))
while (N<=0){
  print('다시 N을 입력하세요.')
  N = as.integer(readline("insert Positive integer: "))
}

M = as.integer(readline("insert Positive integer: "))
while (M<=0){
  print('다시 M을 입력하세요.')
  M = as.integer(readline("insert Positive integer: "))
}

print(choose(N, M))

## 프로그래밍 예제 04 ##

N = as.integer(readline("insert integer: "))
if (N == 0){
  print('0')
} else if(N > 0){
  print(rep(1:N, 1:N))
} else{
  print(rep(-1:N, 1:-N))
}
