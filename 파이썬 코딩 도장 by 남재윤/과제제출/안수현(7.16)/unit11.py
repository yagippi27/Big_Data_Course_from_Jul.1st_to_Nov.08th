#11.8

x = input().split()

del x[-5:len(x)]

print(tuple(x))


#11.9

a = input()
b = input()
print(a[1:len(a):2]+b[0:len(b):2])