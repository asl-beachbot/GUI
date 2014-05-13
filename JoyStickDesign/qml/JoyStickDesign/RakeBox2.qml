import QtQuick 2.0

Rectangle{
    id: box
    property int boxwidth
    property int boxlength
    property int lineWidth: 0
    property bool isPinchingPlus: false
    property bool isPinchingMinus: false
    width: boxwidth
    height: boxlength
    color: "transparent"
//    border.color: "yellow"
//    border.width: 5

    Column{
        z:2
        anchors.centerIn: parent
        spacing:20
        Button2{
            id: controller1
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                mappi.requestPaint();
                if(controller1.state === "BUTTON_PRESSED"){
                    state1 = "PRESSED";
                }
                else if (controller1.state === "BUTTON_RELEASED"){
                    state1 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller2
            index: 2
            label: "Controller 2"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller2.state === "BUTTON_PRESSED"){
                    state2 = "PRESSED";
                }
                else if (controller2.state === "BUTTON_RELEASED"){
                    state2 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller3
            index: 3
            label: "Controller 3"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller3.state === "BUTTON_PRESSED"){
                    state3 = "PRESSED";
                }
                else if (controller3.state === "BUTTON_RELEASED"){
                    state3 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller4
            index: 4
            label: "Controller 4"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller4.state === "BUTTON_PRESSED"){
                    state4 = "PRESSED";
                }
                else if (controller4.state === "BUTTON_RELEASED"){
                    state4 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller5
            index: 5
            label: "Controller 5"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller5.state === "BUTTON_PRESSED"){
                    state5 = "PRESSED";
                }
                else if (controller5.state === "BUTTON_RELEASED"){
                    state5 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller6
            index: 6
            label: "Controller 6"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller6.state === "BUTTON_PRESSED"){
                    state6 = "PRESSED";
                }
                else if (controller6.state === "BUTTON_RELEASED"){
                    state6 = "RELEASED";
                }
            }
        }
        Button2{
            id: controller7
            index: 7
            label: "Controller 7"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                if(controller7.state === "BUTTON_PRESSED"){
                    state7 = "PRESSED";
                }
                else if (controller7.state === "BUTTON_RELEASED"){
                    state7 = "RELEASED";
                }
            }
        }
    }

    MouseArea{
        id: rakeArea
        anchors.fill: box
        onDoubleClicked:{
            controller1.state = "BUTTON_RELEASED"
            controller2.state = "BUTTON_RELEASED"
            controller3.state = "BUTTON_RELEASED"
            controller4.state = "BUTTON_RELEASED"
            controller5.state = "BUTTON_RELEASED"
            controller6.state = "BUTTON_RELEASED"
            controller7.state = "BUTTON_RELEASED"
        }
    }
}
