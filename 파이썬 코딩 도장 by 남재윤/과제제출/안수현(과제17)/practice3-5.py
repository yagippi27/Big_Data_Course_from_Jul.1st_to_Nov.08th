import random
import os
import shutil

PATH = 'c:/Temp/Ex04'
os.mkdir(PATH)
os.chdir(PATH)
for dirname in ('low', 'mid', 'high'):
    os.mkdir(PATH + '/' + dirname)
    for num in ('1','2','3'):
        os.mkdir(PATH + '/' + dirname + '/' +num)

a = random.randrange(0,10000)
b = str(random.randrange(1,4))
file_name = '%04d.txt' % a
print(file_name)

with open(file_name, 'w') as file:
    file.write(b)

fileList = os.listdir(PATH)
for file_name in fileList:
    if os.path.isdir(file_name):
        continue

    if a <= 3333:
        dirname = 'low'
    elif a <= 6666:
        dirname = 'mid'
    else:
        dirname = 'high'
    dst = dirname +'/'+ b + '/' +file_name
    shutil.move(file_name, dst)