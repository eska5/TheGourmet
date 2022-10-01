import base64
import json
import os
from io import BytesIO

import requests
import yaml
from PIL import Image

BAD_RESULTS_PATH = "data/bad_results"
NEW_IMAGES_PATH = "data/images"


def save_image(title: str, coded_image: str, path: str):
    # If there is no such directory create the dir
    if not os.path.isdir(f"{path}/{title}"):
        os.mkdir(f"{path}/{title}")
        # creating number.txt that counts files
        with open(f"{path}/{title}/number.txt", "a", encoding="utf8") as file:
            file.write("0")
        add_labels(value=title, path=f"{path}/labels.yaml")
    # getting the number
    with open(f"{path}/{title}/number.txt", "r", encoding="utf8") as file:
        image_number = file.read()

    # decoding base64 to a file
    decoded_image = Image.open(BytesIO(base64.b64decode(str(coded_image))))
    image_rgb = decoded_image.convert("RGB")
    image_rgb.save(f"{path}/{title}/{image_number}.jpg")
    image_number = str(int(image_number) + 1)

    # change the number of files in number.txt
    with open(f"{path}/{title}/number.txt", "w", encoding="utf8") as file:
        file.write(str(image_number))


def get_suggestions() -> list:
    with open(f"{NEW_IMAGES_PATH}/labels.yaml", "r", encoding="utf8") as stream:
        suggestions = yaml.safe_load(stream)["suggestions"]
        return sorted(suggestions)


def add_labels(value: str, path: str):
    with open(path, "a") as yaml_file:
        yaml_file.write(f' - "{value}"\n')


def get_meal(meal_name: str) -> dict:
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/findOne"
    payload = json.dumps(
        {
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
            },
        }
    )
    headers = {
        "Content-Type": "application/json",
        "Access-Control-Request-Headers": "*",
        "api-key": "4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7",
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    return json.loads(response.text)["document"]
