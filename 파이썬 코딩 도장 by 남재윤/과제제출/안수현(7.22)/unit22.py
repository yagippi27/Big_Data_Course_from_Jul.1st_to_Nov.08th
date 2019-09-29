number1, number2 = map(int, input().split())

a = [2**i for i in range(number1, number2+1)]
del a[1]
del a[-2]
print(a)