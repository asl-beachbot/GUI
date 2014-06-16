import QtQuick 2.0
import Qt.WebSockets 1.0

Canvas{
    id: canvas2
    property int polesMaxX: 0
    property int polesMaxY: 0
    property int polesMinX: 0
    property int polesMinY: 0
    property real polesMaxXun: 0
    property real polesMinXun: 0
    property real polesMaxYun: 0
    property real polesMinYun: 0
    property var ctx
    property int scale: 80
    property int width1: 600
    property int height1: 600
    width: width1
    height: height1
    z:8

    function updateScale()
    {
        for(var i = 0; i<20; i++)
        {
            polesMaxXun = getMax(polesX[i],polesMaxXun)
            polesMaxYun = getMax(polesY[i],polesMaxYun)
            polesMinXun = getMin(polesX[i],polesMinXun)
            polesMinYun = getMin(polesY[i],polesMinYun)
        }
        var lengthX = Math.abs(polesMaxXun - polesMinXun)
        var lengthY = Math.abs(polesMaxYun - polesMinYun)
        scale = (mapContainer.height-2*offset)/(Math.max(lengthX,lengthY))

        console.log("Scale: " + scale)
        console.log("Max_X: " + polesMaxXun);
        console.log("Max_Y: " + polesMaxYun);
        console.log("Min_X: " + polesMinXun);
        console.log("Min_Y: " + polesMinYun);
    }

    function updateposiX(x){
        var positionx;
        if(polesMinX == 0.0 && polesMinY == 0.0){
            positionx = x*scale + offset;
        }

        else if(polesMinX <= 0.0 && polesMinY == 0.0){
            positionx = x*scale + offset - polesMinX;
        }

        else if(polesMinX == 0.0 && polesMinY <= 0.0){
            positionx = x*scale + offset;
        }
        else if(polesMinX <= 0.0 && polesMinY <= 0.0){
            positionx = x*scale + offset - polesMinX;
        }
        return positionx;
    }
    function updateposiY(y){
        var positiony;
        if(polesMinX == 0.0 && polesMinY == 0.0){
            positiony = -y*scale + height1 - offset;
        }

        else if(polesMinX <= 0.0 && polesMinY == 0.0){
            positiony = height1 - y*scale - offset;
        }

        else if(polesMinX == 0.0 && polesMinY <= 0.0){
            positiony = height1 - y*scale - offset + polesMinY;
        }
        else if(polesMinX <= 0.0 && polesMinY <= 0.0){
            positiony = height1 - y*scale - offset + polesMinY;
        }
        return positiony;
    }

    function getMax(val, max){
        if(val>max){
            return val;
        }
        else{
            return max;
        }
    }

    function getMin(val, min){
        if(val<min){
            return val;
        }
        else{
            return min;
        }
    }

    function updatemap()
    {
        for(var i=0; i < 20; i++)
        {
            polesMaxX = getMax(polesX[i]*scale,polesMaxX)
            polesMaxY = getMax(polesY[i]*scale,polesMaxY)
            polesMinX = getMin(polesX[i]*scale,polesMinX)
            polesMinY = getMin(polesY[i]*scale,polesMinY)
            if(polesMinX == 0.0 && polesMinY == 0.0){
                ctx.beginPath();
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX <= 0.0 && polesMinY == 0.0){
                ctx.beginPath();
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX == 0.0 && polesMinY <= 0.0){
                ctx.beginPath();
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset + polesMinY,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset + polesMinY,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX <= 0.0 && polesMinY <= 0.0){
                ctx.beginPath();
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset + polesMinY,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset + polesMinY,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
        }
        width1 = Math.abs(polesMaxX - polesMinX + 2*offset);
        height1 = Math.abs(polesMaxY - polesMinY + 2*offset);
    }
    Image{
        id: recti
        height: 100
        width: 100
        source: "../pics/box-turtle1.png"
        fillMode: Image.Stretch
        x: posiX
        y: posiY
        transform: Rotation{
            angle: 90 - angle1
            origin.x: 0.5*recti.width
            origin.y: 0.5*recti.height
        }
        z:8
    }

    onPaint: {
        ctx = canvas2.getContext('2d');
        updateScale();
        updatemap();
        //poles = [];
    }

    Rectangle{
        id: recti2
        color: "#FAFEBE"
        opacity: 0.7
        height: canvas2.height1 - 2*offset
        width: canvas2.width1 - 2*offset
        anchors.centerIn: canvas2
        radius: 20
    }
}

