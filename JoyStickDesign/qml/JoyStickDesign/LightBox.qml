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
        ButtonLight{
            id: light1
            index: 1
            label: "light 1"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state1 = updateState(state1);
            }
            state: state1
        }
        ButtonLight{
            id: light2
            index: 1
            label: "light 2"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state2 = updateState(state2);
            }
            state: state2
        }
        ButtonLight{
            id: light3
            index: 1
            label: "light 3"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state3 = updateState(state3);
            }
            state: state3
        }
        ButtonLight{
            id: light4
            index: 1
            label: "light 4"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state4 = updateState(state4);
            }
            state: state4
        }
        ButtonLight{
            id: light5
            index: 1
            label: "light 5"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state5 = updateState(state5);
            }
            state: state5
        }
        ButtonLight{
            id: light6
            index: 1
            label: "light 6"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state6 = updateState(state6);
            }
            state: state6
        }
        ButtonLight{
            id: light7
            index: 1
            label: "light 7"
            buttonHeight: 140
            buttonWidth: 140
            onButtonClick:{
                state7 = updateState(state7);
            }
            state: state7
        }
    }
}
