import os
import base64
import json
from PIL import Image
from io import BytesIO
import tensorflow
import cv2
import numpy as np


def SaveAndDecodeMessage(title: str, codedPhoto: str):
    # If there is no such directory create the dir
    if os.path.isdir("data/" + title) == False:
        os.mkdir("data/" + title)
        # creating number.txt that counts files
        with open("data/" + title + "/number.txt", "a") as file:
            file.write("0")
        file.close()
        # adding line to data/meals.txt
        with open("data/meals.txt", "a") as file:
            file.write(title + "\n")
        file.close()

    # getting the number
    numberOfPhotos = 0
    with open("data/" + title + "/number.txt", "r") as file:
        numberOfPhotos = file.read()
    file.close()

    # decoding base64 to a file
    decodedImage = Image.open(BytesIO(base64.b64decode(str(codedPhoto))))
    imageRgb = decodedImage.convert('RGB')
    imageRgb.save("data/" + title + "/" + numberOfPhotos + ".jpg")
    # img = Image.open("data/"+ title +"/"+numberOfPhotos+".jpg")
    # width,height = img.size
    # if width>1000:
    #    if height>1000:
    #        img = img.resize((int(width/2),int(height/2)),Image.ANTIALIAS)
    #        width,height = img.size
    #        img.save("data/"+ title +"/"+numberOfPhotos+".jpg")
    # img.close()

    numberOfPhotos = int(numberOfPhotos) + 1
    # change the number of files in number.txt
    with open("data/" + title + "/number.txt", "w") as file:
        file.write(str(numberOfPhotos))
    file.close()


def classifyThePhoto(codedPhoto: str):
    Labels = ['gyoza', 'pad_thai', 'beignets', 'cheese_plate', 'prime_rib',
              'lobster_roll_sandwich', 'red_velvet_cake', 'seaweed_salad', 'ravioli',
              'bibimbap', 'samosa', 'hamburger', 'spring_rolls', 'lobster_bisque',
              'beef_carpaccio', 'eggs_benedict', 'macarons', 'crab_cakes', 'mussels',
              'french_toast', 'tacos', 'club_sandwich', 'ramen', 'spaghetti_bolognese',
              'chocolate_mousse', 'bread_pudding', 'miso_soup', 'takoyaki',
              'chicken_quesadilla', 'poutine', 'chicken_wings', 'waffles', 'pancakes',
              'baby_back_ribs', 'ice_cream', 'falafel', 'huevos_rancheros',
              'fish_and_chips', 'omelette', 'donuts', 'onion_rings', 'deviled_eggs',
              'baklava', 'french_onion_soup', 'edamame', 'sashimi', 'creme_brulee',
              'tuna_tartare', 'churros', 'foie_gras', 'caesar_salad', 'clam_chowder',
              'croque_madame', 'hummus', 'nachos', 'breakfast_burrito', 'paella',
              'pork_chop', 'pizza', 'bruschetta', 'gnocchi', 'shrimp_and_grits',
              'cheesecake', 'panna_cotta', 'escargots', 'fried_rice', 'peking_duck',
              'grilled_cheese_sandwich', 'sushi', 'guacamole', 'ceviche', 'chicken_curry',
              'fried_calamari', 'grilled_salmon', 'garlic_bread', 'apple_pie',
              'strawberry_shortcake', 'steak', 'beef_tartare', 'cannoli', 'tiramisu',
              'beet_salad', 'scallops', 'hot_dog', 'macaroni_and_cheese', 'caprese_salad',
              'carrot_cake', 'pho', 'risotto', 'oysters', 'pulled_pork_sandwich',
              'filet_mignon', 'lasagna', 'dumplings', 'cup_cakes', 'spaghetti_carbonara',
              'frozen_yogurt', 'chocolate_cake', 'greek_salad', 'hot_and_sour_soup',
              'french_fries']

    decodedImage = Image.open(BytesIO(base64.b64decode(str(codedPhoto))))
    imageRgb = decodedImage.convert('RGB')
    opencvImage = cv2.cvtColor(np.array(imageRgb), cv2.COLOR_RGB2BGR)
    model = tensorflow.keras.models.load_model("model-best.h5")
    im = cv2.resize(opencvImage, (400, 400))
    img = np.expand_dims(im, 0)
    predict = model.predict(img).argmax(axis=1)
    jsonMessage = json.dumps(Labels[predict[0]])
    return jsonMessage


def mealsList():
    with open("data/meals.txt", "r") as file:
        Lines = file.readlines()
        newLines = [x[:-1] for x in Lines]  # comprehension pogU
        mealsJson = json.dumps(newLines)
    file.close()
    return mealsJson
