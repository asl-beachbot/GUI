function drawHandles(elem, ctx) {
    ctx.fillStyle = "black";
    for(var i = 1; i < elem.coords.length; i++) {
        ctx.fillRect (elem.coords[i][0]-2, elem.coords[i][1]-2, 4, 4);
    }
    if(elem.selected_idx) {
        ctx.fillStyle = "green";
        ctx.fillRect (elem.coords[elem.selected_idx][0]-2, elem.coords[elem.selected_idx][1]-2, 8, 8);
    }
}


function drawPoly(elem, ctx) {

//    ctx.save();
//    ctx.clearRect(0, 0, canvas.width, canvas.height);
//    ctx.strokeStyle = 'palegreen'
//    ctx.fillStyle = 'limegreen';
//    ctx.lineWidth = 5;
//    ctx.beginPath();
//    ctx.moveTo(100, 100);
//    ctx.lineTo(300, 100);
//    ctx.lineTo(100, 200);
//    ctx.closePath();
//    ctx.fill();
//    ctx.stroke();
//    ctx.fillStyle = 'aquamarine'
//    ctx.font = '20px sansserif'
//    ctx.fillText('HTML Canvas API!', 100, 300);
//    ctx.fillText('Imperative Drawing!', 100, 340);
//    ctx.restore();
//    return;


    ctx.transform( elem.a, elem.b, elem.c, elem.d, elem.e, elem.f);
    ctx.strokeStyle = elem.color;
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(elem.coords[0][0], elem.coords[0][1]);
    for(var i = 1; i < elem.coords.length; i++) {

        ctx.lineTo(elem.coords[i][0], elem.coords[i][1]);
    }
    if(elem.closed) ctx.closePath();
    if(elem.fillColor) {
        ctx.fillStyle = elem.fillColor;
        ctx.fill();
    }
    ctx.stroke();

}

// Necessary for adding point to line! :)
function sqr(x) { return x * x }
function dist2(v, w) { return sqr(v[0] - w[0]) + sqr(v[1] - w[1]) }
function distToSegmentSquared(p, v, w) {
  var l2 = dist2(v, w);
  if (l2 == 0) return dist2(p, v);
  var t = ((p[0] - v[0]) * (w[0] - v[0]) + (p[1] - v[1]) * (w[1] - v[1])) / l2;
  if (t < 0) return dist2(p, v);
  if (t > 1) return dist2(p, w);
  return dist2(p, { x: v[0] + t * (w[0] - v[0]),
                    y: v[1] + t * (w[1] - v[1]) });
}
function distToSegment(p, v, w) { return Math.sqrt(distToSegmentSquared(p, v, w)); }
function dist2ToSegment(p, v, w) {
    var px = w[0] - v[0];
    var py = w[1] - v[1];
    var da = px*px + py*py;
    var u = ((p[0] - v[0]) * px + (p[1] - v[1]) * py) / da;
    if(u > 1) {
        u = 1;
    } else if (u < 1) {
        u = 0;
    }

    var x = w[0] + u * px;
    var y = w[1] + u * py;

    var dx = x - p[0];
    var dy = y - p[1];

    return dx*dx + dy*dy;
}
