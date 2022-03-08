def MealsIndex(name: str):
    with open("data/meals.txt", "a") as myfile:
        myfile.write(name + '\n')