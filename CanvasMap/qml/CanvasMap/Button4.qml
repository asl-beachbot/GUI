import QtQuick 2.0


Rectangle {
    id: button
    property int buttonHeight: 66
    property int buttonWidth: 66
    property string label
    property real labelSize: 14
    property color buttonColor: "transparent"
    property string buttonLabel

    radius: 66
    antialiasing: true
    border.color: "transparent"
    border.width: 2
    width: buttonWidth
    height: buttonHeight

    signal buttonClick()

    onButtonClick: {
        console.log(buttonLabel + " clicked")
    }

    MouseArea{
        id: buttonMouseArea
        onClicked: buttonClick()
        anchors.fill: parent
    }

    // Determines the color of the button by using the conditional operator
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor

    Behavior on color {ColorAnimation {duration:55}}

    scale:buttonMouseArea.pressed ? 1.1 : 1.0
    Behavior on scale { NumberAnimation{duration:55}}

}
