import base64
import json
import logging
from io import BytesIO

import cv2
import numpy as np
import requests
import tensorflow
import yaml
from PIL import Image
from flask import Flask, request
from flask_cors import CORS
from requests_toolbelt.multipart.encoder import MultipartEncoder

from response_type import ClassifiedMeal

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

MY_KEY = "lWO8hVwoyNSPIZhEjKCU"
MODEL_URL = "https://detect.roboflow.com/dataset-te7wt/1"

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
    return app.response_class(status=200, response=json.dumps(predictions).encode('utf8'),
                              content_type='application/json')


@app.route("/detection", methods=["POST"], strict_slashes=False)
def detect_meal():
    app.logger.info("Running YOLO classification on the image...")

    # Load Image with PIL
    decoded_image = Image.open(BytesIO(base64.b64decode(str(request.json["img_for_detection"]))))
    opencv_image = cv2.cvtColor(np.array(decoded_image.convert("RGB")), cv2.COLOR_RGB2BGR)
    pilImage = Image.fromarray(opencv_image)

    # Convert to JPEG Buffer
    buffered = BytesIO()
    pilImage.save(buffered, quality=100, format="JPEG")

    app.logger.info("Sending request to Roboflow.")
    multipart_form = MultipartEncoder(fields={'file': ("imageToUpload", buffered.getvalue(), "image/jpeg")})
    response = requests.post(f"{MODEL_URL}?api_key={MY_KEY}",
                             data=multipart_form,
                             headers={'Content-Type': multipart_form.content_type})
    predictions = response.json()

    # label list
    detection_labels = []
    for prediction in predictions["predictions"]:
        if prediction["class"] not in detection_labels:
            detection_labels.append(prediction["class"])

    # initialize a list of colors to represent each possible class label
    np.random.seed(42)
    COLORS = np.random.randint(0, 255, size=(len(detection_labels), 3),
                               dtype="uint8")

    # ensure at least one detection exists
    if len(predictions["predictions"]) > 0:
        for index, prediction in enumerate(predictions["predictions"]):
            (x1, y1) = (int(prediction["x"] - prediction['width'] / 2), int(prediction["y"] - prediction['height'] / 2))
            (x2, y2) = (int(prediction["x"] + prediction["width"] / 2), int(prediction["y"] + prediction["height"] / 2))
            color = [int(c) for c in COLORS[detection_labels.index(prediction["class"])]]
            cv2.rectangle(opencv_image, (x1, y1), (x2, y2), color, 2)
            text = "{}: {:.4f}".format(prediction["class"], prediction["confidence"])
            cv2.putText(opencv_image, text, (x1, y1 - 5), cv2.FONT_HERSHEY_SIMPLEX,
                        0.5, color, 2)

    yolo_image = base64.b64encode(cv2.imencode('.jpg', opencv_image)[1]).decode()
    response_body = {
        'detection_result': yolo_image
    }
    app.logger.info("Detection finished.")
    return app.response_class(status=200, response=json.dumps(response_body).encode('utf8'),
                              content_type='application/json')


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5100)
