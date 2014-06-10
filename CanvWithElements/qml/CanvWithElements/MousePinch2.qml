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
        if(!asd.active){
            mappi.elements.forEach(function(el){
                if(el.selected) {
                    el.pinchStart();
                }
            });
        }
     }

    onPinchUpdated:{
        if(!asd.active){
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
    }
    onPinchFinished: {
        if(!asd.active){
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
    }
    MouseArea{

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
 //               else if(el.type === 3){
 //                    el.selected = false;
 //               }
            });
            if(pf === false) {
                mappi.elements.forEach(function(el2) {
                    el2.deselectAllNodes();
                    selected_element = 0;
                });
            }
        }

       id:mousearea
       property int hitrad: 5;
       anchors.fill: parent
       property var selected_element: 0;
       onDoubleClicked: {
           if(!asd.active){
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
       }

       onClicked: {
           if(!asd.active){
               mappi.elements.forEach(function(el){
                       trySelect(mouse);
                       mappi.requestPaint();
                       mappi.clear();
                       console.log("clear_click");
               });
           }
           else if(asd.active){
               ground.requestPaint();
           }
        }
       onPressedChanged:{
           if(asd.active){
                if (asd.state == "RELEASED")
                   {
                       asd.state = "PRESSED";
                       asd.mouseStart(mouseX,mouseY);
                       console.log("DOWN")
                   }
                   else if (asd.state == "PRESSED")
                   {
                       asd.state = "RELEASED";
                       asd.mouseStop();
                       console.log("UP")
                   }
               }

       }
       onPositionChanged: {
            mappi.elements.forEach(function(el) {
                if(el.type !== 3){
                    if(!el.selected) {
                        //trySelect(mouse);
                    }
                    else if(el.selected) {
                        if(el.type === 2){
                            el.mouseMove(mouse.x, mouse.y);
                            el.updateSvgArr();
                            mappi.requestPaint();
                            mappi.clear();
                            console.log("clear_pos_cha");
                        }
                    }
                }
                else if(el.type === 3){
                    if(el.active){
                        el.mouseMove(mouse.x,mouse.y);
                        mappi.requestPaint();
                        }
                    }
            });
        }
    }
}

