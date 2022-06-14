from flask import Flask, request
from flask_cors import CORS

import operator

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/ping", methods=["GET"], strict_slashes=False)
def app_health_check():
    return f"App is running."


@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    operator.save_image(request.json["mealName"], request.json["mealPhoto"])
    return operator.mealsList()


@app.route("/suggestions", methods=["GET"], strict_slashes=False)
def suggestions():
    return operator.mealsList()


@app.route("/badresult", methods=["POST"], strict_slashes=False)
def bad_result():
    dir_name = f"{request.json['modeloutput']}_{request.json['useroutput']}"
    operator.save_image(dir_name, request.json["mealPhoto"])
    return "OK"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
