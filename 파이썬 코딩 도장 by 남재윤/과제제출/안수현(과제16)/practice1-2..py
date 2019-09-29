hour, minute = map(int, input('시간과 분을 입력하세요: ').split())

if minute >= 45:
    print(hour,"시", minute-45, '분')
else:
    print(hour-1, "시", 60-(45-minute), "분")