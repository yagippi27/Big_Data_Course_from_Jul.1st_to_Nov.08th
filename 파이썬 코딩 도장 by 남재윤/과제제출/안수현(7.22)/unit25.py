keys = input().split()
values = map(int, input().split())

x = dict(zip(keys, values))

#코딩 시작 부분

x = {keys: values for keys, values in x.items()
     if keys != 'delta' if values != 30}

#코딩 끝 부분
print(x)