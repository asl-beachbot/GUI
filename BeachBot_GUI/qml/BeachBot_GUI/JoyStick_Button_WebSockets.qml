import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: button
    property int index
    property int buttonHeight
    property int buttonWidth
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"
    property int bUTTON_MESSAGE_TYPE: 3


    state: "BUTTON_RELEASED"
    radius: 6
    antialiasing: true
    border.width: 2
    border.color: "#0CF785"
    width: buttonWidth
    height: buttonHeight

    z:2


    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent
        onClicked:{
            if(button.state == "BUTTON_PRESSED"){
                button.state = "BUTTON_RELEASED"
                console.log(button.label + " up")

                var json2 = {
                    "msg_type": bUTTON_MESSAGE_TYPE,
                    "index": index,
                    "pressed": 0
                };

                if(socket2.active){
                    socket2.sendTextMessage(JSON.stringify(json2))
                }
                else{
                    socket2.active = !socket2.active
                }

            }
            else if (button.state == "BUTTON_RELEASED"){
                button.state = "BUTTON_PRESSED"
                console.log(button.label + " down")

                var json3 = {
                    "msg_type": bUTTON_MESSAGE_TYPE,
                    "index": index,
                    "pressed": 1
                };

                if(socket2.active){
                    socket2.sendTextMessage(JSON.stringify(json3))
                }
                else{
                    socket2.active = !socket2.active
                }
            }
        }
    }

    states:[
    State{
            name: "BUTTON_PRESSED"
            PropertyChanges{target: button; color:"green"}
        },
    State{
            name: "BUTTON_RELEASED"
            PropertyChanges{target: button; color: "red"}
        }
    ]
    Behavior on color {ColorAnimation {duration:100} }
}
