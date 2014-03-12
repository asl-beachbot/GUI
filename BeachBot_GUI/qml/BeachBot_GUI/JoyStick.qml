import QtQuick 2.0

Item{
    id: joystick
    property int jwidth
    property int jheight
    width: jwidth
    height: jheight

    signal stickPressed()
    signal stickMoved()
    signal stickReleased()

    onStickReleased: {
        mover.x = background.width/2 - mover.width/2
        mover.y = background.height/2 - mover.height/2
        console.log("Released")
     }

    onStickPressed: {
        console.log("Pressed")
    }

    JoyStick_BackGround{
        id: background
        anchors.centerIn: parent
        bwidth: jwidth
        bheight: jheight
    }

    JoyStick_Mover{
        id: mover
        moverheight: jheight/3
        moverwidth: jwidth/3
        x: jwidth/2 - mover.width/2//background.width/2 - mover.width/2
        y: jheight/2 - mover.height/2//background.height/2 - mover.height/2
    }

    MouseArea{
        id: joyStickArea
        anchors.fill: parent
        onPressed: stickPressed()
        onReleased: stickReleased()

    }
}
