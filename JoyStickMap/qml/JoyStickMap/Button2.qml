import QtQuick 2.0
import Qt.WebSockets 1.0

Rectangle {
    id: placeholder
    property int index
    property int buttonHeight:500
    property int buttonWidth:200
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"
    property int bUTTON_MESSAGE_TYPE: 3
    property bool dClick: false

    signal dClick1()

    onDClick1:{
        return true;
    }

    state: "BUTTON_RELEASED"
    antialiasing: true
    width: buttonWidth
    height: buttonHeight
    color: "transparent"

    Column{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20

        Rectangle{
            id: rakePin1
            radius: 2
            border.color: "black"
            height: buttonHeight/5
            width: placeholder.width-100
            Behavior on color {ColorAnimation {duration:100}}
            Behavior on width {NumberAnimation {duration: 300}}
        }
        Rectangle{
            id: rakePin2
            radius: 2
            border.color: "black"
            height: buttonHeight/5
            width: placeholder.width-100
            Behavior on color {ColorAnimation {duration:100}}
            Behavior on width {NumberAnimation {duration: 300}}
        }
    }

    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onDoubleClicked:{
            dClick1()
        }

        onClicked:{
            if(placeholder.state === "BUTTON_PRESSED"){
                placeholder.state = "BUTTON_RELEASED"

            }
            else if (placeholder.state === "BUTTON_RELEASED"){
                placeholder.state = "BUTTON_PRESSED"
            }
        }
    }
    function sendPressed(){
        console.log(placeholder.label + " down")

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
        console.log(placeholder.label + " up")

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
            name: "BUTTON_PRESSED"
            PropertyChanges{target: rakePin1; color:"green"}
            PropertyChanges{target: rakePin2; color:"green"}
            PropertyChanges{target: rakePin1; width: placeholder.width}
            PropertyChanges{target: rakePin2; width: placeholder.width}
            StateChangeScript{
                name: "send1"
                script: sendPressed();
            }
        },
    State{
            name: "BUTTON_RELEASED"
            PropertyChanges{target: rakePin1; color: "red"}
            PropertyChanges{target: rakePin2; color: "red"}
            PropertyChanges{target: rakePin1; width: placeholder.width-100}
            PropertyChanges{target: rakePin2; width: placeholder.width-100}
            StateChangeScript{
                name: "send2"
                script: sendReleased();
            }
        }
    ]
    transitions:[
        Transition{
           to: "BUTTON_PRESSED"
           ScriptAction{scriptName: "send1"}
        },
        Transition{
            to: "BUTTON_RELEASED"
            ScriptAction{scriptName: "send2"}
        }

    ]
}
