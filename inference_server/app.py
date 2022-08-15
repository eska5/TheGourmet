import base64
import json
import logging
from io import BytesIO

import cv2
import numpy as np
import tensorflow
import yaml
from PIL import Image
from flask import Flask, request
from flask_cors import CORS

from response_type import ClassifiedMeal

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

logging.basicConfig(
    format='%(asctime)s %(levelname)-8s %(message)s',
    level=logging.INFO,
    datefmt='%Y-%m-%d %H:%M:%S')


@app.before_first_request
def before_first_request():
    global model
    model = tensorflow.keras.models.load_model("model.h5")

    global labels
    with open("catalog.yaml", 'r', encoding='utf8') as stream:
        labels = yaml.safe_load(stream)['catalog']

    global descriptions
    with open("descriptions.yaml", 'r', encoding='utf8') as stream:
        descriptions = yaml.safe_load(stream)['descriptions']


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    model_status = "Not loaded"
    if model is not None:
        model_status = "Loaded"
    return app.response_class(status=200, response=f"App is running. Model status is {model_status}.",
                              content_type='application/json')


@app.route("/catalog", methods=["GET"], strict_slashes=False)
def meals_catalog():
    return app.response_class(response=json.dumps(labels).encode('utf8'),
                              content_type='application/json')


@app.route("/classify", methods=["POST"], strict_slashes=False)
def classify_photo():
    app.logger.info("Running classification on the image...")
    decoded_image = Image.open(BytesIO(base64.b64decode(str(request.json["mealPhoto"]))))
    opencv_image = cv2.cvtColor(np.array(decoded_image.convert("RGB")), cv2.COLOR_RGB2BGR)
    img = np.expand_dims(cv2.resize(opencv_image, (400, 400)), 0)
    app.logger.info("Model is loading...")
    predict = model.predict(img)
    app.logger.info("Model loaded")

    predictions = []

    app.logger.info("Creating predictions...")
    for i in range(0, 7):
        name = labels[predict.argmax(axis=1)[0]]
        certainty = predict[0][[predict.argmax(axis=1)[0]]][0]
        predict[0][[predict.argmax(axis=1)[0]]] = 0
        predictions.append(
            ClassifiedMeal(name=name, description=descriptions[name.lower()], certainty=certainty).to_dict())
    app.logger.info("Predictions created. Classification finished")
    return app.response_class(response=json.dumps(predictions).encode('utf8'),
                              content_type='application/json')


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5100)
