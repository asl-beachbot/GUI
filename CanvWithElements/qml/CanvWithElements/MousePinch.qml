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
            if(el.selected){
                    el.pinchUpdate(pinch.scale, pinch.rotation);
            }
        });
        mappi.requestPaint();
        mappi.clear();
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
    }
    MouseArea{
       id:mousearea
       property int hitrad: 5;
       anchors.fill: parent
       property var selected_element: 0
       function trySelect(mouse) {
           var pf = false;
           mappi.elements.forEach(function(el) {
               if (el.type === 2){
                   el.selected = false;
                   if(mouse.x < el.bb.x + el.bb.width + hitrad && mouse.x > el.bb.x - hitrad &&
                      mouse.y < el.bb.y + el.bb.height + hitrad && mouse.y > el.bb.y - hitrad) {
                            console.log("hit")
                            mappi.clear();
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
//       onDoubleClicked: {
//           mappi.elements.forEach(function(el) {
//                if(el.selected){
//                       el.path1 = " ";
//                       el.svgCurArr = [];
//                       el.svgOldArr = [];
//                       el.updateSvgArr();
//                       mappi.requestPaint();
//                       mappi.clear();
//               }
//           });
//       }

       onClicked:{
           mappi.elements.forEach(function(el){
               trySelect(mouse);
               if(el.selected){
                       createLine.state = "BUTTON_RELEASED";
                   }
               mappi.requestPaint();
               mappi.clear();
           });
        }
       onPressedChanged:{
           mappi.elements.forEach(function(el){
               if(el.selected){
                   if(el.state === "RELEASED"){
                       el.state = "PRESSED";
                       el.mouseStart();
                   }
                   else if(el.state === "PRESSED"){
                       el.state = "RELEASED"
                       if(!el.pinchActive){
                           el.mouseStop();
                           el.updateSvgArr();
                           mappi.requestPaint();
                           mappi.clear();
                       }
                   }
               }
               if(el.active){
                   if(el.type === 3){
                        if (el.state === "RELEASED"){
                               el.state = "PRESSED";
                               el.mouseStart(mouseX,mouseY);
                           }
                           else if (el.state === "PRESSED"){
                               el.state = "RELEASED";
                               el.mouseStop();
                               mappi.requestPaint();
                               mappi.clear();
                           }
                        }
                    }
//               console.log("presschange");
            });
       }
       onPositionChanged: {
            mappi.elements.forEach(function(el) {
                    if(el.selected || el.active) {
                        if(el.type === 2){
                            if(!el.pinchActive){
                                el.mouseMove(mouse.x, mouse.y);
                            }
                            mappi.requestPaint();
                            mappi.clear();
                        }
                        else if(el.type === 3){
                            el.mouseMove(mouse.x, mouse.y);
                            mappi.requestPaint();
                        }
                    }
            });
        }
//       onReleased: {
//           mappi.elements.forEach(function(el){
//               console.log("release");
//           });
//       }
    }
}

