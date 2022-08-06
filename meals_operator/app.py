import json

from flask import Flask, request
from flask_cors import CORS

import meal_operator as m_operator

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    return app.response_class(status=200, response="App is running.", mimetype='application/json')


@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    meal_name = request.json["mealName"]
    meal_photo = request.json["mealPhoto"]

    if meal_photo == "" or meal_name == "":
        return app.response_class(status=400)

    m_operator.save_image(title=meal_name, coded_image=meal_photo)
    return app.response_class(status=201)


@app.route("/suggestions", methods=["GET"], strict_slashes=False)
def suggestions():
    return app.response_class(response=json.dumps(m_operator.get_suggestions()), mimetype='application/json')


@app.route("/badresult", methods=["POST"], strict_slashes=False)
def bad_result():
    bad_result_name = f"{request.json['modeloutput']}_{request.json['useroutput']}"
    bad_result_photo = request.json["mealPhoto"]

    if bad_result_name == "" or bad_result_photo == "":
        return app.response_class(status=400)

    m_operator.save_image(title=bad_result_name, coded_image=request.json["mealPhoto"])
    return app.response_class(status=201)


@app.route("/details", methods=["GET"], strict_slashes=False)
def meal_details():
    meal_details_dict = m_operator.get_meal(meal_name=request.args.get("name"))

    if meal_details_dict is None:
        return app.response_class(status=404)

    return app.response_class(status=200, response=json.dumps(meal_details_dict),
                              mimetype='application/json')


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
