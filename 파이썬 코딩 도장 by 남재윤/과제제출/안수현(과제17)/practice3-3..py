string = str(input("찾을 문자열: "))
filename = str(input("찾을 파일명: "))

line_number=1
with open(filename, 'r', encoding="UTF-8") as file:
    for line in file:
        if line.find(string) >= 0:
            print(line_number, ": ", line, end='')
        line_number += 1