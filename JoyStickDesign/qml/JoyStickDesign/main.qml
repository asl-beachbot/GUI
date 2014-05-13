import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle{
    id: screen
    width: 2560
    height: 1600
    property real posiX
    property real posiY
    property real angle1
    property var poles: []
    property int sTATE_MESSAGE_TYPE: 6
    property string state1
    property string state2
    property string state3
    property string state4
    property string state5
    property string state6
    property string state7
    z:0

    WebSocket{
        id: socket2
        url: "ws://10.10.0.1:5000/sock"
        onTextMessageReceived: {
            var json2 = JSON.parse(message);
            if (json2.msg_type === 5){
                posiX = mappi.updateposiX(json2.x_l);
                posiY = mappi.updateposiY(json2.y_l);
                angle1 = json2.phi_l;
                console.log(angle1)
            }
            else if(poles.length < 20 && json2.msg_type === 4){
                poles.push({
                    x: json2.x_p,
                    y: json2.y_p
                });
            }
        }
        onStatusChanged: if (socket2.status == WebSocket.Error) {
                             console.log("Error: " + socket2.errorString)
                         } else if (socket2.status == WebSocket.Open) {
                             //socket2.sendTextMessage("Hello World")
                         } else if (socket2.status == WebSocket.Closed) {
                             //messageBox.text += "\nSocket closed"
                         }
        active: false
    }
    RakeBox2{
        z:10
        anchors{
            left: parent.left
            leftMargin: 50
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -25
        }
        radius: 5
        boxwidth: 240
        boxlength: screen.height-300
    }

    LightBox{
        z:10
        id: lighti
        anchors{
            left: parent.left
            leftMargin: 350
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -25
        }
        lightwidth: 240
        lightlength: screen.height-300
    }

//    Button4{
//        id: refresh
//        anchors.top: screen.top
//        anchors.left: screen.left
//        anchors.topMargin: 20
//        anchors.leftMargin: 100
//        onButtonClick:{
//            mappi.requestPaint();
//            var json6 = {
//                "msg_type": sTATE_MESSAGE_TYPE,
//                "state": 2
//            };

//            if(socket2.active){
//                socket2.sendTextMessage(JSON.stringify(json6))
//            }
//            else{
//                socket2.active = !socket2.active
//            }
//        }
//    }

//    Button4{
//        id: stop
//        buttonColor: "red"
//        anchors.top: screen.top
//        anchors.right: screen.right
//        anchors.topMargin: 20
//        anchors.rightMargin: 100
//        onButtonClick:{
//            var json5 = {
//                "msg_type": sTATE_MESSAGE_TYPE,
//                "state": 0,
//            };

//            if(socket2.active){
//                socket2.sendTextMessage(JSON.stringify(json5))
//            }
//            else{
//                socket2.active = !socket2.active
//            }
//        }
//    }
    JoyWebSocket{
        z:10
        anchors.right: parent.right
        anchors.rightMargin: 88
        anchors.verticalCenter: screen.verticalCenter
        anchors.verticalCenterOffset: -17
        jwidth1: 390
        jheight1: 390
    }
    Rectangle{
        z:10
        anchors{
            horizontalCenter: screen.horizontalCenter
            verticalCenter: screen.verticalCenter
            verticalCenterOffset: -16
            horizontalCenterOffset: 22
        }

        height: 1100
        width: 1100
        id: mapContainer
        color: "transparent"
        radius: 3
        border.width: 4
        TestMap3{
            z:10
            id: mappi
            anchors.centerIn: parent
            width1: mapContainer.width
            height1: mapContainer.height
        }
        Rectangle{
            z:5
            anchors.centerIn: parent
            height: 1135
            width: 1305
            color: "#FE9A2E"
            radius: 20
        }
    }
    Image{
        z:0
        id: baseImage
        width: screen.width
        height: screen.height
        smooth: true
        source: "../pics/Base1.png"
        fillMode: Image.Stretch
        anchors.centerIn: screen
    }
}
