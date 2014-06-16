import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle{
    id: screen
    width: 2560
    height: 1600
    property real posiX
    property real posiY
    property real angle1
    property var polesX: []
    property var polesY: []
    property int pING_MESSAGE_TYPE: 8
    property int offset: 50
    property string state1: "RELEASED"
    property string state2: "RELEASED"
    property string state3: "RELEASED"
    property string state4: "RELEASED"
    property string state5: "RELEASED"
    property string state6: "RELEASED"
    property string state7: "RELEASED"
    property string color1: "transparent"
    z:0
    FontLoader { id: lily; source: "../pics/LilyScriptOne-Regular.ttf" }

    WebSocket{
        id: socket2
        url: "ws://10.10.0.1:5000/sock"
        onTextMessageReceived: {
            var json2 = JSON.parse(message);
            if (json2.msg_type === 5){
                posiX = mappi.updateposiX(json2.x_l);
                posiY = mappi.updateposiY(json2.y_l);
                angle1 = json2.phi_l;
            }
            else if(json2.msg_type === 4){
                polesX.push(json2.x_p);
                polesY.push(json2.y_p);
            }
        }
        onStatusChanged: if (socket2.status == WebSocket.Error) {
                             console.log("Error: " + socket2.errorString)
                             color1 = "red";
                         } else if (socket2.status == WebSocket.Open) {
                             color1 = "transparent";
                         } else if (socket2.status == WebSocket.Closed) {
                            color1 = "red";
                         }
        active: false
    }
    RakeBox{
        id: rakie
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

    ButtonMain{
        z:6
        id: upi
        buttonLabel: "push"
        buttonColor: "transparent"
        anchors.top: screen.top
        anchors.left: screen.left
        anchors.topMargin: 35
        anchors.leftMargin: 530
        buttonHeight: 100
        buttonWidth: 100
        radius: 100
        onButtonClick:{
            state1 = "RELEASED";
            state2 = "RELEASED";
            state3 = "RELEASED";
            state4 = "RELEASED";
            state5 = "RELEASED";
            state6 = "RELEASED";
            state7 = "RELEASED";
        }
    }
    Text{
        text: "Up"
        font.family: lily.name
        font.pointSize: 35
        anchors.top: screen.top
        anchors.left: screen.left
        anchors.topMargin: 27
        anchors.leftMargin: 425
        z: 6
    }

    ButtonMain{
        z:6
        id: downi
        buttonLabel: "lift"
        buttonColor: "transparent"
        anchors.bottom: screen.bottom
        anchors.left: screen.left
        anchors.bottomMargin: 110
        anchors.leftMargin: 250
        buttonHeight: 100
        buttonWidth: 100
        radius: 100
        onButtonClick:{
            state1 = "PRESSED";
            state2 = "PRESSED";
            state3 = "PRESSED";
            state4 = "PRESSED";
            state5 = "PRESSED";
            state6 = "PRESSED";
            state7 = "PRESSED";
        }
    }
    Text{
        text: "Down"
        font.family: lily.name
        font.pointSize: 35
        anchors.bottom: screen.bottom
        anchors.left: screen.left
        anchors.bottomMargin: 115
        anchors.leftMargin: 382
        z: 6
    }

    ButtonMain{
        z:6
        id: refresh
        buttonLabel: "refresh"
        anchors.right: screen.right
        anchors.top: screen.top
        anchors.rightMargin: 79
        anchors.topMargin: 206
        buttonColor: color1
        onButtonClick:{
            mappi.requestPaint();
        }

    }

    JoyStick{
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
        TestMap{
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
            color: "#F5D0A9"
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
    Timer{
        interval: 20000
        repeat: true
        running: true
        onTriggered: {
            var json8 = {
                "msg_type": pING_MESSAGE_TYPE,
                "ping": "PingPong"
            };
            if(socket2.active){
                socket2.sendTextMessage(JSON.stringify(json8));
            }
            else{
                socket2.active = !socket2.active
            }
        }
    }
}
