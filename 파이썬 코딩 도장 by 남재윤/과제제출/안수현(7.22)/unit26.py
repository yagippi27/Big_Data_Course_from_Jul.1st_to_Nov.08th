
#코딩 시작 부분

a, b = map(int, input().split())
a = set(i for i in range(1, a+1) if a % i == 0)
b = set(k for k in range(1, b+1) if b % k == 0)


# 코딩 끝
divisor = a & b

result = 0
if type(divisor) == set:
    result = sum(divisor)

print(result)

#공약수 ex 12
# 12 = 1,2,3,4,6,12 -> 12랑 나눠짐