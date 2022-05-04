from flask import Flask, redirect, url_for, request
from flask_cors import CORS, cross_origin
import directoryHandler as dirHandler

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    title = request.json["mealName"]
    photo = request.json["mealPhoto"]
    dirHandler.SaveAndDecodeMessage(title, photo)
    response = dirHandler.mealsList()
    return response


@app.route("/classify", methods=["POST"], strict_slashes=False)
def classify():
    photo = request.json["mealPhoto"]
    return dirHandler.classifyThePhoto(photo)


@app.route("/suggestions", methods=["GET"], strict_slashes=False)
def suggestMeals():
    suggestions = dirHandler.mealsList()
    return suggestions


if __name__ == "__main__":
    app.run(debug=True)
