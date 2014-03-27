import QtQuick 2.0

Rectangle {
    id: circle
    radius: 50
    width: 2 * radius
    height: 2 * radius
    color: "yellow"
    border.color: "black"

    MouseArea {
        anchors.fill: parent
        acceptedButtons:  Qt.LeftButton | Qt.RightButton
        onDoubleClicked: circle.destroy();

        onPositionChanged: {
            if (mouse.buttons & Qt.RightButton) {
                circle.radius = Math.abs(x - mouseX);
            }
            if (mouse.buttons & Qt.LeftButton) {
                circle.x -= (x + circle.radius - mouse.x); circle.y -=  (y + circle.radius - mouse.y)
            }
        }
    }
}
