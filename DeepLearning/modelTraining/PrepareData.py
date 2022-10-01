import os
import cv2
from PIL import Image
import numpy as np


categories = []
pathTrain = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\train\\"
pathValidation = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\validation\\"
pathTest = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\test\\"

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain")
except:
    pass

for category in os.listdir(pathTrain):
    categories.append(category)
    imagesPath = os.path.join(pathTrain, category)
    print(imagesPath)
    try:
        os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        img = Image.open(pathTrain + category + "\\" + imgPath).convert("RGB")
        opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        cv2.imwrite(
            "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTrain\\" + category + "\\" + imgPath, im
        )

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation")
except:
    pass
for category in os.listdir(pathValidation):
    categories.append(category)
    imagesPath = os.path.join(pathValidation, category)
    print(imagesPath)
    try:
        os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathValidation + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedValidation\\" + category + "\\" + imgPath,
                im,
            )
        except Exception as e:
            pass

try:
    os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest")
except:
    pass
for category in os.listdir(pathTest):
    categories.append(category)
    imagesPath = os.path.join(pathTest, category)
    print(imagesPath)
    try:
        os.mkdir("C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathTest + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\convertedTest\\" + category + "\\" + imgPath, im
            )
        except Exception as e:
            pass

print("DONE")