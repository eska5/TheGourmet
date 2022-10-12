import json
import logging

from flask import Flask, request
from flask_cors import CORS

from inference_operator import (
    classification_inference,
    create_classification_predictions,
    load_image_for_detection,
    detection_inference,
    draw_result_image,
    MODEL,
)
from meals_data import MealsData

app = Flask(__name__)  # pylint: disable=C0103
CORS = CORS(app, resources={r"/*": {"origins": "*"}})

logging.basicConfig(
    format="%(asctime)s %(levelname)-8s %(message)s",
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
)


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    model_status = "not loaded"
    if MODEL is not None:
        model_status = "loaded"
    return app.response_class(
        status=200,
        response=f"App is running. Model is {model_status}.",
        content_type="application/json",
    )


@app.route("/catalog", methods=["GET"], strict_slashes=False)
def meals_catalog():
    app.logger.info("Creating meal catalog...")
    catalog = MealsData.get_catalog()
    return app.response_class(
        response=json.dumps(catalog).encode("utf8"), content_type="application/json"
    )


@app.route("/classify", methods=["POST"], strict_slashes=False)
def classify_photo():
    app.logger.info("Running classification on the image...")
    classification_model = classification_inference(str(request.json["image"]))
    app.logger.info("Model loaded")

    app.logger.info("Creating predictions")
    predictions = create_classification_predictions(model=classification_model)
    app.logger.info("Classification finished.")

    return app.response_class(
        response=json.dumps(predictions).encode("utf8"), content_type="application/json"
    )


@app.route("/detection", methods=["POST"], strict_slashes=False)
def detect_meal():  # pylint: disable=R0914
    app.logger.info("Running YOLO classification on the image...")

    app.logger.info("Loading image from base64")
    loaded_image = load_image_for_detection(image=str(request.json["image"]))

    app.logger.info("Sending request to Roboflow")
    inference_result = detection_inference(image=loaded_image["image_for_inference"])
    app.logger.info(f"Response from Roboflow model: {inference_result}")

    detected_meals = []
    for prediction in inference_result["predictions"]:
        if prediction["class"] not in detected_meals:
            detected_meals.append(prediction["class"])

    app.logger.info("Drawing result on the new image")
    predictions = draw_result_image(
        inference_result=inference_result["predictions"],
        image_for_drawing=loaded_image["image_for_drawing"],
        detected_meals=detected_meals,
    )
    app.logger.info("Detection finished.")
    return app.response_class(
        status=200,
        response=json.dumps(predictions).encode("utf8"),
        content_type="application/json",
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5100)  # pragma: no cover
