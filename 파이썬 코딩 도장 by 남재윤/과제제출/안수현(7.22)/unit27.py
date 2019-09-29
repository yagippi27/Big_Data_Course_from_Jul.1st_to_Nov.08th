import string
with open('words.txt', 'r') as file:
    for line in file:
        a = line.split()
        for i in range(len(a)):
            a[i] = a[i].strip(string.punctuation)
            if a[i].find("c") >= 0:
                print(a[i])