N = int(input())

def nature(x):
    number = []
    for i in range(1, x):
        if x % i == 0:
            number.append(i)
    return number

for k in range(1, 1+N):
    a = nature(k)
    if k == sum(a):
        print(k)