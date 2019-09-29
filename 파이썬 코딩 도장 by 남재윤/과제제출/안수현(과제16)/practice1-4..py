for a in range(1,333):
    for b in range(a+1, 500):
        c = 1000-a-b
        if c < b:
            continue
        if a**2 + b**2 == c**2:
            print(a,b,c)
            print(a+b+c)
            print(a**2, b**2, c**2)
            break