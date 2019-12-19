// correspondences.asy
//  Animate correspondences between countable sets 

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../asy/");
import jh;
cd("");
// import node;

import graph;


// ========= Exercises =================================
string OUTPUT_FN = "functions%03d";


// ==========================================
// xy graph of y=x^3
int picnum = 0;
picture pic;
unitsize(pic,0.35cm);
real u=1;
real v=u;

scale(pic,Linear(5),Linear);  // make the y-axis 1/3 as tall

real f(real x) {
  return x^3;
}

real xmin = -3.0;
real xmax = 3.0;
real ymin = f(xmin);
real ymax = f(xmax);

real[] xMajorTicks={-3,-2,-1,0,1,2,3};
real[] xMinorTicks={};
real[] yMajorTicks={-25,-20,-15,-10,-5,0,5,10,15,20,25}; 
real[] yMinorTicks={}; 

arrowbar axisarrow = Arrows(TeXHead);

path f_graph = graph(pic, f, xmin, xmax);
draw(pic, f_graph, FCNPEN+highlightcolor);
xaxis(pic, "$x$",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(xMajorTicks,xMinorTicks),
      EndArrow(TeXHead));           // arrow on rhs only
yaxis(pic, "$y$",XZero(),
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f(x)=x^3$}", Scale(pic,(1.5,25)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
