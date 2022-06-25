import json

import requests
from flask import Flask, request
from flask_cors import CORS

import meal_operator as m_operator

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    return f"App is running."


@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    m_operator.save_image(request.json["mealName"], request.json["mealPhoto"])
    return m_operator.list_meals()


@app.route("/suggestions", methods=["GET"], strict_slashes=False)
def suggestions():
    return m_operator.list_meals()


@app.route("/badresult", methods=["POST"], strict_slashes=False)
def bad_result():
    dir_name = f"{request.json['modeloutput']}_{request.json['useroutput']}"
    m_operator.save_image(dir_name, request.json["mealPhoto"])
    return "OK"


@app.route("/details", methods=["GET"], strict_slashes=False)
def meal_details():
    meal_name = "marchewka"
    url = "https://data.mongodb-api.com/app/data-bduvb/endpoint/data/v1/action/findOne"
    payload = json.dumps({
        "collection": "meals",
        "database": "gourmet",
        "dataSource": "Cluster0",
        "filter": {"name": meal_name},
        "projection": {
            "_id": 1,
            "name": 1,
            "calories": 1,
            "alergens": 1,
            "photos": 1,

        }
    })
    headers = {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': '4wyTSiqX9oBUrS8o3X9WnSAwifMFmXfa1DdO39ElkY3WuxjAkOQcUExbDtSXzWJ7',
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    print(response.text)
    return response.text


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
