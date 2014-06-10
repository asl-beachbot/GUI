import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle{
    id: screen
    width: 2560
    height: 1600
    property real posiX
    property real posiY
    property var poles: []
    property int sTATE_MESSAGE_TYPE: 6

    WebSocket{
        id: socket2
        url: "ws://10.10.0.1:5000/sock"
        onTextMessageReceived: {
            var json2 = JSON.parse(message);
            if (json2.msg_type === 5)
            {
                posiX = mappi.updateposiX(json2.x_l);
                posiY = mappi.updateposiY(json2.y_l);

            }
            else if(poles.length < 20 && json2.msg_type === 4)
            {
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
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        radius: 5
        border.color: "black"
        boxwidth: 250
        boxlength: screen.height-200
    }

    Button4{
        id: refresh
        anchors.top: screen.top
        anchors.left: screen.left
        anchors.topMargin: 20
        anchors.leftMargin: 100
        onButtonClick:{
            mappi.requestPaint();
            var json6 = {
                "msg_type": sTATE_MESSAGE_TYPE,
                "state": 2
            };

            if(socket2.active){
                socket2.sendTextMessage(JSON.stringify(json6))
            }
            else{
                socket2.active = !socket2.active
            }
        }
    }

    Button4{
        id: stop
        buttonColor: "red"
        anchors.top: screen.top
        anchors.right: screen.right
        anchors.topMargin: 20
        anchors.rightMargin: 100
        onButtonClick:{
            var json5 = {
                "msg_type": sTATE_MESSAGE_TYPE,
                "state": 0,
            };

            if(socket2.active){
                socket2.sendTextMessage(JSON.stringify(json5))
            }
            else{
                socket2.active = !socket2.active
            }
        }
    }
    JoyWebSocket{
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        jwidth1: 450
        jheight1: 450
    }
    Rectangle{
        anchors.centerIn: parent
        height: 1400
        width: 1400
        id: mapContainer
        border.color: "black"
        radius: 3
        border.width: 2
        TestMap3{
            id: mappi
            anchors.centerIn: parent
            width1: mapContainer.width
            height1: mapContainer.height
        }
    }
}
