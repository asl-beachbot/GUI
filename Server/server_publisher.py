# Simple gevent-websocket server
import json
import random
import rospy
import threading

#from time import sleep

from std_msgs.msg import String
from sensor_msgs.msg import Joy
from geometry_msgs.msg import PoseStamped

from flask import Flask, app, render_template

from gevent import pywsgi, sleep
from geventwebsocket import WebSocketServer, WebSocketApplication, Resource
from gevent import Greenlet
import gevent
import gevent.monkey

# gevent.monkey.patch_all()

# Register ros node
rospy.init_node("server_node", disable_signals=True)

pub2 = rospy.Publisher('joy', Joy)

app = Flask(__name__)
@app.route("/hallo")
def hallo():
    return "Hallo!"

msg1 = Joy()
msg1.buttons = [0,0,0,0,0,0,0,0,0,0]

def remove_duplicates(filename):
    numbers = []
    with open(filename) as g:
        for line in g:
            if not len(line.strip()) == 0:            
                numbers.append([int(n) for n in line.strip().split(' ')])
            elif len(line.strip()) == 0:
                numbers.append([0,0])
    x_1, y_1 = numbers[0]
    for pair in numbers[1:]:
        try:
            if x_1 == pair[0] and y_1 == pair[1]:
                print "jes"
                numbers.remove(pair)
            x_1,y_1 = pair[0],pair[1]
        except IndexError:
            print "Errororro"
    string2 = ''
    for pair1 in numbers:
        string2 += str(pair1[0]) + " " + str(pair1[1]) + "\n"
    h = open("filtered.txt", "w")
    h.write(string2)
    print numbers            

class WebsocketApp(WebSocketApplication):
    broadcast_rate = rospy.Rate(1.0)
    def on_open(self):
        print "Websocket Open"
        #pub2 = rospy.Publisher('joy', Joy)
        ros_t = threading.Thread(target=self.ros_thread)
        ros_t.daemon = True
        ros_t.start()
        return
        # self.broadcast_ros(["test"])

    def on_message(self, message):
#        if message is None:
#            return
#        elif message is String:
#            print message
#            return
#        else:
        msg = json.loads(message)
        #msg1 = Joy()
        if message is None:
            return
        elif msg["msg_type"] == 1:
            x = msg["x_posi"]
            y = msg["y_posi"]
            print x 
            print y
            msg1.axes = [0, 0, 0, -float(x), float(y), 0]
            pub2.publish(msg1)

        elif msg["msg_type"] == 3:
            index1 = msg["index"]
            state1 = msg["pressed"]
            index2 = int(index1)
            state2 = int(state1)
            #msg1.buttons = [0,0,0,0,0,0,0,0,0,0]

            #msg1.buttons = [a,b,c,d,e,f,g,0,0,0]
            msg1.buttons[index2-1] = state2
            print index2
            print state2
            pub2.publish(msg1)
        elif msg["msg_type"] == 2:
            #print msg["lwidth"]
            print msg["points"]
            f = open("asd.txt","w",0)
            f.write(msg["points"])
            remove_duplicates("asd.txt")
        else:
            #print message
            return

    def ros_thread(self):
        def location_subscriber_cb(data):
            ret = [data.pose.position.x, data.pose.position.y] #data.pose.orientation.w]
            rospy.loginfo("Location: \n %s \n %s", data.pose.position.x, data.pose.position.y)
            self.broadcast_ros(ret)
            self.broadcast_rate.sleep()
            #print data.pose.position.x
            #print data.pose.position.y
            #print data.pose.position.x
            #print data.pose.position.y
            #print data.pose.orientation.z
            #print data.pose.orientation.w

        rospy.Subscriber("/localization/bot_pose", PoseStamped, location_subscriber_cb, queue_size=1)
        rospy.loginfo("starting ros thread")
        print "starting ros thread"
        #print data.pose.position.x
        #print data.pose.position.y
        rospy.spin()



    def broadcast_ros(self, message):
        for client in self.ws.handler.server.clients.values():
            client.ws.send(json.dumps(message))

    def on_close(self, reason):
        print "Connection Closed!", reason

resource = Resource({
    '^/sock': WebsocketApp,
    '/': app
})

server = WebSocketServer(("", 5000), resource)
server.serve_forever()


# def location_subscriber_cb(data):
#     rospy.loginfo("Location: %s", data.data)

# rospy.Subscriber("/chatter", String, location_subscriber_cb)
# rospy.loginfo("starting ros thread")
# rospy.spin()

# server.serve_forever()
# gevent.joinall([
#     server.start(),
#     ros_t.start()
#     ]
# )

# def do_all_the_rest():
#     if _webs is not None:
#         _webs.send(json.dumps({"x":"12"}))

# while True:
#     do_all_the_rest()

# gevent.joinall(jobs)

# RosGreenlet().spawn()
# g.start()
# g.join()

