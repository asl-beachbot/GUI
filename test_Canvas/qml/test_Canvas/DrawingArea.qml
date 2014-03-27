import QtQuick 2.0

Canvas {
    //width: 1000; height: 1000
    id: myCanvas
    property int posX
    property int posY
    property int lineWidth: 8
    property color drawColor: "#FF4000"
    property var ctx
    //property string svgTerminator: "\n</svg>"
    property string sdata: ""

    state: "RELEASED"


    /*function init()
    {
        sdata = "start\n";
        //updateText(true);
        //Data = lineWidth;
    }*/

    /*function updateText(bFull)
    {
        var SVGSize = "SVG: " + String(data.length) + " bytes\n";
        SVGSize.text = SVGSize;
        if (bFull) txtSVG.text = svgData;
    }*/

    function _MouseMoveHandler(x_a,y_a)
    {
        var dx = Math.round(x_a);
        var dy = Math.round(y_a);
        sdata += dx + ", " + dy + "\n";
        //updateText(false);
    }

    function _MouseDownHandler()
    {
        var dx = Math.round(posX);	// x coordinate of mouse
        var dy = Math.round(posY);	// y coordinate of mouse
        sdata += "\nwidth = " + lineWidth + "\n";
        //svgData += "\n<path fill='none' stroke='" + drawColor + "' stroke-width='" + lineWidth + "' d='M" + dx + ", " + dy + " L" + dx + ", " + dy; // update SVG info
        //updateText(false);

    }

    function _MouseUpHandler()
    {
        var dx = Math.round(posX);
        var dy = Math.round(posY);
        //svgData += " '/>";
        //updateText(true);
        sdata += "end of line\n"
    }

    //Component.onCompleted: init()

    onPaint: {
        ctx = getContext('2d');
        ctx.beginPath();
        ctx.strokeStyle = drawColor
        ctx.lineWidth = lineWidth
        ctx.moveTo(posX, posY);
        ctx.lineTo(mousearea.mouseX, mousearea.mouseY);
        ctx.stroke();
        ctx.closePath();
        posX = mousearea.mouseX;
        posY = mousearea.mouseY;
    }

    MouseArea{
        id:mousearea
        anchors.fill: parent
        onPressed: {
            posX = mouseX
            posY = mouseY
            console.log(posX)
            console.log(posY)
        }
        onPositionChanged: {
            _MouseMoveHandler(posX,posY)
            requestPaint()
            console.log(posX)
            console.log(posY)
        }
        onPressedChanged: {
            if (myCanvas.state == "RELEASED")
            {
                myCanvas.state = "PRESSED"
                _MouseDownHandler()
                console.log("pressed")
            }
            else if (myCanvas.state == "PRESSED")
            {
                myCanvas.state = "RELEASED"
                _MouseUpHandler()
                //posX = mouseX
                //posY = mouseY
                console.log("released")
            }
        }
    }
}
