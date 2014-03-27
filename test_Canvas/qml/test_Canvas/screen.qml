import QtQuick 2.0

Rectangle {
    id: screen
    width: 2560
    height: 1600
    property int partition1: width/10
    property int partition2: height/16

    Working {
        id: menuBar
        barheight: partition2
        barwidth: screen.width
        z: 1
    }

    DrawingArea{
        id: drawingArea
        anchors.top: menuBar.bottom
        height: 19*partition2
        width: screen.width
        drawColor: "#FF4000"
    }
}
