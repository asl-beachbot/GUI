import QtQuick 2.0

Rectangle {
    id: screen
    width: 700; height:500
    //property int partition: 1/8
    JoyStickTest {
        id: joystick1
        anchors.centerIn: screen
        jwidth1: 200
        jheight1: 200
    }


    Rectangle{
        id: rakeControls
        color: "transparent"
        anchors.horizontalCenter: screen.horizontalCenter
        anchors.bottom: screen.bottom
        anchors.bottomMargin: 20
        width: parent.width
        height: parent.height/8
        z:1

        Row{
            spacing: screen.width/17
            anchors.centerIn: parent


            JoyStick_Button{
                id: controller1
                label: "Controller 1"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller2
                label: "Controller 2"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller3
                label: "Controller 3"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller4
                label: "Controller 4"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller5
                label: "Controller 5"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller6
                label: "Controller 6"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button{
                id: controller7
                label: "Controller 7"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }

        }

    }

}
