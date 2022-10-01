import os
import cv2
from PIL import Image
import numpy as np


CATEGORIES = []
PATH_TRAINING = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\train\\"
PATH_VALIDATION = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\validation\\"
PATH_TEST = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\test\\"

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain")
except OSError as err:
    pass

for category in os.listdir(PATH_TRAINING):
    CATEGORIES.append(category)
    imagesPath = os.path.join(PATH_TRAINING, category)
    print(imagesPath)
    try:
        os.mkdir(
            "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain\\" + category
        )
    except OSError as err:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        img = Image.open(PATH_TRAINING + category + "\\" + imgPath).convert("RGB")
        opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        cv2.imwrite(
            "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain\\"
            + category
            + "\\"
            + imgPath,
            im,
        )

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation")
except OSError as err:
    pass
for category in os.listdir(PATH_VALIDATION):
    CATEGORIES.append(category)
    imagesPath = os.path.join(PATH_VALIDATION, category)
    print(imagesPath)
    try:
        os.mkdir(
            "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation\\"
            + category
        )
    except OSError as err:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(PATH_VALIDATION + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation\\"
                + category
                + "\\"
                + imgPath,
                im,
            )
        except OSError as err:
            pass

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest")
except OSError as err:
    pass
for category in os.listdir(PATH_TEST):
    CATEGORIES.append(category)
    imagesPath = os.path.join(PATH_TEST, category)
    print(imagesPath)
    try:
        os.mkdir(
            "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest\\" + category
        )
    except OSError as err:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(PATH_TEST + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest\\"
                + category
                + "\\"
                + imgPath,
                im,
            )
        except OSError as err:
            pass

print("DONE")
