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
        spacing:30
        JoyStick_Button_WebSockets{
            id: controller1
            index: 1
            label: "Controller 1"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller2
            index: 2
            label: "Controller 2"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller3
            index: 3
            label: "Controller 3"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller4
            index: 4
            label: "Controller 4"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller5
            index: 5
            label: "Controller 5"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller6
            index: 6
            label: "Controller 6"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
        JoyStick_Button_WebSockets{
            id: controller7
            index: 7
            label: "Controller 7"
            buttonHeight: box.height/10
            buttonWidth: boxwidth
        }
    }
    PinchArea{
        id: pinchArea
        anchors.fill: parent
        onPinchUpdated:{
            var startDist = Math.sqrt((pinch.startPoint1.y - pinch.startPoint2.y)*(pinch.startPoint1.y - pinch.startPoint2.y));
            var actualDist = Math.sqrt((pinch.point1.y-pinch.point2.y)*(pinch.point1.y-pinch.point2.y));
            if(actualDist > startDist+200)
            {
                isPinchingPlus = true;
            }
            else if(Math.sqrt(actualDist+600 < startDist))
            {
                isPinchingMinus = true;
            }

        }
        onPinchFinished: {
            if(isPinchingPlus === true)
            {
                if(lineWidth < 4)
                {
                    lineWidth += 1;
                }
            }
            if(isPinchingMinus === true)
            {
                if(lineWidth > 0)
                {
                    lineWidth -= 1;
                }
            }

            console.log(lineWidth);
            isPinchingMinus = false;
            isPinchingPlus = false;
            if(lineWidth == 0)
            {
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_RELEASED"
                controller3.state = "BUTTON_RELEASED"
                controller4.state = "BUTTON_RELEASED"
                controller5.state = "BUTTON_RELEASED"
                controller6.state = "BUTTON_RELEASED"
                controller7.state = "BUTTON_RELEASED"
            }
            else if(lineWidth == 1)
            {
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_RELEASED"
                controller3.state = "BUTTON_RELEASED"
                controller4.state = "BUTTON_PRESSED"
                controller5.state = "BUTTON_RELEASED"
                controller6.state = "BUTTON_RELEASED"
                controller7.state = "BUTTON_RELEASED"
            }
            else if(lineWidth == 2)
            {
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_RELEASED"
                controller3.state = "BUTTON_PRESSED"
                controller4.state = "BUTTON_PRESSED"
                controller5.state = "BUTTON_PRESSED"
                controller6.state = "BUTTON_RELEASED"
                controller7.state = "BUTTON_RELEASED"
            }
            else if(lineWidth == 3)
            {
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_PRESSED"
                controller3.state = "BUTTON_PRESSED"
                controller4.state = "BUTTON_PRESSED"
                controller5.state = "BUTTON_PRESSED"
                controller6.state = "BUTTON_PRESSED"
                controller7.state = "BUTTON_RELEASED"
            }
            else if(lineWidth == 4)
            {
                controller1.state = "BUTTON_PRESSED"
                controller2.state = "BUTTON_PRESSED"
                controller3.state = "BUTTON_PRESSED"
                controller4.state = "BUTTON_PRESSED"
                controller5.state = "BUTTON_PRESSED"
                controller6.state = "BUTTON_PRESSED"
                controller7.state = "BUTTON_PRESSED"
            }
        }
        MouseArea{
            anchors.fill: parent
            onDoubleClicked:{
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_RELEASED"
                controller3.state = "BUTTON_RELEASED"
                controller4.state = "BUTTON_RELEASED"
                controller5.state = "BUTTON_RELEASED"
                controller6.state = "BUTTON_RELEASED"
                controller7.state = "BUTTON_RELEASED"
                lineWidth = 0;
            }
            onClicked:{
                controller1.state = "BUTTON_RELEASED"
                controller2.state = "BUTTON_RELEASED"
                controller3.state = "BUTTON_RELEASED"
                controller4.state = "BUTTON_PRESSED"
                controller5.state = "BUTTON_RELEASED"
                controller6.state = "BUTTON_RELEASED"
                controller7.state = "BUTTON_RELEASED"
                lineWidth = 1;
            }
        }
    }
}
