import string
diction = {}
with open("queen.txt", 'r') as file:
    for line in file:
        bohemian = line.split()
        for i in range(len(bohemian)):
            rhapsody = bohemian[i].strip(string.punctuation)

            count = diction.get(rhapsody, 0)
            if count == 0:
                diction.setdefault(rhapsody, 1)
            else:
                diction.update(zip([rhapsody], [count+1]))

print('총 단어수 = ', len(diction))
import operator
Sorter = sorted(diction.items(), key=operator.itemgetter(1), reverse = True)
for i in range(10):
    print(Sorter[i])