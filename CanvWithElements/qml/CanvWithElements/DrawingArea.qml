import QtQuick 2.0

Canvas {
    id: myCanvas
    property int lineWidth1: 1
    property int posX
    property int posY
    property color drawColor: "#FF4000"
    property var ctx
    property string sdata: ""
    property string svgData: ""
    property string svgTerminator: "\n</svg>"
    property var points: []
    property int last_displayed: 0
    property int height2
    property int width2
    property real fieldx:mappi.polesMaxXun - mappi.polesMinXun
    property real fieldy:mappi.polesMaxYun - mappi.polesMinYun

    height: height2
    width: width2

    state: "RELEASED"

    property bool selected: false
    property int type: 3


    function init()
    {
        svgData =  "<?xml version='1.0'?>\n<svg>";
        //updateText(true);
        //Data = lineWidth;
    }

    function normalvector(po1,po2)
    {
        var normalvector1 = [];
        var v1x = po1.y-po2.y;
        var v1y = po2.x-po1.x;
        var norm2 = Math.sqrt(v1x*v1x + v1y*v1y);
        normalvector1.x = v1x/norm2;
        normalvector1.y = v1y/norm2;
        return normalvector1;
    }

    function midPointBtw(p1,p2)
    {
        return{
            x: p1.x + (p2.x - p1.x)*0.5,
            y: p1.y + (p2.y - p1.y)*0.5
        };
    }

    function offsetPoints(val)
    {
        var offsetPoints = [];
        var p1 = points[0];
        var p2 = points[1];

        for (var i = 1, len = points.length; i < len; i++) {
            var nv = normalvector(p1,p2)
            offsetPoints.push({
                x: points[i].x + val*nv.x,
                y: points[i].y + val*nv.y
            });
            p1 = points[i];
            p2 = points[i+1];
        }

        return offsetPoints;
    }

    function _MouseMoveHandler(x_a,y_a)
    {
        var dx = Math.round(x_a);
        var dy = Math.round(y_a);
        if (points.length > 0 && points[points.length-1].x === dx && points[points.length-1].y === dy)
            return false;
        points.push({x:dx, y:dy});
        var x_coord = (fieldx*x_a)/(width2) + mappi.polesMinXun;
        var y_coord = fieldy*(height2 - y_a)/(height2);
        sdata += x_coord + " " + y_coord + "\n";
        svgData += ", " + x_coord + ", " + y_coord;
        return true;
    }

    function _MouseDownHandler()
    {
        //var dx = Math.round(posX);
        //var dy = Math.round(posY);
        points.push({x: posX, y: posY});
        var x_coord1 = (fieldx*posX)/(width2) + mappi.polesMinXun;
        var y_coord1 = fieldy*(height2 - posY)/(height2);
        //svgData += "downdowndown"
        svgData += "\n<path fill='none' stroke='#000000'" + " stroke-width='" + lineWidth1 + "' d='M" + x_coord1  + ", " + y_coord1  + " L" + x_coord1  + ", " + y_coord1;
    }

    function _MouseUpHandler()
    {
        //var dx = Math.round(mousearea.mouseX);
        //var dy = Math.round(mousearea.mouseY);
        points.length = 0;
        sdata += "\n";
        svgData += " '/>";
        last_displayed = 0;
        console.log(sdata)
    }

    onPaint: {
        function stroke(points) {

          if (points.length <= 1)
              return;
          var start_pos = Math.max(last_displayed-3,0)
          //var start_pos = 0
          var p1 = points[start_pos];
          var p2 = points[start_pos+1];

          ctx.moveTo(p1.x, p1.y);

            // TODO:use quadratic properly
          for (var i = start_pos+1, len = points.length; i < len; i++) {
                // we pick the point between pi+1 & pi+2 as the
                // end point and p1 as our control point
                var midPoint = midPointBtw(p1, p2);
                ctx.quadraticCurveTo(p2.x, p2.y, midPoint.x, midPoint.y);
                p1 = points[i];
                p2 = points[i+1];
                // TODO: make sure the access is not out of bounds
            }
          // Draw last line as a straight line while
          // we wait for the next point to be able to calculate
          // the bezier control point
          //ctx.lineTo(p1.x, p1.y);
          ctx.stroke();
        }

        ctx = getContext('2d');
        ctx.lineWidth = 2;
        ctx.lineJoin = ctx.lineCap = 'round';
        ctx.beginPath();
        if(lineWidth1 == 1)
        {
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
        }
        else if (lineWidth1 == 2)
        {
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
        }
        else if (lineWidth1 == 3)
        {
            stroke(offsetPoints(-10));
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
            stroke(offsetPoints(10));
        }
        else if(lineWidth1 == 4)
        {
            stroke(offsetPoints(-14));
            stroke(offsetPoints(-10));
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
            stroke(offsetPoints(10));
            stroke(offsetPoints(14));
        }
        last_displayed = points.length
    }

    MouseArea{
        id:mousearea
        anchors.fill: parent
        onPositionChanged: {
            posX = mouseX
            posY = mouseY
            if (_MouseMoveHandler(posX,posY))
                requestPaint()
        }
        onPressedChanged: {
            if (myCanvas.state == "RELEASED")
            {
                myCanvas.state = "PRESSED"
                posX = mouseX
                posY = mouseY
                _MouseDownHandler()
                console.log("DOWN")
            }
            else if (myCanvas.state == "PRESSED")
            {
                myCanvas.state = "RELEASED"
                _MouseUpHandler()
                console.log("UP")
            }
        }
    }
    function renderToCtx(ctx){

    }

    function deselectAllNodes(){
        return;
    }
    function getDimensions(){

    }
    function deselectAllNodes(){

    }
    function updateSvgArr(){

    }
    function pinchStart(){

    }
    function pinchUpdate(scale, rotate1) {

    }
    function pinchStop() {

    }
    function moveSelectedNode(x_m,y_m){
    }
    function importPath(){

    }
}
