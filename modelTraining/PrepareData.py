import os
import cv2
import random
import pickle
from PIL import Image

categories = []
pathTrain = "C:\\Users\\Kuba\\Desktop\\zdjotka\\train\\"
pathValidation = "C:\\Users\\Kuba\\Desktop\\zdjotka\\validation\\"

try:
	os.mkdir("convertedTrain")
except:
	pass

for category in os.listdir(pathTrain):
	categories.append(category)
	imagesPath = os.path.join(pathTrain,category)
	print(imagesPath)
	try:
		os.mkdir("convertedTrain\\" + category)
	except:
		pass
	for imgPath in os.listdir(imagesPath):
		print(imgPath)
		try:
			basewidth = 500
			img = Image.open(pathTrain+category+"\\"+imgPath).convert('RGB')
			wpercent = (basewidth/float(img.size[0]))
			hsize = int((float(img.size[1])*float(wpercent)))
			img = img.resize((basewidth,hsize), Image.ANTIALIAS)
			img.save(pathTrain.replace('train','')+"convertedTrain\\"+category + "\\"+imgPath)
		except Exception as e:
		       pass

try:
	os.mkdir("convertedValidation")
except:
	pass
for category in os.listdir(pathValidation):
	categories.append(category)
	imagesPath = os.path.join(pathValidation,category)
	print(imagesPath)
	try:
		os.mkdir("convertedValidation\\" + category)
	except:
		pass
	for imgPath in os.listdir(imagesPath):
		print(imgPath)
		try:
			basewidth = 500
			img = Image.open(pathValidation+category+"\\"+imgPath).convert('RGB')
			wpercent = (basewidth/float(img.size[0]))
			hsize = int((float(img.size[1])*float(wpercent)))
			img = img.resize((basewidth,hsize), Image.ANTIALIAS)
			img.save(pathValidation.replace('validation','')+"convertedValidation\\"+category + "\\"+imgPath)
		except Exception as e:
		       pass



#imgArray = cv2.imread(os.path.join(
#    path, img), cv2.IMREAD_GRAYSCALE)