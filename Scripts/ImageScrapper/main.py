import os
from GoogleImageScrapper import GoogleImageScraper
from patch import webdriver_executable

if __name__ == "__main__":
    # Define file path
    webdriver_path = os.path.normpath(
        os.path.join(os.getcwd(), "webdriver", webdriver_executable())
    )
    image_path = os.path.normpath(os.path.join(os.getcwd(), "photos"))

    # Add new search key into array ["cat","t-shirt","apple","orange","pear","fish"]
    with open("meals.txt", "r", encoding="utf8") as file:
        meals = file.readlines()
    search_keys = []
    for food in meals:
        search_keys.append(food[0:-1])
    # Parameters
    number_of_images = 20
    headless = False
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

    # Release resources
    del image_scrapper
