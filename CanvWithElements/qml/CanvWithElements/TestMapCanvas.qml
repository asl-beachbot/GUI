import QtQuick 2.0

Canvas {
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
    function updateScale()
    {
        for(var i = 0; i<20; i++)
        {
            polesMaxXun = getMax(poles[i].x,polesMaxXun)
            polesMaxYun = getMax(poles[i].y,polesMaxYun)
            polesMinXun = getMin(poles[i].x,polesMinXun)
            polesMinYun = getMin(poles[i].y,polesMinYun)
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
            polesMaxX = getMax(poles[i].x*scale,polesMaxX)
            polesMaxY = getMax(poles[i].y*scale,polesMaxY)
            polesMinX = getMin(poles[i].x*scale,polesMinX)
            polesMinY = getMin(poles[i].y*scale,polesMinY)
            if(polesMinX == 0.0 && polesMinY == 0.0){
                ctx.beginPath();
                ctx.arc(poles[i].x*scale + offset,height1 - poles[i].y*scale - offset,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(poles[i].x*scale + offset,height1 - poles[i].y*scale - offset,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX <= 0.0 && polesMinY == 0.0){
                ctx.beginPath();
                ctx.arc(poles[i].x*scale + offset - polesMinX,height1 - poles[i].y*scale - offset,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(poles[i].x*scale + offset - polesMinX,height1 - poles[i].y*scale - offset,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX == 0.0 && polesMinY <= 0.0){
                ctx.beginPath();
                ctx.arc(poles[i].x*scale + offset,height1 - poles[i].y*scale - offset + polesMinY,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(poles[i].x*scale + offset,height1 - poles[i].y*scale - offset + polesMinY,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
            else if(polesMinX <= 0.0 && polesMinY <= 0.0){
                ctx.beginPath();
                ctx.arc(poles[i].x*scale + offset - polesMinX,height1 - poles[i].y*scale - offset + polesMinY,20,0,2*Math.PI,false);
                ctx.fillStyle = "#FF4000";
                ctx.fill();
                ctx.lineWidth = 2;
                ctx.strokeStyle = "#000000"
                ctx.stroke();
                ctx.beginPath();
                ctx.fillStyle = "#000000";
                ctx.arc(poles[i].x*scale + offset - polesMinX,height1 - poles[i].y*scale - offset + polesMinY,5,0,2*Math.PI,false)
                ctx.fill();
                ctx.stroke();
            }
        }
        width1 = Math.abs(polesMaxX - polesMinX + 2*offset);
        height1 = Math.abs(polesMaxY - polesMinY + 2*offset);
    }
    Rectangle{
        id: recti
        color: "green"
        height: 60
        width: 30
        smooth:true
        antialiasing: true
        transform: Rotation{
            angle: -angle1
        }
        x: posiX
        y: posiY
        z:8
    }

    onPaint: {
        ctx = canvas2.getContext('2d');
//        updateScale();
//        updatemap();
//        poles = [];
        elements.forEach(function(el) {
            if(el.active){
                el.drawOnCanv(ctx);
            }
            else{
                el.renderToCtx(ctx);
            }
        });
    }
    Rectangle{
        z:0
        id: recti2
        color: "#FAFEBE"
        border.color: "yellow"
        opacity: 0.7
        height: canvas2.height1
        width: canvas2.width1
        anchors.centerIn: canvas2
        radius: 20
    }
    antialiasing: true
    smooth: true
    renderTarget: Canvas.Image
    property var elements: []
    function updateElements(name){
        elements.push(name);
    }

    onAvailableChanged: {
        if(available) {
            //elements.push(poly1);
            //elements.push(poly2);
//            elements.push(svg1);
//            elements.push(asd);
//            updateElements(svg1);
//            updateElements(asd);
            ctx = mappi.getContext('2d');
        }
    }
    function clear() {
        console.log("canv_clear");
        ctx.clearRect(0, 0, mappi.width, mappi.height);
    }

    function exportToSVG() {

    }
    Component.onCompleted:{
        canvas2.requestPaint();
    }
}
