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
    property int offset: 50
    property int cANVAS_MESSAGE_TYPE: 2
    property int sTATE_MESSAGE_TYPE: 6
    property int pING_MESSAGE_TYPE: 8
    property int lineWidth1
    property string state1: "RELEASED"
    property string state2: "RELEASED"
    property string state3: "RELEASED"
    property string state4: "RELEASED"
    property string state5: "RELEASED"
    property string state6: "RELEASED"
    property string state7: "RELEASED"

    FontLoader { id: lily; source: "../pics/LilyScriptOne-Regular.ttf" }

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
            else if(json2.msg_type === 4)
            {
//                var xp = json2.x_p;
//                var yp = json2.y_p;
                polesX.push(json2.x_p);
                polesY.push(json2.y_p);
                console.log(json2.x_p);
                console.log(json2.y_p);
            }
        }
        onStatusChanged: if (socket2.status == WebSocket.Error) {
                             console.log("Error: " + socket2.errorString)
                         } else if (socket2.status == WebSocket.Open) {
                             //socket2.sendTextMessage("Hello World")
                         } else if (socket2.status == WebSocket.Closed) {
                             //messageBox.text += "\nSocket closed"
                         }
        active: true
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

    function updateState1(){
        if(lineWidth1 === 0){
            state1 = "RELEASED";
            state2 = "RELEASED";
            state3 = "RELEASED";
            state4 = "RELEASED";
            state5 = "RELEASED";
            state6 = "RELEASED";
            state7 = "RELEASED";
        }
        if(lineWidth1 === 1){
            state1 = "RELEASED";
            state2 = "RELEASED";
            state3 = "RELEASED";
            state4 = "PRESSED";
            state5 = "RELEASED";
            state6 = "RELEASED";
            state7 = "RELEASED";
        }
        if(lineWidth1 === 2){
            state1 = "RELEASED";
            state2 = "RELEASED";
            state3 = "PRESSED";
            state4 = "PRESSED";
            state5 = "PRESSED";
            state6 = "RELEASED";
            state7 = "RELEASED";
        }
        if(lineWidth1 === 3){
            state1 = "RELEASED";
            state2 = "PRESSED";
            state3 = "PRESSED";
            state4 = "PRESSED";
            state5 = "PRESSED";
            state6 = "PRESSED";
            state7 = "RELEASED";
        }
        if(lineWidth1 === 4){
            state1 = "PRESSED";
            state2 = "PRESSED";
            state3 = "PRESSED";
            state4 = "PRESSED";
            state5 = "PRESSED";
            state6 = "PRESSED";
            state7 = "PRESSED";
        }
    }

    Button4{
        z:6
        id: upi
        buttonLabel: "push"
        anchors.top: screen.top
        anchors.left: screen.left
        anchors.topMargin: 35
        anchors.leftMargin: 530
        buttonHeight: 100
        buttonWidth: 100
        radius: 100
        onButtonClick:{
            if(lineWidth1 < 4){
                lineWidth1 +=1;
            }
            updateState1();
            console.log(lineWidth1)
        }
    }
    Text{
        text: "Plus"
        font.family: lily.name
        font.pointSize: 35
        anchors.top: screen.top
        anchors.left: screen.left
        anchors.topMargin: 27
        anchors.leftMargin: 370
        z: 6
    }

    Button4{
        z:6
        id: downi
        buttonLabel: "lift"
        anchors.bottom: screen.bottom
        anchors.left: screen.left
        anchors.bottomMargin: 110
        anchors.leftMargin: 250
        buttonHeight: 100
        buttonWidth: 100
        radius: 100
        onButtonClick:{
            if(lineWidth1 > 0){
                lineWidth1 -= 1;
            }
            updateState1();
            console.log(lineWidth1)
        }
    }
    Text{
        text: "Minus"
        font.family: lily.name
        font.pointSize: 35
        anchors.bottom: screen.bottom
        anchors.left: screen.left
        anchors.bottomMargin: 115
        anchors.leftMargin: 380
        z: 6
    }

    Button4{
        z:8
        anchors.right: screen.right
        anchors.top: screen.top
        buttonLabel: "refresh"
        anchors.rightMargin: 79
        anchors.topMargin: 206
        buttonColor: "transparent"
        onButtonClick:{
            mappi.requestPaint();
            drawthis.clear();
            drawthis.requestPaint();
        }
    }

    Button4{
        z:8
        id: send
        buttonColor: "green"
        anchors.top: screen.top
        anchors.right: screen.right
        anchors.topMargin: 20
        anchors.rightMargin: 100
        onButtonClick:{
            if(socket2.active){
                var json2 = {
                    "msg_type": cANVAS_MESSAGE_TYPE,
                    "points" : drawthis.sdata
                };
                socket2.sendTextMessage(JSON.stringify(json2))
            }
            else{
                socket2.active = !socket2.active
            }
        }
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
        TestMapCanvas{
            z:10
            id: mappi
            anchors.centerIn: parent
            width1: mapContainer.width
            height1: mapContainer.height
        }
        DrawingArea4{
            id:drawthis
            z:11
            anchors.centerIn: mappi
            width2: mappi.width - 2*offset
            height2: mappi.height - 2*offset
            fieldx: mappi.polesMaxXun - mappi.polesMinXun
            fieldy: mappi.polesMaxYun - mappi.polesMinYun
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
