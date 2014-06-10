# Simple gevent-websocket server
import json
import random
import rospy
import threading

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

JOY_MESSAGE = 1
LOCATION_MESSAGE = 2

# Register ros node
rospy.init_node("server_node", disable_signals=True)

app = Flask(__name__)
@app.route("/hallo")
def hallo():
    return "Hallo!"


class WebsocketApp(WebSocketApplication):
    broadcast_rate = rospy.Rate(0.1)
    def on_open(self):
        print "Websocket Open"
        ros_t = threading.Thread(target=self.ros_thread)
        ros_t.daemon = True
        ros_t.start()
        return
        # self.broadcast_ros(["test"])

    def on_message(self, message):
        if message is None:
            return
        if message.msg_type == JOY_MESSAGE:
        print(message)

    def ros_thread(self):
        def location_subscriber_cb(data):
            rospy.loginfo("Location: %s", data.pose.position.x)
            ret = [data.pose.position.x, data.pose.position.y, data.pose.position.z]
            self.broadcast_ros(ret)
            self.broadcast_rate.sleep()
        rospy.Subscriber("/localization/bot_pose", PoseStamped, location_subscriber_cb, queue_size=1)
        rospy.loginfo("starting ros thread")
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
