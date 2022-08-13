import base64
import json
import os
from io import BytesIO

import requests
from PIL import Image


def save_image(title: str, coded_image: str):
    # If there is no such directory create the dir
    if not os.path.isdir("data/" + title):
        os.mkdir("data/" + title)
        # creating number.txt that counts files
        with open("data/" + title + "/number.txt", "a", encoding="utf8") as file:
            file.write("0")
        add_suggestion(value=title)
    # getting the number
    with open("data/" + title + "/number.txt", "r", encoding="utf8") as file:
        image_number = file.read()

    # decoding base64 to a file
    decoded_image = Image.open(BytesIO(base64.b64decode(str(coded_image))))
    image_rgb = decoded_image.convert("RGB")
    image_rgb.save("data/" + title + "/" + image_number + ".jpg")
    image_number = int(image_number) + 1

    # change the number of files in number.txt
    with open("data/" + title + "/number.txt", "w", encoding="utf8") as file:
        file.write(str(image_number))


def get_suggestions() -> list:
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/findOne"
    payload = json.dumps({
        "collection": "suggestions",
        "database": "gourmet",
        "dataSource": "Cluster0",
        "filter": {"key": "suggestions"},
    })
    headers = {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': '4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7',
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    raw_data = json.loads(response.text)["document"]
    del raw_data["key"], raw_data["_id"]
    return list(raw_data.values())


def get_meal(meal_name: str) -> dict:
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/findOne"
    payload = json.dumps({
        "collection": "meals",
        "database": "gourmet",
        "dataSource": "Cluster0",
        "filter": {"name": meal_name},
        "projection": {
            "_id": 0,
            "name": 1,
            "calories": 1,
            "allergens": 1,
            "photos": 1,

        }
    })
    headers = {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': '4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7',
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    return json.loads(response.text)["document"]


def add_suggestion(value: str) -> int:
    index = len(get_suggestions())
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/updateOne"
    payload = json.dumps({
        "collection": "suggestions",
        "database": "gourmet",
        "dataSource": "Cluster0",
        "filter": {"key": "suggestions"},
        "update": {"$set": {index: value}}
    })
    headers = {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': '4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7',
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    return response.status_code
