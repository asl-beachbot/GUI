import QtQuick 2.0
import "Polygon.js" as P

Item
{
    id: self
    property real a: 1;
    property real b: 0;
    property real c: 0;
    property real d: 1;
    property real e: 0;
    property real f: 0;
    property string color: "red";
    property var fillColor
    property bool closed: false;
    property int selected_idx;
    property bool poly_selected: false;
    property var coords: [];
    function renderToCtx(ctx) {
        ctx.save();
        P.drawPoly(this, ctx)
        P.drawHandles(this, ctx);
        ctx.restore();
    }
    function selectNode(idx) {
        selected_idx = idx;
    }
    function moveSelectedNode(x, y) {
        coords[selected_idx][0] = x; // or delta += ?
        coords[selected_idx][1] = y; // or delta += ?
    }
    function deselectAllNodes() {
        selected_idx = 0;
    }
    function insertNodeAt(idx, x, y) {
        coords.splice(idx, 0, [x, y]);
    }

    function toSVGXML () {

    }
}
