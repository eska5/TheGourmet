from importlib.resources import path
import os
import string
import cv2
import numpy as np
from sqlalchemy import false
import tensorflow as tf
import argparse

def dir_path(path):
    if os.path.isdir(path):
        return path
    else:
        raise argparse.ArgumentTypeError(f"readable_dir:{path} is not a valid path")

def main(args):
    if args['generate_results']:
        MODEL = tf.keras.models.load_model(args['model_path'])
        labels = []
        for images in os.listdir(args['data_path']):
            labels.append(images)

        predictions = []
        for count, label in enumerate(os.listdir(args['data_path'])):
            correct_predictions = 0
            overall_predictions = 0
            for image in os.listdir(args['data_path'] + os.sep + label):
                if image.endswith(".png") or image.endswith(".jpg") or image.endswith(".jpeg"):
                    imhelper = cv2.imread(args['data_path'] + os.sep + label + os.sep + image)
                    opencvImage = cv2.cvtColor(np.array(imhelper), cv2.COLOR_RGB2BGR)
                    im = cv2.resize(opencvImage, (400, 400))
                    img = np.expand_dims(im, 0)
                    predict = MODEL.predict(img, verbose = 0).argmax(axis=1)
                    if(labels[count] == labels[predict[0]]):
                        correct_predictions+=1
                    overall_predictions+=1
            predictions.append(f"{label} {correct_predictions/overall_predictions * 100}")
            print(f"INFO: finished {label}")
        print(predictions)
        with open(os.path.dirname(args['model_path']) + os.sep + 'test_data.txt', 'w') as file:
            for prediction in predictions:
                file.write(prediction + '\n')

    
parser = argparse.ArgumentParser()
parser.add_argument('-m', '--model_path', required=False,\
    default=(os.path.dirname(os.path.abspath(__file__)))+ os.sep + "model.h5",\
        type=str, help="Path to the model including path name.")
parser.add_argument('-d', '--data_path', required=True,  type=dir_path, help="Path to the folder with different categories.")
parser.add_argument('-g', '--generate_results', action=argparse.BooleanOptionalAction)
args = vars(parser.parse_args())
main(args)

