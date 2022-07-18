import json
import os
import time

import cv2
import numpy as np
import tensorflow
from PIL import Image

model = tensorflow.keras.models.load_model(
    "C:\\Users\\LocalAdmin\\Desktop\\scripts\\effnet.h5"
)
Labels = [
    "Brokół",
    "Sałatka cezar",
    "Marchewka",
    "Sernik",
    "Skrzydełka kurczaka",
    "Tort czekoladowy",
    "Babeczki",
    "Winniczki",
    "Frytki",
    "Hamburger",
    "Hot dog",
    "Lody",
    "Lasagne",
    "Omlet",
    "Naleśniki",
    "Pizza",
    "Żeberka",
    "Jajecznica",
    "Zupa",
    "Spaghetti bolognese",
    "Spaghetti carbonara",
    "Stek",
    "Sushi",
    "Tiramisu",
    "Gofry",
]

# get the path/directory
folder_dir = "C:\\Users\\LocalAdmin\\Desktop\\scripts\\xd"
for images in os.listdir(folder_dir):
    start = time.time()
    # check if the image ends with png
    if images.endswith(".png") or images.endswith(".jpg") or images.endswith(".jpeg"):
        decodedImage = Image.open(folder_dir + "\\" + images)
        imageRgb = decodedImage.convert("RGB")
        opencvImage = cv2.cvtColor(np.array(imageRgb), cv2.COLOR_RGB2BGR)
        first_stage = time.time()
        print("[INFO] DECODING time: " + str(first_stage - start))

        # model = tensorflow.keras.models.load_model("model.h5")
        im = cv2.resize(opencvImage, (400, 400))
        img = np.expand_dims(im, 0)

        # second_stage = time.time()
        # print("[INFO] LOADING MODEL 2 time: " + str(second_stage - start))

        predict = model.predict(img)
        third_stage = time.time()
        print("[INFO] MODEL PREDICT time: " + str(third_stage - start))

        predictions = []
        # 3 best labels and probabilities
        for i in range(0, 3):
            predictions.append(Labels[predict.argmax(axis=1)[0]])
            predictions.append(str(predict[0][[predict.argmax(axis=1)[0]]][0]))
            predict[0][[predict.argmax(axis=1)[0]]] = 0
        jsonMessage = json.dumps(predictions)
        print(jsonMessage)
        end = time.time()
        print("[INFO] JOB FINISHED time: " + str(end - start))
        print("-------------------------------------------------------")
