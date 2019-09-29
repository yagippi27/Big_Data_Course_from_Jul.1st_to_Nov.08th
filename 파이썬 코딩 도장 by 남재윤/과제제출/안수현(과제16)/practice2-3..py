total = 0
for hour in range(24):
    if hour % 10 == 3:
        total += 60*60
    else:
        for minute in range(60):
            if minute // 10 == 3:
                total += 60
            elif minute % 10 == 3:
                total += 60

print(total)