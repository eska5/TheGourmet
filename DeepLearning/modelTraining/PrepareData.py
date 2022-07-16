import os
import cv2
import random
import pickle
from PIL import Image
import numpy as np

categories = []
basicPath = "/Users/jakubsachajko/Desktop/GourmetDataset/"
pathTrain = basicPath + "train/"
pathValidation = basicPath + "validation/"
pathTest = basicPath + "test/"

try:
    os.mkdir(basicPath + "convertedTrain")
except:
    pass

for category in os.listdir(pathTrain):
    categories.append(category)
    imagesPath = os.path.join(pathTrain, category)
    print(imagesPath)
    try:
        os.mkdir(basicPath + "convertedTrain/" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        img = Image.open(pathTrain + category + "/" + imgPath).convert("RGB")
        opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        cv2.imwrite(
            basicPath + "convertedTrain/" + category + "/" + imgPath, im
        )

try:
    os.mkdir(basicPath + "convertedValidation")
except:
    pass
for category in os.listdir(pathValidation):
    categories.append(category)
    imagesPath = os.path.join(pathValidation, category)
    print(imagesPath)
    try:
        os.mkdir(basicPath + "convertedValidation/" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathValidation + category +
                             "/" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                basicPath + "convertedValidation/" + category + "/" + imgPath,
                im,
            )
        except Exception as e:
            pass

try:
    os.mkdir(basicPath + "convertedTest")
except:
    pass
for category in os.listdir(pathTest):
    categories.append(category)
    imagesPath = os.path.join(pathTest, category)
    print(imagesPath)
    try:
        os.mkdir(basicPath + "convertedTest/" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathTest + category + "/" +
                             imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                basicPath + "convertedTest/" + category + "/" + imgPath, im
            )
        except Exception as e:
            pass
