

vegetables = {'가지':800, '오이':600, '수박':15000, '호박':1000, '깻잎':500}

import operator
sv = sorted(vegetables.items(), key=operator.itemgetter(1), reverse=True)

for key, value in sv:
    print(key, ":", '{0:>7,}'.format(value))
