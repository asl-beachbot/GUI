import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: placeholder
    property int buttonHeight:180
    property int buttonWidth:360
    property string label
    property color buttonColor: "red"
    property color pressedColor: "violet"
    property real labelSize: 25

    state: "BUTTON_RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight

    signal buttonClick()

    onButtonClick:{
        if(placeholder.state === "BUTTON_PRESSED"){
            placeholder.state = "BUTTON_RELEASED"

        }
        else if (placeholder.state === "BUTTON_RELEASED"){
            placeholder.state = "BUTTON_PRESSED"
        }
    }

    Text{
        id: buttonLabel
        anchors.centerIn: parent
        text: label
        color: "#DCDCCC"
        font.pointSize: labelSize
    }

    Behavior on color {ColorAnimation {duration:100}}
    Behavior on width {NumberAnimation {duration: 300}}

    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent
        onClicked:buttonClick()
    }
    states:[
    State{
            name: "BUTTON_PRESSED"
            PropertyChanges{target: placeholder; color:pressedColor}
        },
    State{
            name: "BUTTON_RELEASED"
            PropertyChanges{target: placeholder; color: buttonColor}
        }
    ]
}
