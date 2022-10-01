import os
import cv2
import numpy as np
import tensorflow as tf


LABELS = [
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
FOLDER_DIR = "D:\\naszeJedzenie\\convertedTest\\ham"
MODEL = tf.keras.models.load_model("D:\\model.h5")
for images in os.listdir(FOLDER_DIR):
    print(images)
    # check if the image ends with png
    if images.endswith(".png") or images.endswith(".jpg") or images.endswith(".jpeg"):
        imhelper = cv2.imread(FOLDER_DIR + "\\" + images)
        opencvImage = cv2.cvtColor(np.array(imhelper), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        img = np.expand_dims(im, 0)
        predict = MODEL.predict(img).argmax(axis=1)
        print(LABELS[predict])
