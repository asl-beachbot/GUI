import QtQuick 2.0

Rectangle {
    id: button
    property int buttonHeight
    property int buttonWidth
    property string label
    property color buttonColor: "red"
    property color pressedColor: "green"


    state: "BUTTON_RELEASED"
    radius: 6
    antialiasing: true
    border.width: 2
    border.color: "#0CF785"
    width: buttonWidth
    height: buttonHeight

    z:2


    MouseArea{
        id: buttonMouseArea
        anchors.fill: parent
        onClicked:{
            var testjson
            if(button.state == "BUTTON_PRESSED"){
                button.state = "BUTTON_RELEASED"
                console.log(button.label + " up")
            }
            else if (button.state == "BUTTON_RELEASED"){
                button.state = "BUTTON_PRESSED"
                console.log(button.label + " down")
            }
            var xmlhttp=new XMLHttpRequest();
            xmlhttp.open('GET', 'http://localhost:5000/test2/123.23/321.32', true);
            xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4) {
                        console.log(xmlhttp.responseText);
                        testjson = JSON.parse(xmlhttp.responseText);
                        console.log(testjson)
                        console.log(testjson["other_stuff"])
                    } else { console.log("fail"); }
                };
            xmlhttp.send(null);
        }
    }

    states:[
    State{
            name: "BUTTON_PRESSED"
            PropertyChanges{target: button; color:"green"}
        },
    State{
            name: "BUTTON_RELEASED"
            PropertyChanges{target: button; color: "red"}
        }

    ]

    Behavior on color {ColorAnimation {duration:100} }
}
