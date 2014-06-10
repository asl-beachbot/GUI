import QtQuick 2.0

Canvas {
    id: myCanvas
    property int lineWidth1: 1
    property int lineWidth2
    property int posX
    property int posY
    property color drawColor: "#FF4000"
    property var ctx
    property var points: []
    property int last_displayed: 0
    property int height2
    property int width2
    property real fieldx:1.5
    property real fieldy:3

    height: height2
    width: width2

    state: "RELEASED"

    function normalvector(po1,po2){
        var normalvector1 = [];
        var v1x = po1.y-po2.y;
        var v1y = po2.x-po1.x;
        var norm2 = Math.sqrt(v1x*v1x + v1y*v1y);
        normalvector1.x = v1x/norm2;
        normalvector1.y = v1y/norm2;
        return normalvector1;
    }

    function midPointBtw(p1,p2){
        return{
            x: p1.x + (p2.x - p1.x)*0.5,
            y: p1.y + (p2.y - p1.y)*0.5
        };
    }

    function offsetPoints(val){
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
    function clear() {
        ctx.clearRect(0, 0, myCanvas.width, myCanvas.height);
    }

    function _MouseMoveHandler(x_a,y_a){
        var dx = Math.round(x_a);
        var dy = Math.round(y_a);
        if (this.points.length > 0 && this.points[this.points.length-1].x === dx && this.points[this.points.length-1].y === dy)
            return false;
        this.points.push({x: x_a , y: y_a});
        return true;
    }

    function _MouseDownHandler(){
        points.push({x: posX, y: posY});
    }

    function _MouseUpHandler(){
        points.length = 0;
        last_displayed = 0;
    }

    onPaint:{
        function stroke(points1) {
          if (points1.length <= 1)
              return;
          var start_pos = Math.max(last_displayed-3,0)
          var p1 = points1[start_pos];
          var p2 = points1[start_pos+1];
          ctx.moveTo(p1.x, p1.y);
          for (var i = start_pos+1, len = points1.length; i < len; i++) {
                var midPoint = midPointBtw(p1, p2);
//                ctx.quadraticCurveTo(p2.x, p2.y, midPoint.x, midPoint.y);
                ctx.lineTo(p2.x,p2.y)
                p1 = points1[i];
                p2 = points1[i+1];
            }
          ctx.stroke();
      }
        ctx = getContext('2d');
        ctx.lineWidth = 2;
        ctx.lineJoin = ctx.lineCap = 'round';
        ctx.beginPath();
        if(state4 === "PRESSED"){
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
        }
        if(state3 === "PRESSED"){
            stroke(offsetPoints(-6));
        }
        if(state2 === "PRESSED"){
            stroke(offsetPoints(-10));
        }
        if(state1 === "PRESSED"){
            stroke(offsetPoints(-14));
        }
        if(state5 === "PRESSED"){
            stroke(offsetPoints(6));
        }
        if(state6 === "PRESSED"){
            stroke(offsetPoints(10));
        }
        if(state7 === "PRESSED"){
            stroke(offsetPoints(14));
        }
        last_displayed = points.length
        console.log("Paint");
    }
//    MouseArea{
//        id:mousearea
//        anchors.fill: parent
//        onPositionChanged: {
//            posX = mouseX
//            posY = mouseY
//            if (_MouseMoveHandler(posX,posY))
//                requestPaint()
//        }
//        onPressedChanged: {
//            if (myCanvas.state == "RELEASED")
//            {
//                myCanvas.state = "PRESSED"
//                posX = mouseX
//                posY = mouseY
//                _MouseDownHandler()
//                console.log("DOWN")
//            }
//            else if (myCanvas.state == "PRESSED")
//            {
//                myCanvas.state = "RELEASED"
//                _MouseUpHandler()
//                console.log("UP")
//            }
//        }
//    }
}
