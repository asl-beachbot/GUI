import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
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
    property int pIC_MESSAGE_TYPE: 7
    property var svg_fig: []
    property var svg_mic: []
    property var line_arr: []
    property var star: []
    property var svg_head: []
    property int pING_MESSAGE_TYPE: 8

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
        active: true
    }
    Button4{
        property int linewidth3: 1
        anchors{
            left:screen.left
            top: screen.top
            leftMargin: 150
            topMargin: 50
        }
        id: whandler
        buttonHeight: 250
        buttonWidth: 250
        radius: 250
        labelColor: "orange"
        buttonColor: "yellow"
        label: "Width: " + linewidth3
        onButtonClick:{
            if(linewidth3 < 4){
                linewidth3 += 1;
            }
            else{
                linewidth3 = 1;
            }
        }
        states:[
        State{
                name: "BUTTON_ACTIVE"
                PropertyChanges{target: whandler; color: whandler.buttonColor}
                PropertyChanges{target: whandler; color: "orange"}
            },
        State{
                name: "BUTTON_RELEASED"
                PropertyChanges{target: whandler; color: "transparent"}
                PropertyChanges{target: whandler; labelColor: "transparent"}
            }
        ]
    }
    function createStuff(nameFile,arr){
        var tmp1 = Qt.createComponent(nameFile);
        if (tmp1.status === Component.Ready){
            var tmp2= tmp1.createObject(screen);
            mappi.elements.forEach(function(el){
                el.selected = false;
                el.active = false;
                mappi.requestPaint();
                mappi.clear();
            });
            arr.push(tmp2)
            if(arr[arr.length -1].type === 2){
//                arr[arr.length -1].getDimensions();
//                arr[arr.length -1].getDimensions2();
                arr[arr.length -1].importPath();
                arr[arr.length -1].selected = true;
            }
            else if(arr[arr.length -1].type === 3){
                arr[line_arr.length - 1].active = true;
                arr[line_arr.length - 1].state = "RELEASED";
                arr[line_arr.length - 1].lineWidth1 = whandler.linewidth3;
            }
            mappi.elements.push(arr[arr.length -1]);
            mappi.requestPaint();
        }
    }
    Column{
        anchors{
            left: screen.left
            leftMargin: 100
            verticalCenter: screen.verticalCenter
        }
        id: actionContainer
        spacing: 30
        Button4{
            buttonColor: "red"
            label: "Figure"
            onButtonClick:{
                createLine.state = "BUTTON_RELEASED";
                createStuff("StrangeFigure.qml",svg_fig);
            }
        }
        Button4{
            buttonColor: "magenta"
            label: "Star"
            onButtonClick:{
                createLine.state = "BUTTON_RELEASED";
                createStuff("Star.qml", star);
            }
        }

        Button4{
            buttonColor: "green"
            label: "Mickey"
            onButtonClick:{
                createLine.state = "BUTTON_RELEASED";
                createStuff("Mickey.qml",svg_mic);
            }
        }

        Button4{
            buttonColor: "yellow"
            label: "Mickey Head"
            onButtonClick:{
                createLine.state = "BUTTON_RELEASED";
                createStuff("MickeyHead.qml", svg_head);
            }
        }

        Button2{
            id: createLine
            buttonColor: "orange"
            label: "CreateLine"
            onButtonClick:{
                if(createLine.state == "BUTTON_PRESSED"){
                    createStuff("LineToCanv.qml",line_arr)
                }
                else if(createLine.state == "BUTTON_RELEASED"){
                    mappi.elements.forEach(function(el){
                        el.active = false;
                    });
                }
            }
        }
    }
    Column{
        anchors{
            right: screen.right
            rightMargin: 100
            verticalCenter: screen.verticalCenter
        }
        id:menuContainer
        spacing: 30
        Button4{
            buttonColor: "red"
            label: "Delete All"
            onButtonClick: {
                mappi.elements.forEach(function(el) {
                    el.path2 = " ";
                    el.path1 = " ";
                    el.svgCurArr = [];
                    el.svgOldArr = [];
                    el.updateSvgArr();
                    el.selected = false;
                    el.points = [];
                    el.active = false;
                    el.currTransX2Curr = 6000;
                    el.currTransY2Curr = 6000;
                });
                mappi.svgOutput = " ";
                mappi.requestPaint();
                mappi.clear();
                createLine.state = "BUTTON_RELEASED";
                svg_fig = [];
                svg_mic = [];
                line_arr = [];
                star = [];
                svg_head = [];
                mappi.elements = [];
                console.log("clear");
            }
        }
        Button4{
            buttonColor: "green"
            label: "Show"
            onButtonClick:{
                mappi.exportToSVG();
                if(socket2.active){
                    var json2 = {
                        "msg_type": pIC_MESSAGE_TYPE,
                        "path": mappi.svgOutput
                    };
                    socket2.sendTextMessage(JSON.stringify(json2))
                }
                else{
                    socket2.active = !socket2.active
                }
                console.log(mappi.svgOutput);
                mappi.svgOutput = " ";
            }
        }
        Button4{
            buttonColor: "red"
            label: "Delete Element"
            onButtonClick:{
                mappi.elements.forEach(function(el) {
                     if(el.selected){
                        el.path2 = "";
                        el.path1 = "";
                        el.svgCurArr = [];
                        el.svgOldArr = [];
                        el.updateSvgArr();
                        el.currTransX2Curr = 6000;
                        el.currTransY2Curr = 6000;
                        el.selected = false;
                        el.points = [];
                        el.active = false;
                    }
                });
                mappi.requestPaint();
                mappi.clear();
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
            anchors.centerIn: mapContainer
            width1: mapContainer.width-2*offset
            height1: mapContainer.height-2*offset
            MousePinch{
                id: pinchi
            }
        }
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
