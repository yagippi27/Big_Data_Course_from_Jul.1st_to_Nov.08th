korean, english, math, science = map(int, input().split())
if 0 <= korean <=100 and 0 <= english <=100 and 0 <= math <=100 and 0 <= science <=100:
    if (korean+english+math+science)/4 >=80:
        print("합격")
    else:
        print("불합격")
else:
    print("잘못된 점수")