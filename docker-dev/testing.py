import json
def mealsList():
    with open("data/meals.txt","r") as file:
        Lines = file.readlines()
        newLines = [x[:-1] for x in Lines] #comprehension pogU
        mealsJson = json.dumps(newLines)
    return mealsJson




if __name__ == '__main__':
   mealsList()