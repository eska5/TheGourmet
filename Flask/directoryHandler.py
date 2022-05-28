import base64
import json
import os
from io import BytesIO

import cv2
import numpy as np
import tensorflow
from PIL import Image


def SaveAndDecodeMessage(title: str, codedPhoto: str):
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
    numberOfPhotos = 0
    with open("data/" + title + "/number.txt", "r", encoding="utf8") as file:
        numberOfPhotos = file.read()
    file.close()

    # decoding base64 to a file
    decodedImage = Image.open(BytesIO(base64.b64decode(str(codedPhoto))))
    imageRgb = decodedImage.convert("RGB")
    imageRgb.save("data/" + title + "/" + numberOfPhotos + ".jpg")
    numberOfPhotos = int(numberOfPhotos) + 1
    # change the number of files in number.txt
    with open("data/" + title + "/number.txt", "w", encoding="utf8") as file:
        file.write(str(numberOfPhotos))
    file.close()


def classifyThePhoto(codedPhoto: str):
    Labels = [
        "Banan",
        "Chleb",
        "Brokół",
        "Marchew",
        "Szynka",
        "Pizza",
        "Łosoś",
        "Kiełbasa",
        "Jajecznica",
        "Ser żółty",
    ]

    decodedImage = Image.open(BytesIO(base64.b64decode(str(codedPhoto))))
    imageRgb = decodedImage.convert("RGB")
    opencvImage = cv2.cvtColor(np.array(imageRgb), cv2.COLOR_RGB2BGR)
    model = tensorflow.keras.models.load_model("model.h5")
    im = cv2.resize(opencvImage, (400, 400))
    img = np.expand_dims(im, 0)
    predict = model.predict(img)

    predictions = []
    # 3 best labels and probabilities
    predictions.append(Labels[predict.argmax(axis=1)[0]])
    predictions.append(str(predict[0][[predict.argmax(axis=1)[0]]][0]))
    predict[0][[predict.argmax(axis=1)[0]]] = 0
    predictions.append(Labels[predict.argmax(axis=1)[0]])
    predictions.append(str(predict[0][[predict.argmax(axis=1)[0]]][0]))
    predict[0][[predict.argmax(axis=1)[0]]] = 0
    predictions.append(Labels[predict.argmax(axis=1)[0]])
    predictions.append(str(predict[0][[predict.argmax(axis=1)[0]]][0]))
    jsonMessage = json.dumps(predictions)
    return jsonMessage


def mealsList():
    with open("data/meals.txt", "r", encoding="utf8") as file:
        Lines = file.readlines()
        Lines.sort()
        newLines = [x[:-1] for x in Lines]  # comprehension pogU
        mealsJson = json.dumps(newLines)
    file.close()
    return mealsJson
