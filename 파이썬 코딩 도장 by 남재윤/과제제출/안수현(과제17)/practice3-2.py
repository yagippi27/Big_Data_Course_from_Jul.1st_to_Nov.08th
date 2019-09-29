Letter, Number = map(str, input().split())

Letter = Letter.upper()
alpabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
           'W', 'X', 'Y', 'Z']*2
Number = int(Number)
Number = int(Number%26)
x = [0]*len(Letter)


for i in range(len(Letter)):
    x[i] = (alpabet[alpabet.index(Letter[i]) + Number])

print(type(x))
X = "".join(x)
print(X)