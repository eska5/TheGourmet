import base64
import json
import os
from io import BytesIO

from PIL import Image


def save_image(title: str, coded_image: str):
    # If there is no such directory create the dir
    if os.path.isdir("data/" + title) == False:
        os.mkdir("data/" + title)
        # creating number.txt that counts files
        with open("data/" + title + "/number.txt", "a", encoding="utf8") as file:
            file.write("0")
        file.close()
        # adding line to data/meals.txt
        with open("data/meals.txt", "a", encoding="utf8") as file:
            file.write(title + "\n")
        file.close()

    # getting the number
    image_number = 0
    with open("data/" + title + "/number.txt", "r", encoding="utf8") as file:
        image_number = file.read()
    file.close()

    # decoding base64 to a file
    decoded_image = Image.open(BytesIO(base64.b64decode(str(coded_image))))
    image_rgb = decoded_image.convert("RGB")
    image_rgb.save("data/" + title + "/" + image_number + ".jpg")
    image_number = int(image_number) + 1

    # change the number of files in number.txt
    with open("data/" + title + "/number.txt", "w", encoding="utf8") as file:
        file.write(str(image_number))
    file.close()


def list_meals():
    with open("data/meals.txt", "r", encoding="utf8") as file:
        lines = file.readlines()
    file.close()
    lines.sort()
    return json.dumps([x[:-1] for x in lines])
