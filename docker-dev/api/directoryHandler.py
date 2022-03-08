import os
import base64
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

    numberOfPhotos = int(numberOfPhotos)+1
    #change the number of files in number.txt
    with open ("data/"+title + "/number.txt","w") as file:
        file.write(str(numberOfPhotos))
    file.close()

    




    

