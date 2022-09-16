// 3d.asy
// Graphics for Theory of Computing Jim Hefferon, Chapter 2
//   GPL 3
// 2020-Jan-31  JH  node.asy and graph3.asy not compatible, so break this
//   out.


// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

import settings;
settings.outformat="pdf";
settings.render=0;   // Not PDF PRC just a pdf file
import graph3;

// ========= Prefix of output file names =================================
string OUTPUT_FN = "3d%03d";


// ============Cantor R^2 -> R ==========================
// Graph of cantor(x,y), showing solution for x=1
int picnum = 0;

picture pic;
size3(pic, 2.0cm,0);


real cantor(pair z) {
  return z.x + (z.x+z.y)*(z.x+z.y+1)/2;
}

real xmin = 0;
real xmax = 2;
real ymin = -6;
real ymax = 3;

currentprojection=orthographic(5,-5,15);
currentlight=(0,0,10);

// rectangle in xy plane over which surface is drawn
draw(pic, (xmin,ymin,0)--(xmin,ymax,0)--(xmax,ymax,0)--(xmax,ymin,0)--cycle, DASHPEN);

// For the horizontal line where we find the y values
triple neg_intersection = (1,-5.27491721763537,8);
triple pos_intersection = (1,2.27491721763537,8);
triple horizline_posend = (1,4,8);
triple horizline_negend = (1,-6,8);
path3 horizline = horizline_negend--horizline_posend; 
// Draw line ends that are partly obscured by the surface
draw(pic,horizline_negend--neg_intersection, DARKPEN+highlightcolor);
draw(pic,pos_intersection--horizline_posend, DARKPEN+highlightcolor);

// Draw the surface add the axes
draw(pic, surface(cantor,(xmin-0.5,ymin-0.5),(xmax+0.5,ymax+0.5),nx=9,Spline),
     lightcolor+opacity(0.4),lightcolor, nolight);
xaxis3(pic, Label("$x$"), xmin-0.5,xmax+0.5, OutTicks);
yaxis3(pic, Label("$y$",S), ymin-0.5,ymax+0.5, OutTicks);
zaxis3(pic, Label("$z$"), XYZero(extend=true),0-0.5, cantor((xmax,ymax))+0.5, OutTicks);

// Draw rest of line
draw(pic,neg_intersection--pos_intersection, linewidth(2.0pt)+white);
draw(pic,neg_intersection--pos_intersection, DARKPEN+highlightcolor);
real save_dotfactor=dotfactor;
dotfactor=12;
dot(pic,(1,2.27,8),black);
dot(pic,(1,-5.27,8),black);
dotfactor=save_dotfactor;

shipout(format(OUTPUT_FN,picnum), pic, format="pdf");
// sage: n((-3-sqrt(57))/2)
// -5.27491721763537
// sage: n((-3+sqrt(57))/2)
// 2.27491721763537
