a,b,c = map(int, input("정수를 입력하시오: ").split())
if a > b:
    a, b = b, a
if a > c:
    a, c = c, a
if b > c:
    b, c = c, b

print(a,b,c)