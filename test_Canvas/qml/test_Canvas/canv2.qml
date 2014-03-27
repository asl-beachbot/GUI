import QtQuick 2.0

Rectangle {
    width: 360
    height: 360

    property int xpos
    property int ypos

    Canvas {
        id: myCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext('2d')
            ctx.fillStyle = "red"
            ctx.fillRect(xpos-1, ypos-1, 3, 3)

        }

        MouseArea{
            anchors.fill: parent
            onPressed: {
                xpos = mouseX
                ypos = mouseY
                myCanvas.requestPaint()
            }
            onMouseXChanged: {
                xpos = mouseX
                ypos = mouseY
                myCanvas.requestPaint()
            }
            onMouseYChanged: {
                xpos = mouseX
                ypos = mouseY
                myCanvas.requestPaint()
            }
        }

    }

}
