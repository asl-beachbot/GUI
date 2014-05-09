import QtQuick 2.0

Item {
    property int lineWidth1: 1
    property var ctx
    property string path1: ""
    property string svgData: ""
    property string svgTerminator: "\n</svg>"
    property var points: [0,0]
    property int last_displayed: 0
    property bool selected: true
    property bool active: false
    property var svgOldArr: []
    property var svgCurArr: []
    property int type: 3

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
        var p1 = this.points[0];
        var p2 = this.points[1];
        for (var i = 1, len = this.points.length; i < len; i++) {
            var nv = normalvector(p1,p2)
            offsetPoints.push({
                x: this.points[i].x + val*nv.x,
                y: this.points[i].y + val*nv.y
            });
            p1 = this.points[i];
            p2 = this.points[i+1];
        }
        return offsetPoints;
    }
    function mouseMove(x_a,y_a){
        var dx = Math.round(x_a);
        var dy = Math.round(y_a);
        if (this.points.length > 0 && this.points[this.points.length-1].x === dx && this.points[this.points.length-1].y === dy)
            return false;
        this.points.push({x:dx, y:dy});
        svgData += ", " + dx + ", " + dx;
//        path1 += ", " + dx + ", " + dx
        return true;
    }

    function mouseStart(x_a,y_a){
        console.log("Mouse_Start");
        this.points.push({x: x_a, y: y_a});
        svgData += "\n<path fill='none' stroke='#000000'" + " stroke-width='" + lineWidth1 + "' d='M" + x_a + ", " + y_a + " L" + x_a + ", " + y_a;
//        path1 += "M" + x_a + ", " + y_a + " L" + x_a + ", " + y_a;
    }

    function mouseStop(){
        console.log("Mouse_Stop");
        //points.length = 0;
        createLine.state = "BUTTON_RELEASED";
        this.active = false;
        svgData += " '/>";
        last_displayed = 0;
    }

    function drawOnCanv(ctx){
        function stroke(points){
          if (points.length <= 1)
              return;
          var start_pos = Math.max(last_displayed-3,0)
          var p1 = points[start_pos];
          var p2 = points[start_pos+1];
          ctx.moveTo(p1.x, p1.y);
          for (var i = start_pos+1, len = points.length; i < len; i++) {
                var midPoint = midPointBtw(p1, p2);
                ctx.quadraticCurveTo(p2.x, p2.y, midPoint.x, midPoint.y);
                p1 = points[i];
                p2 = points[i+1];
            }
          ctx.stroke();
        }
        ctx.lineWidth = 2;
        ctx.lineJoin = ctx.lineCap = 'round';
        ctx.beginPath();
        if(lineWidth1 == 1){
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
        }
        else if (lineWidth1 == 2){
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
        }
        else if (lineWidth1 == 3){
            stroke(offsetPoints(-10));
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
            stroke(offsetPoints(10));
        }
        else if(lineWidth1 == 4){
            stroke(offsetPoints(-14));
            stroke(offsetPoints(-10));
            stroke(offsetPoints(-6));
            stroke(offsetPoints(-2));
            stroke(offsetPoints(2));
            stroke(offsetPoints(6));
            stroke(offsetPoints(10));
            stroke(offsetPoints(14));
        }
        this.last_displayed = this.points.length
    }

    function renderToCtx(ctx){
        ctx.save();
        ctx.beginPath();
        ctx.lineWidth = 6*lineWidth1;
        ctx.lineJoin = ctx.lineCap = 'round';
        ctx.strokeStyle = "#000000";
        ctx.moveTo(this.points[0].x,this.points[0].y);
        for(var i=1;i<this.points.length; i++){
            ctx.lineTo(this.points[i].x, this.points[i].y);
        }
        ctx.stroke();
        ctx.restore();
    }
    function deselectAllNodes(){
        return;
    }
    function getDimensions(){

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
