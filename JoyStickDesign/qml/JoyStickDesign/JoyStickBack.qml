import QtQuick 2.0


Rectangle {
    property int bwidth
    property int bheight
    property double bradius: bwidth/2
    width: bwidth
    height: bheight
    radius: bwidth/2
    z:1
    color: "transparent"
    antialiasing: true
}
