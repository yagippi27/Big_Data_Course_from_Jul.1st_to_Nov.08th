
def fib(x):
    if x < 3:
        return 1
    else:
        return fib(x-1) + fib(x-2)

n = int(input())
print(fib(n))
