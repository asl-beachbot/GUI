import QtQuick 2.0

Rectangle {
    property int moverheight
    property int moverwidth
    property int moverradius: moverheight/2
    height: moverheight
    width: moverwidth

    radius: moverheight / 2

    z: 10

    Image{
        id: moverimage
        width: moverwidth
        height: moverheight
        smooth: true
        source: "../pics/logo_2.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
}
