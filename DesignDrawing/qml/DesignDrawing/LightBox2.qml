import QtQuick 2.0

Rectangle{
    property int lightwidth
    property int lightlength
    width: lightwidth
    height: lightlength
    color: "transparent"

    function updateState(state_1){
        if(state_1 === "RELEASED"){
            state_1 = "PRESSED";
        }
        else if (state_1 === "PRESSED"){
            state_1 = "RELEASED";
        }
        return state_1
    }

    Column{
        id: lightcolumn
        z:2
        anchors.centerIn: parent
        spacing:20
        Button6{
            id: light1
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state1 = updateState(state1);
            }
            state: state1
        }
        Button6{
            id: light2
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state2 = updateState(state2);
            }
            state: state2
        }
        Button6{
            id: light3
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state3 = updateState(state3);
            }
            state: state3
        }
        Button6{
            id: light4
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state4 = updateState(state4);
            }
            state: state4
        }
        Button6{
            id: light5
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state5 = updateState(state5);
            }
            state: state5
        }
        Button6{
            id: light6
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state6 = updateState(state6);
            }
            state: state6
        }
        Button6{
            id: light7
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: lightwidth
            onButtonClick:{
                state7 = updateState(state7);
            }
            state: state7
        }
    }
}
