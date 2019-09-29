testcase = int(input())
A, B = map(int, input().split())

for i in range(1,testcase+1):
    print("Case #", i, ": ", A, " + ", B, " = ", A+B, sep="")