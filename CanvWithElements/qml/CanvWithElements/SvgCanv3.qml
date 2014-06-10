import QtQuick 2.0
import "RaphaelSkim.js" as Raphi

Item{
    id: krazz
    property real a: 1;
    property real b: 0;
    property real c: 0;
    property real d: 1;
    property real e: 0;
    property real f: 0;
    property bool active: false
    property bool selected: false
    property bool pinchActive: false
    property real currTransX: 0
    property real currTransY: 0
    property real angle:0
    property real scale1:1
    property var points:[]
    property string path1
    property string path2: ""
    property string picture
    property int type: 2
    property var bb
    property var svgOldArr: []
    property var svgCurArr: []

    state: "RELEASED"

    function resetTrafo1(){
        this.a = 1;
        this.b = 0;
        this.c = 0;
        this.d = 1;
        this.e = 0;
        this.f = 0;
    }

    function drawOnCanv(ctx){
        ctx.save();
        var originX = bb.cx + this.currTransX;
        var originY = bb.cy + this.currTransY;
        ctx.translate(originX, originY)
        ctx.scale(this.scale1, this.scale1);
        ctx.rotate(this.angle);
        ctx.translate(-originX, -originY);
        ctx.translate(this.currTransX,this.currTransY);
        if(!this.pinchactive){
        }
        ctx.path = path2;
        ctx.lineWidth = 2;
        ctx.strokeStyle = "#000000";
        ctx.fillStyle = "#f3bf9c";
        ctx.fill();
        if(selected){
            ctx.rect(bb.x,bb.y,bb.width, bb.height);
        }
        ctx.strokeStyle = "#0000FF";
        ctx.stroke();
        ctx.restore();
    }

    function renderToCtx(ctx){
        ctx.save();
        ctx.path = path2;
        ctx.lineWidth = 2;
        ctx.fillStyle = "#000000";
        ctx.fill();
        if(selected){
            ctx.rect(bb.x,bb.y,bb.width, bb.height);
        }
        ctx.strokeStyle = "#000000";
        ctx.stroke();
        ctx.restore();
        resetTrafo1();
    }

    function getDimensions(){
        bb = Raphi.pathDimensions(path2);
    }
    function deselectAllNodes(){
        return;
    }
    function updateSvgArr(){
        var lengthArr = svgOldArr.length;
        for(var i=0;i<lengthArr;i++){
            var lengthelem = svgOldArr[i].length;
            if(lengthelem === 1){
                svgCurArr[i] = svgOldArr[i];
            }
            svgCurArr[i][0] = svgOldArr[i][0]
                for (var j=1;j<lengthelem;j=j+2){
                    var currx = svgOldArr[i][j];
                    var curry = svgOldArr[i][j+1];
                    var tmp1 = this.a*(currx-bb.cx) + this.c*(curry-bb.cy) + this.e + bb.cx;
                    svgCurArr[i][j] = tmp1.toPrecision(8);
                    var tmp2 = this.b*(currx-bb.cx) + this.d*(curry-bb.cy) + this.f + bb.cy;
                    svgCurArr[i][j+1] = tmp2.toPrecision(8);
                }
        }
        svgOldArr = svgCurArr;
        var tmpstr = " ";
        for(var o=0;o<lengthArr; o++){
            var lengthelem1 = svgCurArr[o].length;
            for(var p=0; p<lengthelem1; p++){
                tmpstr += svgCurArr[o][p] + " ";
            }
        }
        path2 = tmpstr;
        bb = Raphi.pathDimensions(path2);
    }
    function pinchStart(){
        this.active = true;
        this.pinchActive = true;
        console.log("Pinchstart");
    }
    function pinchUpdate(scale, rotate1) {
        this.angle = rotate1/180*Math.PI;
        this.scale1 = scale;
    }
    function pinchStop() {
        this.a = this.scale1*Math.cos(this.angle);
        this.c = -this.scale1*Math.sin(this.angle);
        this.b = this.scale1*Math.sin(this.angle);
        this.d = this.scale1*Math.cos(this.angle);
        this.e = this.currTransX;
        this.f = this.currTransY;
        this.active = false;
        this.pinchActive = false;
        this.currTransX = 0;
        this.currTransY = 0;
        this.angle = 0;
        this.scale1 = 1;
        console.log("Pinchstop");
    }
    function mouseStart(){
//        this.a = 1;
//        this.c = 0;
//        this.b = 0;
//        this.d = 1;
//        this.e = 0;
//        this.f = 0;
        this.active = true;
        console.log("mousestart");
    }

    function mouseMove(x_m,y_m){
        this.currTransX = x_m - bb.cx
        this.currTransY = y_m - bb.cy
    }
    function mouseStop(){
        this.a = 1;
        this.c = 0;
        this.b = 0;
        this.d = 1;
        this.e = this.currTransX
        this.f = this.currTransY
        this.active = false
        console.log("mousestop")
        this.currTransX = 0;
        this.currTransY = 0;
        this.angle = 0;
        this.scale1 = 1;
    }

    function importPath(){
        svgOldArr = Raphi.parsePathString(path2);
        svgCurArr = Raphi.parsePathString(path2);
    }
    function toSVG(){
        this.path1 = "<path stroke='#000000' ";
        this.path1 += "d=";
        this.path1 += "'" + this.path2;
    }
}
