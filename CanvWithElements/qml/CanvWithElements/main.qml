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
    property var svg_fig: []
    property var svg_mic: []
    property var line_arr: []

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
        property int linewidth3: 1
        anchors{
            left:screen.left
            top: screen.top
            leftMargin: 150
            topMargin: 100
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
                var tmp = Qt.createComponent("StrangeFigure.qml");
                if (tmp.status === Component.Ready){
                    var svg_fig1 = tmp.createObject(screen);
                    mappi.elements.forEach(function(el){
                        el.selected = false;
                        el.active = false;
                    });
                    svg_fig.push(svg_fig1)
                    svg_fig[svg_fig.length -1].getDimensions();
                    svg_fig[svg_fig.length -1].importPath();
                    svg_fig[svg_fig.length -1].selected = true;
                    mappi.elements.push(svg_fig[svg_fig.length -1]);
                    mappi.requestPaint();
                }
            }
        }
        Button4{
            buttonColor: "green"
            label: "Mickey"
            onButtonClick:{
                createLine.state = "BUTTON_RELEASED";
                var tmp1 = Qt.createComponent("Mickey.qml");
                if (tmp1.status === Component.Ready){
                    var svg_mic1 = tmp1.createObject(screen);
                    mappi.elements.forEach(function(el){
                        el.selected = false;
                        el.active = false;
                    });
                    svg_mic.push(svg_mic1);
                    svg_mic[svg_mic.length - 1].getDimensions();
                    svg_mic[svg_mic.length - 1].importPath();
                    svg_mic[svg_mic.length - 1].selected = true;
                    mappi.elements.push(svg_mic[svg_mic.length - 1]);
                    mappi.requestPaint();
                }
            }
        }
        Button2{
            id: createLine
            buttonColor: "orange"
            label: "CreateLine"
            onButtonClick:{
                if(createLine.state == "BUTTON_PRESSED"){
                    var tmp2 = Qt.createComponent("LineToCanv.qml");
                    if (tmp2.status === Component.Ready){
                        var line_arr1 = tmp2.createObject(screen);
                        mappi.elements.forEach(function(el){
                            el.selected = false;
                            mappi.requestPaint();
                            mappi.clear();
                        });
                        line_arr.push(line_arr1);
//                        line_arr[line_arr.length - 1].getDimensions();
//                        line_arr[line_arr.length - 1].importPath();
                        line_arr[line_arr.length - 1].active = true;
                        line_arr[line_arr.length - 1].lineWidth1 = whandler.linewidth3;
                        mappi.elements.push(line_arr[line_arr.length - 1]);
                        mappi.requestPaint();
                    }
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
            label: "Delete"
            onButtonClick: {
                mappi.elements.forEach(function(el) {
                        el.path1 = " ";
                        svg_fig = [];
                        svg_mic = [];
                        line_arr = [];
                        el.svgCurArr = [];
                        el.svgOldArr = [];
                        el.updateSvgArr();
                        el.selected = false;
                        el.points = [];
                        el.active = false;
                        mappi.requestPaint();
                        mappi.clear();
                        createLine.state = "BUTTON_RELEASED";
                });
                mappi.elements = [];
                console.log("clear");
            }
        }
        Button4{
            buttonColor: "green"
            label: "Show"
            onButtonClick:{
                console.log(asd.svgData.length);
            }
        }
        Button4{
            buttonColor: "blue"
            label: "3"
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
}
