import QtQuick 2.0

Rectangle{
    property int lightwidth
    property int lightlength
    width: lightwidth
    height: lightlength
    color: "transparent"
//    border.color: "yellow"
//    border.width: 5

    Column{
        id: lightcolumn
        z:2
        anchors.centerIn: parent
        spacing:20
        Button3{
            id: light1
            index: 1
            label: "light 1"
            buttonHeight: 140
            buttonWidth: 140
            state: state1
        }
        Button3{
            id: light2
            index: 2
            label: "light 2"
            buttonHeight: 140
            buttonWidth: 140
            state: state2
        }
        Button3{
            id: light3
            index: 3
            label: "light 3"
            buttonHeight: 140
            buttonWidth: 140
            state: state3
        }
        Button3{
            id: light4
            index: 4
            label: "light 4"
            buttonHeight: 140
            buttonWidth: 140
            state: state4
        }
        Button3{
            id: light5
            index: 5
            label: "light 5"
            buttonHeight: 140
            buttonWidth: 140
            state: state5
        }
        Button3{
            id: light6
            index: 6
            label: "light 6"
            buttonHeight: 140
            buttonWidth: 140
            state: state6
        }
        Button3{
            id: light7
            index: 7
            label: "light 7"
            buttonHeight: 140
            buttonWidth: 140
            state: state7
        }
    }
}
