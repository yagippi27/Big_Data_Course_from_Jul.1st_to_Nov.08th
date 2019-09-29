rate = float(input())
money = int(input())
i = 0
double = money*2

while money <= double:
    money= money+money*rate/100

    print(money)
    i += 1
    print("%d년 입니다." % i)
