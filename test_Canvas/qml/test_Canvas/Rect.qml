import QtQuick 2.0

Rectangle {
    id: rect
    color: "transparent"
    border.color: "black"
    border.width: 5

    width: 50
    height: 50
    MouseArea {
        anchors.fill: parent
        acceptedButtons:  Qt.LeftButton | Qt.RightButton
        onDoubleClicked: rect.destroy();
        onPositionChanged: {
            if (mouse.buttons & Qt.LeftButton) {
                rect.x -= (x + rect.width/2 - mouse.x); rect.y -= (y + rect.height/2 - mouse.y)
            }
            if (mouse.buttons &  Qt.RightButton) {
                rect.width = Math.abs(x - mouseX); rect.height = Math.abs(y - mouseY)
            }
        }
    }
}

