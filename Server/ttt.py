from flask import Flask
from werkzeug.routing import NumberConverter, ValidationError
import json
import rospy
from sensor_msgs.msg import Joy

app = Flask(__name__)
 
class NegativeFloatConverter(NumberConverter):
    regex = r'\-?\d+\.\d+'
    num_convert = float
     
    def __init__(self, map, min=None, max=None):
        NumberConverter.__init__(self, map, 0, min, max)
 
app.url_map.converters['float'] = NegativeFloatConverter


def talker1(x, y):
    msg = Joy()
    msg.axes = [0, 0, 0, -x, y, 0]
    msg.buttons = [0,0,0]
    pub2.publish(msg)


def talker2(index, is_pressed):
    msg = Joy()
    msg.axes = [1.2, 3.4]
    msg.buttons = [0,0,0]
    pub2.publish(msg)    

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/test2/<float:x_c>/<float:y_c>")
def test2(x_c, y_c):   
    l = [x_c, y_c]
    #print(l)
    talker1(x_c, y_c)
    return json.dumps(l)
    #return "Hello World! ASDSDASDASDSD"

@app.route("/elements/<int:index>/<int:state>")
def test3(index, state):
    p = [index, state]
    print p
    talker2(index, state)
    return json.dumps(p)

def run():
    rospy.init_node('joystick', anonymous=True, disable_signals=True)
    global pub2
    pub2 = rospy.Publisher('/bbcontrol/joy', Joy)
    app.debug = True
    app.run(host="0.0.0.0", port=5000, threaded=True)
    


if __name__ == "__main__":
    rospy.loginfo("Ros Running")
    print "Running"
    run()
    rospy.loginfo("Ros Running")