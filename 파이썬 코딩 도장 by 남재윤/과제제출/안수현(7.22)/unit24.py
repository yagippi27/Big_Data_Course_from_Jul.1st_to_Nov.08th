
##24.5 심사문제
# 변수입력
english = str(input())
print(english)

# 문장에서 단어로 쪼개기(x는 리스트형태)
x = english.split()
print(x)

#점이나 콤마 제거 및 검사
import string
count = 0
for i in range(len(x)):
    print(x[i].strip(string.punctuation + ' '))
    if x[i].strip(string.punctuation + ' ') == 'the':
        count += 1
print(count)


##24.6 심사문제
Price = list(map(int, input().split(';')))
print(type(Price))
#가격순대로 정렬하기
Price.sort(reverse = True)
print(Price)

#천 단위 콤마, 왼쪽 정렬
for i in range(len(Price)):
   x = '{0:>9,}'.format(Price[i])
   print(x)
