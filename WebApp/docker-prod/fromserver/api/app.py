from flask import Flask, redirect, url_for, request
from flask_cors import CORS, cross_origin
import directoryHandler as dirHandler
app = Flask(__name__)
cors = CORS(app, resources={r"/meals": {"origins": "https://gourmet.hopto.org"}})

@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    title = request.json['mealName']
    photo = request.json['mealPhoto']
    dirHandler.SaveAndDecodeMessage(title,photo)
    #msg = "flask received photo with this name " + title
    response = dirHandler.mealsList()
    return response

if __name__ == '__main__':
   app.run(debug = True)
