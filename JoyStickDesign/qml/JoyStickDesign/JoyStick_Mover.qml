import QtQuick 2.0

Rectangle {
    property int moverheight
    property int moverwidth
    property int moverradius: moverheight/2
    height: moverheight
    width: moverwidth

    radius: moverheight / 2


    Image{
        z: 10
        id: moverimage
        width: moverwidth
        height: moverheight
        smooth: true
        source: "../pics/Stick1.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
}
