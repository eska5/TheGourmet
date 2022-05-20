import os
import shutil


if __name__ == "__main__":
    originalPath = "D:\\naszeJedzenie\\"
    try:
        os.mkdir(originalPath + "train")
    except:
        pass
    try:
        os.mkdir(originalPath + "test")
    except:
        pass
    try:
        os.mkdir(originalPath + "validation")
    except:
        pass

    # train data set

    for category in os.listdir("D:\\DATASET\\"):
        try:
            os.mkdir(originalPath + "train\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\DATASET\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter == 350:
                break
            else:
                newImgPath = (
                    originalPath + "train\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            counter += 1
    print("train set done")

    # test data set
    for category in os.listdir("D:\\DATASET\\"):
        try:
            os.mkdir(originalPath + "test\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\DATASET\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter > 349:
                newImgPath = (
                    originalPath + "test\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 449:
                break
            counter += 1
    print("test set done")

    # validation data set
    for category in os.listdir("D:\\DATASET\\"):
        try:
            os.mkdir(originalPath + "validation\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\DATASET\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter > 449:
                newImgPath = (
                    originalPath
                    + "validation\\"
                    + category
                    + "\\"
                    + str(counter)
                    + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 499:
                break
            counter += 1
    print("validation set done")
    print("data set creation success")
