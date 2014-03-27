function createCanvas(parent, width, height) {
        var canvas = {};
        canvas.node = document.createElement('canvas');
        canvas.context = canvas.node.getContext('2d');
        canvas.node.width = width || 100;
        canvas.node.height = height || 100;
        parent.appendChild(canvas.node);
        return canvas;
    }

function init(container, width, height, fillColor) {
    var canvas = createCanvas(container, width, height);
    var ctx = canvas.context;
    // define a custom fillCircle method
    ctx.fillCircle = function(x, y, radius, fillColor) {
        this.fillStyle = fillColor;
        this.beginPath();
        this.moveTo(x, y);
        this.arc(x, y, radius, 0, Math.PI * 2, false);
        this.fill();
    };
    ctx.clearTo = function(fillColor) {
        ctx.fillStyle = fillColor;
        ctx.fillRect(0, 0, width, height);
    };
    ctx.clearTo(fillColor || "#ddd");

    // bind mouse events
    canvas.node.onmousemove = function(e) {
        if (!canvas.isDrawing) {
           return;
        }
        var x = e.pageX - this.offsetLeft;
        var y = e.pageY - this.offsetTop;
        var radius = 10; // or whatever
        var fillColor = '#ff0000';
        ctx.fillCircle(x, y, radius, fillColor);
    };
    canvas.node.onmousedown = function(e) {
        canvas.isDrawing = true;
    };
    canvas.node.onmouseup = function(e) {
        canvas.isDrawing = false;
    };
}

//var container = document.getElementById('drawingArea');
//init(container, 200, 200, '#ddd');