import QtQuick 2.0

Rectangle {
    id: button
    property int index
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
            if(button.state == "BUTTON_PRESSED"){
                button.state = "BUTTON_RELEASED"
                console.log(button.label + " up")

                var xmlhttp1=new XMLHttpRequest();
                xmlhttp1.open('GET', "http://127.0.0.1:5000/elements/" + index + "/" + 0, true);
                xmlhttp1.onreadystatechange = function () {
                        if (xmlhttp1.readyState == 4) {
                            console.log(xmlhttp1.responseText);
                            var testjson1 = JSON.parse(xmlhttp1.responseText);
                            console.log(testjson1)
                        } else { console.log("fail"); }
                    };
                xmlhttp1.send(null);


            }
            else if (button.state == "BUTTON_RELEASED"){
                button.state = "BUTTON_PRESSED"
                console.log(button.label + " down")

                var xmlhttp2=new XMLHttpRequest();
                xmlhttp2.open('GET', "http://127.0.0.1:5000/elements/" + index + "/" + 1, true);
                xmlhttp2.onreadystatechange = function () {
                        if (xmlhttp2.readyState == 4) {
                            console.log(xmlhttp2.responseText);
                            var testjson2 = JSON.parse(xmlhttp2.responseText);
                            console.log(testjson2)
                        } else { console.log("fail"); }
                    };
                xmlhttp2.send(null);
            }
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
