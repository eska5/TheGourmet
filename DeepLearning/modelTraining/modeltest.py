import os
from os import listdir
import cv2
import numpy as np
import tensorflow as tf
import time
from pathlib import Path

Labels = [
    "banana",
    "bread",
    "broccoli",
    "carrot",
    "ham",
    "pizza",
    "salmon",
    "sausage",
    "scrambled_eggs",
    "yellow_cheese",
]
# get the path/directory
folder_dir = "C:\\Users\\LocalAdmin\\Desktop\\scripts\\pizzaset"
model = tf.keras.models.load_model(
    "C:\\Users\\LocalAdmin\\Downloads\\Telegram Desktop\\model.h5"
)
for images in os.listdir(folder_dir):
    new_filename = Path(images).stem + ".jpg"
    print(images)
    # check if the image ends with png
    if images.endswith(".png") or images.endswith(".jpg") or images.endswith(".jpeg"):
        imhelper = cv2.imread(folder_dir + "\\" + images)
        opencvImage = cv2.cvtColor(np.array(imhelper), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        img = np.expand_dims(im, 0)
        predict = model.predict(img).argmax(axis=1)
        print(Labels[predict[0]])
        print(model.predict(img))
