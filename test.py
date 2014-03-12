from flask import Flask
import json
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/test2/<float:angle>/<float:_abs>")
def test2(angle, _abs):   
    l = [angle, _abs]
    print(l)
    return json.dumps(l)
    return "Hello World! ASDSDASDASDSD"

if __name__ == "__main__":
    app.run()
