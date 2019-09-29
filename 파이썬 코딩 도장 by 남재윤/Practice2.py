result = [0, 0, 0, 0, 0,  0, 0, 0, 0, 0]
for j in range(1, 1001):
    for x in str(j):
        result[int(x)] += 1

print(result)