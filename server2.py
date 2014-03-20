from flask import Flask
from werkzeug.routing import NumberConverter, ValidationError
import json
import rospy
from rospy.numpy_msg import numpy_msg
from rospy_tutorials.msg import Floats

import numpy
#from std_msgs.msg import String

app = Flask(__name__)
 
class NegativeFloatConverter(NumberConverter):
    regex = r'\-?\d+\.\d+'
    num_convert = float
     
    def __init__(self, map, min=None, max=None):
        NumberConverter.__init__(self, map, 0, min, max)
 
app.url_map.converters['float'] = NegativeFloatConverter

rospy.init_node('joystick', anonymous=True)


def talker1(x,y):
    pub = rospy.Publisher('stick', numpy_msg(Floats))
    #pub2 = rospy.Publisher('buttons', numpy_msg(Floats))

    #rospy.init_node('talker1', anonymous=True)
    a = numpy.array([x,y], dtype=numpy.float32)
    rospy.loginfo(x)
    rospy.loginfo(y)
    pub.publish(a)

b = numpy.zeros([7,1], dtype=numpy.float32)

def talker2(index, is_pressed):
    pub2 = rospy.Publisher('buttons', numpy_msg(Floats))
    #rospy.init_node('talker2', anonymous=True)
    #b = numpy.zeros([7,1], dtype=numpy.float32)
    if is_pressed == 1:
        b[index-1,0] = 1
    elif is_pressed == 0:
        b[index-1,0] = 0
    else:
    	print("error")
    pub2.publish(b)
    

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/test2/<float:angle>/<float:_abs>")
def test2(angle, _abs):   
    l = [angle, _abs]
    print(l)
    talker1(angle, _abs)
    return json.dumps(l)
    #return "Hello World! ASDSDASDASDSD"

@app.route("/elements/<int:index>/<int:state>")
def test3(index, state):
    p = [index, state]
    print(p)
    talker2(index, state)
    return json.dumps(p)

if __name__ == "__main__":
    app.debug = True
    app.run(host="0.0.0.0", port=5000)
