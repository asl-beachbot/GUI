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

    property real shiftOriginX: offset + 580
    property real currTransXSVG: 0
    property real currTransXImg: shiftOriginX
    property real shiftOriginY: offset + 26
    property real currTransYSVG: 0
    property real currTransYImg: shiftOriginY

    property real angleSVG:0
    property real oldAngleImg:0
    property real currAngleImg:0
    property real scaleSVG:1
    property real oldScaleImg:1
    property real currScaleImg:1

    property var points:[]
    property string path1
    property string path2: ""

    property int type: 2
    property var bb
    property var bb_old
    property var svgOldArr: []
    property var svgCurArr: []
    property string imageSource1

    Image{
        id: svg1
        x: currTransXImg
        y: currTransYImg
//        width: bb.width
//        height: bb.height
        source: imageSource1
//        fillMode: Image.Stretch
        transform{
//            Scale{origin.x: svg1.width*0.5; origin.y: svg1.height*0.5; xScale: currScaleImg; yScale: currScaleImg}
//            Rotation{origin.x: svg1.width*0.5; origin.y: svg1.height*0.5; angle: currAngleImg}
//            Translate{x: currTransXImg; y: currTransYImg}
            Scale{origin.x: bb.cx; origin.y: bb.cy; xScale: currScaleImg; yScale: currScaleImg}
            Rotation{origin.x: bb.cx; origin.y: bb.cy; angle: currAngleImg}
        }
    }

    state: "RELEASED"

    function setMatrix(scale,angle,transX,transY){
        this.a = scale*Math.cos(angle);
        this.c = -scale*Math.sin(angle);
        this.b = scale*Math.sin(angle);
        this.d = scale*Math.cos(angle);
        this.e = transX;
        this.f = transY;
    }

    function resetValues(){
        this.currTransXSVG = 0;
        this.currTransYSVG = 0;
        this.angleSVG = 0;
        this.scaleSVG = 1;
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
    }
    function drawOnCanv(){

    }

    function getDimensions(){
        bb = Raphi.pathDimensions(path2);
        bb_old = Raphi.pathDimensions(path2);
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
        this.currAngleImg = this.oldAngleImg+rotate1;
        this.currScaleImg = scale*this.oldScaleImg;
        console.log(bb.x);
    }

    function pinchStop(scale,rotate1) {
        this.angleSVG = rotate1/180*Math.PI;
        this.scaleSVG = scale;
        this.currAngleImg = this.oldAngleImg+rotate1
        this.currScaleImg = scale*this.oldScaleImg;

        setMatrix(this.scaleSVG,this.angleSVG,this.currTransXSVG, this.currTransYSVG)

        this.active = false;
        this.pinchActive = false;

        resetValues();

        this.oldAngleImg = this.currAngleImg;
        this.oldScaleImg = this.currScaleImg;

        console.log("Pinchstop");
    }

    function mouseStart(x_m,y_m){
        this.active = true;
        console.log("mousestart");
    }

    function mouseMove(x_m,y_m){
        this.currTransXSVG = x_m - bb.cx
        this.currTransYSVG = y_m - bb.cy
        console.log( "Mousemove " + bb.x);
        this.currTransXImg = this.shiftOriginX + x_m - bb.width*0.5;
        this.currTransYImg = this.shiftOriginY + y_m - bb.height*0.5;
    }
    function mouseStop(x_m,y_m){
        this.currTransXSVG = x_m - bb.cx
        this.currTransYSVG = y_m - bb.cy
        this.currTransXImg = this.shiftOriginX + x_m - bb.width*0.5;
        this.currTransYImg = this.shiftOriginY + y_m - bb.height*0.5;

        setMatrix(1,0,this.currTransXSVG,this.currTransYSVG);

        this.active = false

        resetValues();

        console.log("mousestop")
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
