import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: button1
    property int index
    property int buttonHeight:66
    property int buttonWidth:66
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"
    property int bUTTON_MESSAGE_TYPE: 3
    property string imageSource1: "../pics/RedLight1.png"
    property string imageSource2: "../pics/GreenLight1.png"
    state: "RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight
    radius: 66
    color: "transparent"

    Image{
        z: 10
        id: lightImage
        width: buttonWidth*0.9
        height: buttonHeight
        smooth: true
        source: imageSource1
        fillMode: Image.PreserveAspectFit
    }

    signal buttonClick()

    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent
        enabled: true
        onClicked:{
            buttonClick();
        }
    }
    function sendPressed(){
        console.log(button1.label + " down")

        var json3 = {
            "msg_type": bUTTON_MESSAGE_TYPE,
            "index": index,
            "pressed": 1
        };

        if(socket2.active){
            socket2.sendTextMessage(JSON.stringify(json3))
        }
        else{
            socket2.active = !socket2.active
        }
    }

    function sendReleased(){
        console.log(button1.label + " up")

        var json2 = {
            "msg_type": bUTTON_MESSAGE_TYPE,
            "index": index,
            "pressed": 0
        };

        if(socket2.active){
            socket2.sendTextMessage(JSON.stringify(json2))
        }
        else{
            socket2.active = !socket2.active
        }
    }
    states:[
    State{
            name: "PRESSED"
            PropertyChanges{target: lightImage; source:imageSource2}
            PropertyChanges{target: lightImage; anchors.horizontalCenterOffset: 35}
            StateChangeScript{
                name: "send1"
                script: sendPressed();
            }
        },
    State{
            name: "RELEASED"
            PropertyChanges{target: lightImage; source:imageSource1}
            PropertyChanges{target: lightImage; anchors.horizontalCenterOffset: -35}
            StateChangeScript{
                name: "send2"
                script: sendReleased();
            }
        }
    ]
    transitions:[
        Transition{
           to: "PRESSED"
           ScriptAction{scriptName: "send1"}
        },
        Transition{
            to: "RELEASED"
            ScriptAction{scriptName: "send2"}
        }
    ]
}
