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
// some parameters
real axis_arrow_size = 0.35mm;
real axis_tick_size = 0.75mm;


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



// ============== how many bits to represent a natural number? ================
picture pic;
int picnum = 2;

size(pic,5cm);
real scalefactor = 1;
scale(pic,Linear,Linear(scalefactor));

real lg(real x) {return log(x)/log(2);}
real one(real x) {
  return 1;
}
real b(real x) {
  return 1+floor(lg(x));
}
pair F(real x) {
  return (x,lg(x));
}
pair G(real x) {
  return (x,b(x));
}

// limits
real xmin=0;  // lg(xmin)=0
real xmax=30;
real ymin=0;
real ymax=5;

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=0, xmax=xmax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=0, ymax=ymax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=2; // http://asymptote.sourceforge.net/FAQ/section3.html


dot(pic, Scale(pic,(0,scalefactor*1)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
for (int i=1;i<=xmax; ++i) {
  dot(pic, Scale(pic,G(i)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
  // dot(pic, G(i), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
}

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== how many bits to represent a natural number? add lg(x) ======
picture pic;
int picnum = 3;

size(pic,11cm);
real scalefactor = 1;
scale(pic,Linear,Linear(scalefactor));

real lg(real x) {return log(x)/log(2);}
real scaled_lg(real x) {return scalefactor*lg(x);}
real one(real x) {
  return 1;
}
real b(real x) {
  return 1+floor(lg(x));
}
pair F(real x) {
  return (x,lg(x));
}
pair G(real x) {
  return (x,b(x));
}

// limits
real xmin=0;  // lg(xmin)=0
real xmax=100;
real ymin=0;
real ymax=6;

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=10, step=5,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=0, xmax=xmax+2,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=0, ymax=ymax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=2; // http://asymptote.sourceforge.net/FAQ/section3.html

dot(pic, Scale(pic,(0,scalefactor*1)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
for (int i=1;i<=xmax; ++i) {
  dot(pic, Scale(pic,G(i)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
  // dot(pic, G(i), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
}
// impose on it the lg fcn
draw(pic, graph(lg,1,xmax,operator ..),FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal") );  // lg(0)=-infty so start at x=1

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== n^2+5n+6 ======
picture pic;
int picnum = 4;

size(pic,4.5cm);

real f(real x) {
  return x**2+5*x+6;
}
pair F(real x) {
  return (x,f(x));
}
real g(real x) {
  return x**2;
}
pair G(real x) {
  return (x,g(x));
}

real maxnum(real x, real y) {
  if (x>=y) {
    return x;
  }
  return y;
}

// limits
real xmin=0;  // lg(xmin)=0
real xmax=20;
real ymin=0;
real ymax=maxnum(f(xmax),g(xmax));

// scale
real scalefactor = 20/ymax;
scale(pic,Linear,Linear(scalefactor));

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=0, xmax=xmax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=100, step=10,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=0, ymax=ymax+15,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

// dotfactor=2; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(xmin); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,F(i)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
  dot(pic, Scale(pic,G(i)), second_pen, Fill(second_pen)); 
}
label(pic,"$f$",Scale(pic,(20,500)), 3W);
label(pic,"$g$",Scale(pic,(17,300)), 3E);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== f(x)/g(x) ======
picture pic;
int picnum = 5;

size(pic,4.5cm);

// real f(real x) {
//   return x**2+5*x+6;
// }
// pair F(real x) {
//   return (x,f(x));
// }
// real g(real x) {
//   return x**2;
// }
// pair G(real x) {
//   return (x,g(x));
// }

// real maxnum(real x, real y) {
//   if (x>=y) {
//     return x;
//   }
//   return y;
// }

// limits
// real xmin=0;  // lg(xmin)=0
// real xmax=20;
// real ymin=0;
real ymax=12;

// scale
real scalefactor = 20/ymax;
scale(pic,Linear,Linear(scalefactor));

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=xmin, xmax=xmax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+0.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// asymptote
yequals(pic, 1,   
	xmin=0.4, xmax=xmax,
        p=AXISPEN+linetype(new real[] {6,6}),
	ticks=NoTicks,
        arrow=None);
dotfactor=2; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(maxnum(xmin,1)); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i)/g(i))), FCNPEN_SOLID, Fill(white));
}

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== (2n^3+3n+4)/(n^2+5n+6) ======
picture pic;
int picnum = 6;

size(pic,4.5cm,IgnoreAspect);

real f(real x) {
  return 2x**3+3*x+4;
}
pair F(real x) {
  return (x,f(x));
}
real g(real x) {
  return x**2+5*x+6;
}
pair G(real x) {
  return (x,g(x));
}

// real maxnum(real x, real y) {
//   if (x>=y) {
//     return x;
//   }
//   return y;
// }

// limits
real xmin=0; 
real xmax=100;
real ymin=0;
real ymax=2000000;

// scale
real scalefactor = 20/ymax;
scale(pic,Linear,Linear(scalefactor));

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=50, step=10,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=xmin, xmax=xmax+7,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=1000000, step=100000, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+80000,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(maxnum(xmin,1)); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i))),FCNPEN,Fill(white));
  dot(pic, Scale(pic,(i,g(i))),second_pen,Fill(white));
}
label(pic,"$g$",Scale(pic,(90,1900000)), W);
label(pic,"$f$",Scale(pic,(90,0)), 2N);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== (2n^3+3n+4)/(n^2+5n+6) ======
picture pic;
int picnum = 7;

size(pic,4.5cm);

real f(real x) {
  return 2x**3+3*x+4;
}
pair F(real x) {
  return (x,f(x));
}
real g(real x) {
  return x**2+5*x+6;
}
pair G(real x) {
  return (x,g(x));
}

// real maxnum(real x, real y) {
//   if (x>=y) {
//     return x;
//   }
//   return y;
// }

// limits
real xmin=0; 
real xmax=100;
real ymin=0;
real ymax=200;

// scale
real scalefactor = 30/ymax;
scale(pic,Linear,Linear(scalefactor));

// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=50, step=50,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=xmin, xmax=xmax+8,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
// yaxis
yaxis(pic, XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=100, step=50, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+40,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=2; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(maxnum(xmin,1)); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i)/g(i))), FCNPEN_SOLID, Fill(white));
}

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






