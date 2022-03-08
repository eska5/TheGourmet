from flask import Flask, redirect, url_for, request
from flask_cors import CORS, cross_origin
import dictionary as meal_dict
import directoryHandler as dirHandler
app = Flask(__name__)
cors = CORS(app, resources={r"/meals": {"origins": "http://localhost:3000"}})

@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    title = request.json['mealName']
    photo = request.json['mealPhoto']
    #meal_dict.MealsIndex(title)
    dirHandler.SaveAndDecodeMessage(title,photo)
    msg = "flask received photo with this name " + title
    return msg

if __name__ == '__main__':
   app.run(debug = True)