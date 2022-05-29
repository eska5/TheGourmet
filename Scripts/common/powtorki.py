import os


def change_ext(filename):
    my_file = filename
    base = os.path.splitext(my_file)[0]
    os.rename(my_file, base + ".jpg")


def unique(list1):
    # initialize a null list
    unique_list = []

    # traverse for all elements
    for x in list1:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)

    return unique_list


directory = "C:\\Users\\LocalAdmin\\TheGourmet\\Scripts\\ImageScrapper\\photos\\broccoli"

counter1 = 0
counter2 = 0
listaDoUsuniecia = []
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    for filename2 in os.listdir(directory):
        f2 = os.path.join(directory, filename2)
        if counter1 > counter2 and open(f, "rb").read() == open(f2, "rb").read():
            listaDoUsuniecia.append(f2)
        counter2 += 1
    counter2 = 0
    counter1 += 1
print(unique(listaDoUsuniecia))
for filename in unique(listaDoUsuniecia):
    os.remove(filename)
