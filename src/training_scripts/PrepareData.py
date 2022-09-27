import os

import cv2
import numpy as np
from PIL import Image

categories = []
pathTrain = "D:\\naszeJedzenie\\train\\"
pathValidation = "D:\\naszeJedzenie\\validation\\"
pathTest = "D:\\naszeJedzenie\\test\\"

try:
    os.mkdir("D:\\naszeJedzenie\\convertedTrain")
except:
    pass

for category in os.listdir(pathTrain):
    categories.append(category)
    imagesPath = os.path.join(pathTrain, category)
    print(imagesPath)
    try:
        os.mkdir("D:\\naszeJedzenie\\convertedTrain\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        # try:
        img = Image.open(pathTrain + category + "\\" + imgPath).convert("RGB")
        opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
        im = cv2.resize(opencvImage, (400, 400))
        cv2.imwrite(
            "D:\\naszeJedzenie\\convertedTrain\\" + category + "\\" + imgPath, im
        )
        # im.save("D:\\naszeJedzenie\\convertedTrain\\" + category + "\\" + imgPath)
        # except Exception as e:
        #     pass

try:
    os.mkdir("D:\\naszeJedzenie\\convertedValidation")
except:
    pass
for category in os.listdir(pathValidation):
    categories.append(category)
    imagesPath = os.path.join(pathValidation, category)
    print(imagesPath)
    try:
        os.mkdir("D:\\naszeJedzenie\\convertedValidation\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathValidation + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "D:\\naszeJedzenie\\convertedValidation\\" + category + "\\" + imgPath,
                im,
            )
        except Exception as e:
            pass

try:
    os.mkdir("D:\\naszeJedzenie\\convertedTest")
except:
    pass
for category in os.listdir(pathTest):
    categories.append(category)
    imagesPath = os.path.join(pathTest, category)
    print(imagesPath)
    try:
        os.mkdir("D:\\naszeJedzenie\\convertedTest\\" + category)
    except:
        pass
    for imgPath in os.listdir(imagesPath):
        print(imgPath)
        try:
            img = Image.open(pathTest + category + "\\" + imgPath).convert("RGB")
            opencvImage = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)
            im = cv2.resize(opencvImage, (400, 400))
            cv2.imwrite(
                "D:\\naszeJedzenie\\convertedTest\\" + category + "\\" + imgPath, im
            )
            # im.save("D:\\naszeJedzenie\\convertedTest\\" + category + "\\" + imgPath)
        except Exception as e:
            pass

# imgArray = cv2.imread(os.path.join(
#    path, img), cv2.IMREAD_GRAYSCALE)
