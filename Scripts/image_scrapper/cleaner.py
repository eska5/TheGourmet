import os


def change_ext(directory: str):
    for filename in os.listdir(directory):
        base = os.path.splitext(filename)[0]
        old_file = os.path.join(directory, filename)
        new_file = os.path.join(directory, base + ".jpg")
        os.rename(old_file, new_file)
    print("[INFO] File extension changed")


def unique(list1):
    # initialize a null list
    unique_list = []

    # traverse for all elements
    for x in list1:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)

    return unique_list


def delete_duplicates(name: str):
    directory = "C:\\Users\\LocalAdmin\\TheGourmet\\Scripts\\ImageScrapper\\photos\\" + name
    change_ext(directory)
    counter2 = counter1 = 0
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
    msg = "[INFO] Files to be deleted: "
    print(f"{msg}{unique(listaDoUsuniecia)}")
    for filename in unique(listaDoUsuniecia):
        os.remove(filename)
