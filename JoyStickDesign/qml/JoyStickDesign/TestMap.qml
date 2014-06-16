import QtQuick 2.0
import Qt.WebSockets 1.0

Canvas{
    id: canvas2
    property int polesMaxX: 0
    property int polesMaxY: 0
    property int polesMinX: 0
    property int polesMinY: 0
    property real polesMaxXUnscaled: 0
    property real polesMinXUnscaled: 0
    property real polesMaxYUnscaled: 0
    property real polesMinYUnscaled: 0
    property var ctx
    property int scale
    property int width1
    property int height1
    width: width1
    height: height1
    z:8

    function updateScale(){
        for(var i = 0; i<20; i++){
            polesMaxXUnscaledscaled = getMax(polesX[i],polesMaxXUnscaledscaled)
            polesMaxYUnscaled = getMax(polesY[i],polesMaxYUnscaled)
            polesMinXUnscaled = getMin(polesX[i],polesMinXUnscaled)
            polesMinYUnscaled = getMin(polesY[i],polesMinYUnscaled)
        }
        var lengthX = Math.abs(polesMaxXUnscaled - polesMinXUnscaled)
        var lengthY = Math.abs(polesMaxYUnscaled - polesMinYUnscaled)
        scale = (mapContainer.height-2*offset)/(Math.max(lengthX,lengthY))
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

    function drawMap(){
        for(var i=0; i<10;i++){
            ctx.beginPath();
            if(polesMinX == 0.0 && polesMinY == 0.0){
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset,20,0,2*Math.PI,false);
            }
            else if(polesMinX <= 0.0 && polesMinY == 0.0){
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset,20,0,2*Math.PI,false);
            }

            else if(polesMinX == 0.0 && polesMinY <= 0.0){
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset + polesMinY,20,0,2*Math.PI,false);
            }

            else if(polesMinX <= 0.0 && polesMinY <= 0.0){
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset + polesMinY,20,0,2*Math.PI,false);
            }
            ctx.fillStyle = "#FF4000";
            ctx.fill();
            ctx.lineWidth = 2;
            ctx.strokeStyle = "#000000"
            ctx.stroke();
            ctx.beginPath();
            ctx.fillStyle = "#000000";
            if(polesMinX == 0.0 && polesMinY == 0.0){
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset,5,0,2*Math.PI,false);
            }
            else if(polesMinX <= 0.0 && polesMinY == 0.0){
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset,5,0,2*Math.PI,false);
            }

            else if(polesMinX == 0.0 && polesMinY <= 0.0){
                ctx.arc(polesX[i]*scale + offset,height1 - polesY[i]*scale - offset + polesMinY,5,0,2*Math.PI,false);
            }

            else if(polesMinX <= 0.0 && polesMinY <= 0.0){
                ctx.arc(polesX[i]*scale + offset - polesMinX,height1 - polesY[i]*scale - offset + polesMinY,5,0,2*Math.PI,false);
            }
            ctx.fill();
            ctx.stroke();
        }
    }

    function updatemap(){
        for(var i=0; i < 10; i++){
            polesMaxX = getMax(polesX[i]*scale,polesMaxX)
            polesMaxY = getMax(polesY[i]*scale,polesMaxY)
            polesMinX = getMin(polesX[i]*scale,polesMinX)
            polesMinY = getMin(polesY[i]*scale,polesMinY)
        }
        drawMap();
        width1 = polesMaxX - polesMinX + 2*offset;
        height1 = polesMaxY - polesMinY + 2*offset;
    }

    Image{
        id: recti
        height: 100
        width: 100
        source: "../pics/box-turtle1.png"
        fillMode: Image.Stretch
        x: posiX
        y: posiY
        z:8
        transform: Rotation{
            angle: 90 - angle1
            origin.x: 0.5*recti.width
            origin.y: 0.5*recti.height
        }
    }
    onPaint: {
        ctx = canvas2.getContext('2d');
        updateScale();
        updatemap();
    }
}

