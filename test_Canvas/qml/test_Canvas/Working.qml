import QtQuick 2.0
//import FileDialog 1.0
import QtQuick.Controls 1.0

Rectangle {
    id: menuBar
    property int barwidth
    property int barheight
    width: barwidth; height: barheight
    color:"transparent"
    border.color: "black"
    border.width: 1

    /*Directory{
        id:directory
        filename: "asd"
        //onDirectoryChanged: fileDialog.notifyRefresh()
    }*/

    Column {
        anchors.fill: parent
        z: 1
        Rectangle {
            height:menuBar.height
            width: menuBar.width
            color: "beige"
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#8C8F8C" }
                GradientStop { position: 0.17; color: "#6A6D6A" }
                GradientStop { position: 0.98;color: "#3F3F3F" }
                GradientStop { position: 1.0; color: "#0e1B20" }
            }
            Text {
                height: parent.height
                anchors { right: labelRow.left ; verticalCenter:parent.bottom; verticalCenterOffset: -10}
                text: "Menu:    "
                color: "red"
                font {family: "Helvetica"; pointSize:20; bold:true}
                smooth: true
            }
            //row displays its children in a vertical row
            Row {
                id: labelRow
                anchors.centerIn: parent
                spacing:40

                Button1 {
                    id: deletebutton
                    buttonHeight: 60
                    buttonWidth: 200
                    label: "Delete"
                    radius: 3
                    labelSize: 12
                    smooth:true
                    onButtonClick:{
                        drawingArea.ctx.clearRect(0, 0, drawingArea.width, drawingArea.height);
                        drawingArea.sdata = " "
                        drawingArea.requestPaint()
                    }
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "orange" }
                        GradientStop { position: 1.0; color: "#FFE306" }
                    }
                }

                Button1 {
                    id: saveButton
                    buttonHeight: 60
                    buttonWidth: 200
                    label: "Save"
                    radius: 3
                    smooth:true
                    labelSize: 12
                    onButtonClick:{
                        /*directory.fileContent = drawingArea.sdata
                        directory.filename = "asd"
                        directory.saveFile()*/
                    }
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ffa800" }
                        GradientStop { position: 1.0; color: "#FFE306" }
                    }
                }
                Slider{
                    id: slider1
                    width: 500
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: "Choose linewidth"
                        color: "white"
                        width: parent.width
                        font.pointSize: 13
                        anchors{
                                verticalCenter: slider1.top
                                verticalCenterOffset: -2
                                horizontalCenter: slider1.right
                                horizontalCenterOffset: -slider1.width*0.2
                        }
                    }
                    tickmarksEnabled: true
                    minimumValue: 8
                    maximumValue: 26
                    value: 8
                    stepSize: 3
                    onValueChanged: drawingArea.lineWidth = value
                }
            }
        }
     }
}
