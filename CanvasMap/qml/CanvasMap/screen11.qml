import QtQuick 2.0
import "numeric-1.2.6.js" as Numeric
import "canvastosvg.js" as CTS
import "Polygon.js" as JSPoly

Rectangle {
    id: screen
    width: 360
    height: 360
    Text {
        text: Numeric.numeric.version
        anchors.centerIn: parent
    }

    Polygon {
        id: poly1
        property string color: "blue";
        coords: [[0,0], [100,0], [100,100], [0,100]];
    }

    Polygon {
        id: poly2
        property string color: "green";
        fillColor: "red"
        coords: [[10,10], [50,0],[50,50], [0,50]];
    }
    Canvas {
        id:canvas
        property int paintX
        property int paintY
        property int count: 0
        property int lineWidth: 2
        property string drawColor: "black"
        property var _getContext;
        property var cs;
        property var ctx;
        renderTarget: Canvas.Image;
        property var elements: [];
        anchors.fill: parent
        MouseArea {
           id:mousearea
           property int hitrad: 5;
           anchors.fill: parent
           property var selected_element: 0;
           function trySelect(mouse) {
               var pf = false;
               canvas.elements.forEach(function(el) {
                   el.coords.forEach(function(c, idx) {
                   if(
                        mouse.x >= c[0] - hitrad && mouse.x <= c[0] + hitrad &&
                        mouse.y >= c[1] - hitrad && mouse.y <= c[1] + hitrad) {
                        canvas.elements.forEach(function(el2) {
                            el2.deselectAllNodes();
                        });
                        canvas.clear();
                        el.selectNode(idx);
                        selected_element = el;
                        pf = true;
                        }
                   });
               });
               if(pf === false) {
                   canvas.elements.forEach(function(el2) {
                       el2.deselectAllNodes();
                       selected_element = 0;
                   });
               }
           }
           onDoubleClicked: {
               canvas.elements.forEach(function(el) {
                   for(var i = 0; i < el.coords.length - 1; i++) {
                        var d = JSPoly.dist2ToSegment([mouse.x, mouse.y],
                                                      el.coords[i + 1],
                                                      el.coords[i])
                       console.log(d);
                       if(d < 25) {
                           el.insertNodeAt(i, mouse.x, mouse.y);
                           canvas.clear();
                           el.selectNode(i);
                           selected_element = el;
                           pf = true;
                           break;
                       }
                    }
               });
               canvas.requestPaint();
           }

           onClicked: {
               //console.log(canvas.cs.getSVG());
               trySelect(mouse);
               canvas.clear();
               canvas.requestPaint();
            }
            onPositionChanged: {
                if(!selected_element) {
                    trySelect(mouse);
                }
                if(selected_element) {
                    selected_element.moveSelectedNode(mouse.x, mouse.y);
                    canvas.clear()
                    canvas.requestPaint()
                } else if (selected_element == 0) {
                }
            }
        }
        Component.onCompleted: {
        }
        onAvailableChanged: {
            if(available) {
                cs = new CTS.CanvasSVG.Deferred()
                cs.wrapCanvas(canvas, canvas.getContext('2d'));
                elements.push(poly1);
                elements.push(poly2);
                ctx = cs.getCTSContext('2d');
            }
        }
        onPaint: {
//            if(!ctx) { // available changed??
//                //ctx = canvas.getContext('2d');

//                for(var prop in cs) {
//                    console.log(" " + prop + " " + cs[prop]);
//                }

//            }

            elements.forEach(function(el) {
                el.renderToCtx(cs);
            });
//            ctx.save();
//            ctx.clearRect(0, 0, canvas.width, canvas.height);
//            ctx.globalAlpha = canvas.alpha;
//            ctx.scale(canvas.scaleX, canvas.scaleY);
//            ctx.rotate(canvas.rotate);
//            ctx.globalCompositeOperation = "source-over";
//            ctx.translate(canvas.width/2, canvas.height/2);
//            ctx.strokeStyle = Qt.rgba(.3, .3, .3,1);
//            ctx.lineWidth = 1;

            //! [0]
//                    ctx.lineWidth = 3;

//                    ctx.path = "M-129.83 103.065C-129.327 109.113 -128.339 115.682 -126.6 118.801C-126.6 118.801 -130.2 131.201 -121.4 144.401C-121.4 144.401 -121.8 151.601 -120.2 154.801C-120.2 154.801 -116.2 163.201 -111.4 164.001C-107.516 164.648 -98.793 167.717 -88.932 169.121C-88.932 169.121 -71.8 183.201 -75 196.001C-75 196.001 -75.4 212.401 -79 214.001C-79 214.001 -67.4 202.801 -77 219.601L-81.4 238.401C-81.4 238.401 -55.8 216.801 -71.4 235.201L-81.4 261.201C-81.4 261.201 -61.8 242.801 -69 251.201L-72.2 260.001C-72.2 260.001 -29 232.801 -59.8 262.401C-59.8 262.401 -51.8 258.801 -47.4 261.601C-47.4 261.601 -40.6 260.401 -41.4 262.001C-41.4 262.001 -62.2 272.401 -65.8 290.801C-65.8 290.801 -57.4 280.801 -60.6 291.601L-60.2 303.201C-60.2 303.201 -56.2 281.601 -56.6 319.201C-56.6 319.201 -37.4 301.201 -49 322.001L-49 338.801C-49 338.801 -33.8 322.401 -40.2 335.201C-40.2 335.201 -30.2 326.401 -34.2 341.601C-34.2 341.601 -35 352.001 -30.6 340.801C-30.6 340.801 -14.6 310.201 -20.6 336.401C-20.6 336.401 -21.4 355.601 -16.6 340.801C-16.6 340.801 -16.2 351.201 -7 358.401C-7 358.401 -8.2 307.601 4.6 343.601L8.6 360.001C8.6 360.001 11.4 350.801 11 345.601C11 345.601 25.8 329.201 19 353.601C19 353.601 34.2 330.801 31 344.001C31 344.001 23.4 360.001 25 364.801C25 364.801 41.8 330.001 43 328.401C43 328.401 41 370.802 51.8 334.801C51.8 334.801 57.4 346.801 54.6 351.201C54.6 351.201 62.6 343.201 61.8 340.001C61.8 340.001 66.4 331.801 69.2 345.401C69.2 345.401 71 354.801 72.6 351.601C72.6 351.601 76.6 375.602 77.8 352.801C77.8 352.801 79.4 339.201 72.2 327.601C72.2 327.601 73 324.401 70.2 320.401C70.2 320.401 83.8 342.001 76.6 313.201C76.6 313.201 87.801 321.201 89.001 321.201C89.001 321.201 75.4 298.001 84.2 302.801C84.2 302.801 79 292.401 97.001 304.401C97.001 304.401 81 288.401 98.601 298.001C98.601 298.001 106.601 304.401 99.001 294.401C99.001 294.401 84.6 278.401 106.601 296.401C106.601 296.401 118.201 312.801 119.001 315.601C119.001 315.601 109.001 286.401 104.601 283.601C104.601 283.601 113.001 247.201 154.201 262.801C154.201 262.801 161.001 280.001 165.401 261.601C165.401 261.601 178.201 255.201 189.401 282.801C189.401 282.801 193.401 269.201 192.601 266.401C192.601 266.401 199.401 267.601 198.601 266.401C198.601 266.401 211.801 270.801 213.001 270.001C213.001 270.001 219.801 276.801 220.201 273.201C220.201 273.201 229.401 276.001 227.401 272.401C227.401 272.401 236.201 288.001 236.601 291.601L239.001 277.601L241.001 280.401C241.001 280.401 242.601 272.801 241.801 271.601C241.001 270.401 261.801 278.401 266.601 299.201L268.601 307.601C268.601 307.601 274.601 292.801 273.001 288.801C273.001 288.801 278.201 289.601 278.601 294.001C278.601 294.001 282.601 270.801 277.801 264.801C277.801 264.801 282.201 264.001 283.401 267.601L283.401 260.401C283.401 260.401 290.601 261.201 290.601 258.801C290.601 258.801 295.001 254.801 297.001 259.601C297.001 259.601 284.601 224.401 303.001 243.601C303.001 243.601 310.201 254.401 306.601 235.601C303.001 216.801 299.001 215.201 303.801 214.801C303.801 214.801 304.601 211.201 302.601 209.601C300.601 208.001 303.801 209.601 303.801 209.601C303.801 209.601 308.601 213.601 303.401 191.601C303.401 191.601 309.801 193.201 297.801 164.001C297.801 164.001 300.601 161.601 296.601 153.201C296.601 153.201 304.601 157.601 307.401 156.001C307.401 156.001 307.001 154.401 303.801 150.401C303.801 150.401 282.201 95.6 302.601 117.601C302.601 117.601 314.451 131.151 308.051 108.351C308.051 108.351 298.94 84.341 299.717 80.045L-129.83 103.065z";

//                    ctx.fillStyle = 'blue';
//                    ctx.fill();
//                    ctx.stroke();
            //! [0]
//            ctx.restore();
//            cs.fillRect(25,25,100,100);
//            cs.clearRect(45,45,60,60);
//            cs.strokeRect(50,50,50,50);
//            console.log(cs.getSVG())
        }

        function clear() {
            ctx.clearRect(0, 0, screen.width, screen.height);
        }

        function exportToSVG() {

        }
    }
}
