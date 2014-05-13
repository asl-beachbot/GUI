import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: button2
    property int index
    property int buttonHeight:500
    property int buttonWidth
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"
    property int bUTTON_MESSAGE_TYPE: 3
    property string imageSource1: "../pics/RedLight1.png"
    property string imageSource2: "../pics/GreenLight1.png"
    state: "RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight
    color: "transparent"

    Image{
        z: 10
        id: lightImage
        width: buttonWidth*0.9
        height: buttonHeight
        smooth: true
        source: imageSource1
        fillMode: Image.PreserveAspectFit
        anchors{
            verticalCenter: button2.verticalCenter
            horizontalCenter: button2.horizontalCenter
        }
    }

    states:[
    State{
            name: "PRESSED"
            PropertyChanges{target: lightImage; source:imageSource2}
        },
    State{
            name: "RELEASED"
            PropertyChanges{target: lightImage; source:imageSource1}
        }
    ]
}
