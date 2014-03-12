from flask import Flask
from werkzeug.routing import NumberConverter, ValidationError
import json
app = Flask(__name__)

 
class NegativeFloatConverter(NumberConverter):
    regex = r'\-?\d+\.\d+'
    num_convert = float
     
    def __init__(self, map, min=None, max=None):
        NumberConverter.__init__(self, map, 0, min, max)
 
app.url_map.converters['float'] = NegativeFloatConverter

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
