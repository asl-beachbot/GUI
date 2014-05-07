import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: placeholder
    property int index
    property int buttonHeight:500
    property int buttonWidth:200
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"
    property int bUTTON_MESSAGE_TYPE: 3

    state: "BUTTON_RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight
    color: "transparent"

    Column{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        Rectangle{
            id: rakePin1
            radius: 2
            border.color: "black"
            height: buttonHeight/5
            width: placeholder.width-100
            Behavior on color {ColorAnimation {duration:100}}
            Behavior on width {NumberAnimation {duration: 300}}
        }
        Rectangle{
            id: rakePin2
            radius: 2
            border.color: "black"
            height: buttonHeight/5
            width: placeholder.width-100
            Behavior on color {ColorAnimation {duration:100}}
            Behavior on width {NumberAnimation {duration: 300}}
        }
    }

    states:[
    State{
            name: "BUTTON_PRESSED"
            PropertyChanges{target: rakePin1; color:"green"}
            PropertyChanges{target: rakePin2; color:"green"}
            PropertyChanges{target: rakePin1; width: placeholder.width}
            PropertyChanges{target: rakePin2; width: placeholder.width}

        },
    State{
            name: "BUTTON_RELEASED"
            PropertyChanges{target: rakePin1; color: "red"}
            PropertyChanges{target: rakePin2; color: "red"}
            PropertyChanges{target: rakePin1; width: placeholder.width-100}
            PropertyChanges{target: rakePin2; width: placeholder.width-100}
        }
    ]
}
