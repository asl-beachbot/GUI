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

    LineToCanv{
        id: asd
    }

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
                linehandler.state = "BUTTON_RELEASED";
                asd.active = false;
                var tmp = Qt.createComponent("StrangeFigure.qml");
                if (tmp.status === Component.Ready)
                {
                    var svg_fig1 = tmp.createObject(screen);
                    mappi.elements.forEach(function(el){
                        el.selected = false;
                    });
                    svg_fig.push(svg_fig1)
                    svg_fig[svg_fig.length -1].getDimensions();
                    svg_fig[svg_fig.length -1].importPath();
                    svg_fig[svg_fig.length -1].selected = true;

                    console.log(svg_fig.length)
                    mappi.elements.push(svg_fig[svg_fig.length -1]);
                    mappi.requestPaint();
                }
            }
        }
        Button4{
            buttonColor: "green"
            label: "Mickey"
            onButtonClick:{
                linehandler.state = "BUTTON_RELEASED";
                asd.active = false;
                var tmp1 = Qt.createComponent("Mickey.qml");
                if (tmp1.status === Component.Ready)
                {
                    svg_mic = tmp1.createObject(screen);
                    svg_mic.getDimensions();
                    svg_mic.importPath();
                    mappi.elements.push(svg_mic);
                    mappi.requestPaint();
                }
            }
        }
        Button2{
            id: linehandler
            buttonColor: "blue"
            label: "DrawLine"
            onButtonClick:{
                mappi.elements.forEach(function(el) {
                    if(el.selected){
                        el.selected = false;
                        console.log("selfalse");
                    }
                });

                if(linehandler.state == "BUTTON_PRESSED"){
                    asd.active = true;
                }
                else if(linehandler.state == "BUTTON_RELEASED"){
                    asd.active = false;
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
                        el.svgCurArr = [];
                        el.svgOldArr = [];
                        el.updateSvgArr();
                        el.selected = false;
                        mappi.requestPaint();
                        mappi.clear();
                        asd.active = false;
                        linehandler.state = "BUTTON_RELEASED";
                });
                mappi.elements = [];
                mappi.elements.push(asd);
                console.log("clear");
            }
        }
        Button4{
            buttonColor: "green"
            label: "2"
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
