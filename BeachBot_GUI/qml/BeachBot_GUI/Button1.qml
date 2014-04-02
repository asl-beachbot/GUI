import QtQuick 2.0


Rectangle {
    id: button
    property int buttonHeight: 75
    property int buttonWidth: 150
    property string label
    property real labelSize: 14

    property color buttonColor: "lightblue"
    property color onHoverColor: "gold"
    property color borderColor: "white"

    radius: 6
    antialiasing: true
    border.width: 2
    border.color: borderColor
    width: buttonWidth
    height: buttonHeight

    Text{
        id: buttonLabel
        anchors.centerIn: parent
        text: label
        color: "#DCDCCC"
        font.pointSize: labelSize
    }

    signal buttonClick()

    onButtonClick: {
        console.log(buttonLabel.text + " clicked")
    }

    MouseArea{
        id: buttonMouseArea
        onClicked: buttonClick()
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.border.color = onHoverColor
        onExited:  parent.border.color = borderColor
    }

    // Determines the color of the button by using the conditional operator
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor

    Behavior on color {ColorAnimation {duration:55}}

    scale:buttonMouseArea.pressed ? 1.1 : 1.0
    Behavior on scale { NumberAnimation{duration:55}}

}
