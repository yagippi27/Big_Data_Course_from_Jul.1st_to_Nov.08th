# 또 풀어보기
N = int(input("5이상 9이하의 홀수: "))
h = (N+1)//2

for i in range(1, h+1):
    for k in range(h-i):
        print(' ', end='')
    for k in range(i*2-1):
        print('*', end='')
    print()

for i in reversed(range(1, h)):
    for k in range(i, h):
        print(' ', end='')
    for k in range(i*2-1):
        print('*', end='')
    print()