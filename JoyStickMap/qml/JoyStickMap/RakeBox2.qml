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
    color: "#F9FB6B"

    Column{
        z:2
        anchors.centerIn: parent
        spacing:boxlength/30
        Button2{
            id: controller1
            index: 1
            label: "Controller 1"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller2
            index: 2
            label: "Controller 2"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller3
            index: 3
            label: "Controller 3"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller4
            index: 4
            label: "Controller 4"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller5
            index: 5
            label: "Controller 5"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller6
            index: 6
            label: "Controller 6"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
        }
        Button2{
            id: controller7
            index: 7
            label: "Controller 7"
            buttonHeight: boxlength/10
            buttonWidth: boxwidth
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
