import QtQuick 2.0

Rectangle{
    id: box
    property int boxwidth
    property int boxlength
    property int lineWidth: 0
    width: boxwidth
    height: boxlength
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
        id: coli
        z:2
        anchors.centerIn: parent
        spacing:20
        ButtonRake{
            id: controller1
            index: 1
            label: "Controller 1"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state1 = updateState(state1);
            }
            state: state1
        }
        ButtonRake{
            id: controller2
            index: 2
            label: "Controller 2"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state2 = updateState(state2);
            }
            state: state2
        }
        ButtonRake{
            id: controller3
            index: 3
            label: "Controller 3"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state3 = updateState(state3);
            }
            state: state3
        }
        ButtonRake{
            id: controller4
            index: 4
            label: "Controller 4"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state4 = updateState(state4);
            }
            state: state4
        }
        ButtonRake{
            id: controller5
            index: 5
            label: "Controller 5"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state5 = updateState(state5);
            }
            state: state5
        }
        ButtonRake{
            id: controller6
            index: 6
            label: "Controller 6"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state6 = updateState(state6);
            }
            state: state6
        }
        ButtonRake{
            id: controller7
            index: 7
            label: "Controller 7"
            buttonHeight: 140
            buttonWidth: boxwidth
            onButtonClick:{
                state7 = updateState(state7);
            }
            state: state7
        }
    }
}
