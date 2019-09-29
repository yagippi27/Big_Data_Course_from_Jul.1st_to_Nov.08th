# 참고: x 대신에 i 값을 넣어야함
# x = [49,-17,25,102,8,62,21]
# for i in x:
#    print(i*10, end=" ")
#ⓒnot x instead of i

# 참고: 주사위 돌리기
# i = 0
# while i != 3:
#    i = random.randint(1,6)
#    print(i)

# 참고: i하고 j가 while 조건문에
# 맞는 값이 되기 전까지 실행한다는 것을 알아두기
# i = 2
# j = 5
# while i<=33 or j>=1:
#    print (i, j)
#    i *= 2
#    j -= 1

# 참고: 주사위 2개를 던저 10이상이 될 때 그만두는 값과 횟수 알아보기
# import random as rd

# count = 0
#ⓒ while 문을 통해 값을 올리고자 하면
# 전에 0이나 1같은 고정 값을 만들어 줘야함
# while True:
#    dice1 = rd.randint(1,6)
#    dice2 = rd.randint(1,6)
#    print(dice1, dice2)
#    count += 1
#    if dice1 + dice2 >= 10:
#        break
# print(count)

# 참고: 별 만들기
#계단식
#import random as rd
# for i in range(1,6):
#   for k in range(i):
#        print('*', end='')
#    print()

#백슬래쉬 대각선
# for i in range(1,6):
#    for k in range(1,6):
#        if k == i:
#            print('*', end='')
#        else:
#            print(' ', end="")
#    print()

#슬래쉬 대각선
# for i in reversed(range(5)):
#    for k in range(i):
#        print(' ', end="")
#    print('*')

# for i in range(1,101):
#    if i % 3 ==0 and i % 5 ==0: #3과 5의 최소공배수 15 i%15해도 됨
#        print("FizzBuzz")
#    elif i % 3 ==0:
#        print("Fizz")
#    elif i % 5 ==0:
#        print("Buzz")
#    else:
#        print(i)

from collections import deque
a = deque([10,20,30])
a