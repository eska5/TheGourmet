from flask import Flask, request
from flask_cors import CORS
import tensorflow
import directoryHandler as dirHandler

app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})


@app.before_first_request
def before_first_request():
    global model
    model = tensorflow.keras.models.load_model("model.h5")
    print("model loaded")


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
    # print(type(model))
    # print(
    #    model.summary(
    #        line_length=None,
    #        positions=None,
    #        print_fn=None,
    #        expand_nested=False,
    #        show_trainable=False,
    #    )
    # )
    return dirHandler.classifyThePhoto(photo, model)


@app.route("/suggestions", methods=["GET"], strict_slashes=False)
def suggestMeals():
    suggestions = dirHandler.mealsList()
    return suggestions


@app.route("/badresult", methods=["POST"], strict_slashes=False)
def badresult():
    result = request.json["modeloutput"]
    actual_result = request.json["useroutput"]
    photo = request.json["mealPhoto"]
    response = dirHandler.saveBadResult(result, actual_result, photo)
    return response


if __name__ == "__main__":
    app.run(debug=True)
