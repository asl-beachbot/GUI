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
    property real oldAngle: 0
    property real currAngle: 0
    property real oldScale: 1
    property bool selected: false
    property var points:[]
    property string path1
    property int type: 2
    property var bb
    property var svgOldArr: []
    property var svgCurArr: []

    function renderToCtx(ctx){
        ctx.save();
        ctx.path = path1;
        ctx.lineWidth = 2;
        ctx.strokeStyle = "#000000";
        ctx.fillStyle = "#000000";
        ctx.fill();
        ctx.stroke();
        if(selected){
            ctx.rect(bb.x,bb.y,bb.width, bb.height);
            ctx.stroke();
        }
        ctx.strokeStyle = "#0000FF";
        ctx.stroke();
        ctx.restore();
    }

    function getDimensions(){
        bb = Raphi.pathDimensions(path1);
    }
    function deselectAllNodes(){
        return;
    }
    function updateSvgArr(){
//        console.log(path1);
        var lengthArr = svgOldArr.length;
        for(var i=0;i<lengthArr;i++){
            var lengthelem = svgOldArr[i].length;
            if(lengthelem === 1){
                svgCurArr[i] = svgOldArr[i];
            }
            svgCurArr[i][0] = svgOldArr[i][0]
                for (var j=1;j<lengthelem;j=j+2)
                {
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
        for(var o=0;o<lengthArr; o++)
        {
            var lengthelem1 = svgCurArr[o].length;
            for(var p=0; p<lengthelem1; p++)
            {
                tmpstr += svgCurArr[o][p] + " ";
            }
        }

        path1 = tmpstr;
//        console.log(path1);
        bb = Raphi.pathDimensions(path1);
    }
    function pinchStart(){
        //this.currAngle = this.oldAngle;
        this.e = 0;
        this.f = 0;
        this.oldScale = 1;
        this.currAngle = 0;
        this.oldAngle = 0;
    }
    function pinchUpdate(scale, rotate1) {

        this.currAngle = rotate1/180*Math.PI;
        var diff = rotate1/180*Math.PI - this.oldAngle;
        var diff2  = scale / this.oldScale;

        this.a = diff2*Math.cos(diff);
        this.c = -Math.sin(diff);
        this.e = 0
        this.b = Math.sin(diff);
        this.d = diff2*Math.cos(diff);
        this.f = 0;
        this.oldAngle = this.currAngle;
        this.oldScale = scale;
//        this.a = scale;
//        this.d = scale;
    }
    function pinchStop() {
        this.a = 1;
        this.c = 0;
        this.e = 0;
        this.b = 0;
        this.d = 1;
        this.f = 0;
        return;
    }
    function mouseMove(x_m,y_m){
        this.e = x_m - bb.cx;
        this.f = y_m - bb.cy;
    }
    function importPath(){
        svgOldArr = Raphi.parsePathString(path1);
        svgCurArr = Raphi.parsePathString(path1);
    }
}
