from flask import Flask, redirect, url_for, request
from flask_cors import CORS, cross_origin
app = Flask(__name__)
cors = CORS(app, resources={r"/meals": {"origins": "http://localhost:3000"}})
@app.route("/meals", methods=["POST"], strict_slashes=False)
def meals():
    title = request.json['mealName']
    body = request.json['mealPhoto']
    #print(title)
    print("test")
    msg = "flask received photo with this name " + title;
    return msg

if __name__ == '__main__':
   app.run(debug = True)