import QtQuick 2.0


Rectangle {
    id: screen
    width: 2560
    height: 1600

    SvgCanv2{
        id: svg1
        path1: "M 561.25 18 C 537.95201 17.888394 508.92857 74.160714 500 72.375 C 485.71429 69.517857 177.14286 160.93303 340 175.21875 C 502.85714 189.50446 182.85268 360.94196 54.28125 406.65625 C -74.290178 452.37053 191.42857 763.78125 300 963.78125 C 408.57143 1163.7813 582.84375 778.0625 582.84375 778.0625 C 582.84375 778.0625 168.55804 383.7991 442.84375 346.65625 C 442.84375 346.65625 602.86607 278.06697 591.4375 103.78125 C 587.15179 38.424109 575.22879 18.066964 561.25 18 z M 660 229.5 L 622.84375 440.9375 L 720 292.375 L 660 229.5 z"
        Component.onCompleted: {
            getDimensions();
            importPath();
        }
    }
    Canvas{
        id:canvas
        antialiasing: true
        smooth: true
        property var ctx;
        renderTarget: Canvas.Image;
        property var elements: [];
        anchors.centerIn: parent
        anchors.fill: mappi

        Component.onCompleted: {
            requestPaint();
        }
        onAvailableChanged: {
            if(available) {
                //cs = new CTS.CanvasSVG.Deferred()
                //cs.wrapCanvas(canvas, canvas.getContext('2d'));
                //elements.push(poly1);
                //elements.push(poly2);
                elements.push(svg1);
                ctx = canvas.getContext('2d');
                //ctx = cs.getCTSContext('2d');
            }
        }

        MousePinch{
            id: wazzappa
        }

        onPaint: {
            elements.forEach(function(el) {
                el.renderToCtx(ctx);
            });
        }
        function clear() {
            ctx.clearRect(0, 0, screen.width, screen.height);
        }

        function exportToSVG() {

        }
    }
    Component.onCompleted:{
        canvas.requestPaint();
    }
}
