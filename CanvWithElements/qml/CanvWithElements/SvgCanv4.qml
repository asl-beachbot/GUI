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
    property real currTransX1: 0
    property real currTransX2Old: 580 + offset + bb.cx
    property real currTransX2Curr: 580 + offset + bb.cx
    property real currTransY1: 0
    property real currTransY2Old: offset + 25 + bb.cy
    property real currTransY2Curr: offset + 25 + bb.cy
    property real angle1:0
    property real angle2Old:0
    property real angle2Curr:0
    property real scale1:1
    property real scale2Old:1
    property real scale2Curr:1
    property var points:[]
    property string path1
    property string path2: ""
    property string picture
    property int type: 2
    property var bb
    property var bb_old
    property var svgOldArr: []
    property var svgCurArr: []
    property string imageSource1

    Image{
        id: svg1
        source: imageSource1
        anchors.centerIn: parent
        transform{
            Scale{origin.x: bb_old.cx; origin.y: bb_old.cy; xScale: scale2Curr; yScale: scale2Curr}
            Rotation{origin.x: bb_old.cx; origin.y: bb_old.cy; angle: angle2Curr}
            Translate{x: currTransX2Curr; y: currTransY2Curr}
        }
    }

    state: "RELEASED"

    function resetTrafo1(){
        this.a = 1;
        this.b = 0;
        this.c = 0;
        this.d = 1;
        this.e = 0;
        this.f = 0;
    }

    function renderToCtx(ctx){
        ctx.save();
        ctx.path = path2;
        ctx.lineWidth = 2;
        ctx.strokeStyle = "#000000";
        ctx.fillStyle = "#000000";
        ctx.fill();
        if(selected){
            ctx.rect(bb.x,bb.y,bb.width, bb.height);
        }
        ctx.strokeStyle = "red";
        ctx.stroke();
        ctx.restore();
        resetTrafo1();
    }

    function getDimensions(){
        bb = Raphi.pathDimensions(path2);
        bb_old = Raphi.pathDimensions(path2);
    }

    function update_bb(){
        bb_old = bb
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
        console.log("finished_calc");
    }
    function pinchStart(){
        this.active = true;
        this.pinchActive = true;
        //update_bb();
        console.log("Pinchstart");
    }
    function pinchUpdate(scale, rotate1) {
        this.angle1 = rotate1/180*Math.PI;
        this.angle2Curr = this.angle2Old+rotate1
        this.scale1 = scale;
        this.scale2Curr = scale*this.scale2Old;
    }

    function pinchStop() {
        this.a = this.scale1*Math.cos(this.angle1);
        this.c = -this.scale1*Math.sin(this.angle1);
        this.b = this.scale1*Math.sin(this.angle1);
        this.d = this.scale1*Math.cos(this.angle1);
        this.e = this.currTransX1;
        this.f = this.currTransY1;
        this.active = false;
        this.pinchActive = false;
        this.currTransX1 = 0;
        this.currTransY1 = 0;
        this.angle1 = 0;
        this.angle2Old = this.angle2Curr;
        this.scale1 = 1;
        this.scale2Old = this.scale2Curr;
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
        this.currTransX1 = x_m - bb.cx
        this.currTransX2Curr = this.currTransX2Old + x_m - bb.cx;
        this.currTransY1 = y_m - bb.cy
        this.currTransY2Curr = this.currTransY2Old +  y_m - bb.cy;
    }
    function mouseStop(){
        this.a = 1;
        this.c = 0;
        this.b = 0;
        this.d = 1;
        this.e = this.currTransX1
        this.f = this.currTransY1
        this.active = false
        console.log("mousestop")
        this.currTransX1 = 0;
        this.currTransX2Old = this.currTransX2Curr;
        this.currTransY1 = 0;
        this.currTransY2Old = this.currTransY2Curr;
        this.angle1 = 0;
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
