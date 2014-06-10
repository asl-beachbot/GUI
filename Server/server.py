# Simple gevent-websocket server
import json
import random
import rospy
import threading
import math
import sys
sys.path.append("/home/beachbot/Programs/pathmaker")
sys.path.append("/home/beachbot/Programs/pathmaker/python")
#from time import sleep

from std_msgs.msg import String
from sensor_msgs.msg import Joy
from geometry_msgs.msg import PoseStamped
from geometry_msgs.msg import PointStamped
from geometry_msgs.msg import Quaternion
from bb_state.msg import State
from localization.msg import beach_map
from tf.transformations import euler_from_quaternion

from flask import Flask, app, render_template

from gevent import pywsgi, sleep
from geventwebsocket import WebSocketServer, WebSocketApplication, Resource
from gevent import Greenlet
import gevent
import gevent.monkey

from beachbot_pathgen import Generator

rospy.init_node("server_node", disable_signals=True)

pub2 = rospy.Publisher('joy', Joy)
pub3 = rospy.Publisher('states', State)

app = Flask(__name__)
@app.route("/hallo")
def hallo():
    return "Hallo!"

msg1 = Joy()
msg1.buttons = [0,0,0,0,0,0,0]  
msg1.axes = [0,0,0,0,0,0]


class WebsocketApp(WebSocketApplication):
    broadcast_rate = rospy.Rate(18)
    def on_open(self):
        print("Websocket Open")
        ros_t = threading.Thread(target=self.ros_thread)
        ros_t.daemon = True
        ros_t.start()
        return
        # self.broadcast_ros(["test"])

    def on_message(self, message):
        if type(message) is str:
            msg = json.loads(message)
            if message is None:
                return
            elif msg["msg_type"] == 1:
                x = msg["x_posi"]
                y = msg["y_posi"]
#                print(x) 
#                print(y)
                msg1.axes = [-float(x), float(y), 0,0,0,0]
#               print("%r" % msg1)
                pub2.publish(msg1)

            elif msg["msg_type"] == 3:
                index1 = msg["index"]
                state1 = msg["pressed"]
                index2 = int(index1)
                state2 = int(state1)
                msg1.buttons[index2-1] = state2
                print(index2)
                print(state2)
 #               print("%r" % msg1)
                pub2.publish(msg1)
            elif msg["msg_type"] == 2:
                #print msg["lwidth"]
                print(msg["points"])
                f = open("filtered.txt","w",0)
                f.write(msg["points"])
            elif msg["msg_type"] == 6:
                state_machine1 = msg["state"]
                state_machine2 = int(state_machine1)
                print(state_machine2)
                msg2 = State()
                msg2.state = state_machine2
                pub3.publish(msg2)
            elif msg["msg_type"] == 7:
                path1 = msg["path"]
                print(path1)
                G = Generator()
                path2 = path1.encode("utf-8")
                G.parse_string(path2)
                G.run_routine()
            elif msg["msg_type"] == 8:
                a = msg["ping"]
                print a
            else:
                #print message
                return
        else:
            return

    def ros_thread(self):

        def pole_subscriber_cb(data):
            for pole in data.poles:
                print pole.point.x
                print pole.point.y
                ret2 = {'msg_type': 4, 'x_p': pole.point.x,'y_p': pole.point.y}
                self.broadcast_ros(ret2)
                self.broadcast_rate.sleep()

        def location_subscriber_cb(data):
            quat= data.pose.orientation
            q = [quat.x, quat.y, quat.z, quat.w]
            roll,pitch,yaw = euler_from_quaternion(q)
            phi = math.degrees(yaw)
            ret1 = {'msg_type': 5, 'x_l':data.pose.position.x, 'y_l':data.pose.position.y, 'phi_l': phi}
            self.broadcast_ros(ret1)
            self.broadcast_rate.sleep()

        rospy.Subscriber("/localization/beach_map", beach_map, pole_subscriber_cb, queue_size=1)
        rospy.Subscriber("/localization/bot_pose", PoseStamped, location_subscriber_cb, queue_size=1)


        rospy.loginfo("starting ros thread")
        print("starting ros thread")
        rospy.spin()



    def broadcast_ros(self, message):
        for client in list(self.ws.handler.server.clients.values()):
            client.ws.send(json.dumps(message))

    def on_close(self, reason):
        print("Connection Closed!", reason)

resource = Resource({
    '^/sock': WebsocketApp,
    '/': app
})

server = WebSocketServer(("", 5000), resource)
server.serve_forever()