// arctan.asy
//  Graph of arctan correspondence. 

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);

// cd junk is needed for relative import 
cd("../../../asy/");
import jh;
cd("");

import graph;
real f(real x) {
  return (atan(x)+(pi/2.0))/pi;
}

real xmin = -3.5;
real xmax = 3.5;
real ymin = -0.35;
real ymax = 1.5;

arrowbar axisarrow = Arrows(TeXHead);
draw((xmin,0) -- (xmax,0), boldcolor, arrow=axisarrow);
draw((0,ymin) -- (0,ymax), boldcolor, arrow = axisarrow);
label("$\scriptstyle 1$", (1,0), S, boldcolor);
label("$\scriptstyle 2$", (2,0), S, boldcolor);
label("$\scriptstyle 3$", (3,0), S, boldcolor);
label("$\scriptstyle -1$", (-1,0), S, boldcolor);
label("$\scriptstyle -2$", (-2,0), S, boldcolor);
label("$\scriptstyle -3$", (-3,0), S, boldcolor);


draw((xmin+0.25,1) -- (xmax-0.25,1), dashed+boldcolor, arrow=None);
label("$\scriptstyle 1$", (0,1), NW);

path g = graph(f,xmin,xmax);
draw(g,FCNPEN+highlightcolor);

//label("\makebox[0em][l]{$\scriptstyle (\arctan(x)+(\pi/2))/\pi$}", (2.15,0.8), S);
label("$\scriptstyle (\arctan(x)+(\pi/2))/\pi$", (xmax,0.8), S);

// from http://tex.stackexchange.com/a/299327/339
void centerAtOrigin()
{
    pair origMinPoint = min(currentpicture)/72*2.54;
    pair origMaxPoint = max(currentpicture)/72*2.54;
    pair origSize = size(currentpicture)/72*2.54;
    real xmin = origMinPoint.x;
    real xmax = origMaxPoint.x;
    real ymin = origMinPoint.y;
    if (xmax > fabs(xmin)) { xmin = -xmax; }
    if (fabs(xmin) > xmax) { xmax = -xmin; }
    fill(shift(xmin,ymin)*scale(xmax-xmin,origSize.y)*
    	 unitsquare, opacity(0)+red);
    // draw(shift(xmin,ymin)*scale(xmax-xmin,origSize.y)*
    // 	 unitsquare,red);
}

centerAtOrigin();
