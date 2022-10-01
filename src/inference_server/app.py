import base64
import json
import logging
from io import BytesIO

import yaml
import requests
import cv2
import numpy as np
import tensorflow
from PIL import Image
from flask import Flask, request
from flask_cors import CORS
from requests_toolbelt.multipart.encoder import MultipartEncoder

from response_type import Meal

app = Flask(__name__)  # pylint: disable=C0103
CORS = CORS(app, resources={r"/*": {"origins": "*"}})

MY_KEY = "lWO8hVwoyNSPIZhEjKCU"
MODEL_URL = "https://detect.roboflow.com/dataset-te7wt/4"
MODEL = None
LABELS = []
logging.basicConfig(
    format="%(asctime)s %(levelname)-8s %(message)s",
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
)

with open("descriptions.yaml", "r", encoding="utf8") as stream:
    DESCRIPTIONS = yaml.safe_load(stream)["descriptions"]


for key in DESCRIPTIONS.keys():
    LABELS.append(key)


@app.before_first_request
def before_first_request():
    app.logger.info("Server is preparing for inference...")
    global MODEL
    MODEL = tensorflow.keras.models.load_model("model.h5")
    app.logger.info("Done.")


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    model_status = "Not loaded"
    if MODEL is not None:
        model_status = "Loaded"
    return app.response_class(
        status=200,
        response=f"App is running. Model status is {model_status}.",
        content_type="application/json",
    )


@app.route("/catalog", methods=["GET"], strict_slashes=False)
def meals_catalog():
    app.logger.info("Creating meal catalog...")
    catalog = []
    for meal in LABELS:
        catalog.append(DESCRIPTIONS[meal]["name"])
    return app.response_class(
        response=json.dumps(catalog).encode("utf8"), content_type="application/json"
    )


@app.route("/classify", methods=["POST"], strict_slashes=False)
def classify_photo():
    app.logger.info("Running classification on the image...")
    decoded_image = Image.open(BytesIO(base64.b64decode(str(request.json["image"]))))
    opencv_image = cv2.cvtColor(
        np.array(decoded_image.convert("RGB")), cv2.COLOR_RGB2BGR
    )
    img = np.expand_dims(cv2.resize(opencv_image, (400, 400)), 0)
    app.logger.info("Model is loading...")
    predict = MODEL.predict(img)
    app.logger.info("Model loaded")

    predictions = []

    app.logger.info("Creating predictions")
    for _ in range(0, 7):
        name = LABELS[predict.argmax(axis=1)[0]]
        certainty = predict[0][[predict.argmax(axis=1)[0]]][0]
        predict[0][[predict.argmax(axis=1)[0]]] = 0
        predictions.append(
            Meal(certainty=certainty, description=DESCRIPTIONS[name.lower()]).to_dict()
        )
    app.logger.info("Classification finished.")
    return app.response_class(
        response=json.dumps(predictions).encode("utf8"), content_type="application/json"
    )


@app.route("/detection", methods=["POST"], strict_slashes=False)
def detect_meal():  # pylint: disable=R0914
    app.logger.info("Running YOLO classification on the image...")

    app.logger.info("Loading image from base64")
    image_from_base64 = Image.open(
        BytesIO(base64.b64decode(str(request.json["image"])))
    )
    numpy_coded_image = np.array(image_from_base64.convert("RGB"))
    image_for_inference = Image.fromarray(cv2.resize(numpy_coded_image, (400, 400)))
    final_image = cv2.cvtColor(
        cv2.resize(numpy_coded_image, (400, 400)), cv2.COLOR_BGR2RGB
    )

    app.logger.info("Creating JPEG buffer")
    buffered = BytesIO()
    image_for_inference.save(buffered, quality=100, format="JPEG")

    app.logger.info("Sending request to Roboflow")
    multipart_form = MultipartEncoder(
        fields={"file": ("imageToUpload", buffered.getvalue(), "image/jpeg")}
    )
    roboflow_response = requests.post(
        f"{MODEL_URL}?api_key={MY_KEY}",
        data=multipart_form,
        headers={"Content-Type": multipart_form.content_type},
    ).json()

    app.logger.info(f"Response from Roboflow model: {roboflow_response}")

    predictions = []
    detection_result = []
    for prediction in roboflow_response["predictions"]:
        if prediction["class"] not in detection_result:
            detection_result.append(prediction["class"])

    app.logger.info("Drawing result on the new image")
    np.random.seed(42)
    colors = np.random.randint(0, 255, size=(len(detection_result), 3), dtype="uint8")

    if roboflow_response["predictions"]:
        for prediction in roboflow_response["predictions"]:
            predictions.append(
                Meal(
                    certainty=prediction["confidence"],
                    description=DESCRIPTIONS[prediction["class"]],
                ).to_dict()
            )

            (x_1, y_1) = (
                int(prediction["x"] - prediction["width"] / 2),
                int(prediction["y"] - prediction["height"] / 2),
            )
            (x_2, y_2) = (
                int(prediction["x"] + prediction["width"] / 2),
                int(prediction["y"] + prediction["height"] / 2),
            )
            color = [
                int(c) for c in colors[detection_result.index(prediction["class"])]
            ]
            cv2.rectangle(final_image, (x_1, y_1), (x_2, y_2), color, 2)
            text = "{}: {:.4f}".format(prediction["class"], prediction["confidence"])
            cv2.putText(
                final_image,
                text,
                (x_1, y_1 - 5),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.5,
                color,
                2,
            )

    app.logger.info(f"Inference results: {predictions}")
    yolo_image = {
        "result_image": base64.b64encode(cv2.imencode(".jpg", final_image)[1]).decode()
    }
    predictions.insert(0, yolo_image)
    app.logger.info("Detection finished.")
    return app.response_class(
        status=200,
        response=json.dumps(predictions).encode("utf8"),
        content_type="application/json",
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5100)
