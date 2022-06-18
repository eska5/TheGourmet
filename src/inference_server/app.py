import base64
import json
from io import BytesIO

import cv2
import numpy as np
import tensorflow
from PIL import Image
from flask import Flask, request
from flask_cors import CORS

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

labels = [
    "Brokół",
    "Sałatka cezar",
    "Marchewka",
    "Sernik",
    "Skrzydełka kurczaka",
    "Tort czekoladowy",
    "Babeczki",
    "Winniczki",
    "Frytki",
    "Hamburger",
    "Hot dog",
    "Lody",
    "Lasagne",
    "Omlet",
    "Naleśniki",
    "Pizza",
    "Żeberka",
    "Jajecznica",
    "Zupa",
    "Spaghetti bolognese",
    "Spaghetti carbonara",
    "Stek",
    "Sushi",
    "Tiramisu",
    "Gofry",
]


@app.before_first_request
def before_first_request():
    global model
    model = tensorflow.keras.models.load_model("model.h5")


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    model_status = "Not loaded"
    if model is not None:
        model_status = "Loaded"
    return f"App is running. Model status is {model_status}."


@app.route("/catalog", methods=["GET"], strict_slashes=False)
def meals_catalog():
    return json.dumps(labels)


@app.route("/classify", methods=["POST"], strict_slashes=False)
def classify_photo():
    decoded_image = Image.open(BytesIO(base64.b64decode(str(request.json["mealPhoto"]))))
    opencvImage = cv2.cvtColor(np.array(decoded_image.convert("RGB")), cv2.COLOR_RGB2BGR)
    img = np.expand_dims(cv2.resize(opencvImage, (400, 400)), 0)
    predict = model.predict(img)

    predictions = []
    # 3 best labels and probabilities
    for i in range(0, 3):
        predictions.append(labels[predict.argmax(axis=1)[0]])
        predictions.append(str(predict[0][[predict.argmax(axis=1)[0]]][0]))
        predict[0][[predict.argmax(axis=1)[0]]] = 0
    return json.dumps(predictions)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5100)
