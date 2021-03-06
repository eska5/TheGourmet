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
    return m_operator.get_meal_from_db(dict(request.headers)["Meal-Name"])


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
