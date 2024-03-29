# pylint: disable=C0330
import os
import shutil


if __name__ == "__main__":
    ORIGINAL_PATH = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\"
    IMAGES_PATH = (
        "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"
    )
    try:
        os.mkdir(ORIGINAL_PATH + "train")
    except OSError as err:
        pass
    try:
        os.mkdir(ORIGINAL_PATH + "test")
    except OSError as err:
        pass
    try:
        os.mkdir(ORIGINAL_PATH + "validation")
    except OSError as err:
        pass

    # train data set

    for category in os.listdir(
        "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"
    ):
        try:
            os.mkdir(ORIGINAL_PATH + "train\\" + category)
        except OSError as err:
            pass
        counter = 0
        imagesPath = IMAGES_PATH + category
        for imgPath in os.listdir(imagesPath):
            if counter == 700:
                break
            newImgPath = (
                ORIGINAL_PATH + "train\\" + category + "\\" + str(counter) + ".jpg"
            )
            shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            counter += 1
    print("train set done")

    # test data set
    for category in os.listdir(
        "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"
    ):
        try:
            os.mkdir(ORIGINAL_PATH + "test\\" + category)
        except OSError as err:
            pass
        counter = 0
        imagesPath = IMAGES_PATH + category
        for imgPath in os.listdir(imagesPath):
            if counter > 699:
                newImgPath = (
                    ORIGINAL_PATH + "test\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 899:
                break
            counter += 1
    print("test set done")

    # validation data set
    for category in os.listdir(
        "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"
    ):
        try:
            os.mkdir(ORIGINAL_PATH + "validation\\" + category)
        except OSError as err:
            pass
        counter = 0
        imagesPath = IMAGES_PATH + category
        for imgPath in os.listdir(imagesPath):
            if counter > 899:
                newImgPath = (
                    ORIGINAL_PATH
                    + "validation\\"
                    + category
                    + "\\"
                    + str(counter)
                    + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            if counter == 999:
                break
            counter += 1
    print("validation set done")
    print("data set creation success")
