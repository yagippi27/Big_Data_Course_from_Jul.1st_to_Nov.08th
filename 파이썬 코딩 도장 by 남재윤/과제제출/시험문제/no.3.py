a, b = map(int, input().split())
total = 0
if a % 2 == 0:
    for i in range(a+1, b+1, 2):
        total += i
    print(total)

else:
    for i in range(a, b+1, 2):
        total += i
    print(total)