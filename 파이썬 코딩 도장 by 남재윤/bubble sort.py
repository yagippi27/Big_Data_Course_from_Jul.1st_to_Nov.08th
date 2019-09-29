
#오름차순 버블분류법
aList = list(map(int, input('insert numbers: ').split()))
print(aList)
for i in range(len(aList)-1):
    for k in range(i+1, len(aList)):
        if aList[i] > aList[k]:
            aList[i], aList[k] = aList[k], aList[i]

print(aList)


#내림차순 버블분류법
aList = list(map(int, input('insert numbers: ').split()))
print(aList)
for i in range(len(aList)-1):
    for k in range(i+1, len(aList)):
        if aList[i] > aList[k]:
            #부등호 차이
            aList[i], aList[k] = aList[k], aList[i]

print(aList)