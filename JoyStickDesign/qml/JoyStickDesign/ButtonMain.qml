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
    border.color: "transparent"
    border.width: 2
    width: buttonWidth
    height: buttonHeight
    color: buttonColor

    signal buttonClick()

    onButtonClick: {
        console.log(buttonLabel + " clicked")
    }

    MouseArea{
        id: buttonMouseArea
        onClicked: buttonClick()
        anchors.fill: parent
    }
}
