// bigo.asy
//  Graphs and info about big-O

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jh;
cd("");

string OUTPUT_FN = "bigo%02d";

import graph;
real axis_arrow_size = 0.35mm;
real axis_tick_size = 0.5mm;

// ============== compare sqrt(x) and 10*lg(x) on small scale ================
picture pic;
int picnum = 0;
size(pic,4cm);
real scalefactor = 6;
scale(pic,Linear,Linear(scalefactor));

// limits
real xmin=1;  // lg(xmin)=0
real xmax=1000;
real ymin=0.1;
real ymax=100;

// fcns
real f(real x) {return scalefactor*sqrt(x);}
real g(real x) {return scalefactor*10*log(x)/log(2);}  // they left out log2

// curves
path f=graph(f,xmin,xmax,n=400);
path g=graph(g,xmin,xmax,n=400);
draw(pic,f,FCNPEN);
draw(pic,g,FCNPEN);

// axes
xaxis(pic,YZero,
      xmin-50, xmax+50,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=500, step=500,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));
yaxis(pic,XZero,
      ymin-5, ymax+5,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=50, step=50,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));

// label the curves
label(pic,"$\sqrt{x}$",(500,f(500)),2N,TICLABELPEN);
label(pic,"$10\lg(x)$",(500,g(500)),2N,TICLABELPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== compare sqrt(x) and 10*lg(x) on larger scale ================
picture pic;
int picnum = 1;
size(pic,4cm);
real scalefactor = 750;
scale(pic,Linear,Linear(scalefactor));

// limits
real xmin=1;  // lg(xmin)=0
real xmax=1000000;
real ymin=0.1;
real ymax=1000;

// fcns
real f(real x) {return scalefactor*sqrt(x);}
real g(real x) {return scalefactor*10*log(x)/log(2);}  // they left out log2

// curves
path f=graph(f,xmin,xmax,n=400);
path g=graph(g,xmin,xmax,n=400);
draw(pic,f,FCNPEN);
draw(pic,g,FCNPEN);

// axes
xaxis(pic,YZero,
      xmin-75000, xmax+75000,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=500000, step=100000,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));
yaxis(pic,XZero,
      ymin-75, ymax+75,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=500, step=100,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));

// label the curves
label(pic,"$\sqrt{x}$",(500000,f(500000)),2N,TICLABELPEN);
label(pic,"$10\lg(x)$",(500000,g(500000)),2N,TICLABELPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




