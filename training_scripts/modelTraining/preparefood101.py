import os
import shutil


if __name__ == "__main__":
    ORIGINAL_PATH = "C:\\Users\\kubas\\OneDrive\\Desktop\\DATA\\"
    try:
        os.mkdir(ORIGINAL_PATH + "train")
    except Exception as e:
        print(e)
        pass
    try:
        os.mkdir(ORIGINAL_PATH + "test")
    except Exception as e:
        print(e)
        pass
    try:
        os.mkdir(ORIGINAL_PATH + "validation")
    except Exception as e:
        print(e)
        pass

    # train data set

    for category in os.listdir("C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"):
        try:
            os.mkdir(ORIGINAL_PATH + "train\\" + category)
        except Exception as e:
            print(e)
            pass
        counter = 0
        imagesPath = "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\" + category
        for imgPath in os.listdir(imagesPath):
            if counter == 700:
                break
            else:
                newImgPath = (
                    ORIGINAL_PATH + "train\\" + category + "\\" + str(counter) + ".jpg"
                )
                shutil.copyfile(imagesPath + "\\" + imgPath, newImgPath)
            counter += 1
    print("train set done")

    # test data set
    for category in os.listdir("C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"):
        try:
            os.mkdir(ORIGINAL_PATH + "test\\" + category)
        except Exception as e:
            print(e)
            pass
        counter = 0
        imagesPath = "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\" + category
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
    for category in os.listdir("C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\"):
        try:
            os.mkdir(ORIGINAL_PATH + "validation\\" + category)
        except Exception as e:
            print(e)
            pass
        counter = 0
        imagesPath = "C:\\Users\\kubas\\Downloads\\Telegram Desktop\\Telegram Desktop\\DATASET\\" + category
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
