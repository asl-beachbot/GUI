import QtQuick 2.0


PinchArea{
    id: pinchArea
    enabled: true
    anchors.fill: mappi

    pinch.dragAxis: Pinch.NoDrag
    pinch.minimumScale: 0.0001
    pinch.maximumScale: 1000
    pinch.minimumRotation: -5000
    pinch.maximumRotation: 5000
    onPinchStarted: {
        mappi.elements.forEach(function(el){
            if(el.selected){
                el.pinchStart();
            }
        });
     }

    onPinchUpdated:{
        mappi.elements.forEach(function(el) {
            if(el.selected) {
                    el.pinchUpdate(pinch.scale, pinch.rotation);
                    el.updateSvgArr();
            }
        });
        mappi.requestPaint();
        mappi.clear();
        console.log("clear_pinch_up");
    }
    onPinchFinished: {
        mappi.elements.forEach(function(el) {
            if(el.selected){
                    el.pinchStop();
                    el.updateSvgArr();
            }
        });
        mappi.requestPaint();
        mappi.clear()
        console.log("clear_pinch_fi");
    }
    MouseArea{
       id:mousearea
       property int hitrad: 5;
       anchors.fill: parent
       property var selected_element: 0;
       function trySelect(mouse) {
           var pf = false;
           mappi.elements.forEach(function(el) {
               if (el.type === 2){
                   el.selected = false;
                   if(mouse.x < el.bb.x + el.bb.width + hitrad && mouse.x > el.bb.x - hitrad &&
                      mouse.y < el.bb.y + el.bb.height + hitrad && mouse.y > el.bb.y - hitrad) {
                            console.log("hit")
                            mappi.clear();
                            console.log("clear_selec");
                            selected_element = el;
                            pf = true;
                            el.selected = true;
                   }
                   else{
                       el.selected = false;
                   }
               }
               else if(el.type === 1){
                   el.coords.forEach(function(c, idx) {
                   if(mouse.x >= c[0] - hitrad && mouse.x <= c[0] + hitrad &&
                      mouse.y >= c[1] - hitrad && mouse.y <= c[1] + hitrad) {
                            mappi.elements.forEach(function(el2) {
                            el2.deselectAllNodes();
                        });
                        mappi.clear();
                        console.log("clear_select_2");
                        el.selectNode(idx);
                        selected_element = el;
                        pf = true;
                        }
                   });
               }
               else if(el.type === 3){
                    el.selected = false;
               }
           });
           if(pf === false) {
               mappi.elements.forEach(function(el2) {
                   el2.deselectAllNodes();
                   selected_element = 0;
               });
           }
       }
       onDoubleClicked: {
           mappi.elements.forEach(function(el) {
                if(el.selected){
                       console.log("clear");
                       el.path1 = " ";
                       el.svgCurArr = [];
                       el.svgOldArr = [];
                       el.updateSvgArr();
                       mappi.requestPaint();
                       mappi.clear();
                       console.log("clear_dcli");                   
               }
           });
       }

       onClicked:{
           mappi.elements.forEach(function(el){
               trySelect(mouse);
               if(el.selected){
                       createLine.state = "BUTTON_RELEASED";
                       el.active = false;
                       console.log("clear_click");
                   }
               mappi.requestPaint();
               mappi.clear();
           });
        }
       onPressedChanged:{
           mappi.elements.forEach(function(el){
               if(el.active){
                    if (el.state === "RELEASED"){
                           el.state = "PRESSED";
                           el.mouseStart(mouseX,mouseY);
                           console.log("DOWN")
                       }
                       else if (el.state == "PRESSED"){
                           el.state = "RELEASED";
                           el.mouseStop();
                           console.log("UP")
                       }
                   }
           });
       }
       onPositionChanged: {
            mappi.elements.forEach(function(el) {
                    if(el.selected) {
                        if(el.type === 2){
                            el.mouseMove(mouse.x, mouse.y);
                            el.updateSvgArr();
                            mappi.requestPaint();
                            mappi.clear();
                            console.log("clear_pos_cha");
                        }
                    }
                    if(el.active){
                        el.mouseMove(mouse.x,mouse.y);
                        mappi.requestPaint();
                    }
            });
        }
    }
}

