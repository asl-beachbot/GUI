import QtQuick 2.0


Rectangle {
    id: button
    property int buttonHeight: 180
    property int buttonWidth: 360
    property string label
    property real labelSize: 25

    property color buttonColor: "lightblue"
    property color borderColor: "white"
    property color labelColor: "#DCDCCC"

    radius: 10
    antialiasing: true
    border.width: 2
    border.color: borderColor
    width: buttonWidth
    height: buttonHeight

    Text{
        id: buttonLabel
        anchors.centerIn: parent
        text: label
        color: labelColor
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
    }
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor

    Behavior on color {ColorAnimation {duration:55}}

    scale:buttonMouseArea.pressed ? 1.1 : 1.0
    Behavior on scale { NumberAnimation{duration:55}}

}
