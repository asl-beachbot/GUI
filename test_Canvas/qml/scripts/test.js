function init ()
{
	canvas.addEventListener('mousemove', ev_mousemove, false);
}

var started = false; 
function ev_mousemove (ev)
{
	var x,y;
	if (ev.layerX || ev.layerX == 0)
	{
		x = ev.layerX;
		y = ev.layerY;
	}
	else if (ev.offsetX || ev.offsetX == 0)
	{
		x = ev.offsetX;
		y = ev.offsetY;
	}

	if (!started)
	{
		context.beginPath();
		context.moveTo(x,y);
		started = true;
	}
	else
	{
		context.lineTo(x,y);
		context.stroke();
	}
}