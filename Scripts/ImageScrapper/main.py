import os

from GoogleImageScrapper import GoogleImageScraper
from patch import webdriver_executable


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


if __name__ == "__main__":
    # Define file path
    webdriver_path = os.path.normpath(
        os.path.join(os.getcwd(), "webdriver", webdriver_executable())
    )
    image_path = os.path.normpath(os.path.join(os.getcwd(), "photos"))

    # Add new search key into array ["cat","t-shirt","apple","orange","pear","fish"]
    # with open("meals.txt", "r", encoding="utf8") as file:
    #    meals = file.readlines()
    # search_keys = []
    # for food in meals:
    #    search_keys.append(food[0:-1])
    # Parameters
    search_keys = ["pieczony brokuł"]
    number_of_images = 300
    headless = True
    min_resolution = (400, 400)
    max_resolution = (9999, 9999)

    # Main program
    for search_key in search_keys:
        image_scrapper = GoogleImageScraper(
            webdriver_path,
            image_path,
            search_key,
            number_of_images,
            headless,
            min_resolution,
            max_resolution,
        )
        image_urls = image_scrapper.find_image_urls()
        f = open("images_sources.txt", "a", encoding="utf8")
        i = 1
        for url in image_urls:
            f.write("[" + str(i) + "]" + search_key + ": " + url + "\n")
            i += 1
        f.close()
        image_scrapper.save_images(image_urls)

    counter1 = 0
    counter2 = 0
    listaDoUsuniecia = []
    for filename in os.listdir(image_path):
        f = os.path.join(image_path, filename)
        for filename2 in os.listdir(image_path):
            f2 = os.path.join(image_path, filename2)
            if counter1 > counter2 and open(f, "rb").read() == open(f2, "rb").read():
                listaDoUsuniecia.append(f2)
            counter2 += 1
        counter2 = 0
        counter1 += 1
    print(unique(listaDoUsuniecia))
    for filename in unique(listaDoUsuniecia):
        os.remove(filename)

    # Release resources
    del image_scrapper
