import os
import shutil


if __name__ == "__main__":
    originalPath = "/Users/jakubsachajko/Desktop/GourmetDataset/DATASET/"
    newPath = "/Users/jakubsachajko/Desktop/GourmetDataset/"
    try:
        os.mkdir(newPath + "train")
    except:
        pass
    try:
        os.mkdir(newPath + "test")
    except:
        pass
    try:
        os.mkdir(newPath + "validation")
    except:
        pass

    # train data set

    for category in os.listdir(originalPath):
        try:
            os.mkdir(newPath + "train/" + category)
        except:
            pass
        counter = 0
        imagesPath = originalPath + category
        for imgPath in os.listdir(imagesPath):
            if counter == 700:
                break
            else:
                if counter < 10:
                    newImgPath = (
                        newPath + "train/" + category +
                        "/" + "00" + str(counter) + ".jpg"
                    )
                elif counter < 100:
                    newImgPath = (
                        newPath + "train/" + category +
                        "/" + "0" + str(counter) + ".jpg"
                    )
                else:
                    newImgPath = (
                        newPath + "train/" + category +
                        "/" + str(counter) + ".jpg"
                    )
                shutil.copyfile(imagesPath + "/" + imgPath, newImgPath)
            counter += 1
    print("train set done")

    # test data set
    for category in os.listdir(originalPath):
        try:
            os.mkdir(newPath + "test/" + category)
        except:
            pass
        counter = 0
        imagesPath = originalPath + category
        for imgPath in os.listdir(imagesPath):
            if counter > 699:
                newImgPath = (
                    newPath + "test/" + category +
                    "/" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "/" + imgPath, newImgPath)
            if counter == 899:
                break
            counter += 1
    print("test set done")

    # validation data set
    for category in os.listdir(originalPath):
        try:
            os.mkdir(newPath + "validation/" + category)
        except:
            pass
        counter = 0
        imagesPath = originalPath + category
        for imgPath in os.listdir(imagesPath):
            if counter > 899:
                newImgPath = (
                    newPath
                    + "validation/"
                    + category
                    + "/"
                    + str(counter)
                    + ".jpg"
                )
                shutil.copyfile(imagesPath + "/" + imgPath, newImgPath)
            if counter == 999:
                break
            counter += 1
    print("validation set done")
    print("data set creation success")
