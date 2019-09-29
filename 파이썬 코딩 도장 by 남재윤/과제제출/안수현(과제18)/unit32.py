files = input().split()

print(list(map(lambda x: '%03d.' % int(x.split(".")[0])+x.split(".")[1], files)))