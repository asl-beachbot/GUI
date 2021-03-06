import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: button1
    property int index
    property int buttonHeight:500
    property int buttonWidth
    property string label
    property int bUTTON_MESSAGE_TYPE: 3
    property string imageSource1: "../pics/switchLeft1.png"
    property string imageSource2: "../pics/switchRight1.png"
    state: "RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight
    color: "transparent"

    Image{
        z: 10
        id: switchImage
        width: buttonWidth*0.9
        height: buttonHeight
        smooth: true
        source: imageSource1
        fillMode: Image.Stretch
        anchors{
            verticalCenter: button1.verticalCenter
            horizontalCenter: button1.horizontalCenter
            horizontalCenterOffset: -35
        }
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
            PropertyChanges{target: switchImage; source:imageSource2}
            PropertyChanges{target: switchImage; anchors.horizontalCenterOffset: 35}
            StateChangeScript{
                name: "send1"
                script: sendPressed();
            }
        },
    State{
            name: "RELEASED"
            PropertyChanges{target: switchImage; source:imageSource1}
            PropertyChanges{target: switchImage; anchors.horizontalCenterOffset: -35}
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
