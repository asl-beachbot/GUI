    // var paths = function (ps) {
    //     var p = paths.ps = paths.ps || {};
    //     if (p[ps]) {
    //         p[ps].sleep = 100;
    //     } else {
    //         p[ps] = {
    //             sleep: 100
    //         };
    //     }
    //     setTimeout(function () {
    //         for (var key in p) if (p[has](key) && key != ps) {
    //             p[key].sleep--;
    //             !p[key].sleep && delete p[key];
    //         }
    //     });
    //     return p[ps];
    // };
var lowerCase = String.prototype.toLowerCase;
var math = Math;
var mmax = math.max;
var mmin = math.min;
var abs = math.abs;
var pow = math.pow;
var PI = math.PI;
var nu = "number";
var string = "string";
var array = "array";
//var toString = "toString";
var fillString = "fill";
var objectToString = Object.prototype.toString;
var paper = {};
var push = "push";
var colourRegExp = /^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?)%?\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?)%?\s*\))\s*$/i;
var isnan = {"NaN": 1, "Infinity": 1, "-Infinity": 1};
var bezierrg = /^(?:cubic-)?bezier\(([^,]+),([^,]+),([^,]+),([^\)]+)\)/;
var round = math.round;
var setAttribute = "setAttribute";
var toFloat = parseFloat;
var toInt = parseInt;
var upperCase = String.prototype.toUpperCase;
var concat = "concat";
var separator = /[, ]+/;
var elements = {circle: 1, rect: 1, path: 1, ellipse: 1, text: 1, image: 1};
var formatrg = /\{(\d+)\}/g;
var proto = "prototype";
var has = "hasOwnProperty";
var appendChild = "appendChild";
var apply = "apply";
var whitespace = /[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]/g;
var commaSpaces = /[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*/;
var hsrg = {hs: 1, rg: 1};
var p2s = /,?([achlmqrstvxz]),?/gi;
var pathCommand = /([achlmrqstvz])[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\d*\.?\d*(?:e[\-+]?\d+)?[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)/ig;
var tCommand = /([rstm])[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\d*\.?\d*(?:e[\-+]?\d+)?[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)/ig;
var pathValues = /(-?\d*\.?\d*(?:e[\-+]?\d+)?)[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\x09\x0a\x0b\x0c\x0d\x20\xa0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*/ig;

function l2c(x1, y1, x2, y2) {
    return [x1, y1, x2, y2, x2, y2];
};
function q2c(x1, y1, ax, ay, x2, y2) {
    var _13 = 1 / 3,
        _23 = 2 / 3;
    return [
            _13 * x1 + _23 * ax,
            _13 * y1 + _23 * ay,
            _13 * x2 + _23 * ax,
            _13 * y2 + _23 * ay,
            x2,
            y2
        ];
};
function a2c(x1, y1, rx, ry, angle, large_arc_flag, sweep_flag, x2, y2, recursive) {
    // for more information of where this math came from visit:
    // http://www.w3.org/TR/SVG11/implnote.html#ArcImplementationNotes
    var _120 = PI * 120 / 180,
        rad = PI / 180 * (+angle || 0),
        res = [],
        xy,
        rotate = cacher(function (x, y, rad) {
            var X = x * math.cos(rad) - y * math.sin(rad),
                Y = x * math.sin(rad) + y * math.cos(rad);
            return {x: X, y: Y};
        });
    if (!recursive) {
        xy = rotate(x1, y1, -rad);
        x1 = xy.x;
        y1 = xy.y;
        xy = rotate(x2, y2, -rad);
        x2 = xy.x;
        y2 = xy.y;
        var cos = math.cos(PI / 180 * angle),
            sin = math.sin(PI / 180 * angle),
            x = (x1 - x2) / 2,
            y = (y1 - y2) / 2;
        var h = (x * x) / (rx * rx) + (y * y) / (ry * ry);
        if (h > 1) {
            h = math.sqrt(h);
            rx = h * rx;
            ry = h * ry;
        }
        var rx2 = rx * rx,
            ry2 = ry * ry,
            k = (large_arc_flag == sweep_flag ? -1 : 1) *
                math.sqrt(abs((rx2 * ry2 - rx2 * y * y - ry2 * x * x) / (rx2 * y * y + ry2 * x * x))),
            cx = k * rx * y / ry + (x1 + x2) / 2,
            cy = k * -ry * x / rx + (y1 + y2) / 2,
            f1 = math.asin(((y1 - cy) / ry).toFixed(9)),
            f2 = math.asin(((y2 - cy) / ry).toFixed(9));

        f1 = x1 < cx ? PI - f1 : f1;
        f2 = x2 < cx ? PI - f2 : f2;
        f1 < 0 && (f1 = PI * 2 + f1);
        f2 < 0 && (f2 = PI * 2 + f2);
        if (sweep_flag && f1 > f2) {
            f1 = f1 - PI * 2;
        }
        if (!sweep_flag && f2 > f1) {
            f2 = f2 - PI * 2;
        }
    } else {
        f1 = recursive[0];
        f2 = recursive[1];
        cx = recursive[2];
        cy = recursive[3];
    }
    var df = f2 - f1;
    if (abs(df) > _120) {
        var f2old = f2,
            x2old = x2,
            y2old = y2;
        f2 = f1 + _120 * (sweep_flag && f2 > f1 ? 1 : -1);
        x2 = cx + rx * math.cos(f2);
        y2 = cy + ry * math.sin(f2);
        res = a2c(x2, y2, rx, ry, angle, 0, sweep_flag, x2old, y2old, [f2, f2old, cx, cy]);
    }
    df = f2 - f1;
    var c1 = math.cos(f1),
        s1 = math.sin(f1),
        c2 = math.cos(f2),
        s2 = math.sin(f2),
        t = math.tan(df / 4),
        hx = 4 / 3 * rx * t,
        hy = 4 / 3 * ry * t,
        m1 = [x1, y1],
        m2 = [x1 + hx * s1, y1 - hy * c1],
        m3 = [x2 + hx * s2, y2 - hy * c2],
        m4 = [x2, y2];
    m2[0] = 2 * m1[0] - m2[0];
    m2[1] = 2 * m1[1] - m2[1];
    if (recursive) {
        return [m2, m3, m4][concat](res);
    } else {
        res = [m2, m3, m4][concat](res).join()[split](",");
        var newres = [];
        for (var i = 0, ii = res.length; i < ii; i++) {
            newres[i] = i % 2 ? rotate(res[i - 1], res[i], rad).y : rotate(res[i], res[i + 1], rad).x;
        }
        return newres;
    }
};

function findDotAtSegment (p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y, t) {
            var t1 = 1 - t;
            return {
                x: pow(t1, 3) * p1x + pow(t1, 2) * 3 * t * c1x + t1 * 3 * t * t * c2x + pow(t, 3) * p2x,
                y: pow(t1, 3) * p1y + pow(t1, 2) * 3 * t * c1y + t1 * 3 * t * t * c2y + pow(t, 3) * p2y
            };
        };

function curveDim (p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y) {
    var a = (c2x - 2 * c1x + p1x) - (p2x - 2 * c2x + c1x),
        b = 2 * (c1x - p1x) - 2 * (c2x - c1x),
        c = p1x - c1x,
        t1 = (-b + math.sqrt(b * b - 4 * a * c)) / 2 / a,
        t2 = (-b - math.sqrt(b * b - 4 * a * c)) / 2 / a,
        y = [p1y, p2y],
        x = [p1x, p2x],
        dot;
    abs(t1) > "1e12" && (t1 = .5);
    abs(t2) > "1e12" && (t2 = .5);
    if (t1 > 0 && t1 < 1) {
        dot = findDotAtSegment(p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y, t1);
        x.push(dot.x);
        y.push(dot.y);
    }
    if (t2 > 0 && t2 < 1) {
        dot = findDotAtSegment(p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y, t2);
        x.push(dot.x);
        y.push(dot.y);
    }
    a = (c2y - 2 * c1y + p1y) - (p2y - 2 * c2y + c1y);
    b = 2 * (c1y - p1y) - 2 * (c2y - c1y);
    c = p1y - c1y;
    t1 = (-b + math.sqrt(b * b - 4 * a * c)) / 2 / a;
    t2 = (-b - math.sqrt(b * b - 4 * a * c)) / 2 / a;
    abs(t1) > "1e12" && (t1 = .5);
    abs(t2) > "1e12" && (t2 = .5);
    if (t1 > 0 && t1 < 1) {
        dot = findDotAtSegment(p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y, t1);
        x.push(dot.x);
        y.push(dot.y);
    }
    if (t2 > 0 && t2 < 1) {
        dot = findDotAtSegment(p1x, p1y, c1x, c1y, c2x, c2y, p2x, p2y, t2);
        x.push(dot.x);
        y.push(dot.y);
    }
    return {
        min: {x: mmin[apply](0, x), y: mmin[apply](0, y)},
        max: {x: mmax[apply](0, x), y: mmax[apply](0, y)}
    };
};

function parsePathString(pathString) {
    if (!pathString) {
        return null;
    }
    // var pth = paths(pathString);
    // if (pth.arr) {
    //     return pathClone(pth.arr);
    // }

    var paramCounts = {a: 7, c: 6, h: 1, l: 2, m: 2, r: 4, q: 4, s: 4, t: 2, v: 1, z: 0},
        data = [];
    // if (R.is(pathString, array) && R.is(pathString[0], array)) { // rough assumption
    //     data = pathClone(pathString);
    // }
    if (!data.length) {
        String(pathString).replace(pathCommand, function (a, b, c) {
            var params = [],
                name = b.toLowerCase();
            c.replace(pathValues, function (a, b) {
                b && params.push(+b);
            });
            if (name == "m" && params.length > 2) {
                data.push([b][concat](params.splice(0, 2)));
                name = "l";
                b = b == "m" ? "l" : "L";
            }
            if (name == "r") {
                data.push([b][concat](params));
            } else while (params.length >= paramCounts[name]) {
                data.push([b][concat](params.splice(0, paramCounts[name])));
                if (!paramCounts[name]) {
                    break;
                }
            }
        });
    }
    // data.toString = R._path2string;
    // pth.arr = pathClone(data);
    return data;
};

function pathToAbsolute(pathArray) {
    // var pth = paths(pathArray);
    // if (pth.abs) {
    //     return pathClone(pth.abs);
    // }
    // if (!R.is(pathArray, array) || !R.is(pathArray && pathArray[0], array)) { // rough assumption
    //     pathArray = R.parsePathString(pathArray);
    // }
    pathArray = parsePathString(pathArray);
    if (!pathArray || !pathArray.length) {
        return [["M", 0, 0]];
    }
    var res = [],
        x = 0,
        y = 0,
        mx = 0,
        my = 0,
        start = 0;
    if (pathArray[0][0] == "M") {
        x = +pathArray[0][1];
        y = +pathArray[0][2];
        mx = x;
        my = y;
        start++;
        res[0] = ["M", x, y];
    }
    var crz = pathArray.length == 3 && pathArray[0][0] == "M" && pathArray[1][0].toUpperCase() == "R" && pathArray[2][0].toUpperCase() == "Z";
    for (var r, pa, i = start, ii = pathArray.length; i < ii; i++) {
        res.push(r = []);
        pa = pathArray[i];
        if (pa[0] != upperCase.call(pa[0])) {
            r[0] = upperCase.call(pa[0]);
            switch (r[0]) {
                case "A":
                    r[1] = pa[1];
                    r[2] = pa[2];
                    r[3] = pa[3];
                    r[4] = pa[4];
                    r[5] = pa[5];
                    r[6] = +(pa[6] + x);
                    r[7] = +(pa[7] + y);
                    break;
                case "V":
                    r[1] = +pa[1] + y;
                    break;
                case "H":
                    r[1] = +pa[1] + x;
                    break;
                case "R":
                    var dots = [x, y][concat](pa.slice(1));
                    for (var j = 2, jj = dots.length; j < jj; j++) {
                        dots[j] = +dots[j] + x;
                        dots[++j] = +dots[j] + y;
                    }
                    res.pop();
                    res = res[concat](catmullRom2bezier(dots, crz));
                    break;
                case "M":
                    mx = +pa[1] + x;
                    my = +pa[2] + y;
                default:
                    for (j = 1, jj = pa.length; j < jj; j++) {
                        r[j] = +pa[j] + ((j % 2) ? x : y);
                    }
            }
        } else if (pa[0] == "R") {
            dots = [x, y][concat](pa.slice(1));
            res.pop();
            res = res[concat](catmullRom2bezier(dots, crz));
            r = ["R"][concat](pa.slice(-2));
        } else {
            for (var k = 0, kk = pa.length; k < kk; k++) {
                r[k] = pa[k];
            }
        }
        switch (r[0]) {
            case "Z":
                x = mx;
                y = my;
                break;
            case "H":
                x = r[1];
                break;
            case "V":
                y = r[1];
                break;
            case "M":
                mx = r[r.length - 2];
                my = r[r.length - 1];
            default:
                x = r[r.length - 2];
                y = r[r.length - 1];
        }
    }
    // res.toString = R._path2string;
    // pth.abs = pathClone(res);
    return res;
};

function path2curve(path, path2) {
    //var pth = !path2 && paths(path);
    // if (!path2 && pth.curve) {
    //     return pathClone(pth.curve);
    // }
    var p = pathToAbsolute(path),
        p2 = path2 && pathToAbsolute(path2),
        attrs = {x: 0, y: 0, bx: 0, by: 0, X: 0, Y: 0, qx: null, qy: null},
        attrs2 = {x: 0, y: 0, bx: 0, by: 0, X: 0, Y: 0, qx: null, qy: null},
        processPath = function (path, d, pcom) {
            var nx, ny, tq = {T:1, Q:1};
            if (!path) {
                return ["C", d.x, d.y, d.x, d.y, d.x, d.y];
            }
            !(path[0] in tq) && (d.qx = d.qy = null);
            switch (path[0]) {
                case "M":
                    d.X = path[1];
                    d.Y = path[2];
                    break;
                case "A":
                    path = ["C"][concat](a2c[apply](0, [d.x, d.y][concat](path.slice(1))));
                    break;
                case "S":
                    if (pcom == "C" || pcom == "S") { // In "S" case we have to take into account, if the previous command is C/S.
                        nx = d.x * 2 - d.bx;          // And reflect the previous
                        ny = d.y * 2 - d.by;          // command's control point relative to the current point.
                    }
                    else {                            // or some else or nothing
                        nx = d.x;
                        ny = d.y;
                    }
                    path = ["C", nx, ny][concat](path.slice(1));
                    break;
                case "T":
                    if (pcom == "Q" || pcom == "T") { // In "T" case we have to take into account, if the previous command is Q/T.
                        d.qx = d.x * 2 - d.qx;        // And make a reflection similar
                        d.qy = d.y * 2 - d.qy;        // to case "S".
                    }
                    else {                            // or something else or nothing
                        d.qx = d.x;
                        d.qy = d.y;
                    }
                    path = ["C"][concat](q2c(d.x, d.y, d.qx, d.qy, path[1], path[2]));
                    break;
                case "Q":
                    d.qx = path[1];
                    d.qy = path[2];
                    path = ["C"][concat](q2c(d.x, d.y, path[1], path[2], path[3], path[4]));
                    break;
                case "L":
                    path = ["C"][concat](l2c(d.x, d.y, path[1], path[2]));
                    break;
                case "H":
                    path = ["C"][concat](l2c(d.x, d.y, path[1], d.y));
                    break;
                case "V":
                    path = ["C"][concat](l2c(d.x, d.y, d.x, path[1]));
                    break;
                case "Z":
                    path = ["C"][concat](l2c(d.x, d.y, d.X, d.Y));
                    break;
            }
            return path;
        },
        fixArc = function (pp, i) {
            if (pp[i].length > 7) {
                pp[i].shift();
                var pi = pp[i];
                while (pi.length) {
                    pp.splice(i++, 0, ["C"][concat](pi.splice(0, 6)));
                }
                pp.splice(i, 1);
                ii = mmax(p.length, p2 && p2.length || 0);
            }
        },
        fixM = function (path1, path2, a1, a2, i) {
            if (path1 && path2 && path1[i][0] == "M" && path2[i][0] != "M") {
                path2.splice(i, 0, ["M", a2.x, a2.y]);
                a1.bx = 0;
                a1.by = 0;
                a1.x = path1[i][1];
                a1.y = path1[i][2];
                ii = mmax(p.length, p2 && p2.length || 0);
            }
        };
    for (var i = 0, ii = mmax(p.length, p2 && p2.length || 0); i < ii; i++) {
        p[i] = processPath(p[i], attrs);
        fixArc(p, i);
        p2 && (p2[i] = processPath(p2[i], attrs2));
        p2 && fixArc(p2, i);
        fixM(p, p2, attrs, attrs2, i);
        fixM(p2, p, attrs2, attrs, i);
        var seg = p[i],
            seg2 = p2 && p2[i],
            seglen = seg.length,
            seg2len = p2 && seg2.length;
        attrs.x = seg[seglen - 2];
        attrs.y = seg[seglen - 1];
        attrs.bx = toFloat(seg[seglen - 4]) || attrs.x;
        attrs.by = toFloat(seg[seglen - 3]) || attrs.y;
        attrs2.bx = p2 && (toFloat(seg2[seg2len - 4]) || attrs2.x);
        attrs2.by = p2 && (toFloat(seg2[seg2len - 3]) || attrs2.y);
        attrs2.x = p2 && seg2[seg2len - 2];
        attrs2.y = p2 && seg2[seg2len - 1];
    }
    // if (!p2) {
    //     pth.curve = pathClone(p);
    // }
    return p2 ? [p, p2] : p;
};


function pathDimensions(path) {
    // var pth = paths(path);
    if (!path) {
        return {x: 0, y: 0, width: 0, height: 0, x2: 0, y2: 0};
    }
    path = path2curve(path);
    var x = 0,
        y = 0,
        X = [],
        Y = [],
        p;
    for (var i = 0, ii = path.length; i < ii; i++) {
        p = path[i];
        if (p[0] == "M") {
            x = p[1];
            y = p[2];
            X.push(x);
            Y.push(y);
        } else {
            var dim = curveDim(x, y, p[1], p[2], p[3], p[4], p[5], p[6]);
            X = X[concat](dim.min.x, dim.max.x);
            Y = Y[concat](dim.min.y, dim.max.y);
            x = p[5];
            y = p[6];
        }
    }
    var xmin = mmin[apply](0, X),
        ymin = mmin[apply](0, Y),
        xmax = mmax[apply](0, X),
        ymax = mmax[apply](0, Y),
        width = xmax - xmin,
        height = ymax - ymin,
            bb = {
            x: xmin,
            y: ymin,
            x2: xmax,
            y2: ymax,
            width: width,
            height: height,
            cx: xmin + width / 2,
            cy: ymin + height / 2
        };
    // pth.bbox = clone(bb);
    return bb;
};
function inBBox(bbox, x, y) {
        return x >= bbox.x && x <= bbox.x2 && y >= bbox.y && y <= bbox.y2;
};
