# pylint: disable=C0330
from PIL import Image
import numpy as np
from io import BytesIO
import requests
import base64
import cv2
import tensorflow

from meals_data import MealsData
from response_type import Meal
from requests_toolbelt.multipart.encoder import MultipartEncoder

MY_KEY = "lWO8hVwoyNSPIZhEjKCU"
MODEL_URL = "https://detect.roboflow.com/dataset-te7wt/4"
MODEL_PATH = "model.h5"


def classification_inference(image: str) -> np.ndarray:
    decoded_image = Image.open(BytesIO(base64.b64decode(image)))
    opencv_image = cv2.cvtColor(
        np.array(decoded_image.convert("RGB")), cv2.COLOR_RGB2BGR
    )
    img = np.expand_dims(cv2.resize(opencv_image, (400, 400)), 0)
    model = tensorflow.keras.models.load_model(MODEL_PATH)
    predict = model.predict(img)
    print(type(predict))
    return predict


def create_classification_predictions(model) -> list:
    predictions = []
    for _ in range(0, 7):
        name = MealsData.get_labels()[model.argmax(axis=1)[0]]
        certainty = model[0][[model.argmax(axis=1)[0]]][0]
        model[0][[model.argmax(axis=1)[0]]] = 0
        predictions.append(
            Meal(
                certainty=certainty,
                description=MealsData.get_descriptions()[name.lower()],
            ).to_dict()
        )
    return predictions


def load_image_for_detection(image: str) -> dict:
    image_from_base64 = Image.open(BytesIO(base64.b64decode(image)))
    numpy_coded_image = np.array(image_from_base64.convert("RGB"))
    image_for_inference = Image.fromarray(cv2.resize(numpy_coded_image, (400, 400)))
    final_image = cv2.cvtColor(
        cv2.resize(numpy_coded_image, (400, 400)), cv2.COLOR_BGR2RGB
    )
    buffered = BytesIO()
    image_for_inference.save(buffered, quality=100, format="JPEG")
    return {"image_for_drawing": final_image, "image_for_inference": buffered}


def detection_inference(image: bytes) -> dict:
    multipart_form = MultipartEncoder(
        fields={"file": ("imageToUpload", image, "image/jpeg")}
    )
    roboflow_response = requests.post(
        f"{MODEL_URL}?api_key={MY_KEY}",
        data=multipart_form,
        headers={"Content-Type": multipart_form.content_type},
    ).json()
    return roboflow_response


def draw_result_image(
    inference_result: dict, image_for_drawing, detected_meals: list
) -> list:
    np.random.seed(42)
    colors = np.random.randint(0, 255, size=(len(detected_meals), 3), dtype="uint8")
    predictions = []

    if inference_result:
        for prediction in inference_result:
            predictions.append(
                Meal(
                    certainty=prediction["confidence"],
                    description=MealsData.get_descriptions()[prediction["class"]],
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
            color = [int(c) for c in colors[detected_meals.index(prediction["class"])]]
            cv2.rectangle(image_for_drawing, (x_1, y_1), (x_2, y_2), color, 2)
            text = "{}: {:.4f}".format(prediction["class"], prediction["confidence"])
            cv2.putText(
                image_for_drawing,
                text,
                (x_1, y_1 - 5),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.5,
                color,
                2,
            )
            yolo_image = {
                "result_image": base64.b64encode(
                    cv2.imencode(".jpg", image_for_drawing)[1]
                ).decode()
            }
            predictions.insert(0, yolo_image)
    return predictions
