height = int(input())


for i in range(height):
    for k in reversed(range(height)):
        if k > i:
            print (' ', end ="")
        else:
            print("*", end="")
    for k in range(height):
        if k < i:
            print("*", end="")
    print()