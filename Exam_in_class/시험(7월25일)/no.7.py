def palindrome(Num):
    Num = str(Num)
    if Num == Num[::-1]:
       return int(Num)


maxNum =0
for i in range(100, 1000):
    for k in range(100, 1000):
        if i*k == palindrome(i*k):
            if i*k > maxNum:
                maxNum = i*k
                maxi = i
                maxk = k

print(maxi, maxk, maxNum)