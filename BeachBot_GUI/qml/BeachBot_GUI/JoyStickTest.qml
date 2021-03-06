import QtQuick 2.0

Rectangle {
    id: joystick1
    property int jwidth1
    property int jheight1
    width: jwidth1
    height: jheight1

    signal stickPressed()
    signal stickMoved(real x, real y)
    signal stickReleased()

    onStickMoved: {
        var x_a = -y/((jwidth1-jwidth1*0.33)*0.5)
        var y_a = x/((jwidth1-jwidth1*0.33)*0.5)
        var x_b = x_a.toPrecision(3)
        var y_b = y_a.toPrecision(3)
        console.log(x_b, y_b)

        var xmlhttp=new XMLHttpRequest();
        xmlhttp.open('GET', "http://10.10.0.1:5000/test2/" + x_b + "/" + y_b, true);
        //xmlhttp.open('GET', "http://localhost:5000/test2/" + angle2r + "/" + mag2r, true);
        xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4) {
                    console.log(xmlhttp.responseText);
                    var testjson = JSON.parse(xmlhttp.responseText);
                    //console.log(testjson)
                } else { console.log("fail"); }
            };
        xmlhttp.send(null);
    }

    onStickReleased: {
        releaseAnimation.restart()
        console.log("RELEASED")
        stickMoved(0,0)

    }

    onStickPressed: {
        releaseAnimation.stop()
        console.log("PRESSED")
    }



    JoyStick_BackGround{
        id: background1
        anchors.centerIn: parent
        bwidth: jwidth1
        bheight: jheight1


        JoyStick_Mover{
            id: mover1
            moverheight: jheight1/3
            moverwidth: jwidth1/3
            anchors.centerIn: parent
        }

        ParallelAnimation{
            id:releaseAnimation
            NumberAnimation{target: mover1.anchors; property: "horizontalCenterOffset"; to: 0; duration: 150; easing.type: Easing.InCubic}
            NumberAnimation{target: mover1.anchors; property: "verticalCenterOffset"; to: 0; duration: 150; easing.type: Easing.InCubic}
        }

        MouseArea{
            id: stickArea
            anchors.fill: parent
            property real backgroundbound : background1.width*0.5 - mover1.width*0.5
            property real backgroundbound2 : backgroundbound * backgroundbound
            property real posX: -mouseY + background1.height*0.5
            property real posY: -mouseX + background1.height*0.5
            property real distance2: posX*posX + posY*posY

            onPressed:{
                stickPressed()
            }

            onReleased: {
                stickReleased()
            }

            onPositionChanged: {
                if(distance2 < backgroundbound2){
                    mover1.anchors.horizontalCenterOffset = -posY
                    mover1.anchors.verticalCenterOffset = -posX
                    stickMoved(posX,posY)
                }
                else{
                    var angle1 = Math.atan2(posY,posX)
                    mover1.anchors.horizontalCenterOffset = - Math.sin(angle1) * backgroundbound
                    mover1.anchors.verticalCenterOffset = - Math.cos(angle1) * backgroundbound
                    stickMoved(Math.cos(angle1)*backgroundbound,Math.sin(angle1)*backgroundbound)
                }
            }
        }
    }
}
