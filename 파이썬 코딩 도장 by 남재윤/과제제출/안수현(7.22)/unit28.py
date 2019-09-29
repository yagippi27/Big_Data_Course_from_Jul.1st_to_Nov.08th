with open("words2.txt", "r") as file:
    for line in file:
        words = line.strip('\n')
        if words == words[::-1]:
            print(words)