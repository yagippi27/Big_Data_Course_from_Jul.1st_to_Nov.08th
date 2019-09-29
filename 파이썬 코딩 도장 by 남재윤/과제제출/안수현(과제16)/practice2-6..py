N = int(input())

sumsq = 0
sum = 0

for i in range(1, N+1):
    sum += i
print(sum)

for i in range(1, N+1):
    sumsq += i**2
print(sumsq)

print(sum**2-sumsq)