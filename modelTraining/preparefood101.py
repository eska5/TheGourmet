import os
import shutil


if __name__ == "__main__":
    originalPath = "D:\\Politechnika\\FoodDataSets\\Food101prepared\\"
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

    for category in os.listdir("D:\\Politechnika\\FoodDataSets\\Food101\\images"):
        try:
            os.mkdir(originalPath + "train\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\Politechnika\\FoodDataSets\\Food101\\images\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter == 700:
                break
            else:
                newImgPath = (
                    originalPath + "train\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            counter += 1
    print("train set done")

    # test data set
    for category in os.listdir("D:\\Politechnika\\FoodDataSets\\Food101\\images"):
        try:
            os.mkdir(originalPath + "test\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\Politechnika\\FoodDataSets\\Food101\\images\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter > 699:
                newImgPath = (
                    originalPath + "test\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 899:
                break
            counter += 1
    print("test set done")

    # validation data set
    for category in os.listdir("D:\\Politechnika\\FoodDataSets\\Food101\\images"):
        try:
            os.mkdir(originalPath + "validation\\" + category)
        except:
            pass
        counter = 0
        imagesPath = "D:\\Politechnika\\FoodDataSets\\Food101\\images\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter > 899:
                newImgPath = (
                    originalPath
                    + "validation\\"
                    + category
                    + "\\"
                    + str(counter)
                    + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 1000:
                break
            counter += 1
    print("validation set done")
    print("data set creation success")
