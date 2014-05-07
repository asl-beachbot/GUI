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
    property int offset: 50
    property int cANVAS_MESSAGE_TYPE: 2
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
                angle1 = json2.phi_l;

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
            //console.log(drawthis.svgData)
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
            drawthis.ctx.clearRect(0, 0, drawthis.width, drawthis.height);
            drawthis.sdata = " "
            drawthis.requestPaint()
            drawthis.svgData += drawthis.svgTerminator
            console.log(drawthis.svgData)
            drawthis.svgData = " "
            drawthis.init()
        }
    }

    Button4{
        id: send
        buttonColor: "green"
        anchors.top: stop.bottom
        anchors.right: screen.right
        anchors.topMargin: 20
        anchors.rightMargin: 100
        onButtonClick:{
            if(socket2.active)
            {
                var json2 = {
                    "msg_type": cANVAS_MESSAGE_TYPE,
                    //"lwidth" : drawingArea.lineWidth,
                    "points" : drawthis.sdata
                };
                socket2.sendTextMessage(JSON.stringify(json2))
            }
            else
            {
                socket2.active = !socket2.active
            }
        }
    }

    Rectangle{
        anchors.centerIn: parent
        height: 1400
        width: 1400
        id: mapContainer
        border.color: "black"
        radius: 3
        border.width: 2
        TestMapCanvas{
            id: mappi
            anchors.centerIn: parent
            width1: mapContainer.width
            height1: mapContainer.height
        }
        DrawingArea4{
            id:drawthis
            z:10
            anchors.centerIn: parent
            width2: mappi.width - 2*offset
            height2: mappi.height - 2*offset
            fieldx: mappi.polesMaxXun - mappi.polesMinXun
            fieldy: mappi.polesMaxYun - mappi.polesMinYun
        }
        Component.onCompleted:{
            drawthis.init()
        }
    }
}
