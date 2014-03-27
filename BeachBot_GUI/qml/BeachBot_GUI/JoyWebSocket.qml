import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: joystick1
    property int jwidth1: 400
    property int jheight1: 400
    width: jwidth1
    height: jheight1

    property string data: " "

    signal stickPressed()
    signal stickMoved(real x, real y)
    signal stickReleased()

    WebSocket{
        id: socket
        url: "ws://echo.websocket.org"
        onTextMessageReceived: {
            messageBox.text = messageBox.text + "\nReceived message: " + message
        }
        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                         } else if (socket.status == WebSocket.Open) {
                             socket.sendTextMessage("Hello World")
                         } else if (socket.status == WebSocket.Closed) {
                             messageBox.text += "\nSocket closed"
                         }
        active: false
    }

    /*WebSocket {
        id: secureWebSocket
        url: "wss://echo.websocket.org"
        onTextMessageReceived: {
            messageBox.text = messageBox.text + "\nReceived secure message: " + message
        }
        onStatusChanged: if (secureWebSocket.status == WebSocket.Error) {
                             console.log("Error: " + secureWebSocket.errorString)
                         } else if (secureWebSocket.status == WebSocket.Open) {
                             secureWebSocket.sendTextMessage("Hello Secure World")
                         } else if (secureWebSocket.status == WebSocket.Closed) {
                             messageBox.text += "\nSecure socket closed"
                         }
        active: false
    }*/



    onStickMoved: {
        var x_a = -y/((jwidth1-jwidth1*0.33)*0.5)
        var y_a = x/((jwidth1-jwidth1*0.33)*0.5)
        var x_b = x_a.toPrecision(3)
        var y_b = y_a.toPrecision(3)
        console.log(x_b, y_b)

        /*var xmlhttp=new XMLHttpRequest();
        xmlhttp.open('GET', "http://10.10.0.1:5000/test2/" + x_b + "/" + y_b, true);
        //xmlhttp.open('GET', "http://localhost:5000/test2/" + angle2r + "/" + mag2r, true);
        xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4) {
                    console.log(xmlhttp.responseText);
                    //var testjson = JSON.parse(xmlhttp.responseText);
                    //console.log(testjson)
                } else { console.log("fail"); }
            };
        xmlhttp.send(null);*/

        data = x_b + y_b
    }

    onStickReleased: {
        releaseAnimation.restart()
        console.log("RELEASED")
        stickMoved(0,0)

    }

    onStickPressed: {
        releaseAnimation.stop()
        console.log("PRESSED")
    }

    JoyStick_BackGround{
        id: background1
        anchors.centerIn: parent
        bwidth: jwidth1
        bheight: jheight1


        JoyStick_Mover{
            id: mover1
            moverheight: jheight1/3
            moverwidth: jwidth1/3
            anchors.centerIn: parent
        }

        ParallelAnimation{
            id:releaseAnimation
            NumberAnimation{target: mover1.anchors; property: "horizontalCenterOffset"; to: 0; duration: 150; easing.type: Easing.InCubic}
            NumberAnimation{target: mover1.anchors; property: "verticalCenterOffset"; to: 0; duration: 150; easing.type: Easing.InCubic}
        }

        MouseArea{
            id: stickArea
            anchors.fill: parent
            property real backgroundbound : background1.width*0.5 - mover1.width*0.5
            property real backgroundbound2 : backgroundbound * backgroundbound
            property real posX: -mouseY + background1.height*0.5
            property real posY: -mouseX + background1.height*0.5
            property real distance2: posX*posX + posY*posY

            onPressed:{
                stickPressed()
            }

            onReleased: {
                stickReleased()
            }

            onPositionChanged: {
                if(distance2 < backgroundbound2){
                    mover1.anchors.horizontalCenterOffset = -posY
                    mover1.anchors.verticalCenterOffset = -posX
                    stickMoved(posX,posY)
                }
                else{
                    var angle1 = Math.atan2(posY,posX)
                    mover1.anchors.horizontalCenterOffset = - Math.sin(angle1) * backgroundbound
                    mover1.anchors.verticalCenterOffset = - Math.cos(angle1) * backgroundbound
                    stickMoved(Math.cos(angle1)*backgroundbound,Math.sin(angle1)*backgroundbound)
                }
            }

            onClicked: {
                if(socket.active) {
                    socket.sendTextMessage(data)
                }
                else {
                    socket.active = !socket.active
                }
            }
        }
    }

    Text{
            id: messageBox
            text: socket.status == WebSocket.Open ? qsTr("Sending...") : qsTr("Welcome!")
            anchors.verticalCenterOffset: 20
            z:2
        }
}
