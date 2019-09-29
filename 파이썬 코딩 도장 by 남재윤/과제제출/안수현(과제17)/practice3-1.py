num = [str(i*j) for i in range(100, 1000) for j in range(100, 1000)]
max_palindrome = max([int(n) for n in num if n == n[::-1]])
print(max_palindrome)


for i in range(100, 1000):
    for j in range(100, 1000):
        if max_palindrome == i*j:
            print(i, j)
