import os
from os import listdir
import cv2
import numpy as np
import tensorflow

# get the path/directory
folder_dir = "C:\\Users\\LocalAdmin\\Desktop\\scripts\\testset"
for images in os.listdir(folder_dir):

    # check if the image ends with png
    if images.endswith(".png") or images.endswith(".jpg") or images.endswith(".jpeg"):
        model = tensorflow.keras.models.load_model("model.h5")
        predict = model.predict(images).argmax(axis=1)
        print(predict)
