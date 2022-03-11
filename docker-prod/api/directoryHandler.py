import os
import base64
import json
from PIL import Image
from io import BytesIO

def SaveAndDecodeMessage(title:str,codedPhoto:str):

    #If there is no such directory create the dir    
    if os.path.isdir("data/"+title) == False:
        os.mkdir("data/"+title)
        #creating number.txt that counts files
        with open ("data/"+title + "/number.txt","a") as file:
            file.write("0")
        file.close()
        #adding line to data/meals.txt
        with open("data/meals.txt","a") as file:
            file.write(title + "\n")
        file.close()
        
    #getting the number
    numberOfPhotos=0
    with open ("data/"+title + "/number.txt","r") as file:
        numberOfPhotos = file.read()
    file.close()

    #decoding base64 to a file
    decodedImage = Image.open(BytesIO(base64.b64decode(str(codedPhoto))))
    imageRgb = decodedImage.convert('RGB')
    imageRgb.save("data/"+ title +"/"+numberOfPhotos+".jpg")
    img = Image.open("data/"+ title +"/"+numberOfPhotos+".jpg")
    width,height = img.size
    if width>1000:
        if height>1000:
            img = img.resize((int(width/2),int(height/2)),Image.ANTIALIAS)
            width,height = img.size
            img.save("data/"+ title +"/"+numberOfPhotos+".jpg")
    img.close()

    numberOfPhotos = int(numberOfPhotos)+1
    #change the number of files in number.txt
    with open ("data/"+title + "/number.txt","w") as file:
        file.write(str(numberOfPhotos))
    file.close()


def mealsList():
    with open("data/meals.txt","r") as file:
        Lines = file.readlines()
        newLines = [x[:-1] for x in Lines] #comprehension pogU
        mealsJson = json.dumps(newLines)
    return mealsJson



    




    

