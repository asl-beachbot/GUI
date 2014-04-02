import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle{
    id: screen
    width: 2560; height:1600
    property int jOYSTICK_MESSAGE_TYPE: 1
    //Component.onCompleted: socket2.active = !socket2.active

    //property int partition: 1/8
    /*Button1{
        buttonHeight: 100
        buttonWidth: 200
        label: "Quit"
        onButtonClick: {
            socket2.active = !socket2.active
        }
        anchors
        {
            top: screen.top
            left: screen.left
            topMargin: 10
            leftMargin:10
        }
    }*/
    WebSocket{
        id: socket2
        url: "ws://10.10.0.1:5000/sock"
        onStatusChanged: if (socket2.status == WebSocket.Error) {
                             console.log("Error: " + socket2.errorString)
                         } else if (socket2.status == WebSocket.Open) {
                             //socket2.sendTextMessage("Hello World")
                         } else if (socket2.status == WebSocket.Closed) {
                             //messageBox.text += "\nSocket closed"
                         }
        active: true
    }
    JoyWebSocket {
        id: joystick1
        anchors
        {
            verticalCenter:screen.verticalCenter
            horizontalCenter: screen.horizontalCenter
            verticalCenterOffset: -200
        }
        jwidth1: 800
        jheight1: 800
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


            JoyStick_Button_WebSockets{
                id: controller1
                index: 1
                label: "Controller 1"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller2
                index: 2
                label: "Controller 2"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller3
                index: 3
                label: "Controller 3"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller4
                index: 4
                label: "Controller 4"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller5
                index: 5
                label: "Controller 5"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller6
                index: 6
                label: "Controller 6"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
            JoyStick_Button_WebSockets{
                id: controller7
                index: 7
                label: "Controller 7"
                buttonHeight: rakeControls.height
                buttonWidth: screen.width/15
            }
        }
    }
}
