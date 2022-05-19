import os
from os import listdir
import cv2
import numpy as np
import tensorflow as tf
import time

Labels = [
    "ham",
    "yellow_cheese",
    "salmon",
    "pizza",
    "carrot",
    "scrambled_eggs",
    "bread",
    "sausage",
    "broccoli",
    "banana",
]
# get the path/directory
folder_dir = "C:\\Users\\LocalAdmin\\Desktop\\scripts\\testset"
model = tf.keras.models.load_model("C:\\Users\\LocalAdmin\\Desktop\\model.h5")
for images in os.listdir(folder_dir):
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
