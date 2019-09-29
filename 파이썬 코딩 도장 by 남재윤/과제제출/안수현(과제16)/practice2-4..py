total0 = 0
for i in range(1, 1001):
    a = str(i).count('0')
    if a >= 1:
        total0 += int(a)

total1 = 0
for i in range(1, 1001):
    a = str(i).count('1')
    if a >= 1:
        total1 += int(a)

total2 = 0
for i in range(1, 1001):
    a = str(i).count('2')
    if a >= 1:
        total2 += int(a)

total3 = 0
for i in range(1, 1001):
    a = str(i).count('3')
    if a >= 1:
        total3 += int(a)

total4 = 0
for i in range(1, 1001):
    a = str(i).count('4')
    if a >= 1:
        total4 += int(a)

total5 = 0
for i in range(1, 1001):
    a = str(i).count('5')
    if a >= 1:
        total5 += int(a)

total6 = 0
for i in range(1, 1001):
    a = str(i).count('6')
    if a >= 1:
        total6 += int(a)

total7 = 0
for i in range(1, 1001):
    a = str(i).count('7')
    if a >= 1:
        total7 += int(a)

total8 = 0
for i in range(1, 1001):
    a = str(i).count('8')
    if a >= 1:
        total8 += int(a)

total9 = 0
for i in range(1, 1001):
    a = str(i).count('9')
    if a >= 1:
        total9 += int(a)

print(total0, total1, total2, total3, total4, total5, total6, total7, total8, total9)
