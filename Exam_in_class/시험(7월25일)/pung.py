a = [1,1,1,3,2]

for i in range(5):
    for k in range(5):
        if a[i:i+2] == a[k]:
            print(True)