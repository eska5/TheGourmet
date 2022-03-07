def MealsIndex(name: str):
    with open("meals.txt", "a") as myfile:
        myfile.write(name + '\n')