import QtQuick 2.0

Rectangle{
    function updateState(state_1){
        if(state_1 === "RELEASED"){
            state_1 = "PRESSED";
        }
        else if (state_1 === "PRESSED"){
            state_1 = "RELEASED";
        }
        return state_1
    }

    id: box
    property int boxwidth
    property int boxlength
    property int lineWidth: 0
    width: boxwidth
    height: boxlength
    color: "transparent"

    Column{
        id: coli
        z:2
        anchors.centerIn: parent
        spacing:20
        Button2{
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
        Button2{
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
        Button2{
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
        Button2{
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
        Button2{
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
        Button2{
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
        Button2{
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
//    MouseArea{
//        id: rakeArea
//        anchors.fill: box
//        onDoubleClicked:{
//            state1 = "RELEASED";
//            state2 = "RELEASED";
//            state3 = "RELEASED";
//            state4 = "RELEASED";
//            state5 = "RELEASED";
//            state6 = "RELEASED";
//            state7 = "RELEASED";
//        }
//    }
}
