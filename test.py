from flask import Flask
import json
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/test2/<float:angle>/<float:_abs>")
def test2(angle, _abs):   
    l = {"args": [angle, _abs, 1,3,4,56,6], "other_stuff": "asdasd"}
    l["another_coord"] = {"dict2": [1,23,1]}
    return json.dumps(l)
    return "Hello World! ASDSDASDASDSD"

if __name__ == "__main__":
    app.run()
