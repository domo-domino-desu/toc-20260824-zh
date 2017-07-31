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
real f(real x) {return sqrt(x);}
real g(real x) {return 10*log(x)/log(2);}  // they left out log2

// curves
path f=graph(pic,f,xmin,xmax,n=400);
path g=graph(pic,g,xmin,xmax,n=400);
// draw(pic,f,FCNPEN);
// draw(pic,g,FCNPEN);

// axes
xaxis(pic,YZero,
      xmin-50, xmax+50,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=500, step=500,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
yequals(pic, 0,   
	xmin=0, xmax=xmax+80,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
yaxis(pic,XZero,
      ymin-5, ymax+5,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=50, step=50,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=0, ymax=ymax+10,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
for (int i=ceil(xmin);i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
  dot(pic, Scale(pic,(i,g(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
}
// label the curves
label(pic,"$\sqrt{n}$",Scale(pic,(900,f(900))),1.5S,TICLABELPEN);
label(pic,"$10\lg(n)$",Scale(pic,(800,g(800))),2S,TICLABELPEN);

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
real f(real x) {return sqrt(x);}
real g(real x) {return 10*log(x)/log(2);}  // they left out log2

// curves
path f=graph(pic,f,xmin,xmax,n=400);
path g=graph(pic,g,xmin,xmax,n=400);
draw(pic,f,FCNPEN_SOLID+linewidth(2.5pt));
draw(pic,g,FCNPEN_SOLID+linewidth(2.5pt));

// axes
xaxis(pic,YZero,
      xmin-50000, xmax+75000,
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

// draw the curves
// dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
// for (int i=ceil(xmin);i<=floor(xmax); ++i) {
//   dot(pic, Scale(pic,(i,f(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
//   dot(pic, Scale(pic,(i,g(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
// }
// label the curves
// Use n because 1 000 000 was too many dots for Asymptote
label(pic,"$\sqrt{n}$",Scale(pic,(700000,f(700000))),2N,TICLABELPEN);
label(pic,"$10\lg(n)$",Scale(pic,(700000,g(700000))),2N,TICLABELPEN);

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
real scaled_lg(real x) {return lg(x);}
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

pen second_pen=FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
dot(pic, Scale(pic,(0,scalefactor*1)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
for (int i=1;i<=xmax; ++i) {
  dot(pic, Scale(pic,G(i)), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
  dot(pic, Scale(pic,F(i)), second_pen, Fill(second_pen));
  // dot(pic, G(i), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
}
// impose on it the lg fcn
//draw(pic, graph(lg,1,xmax,operator ..),FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal") );  // lg(0)=-infty so start at x=1

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
  dot(pic, Scale(pic,G(i)), FCNPEN_SOLID, Fill(FCNPEN_SOLID)); 
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
// Hack: get the y=1 tick
yaxis(pic, XZero,
      ymin=0.5, ymax=1.5,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=1, step=1, 
		beginlabel=true, endlabel=true,
		Size=0.5*axis_tick_size,
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
  dot(pic, Scale(pic,(i,f(i))),FCNPEN_SOLID,Fill(white));
  dot(pic, Scale(pic,(i,g(i))),FCNPEN_SOLID,Fill(white));
}
label(pic,"$g$",Scale(pic,(90,1900000)), 0.8W);
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
label(pic,"$g/f$",Scale(pic,(90,180)), 3S);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







// ============== 2n^2+3n+4 vs n^2+5n+6 ======
picture pic;
int picnum = 8;

size(pic,4.5cm,IgnoreAspect);

real f(real x) {
  return 2x**2+3*x+4;
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
real ymax=20000;

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
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=5000, step=1000, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+1500,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(maxnum(xmin,1)); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i))),FCNPEN_SOLID,Fill(white));
  dot(pic, Scale(pic,(i,g(i))),FCNPEN_SOLID,Fill(white));
}
label(pic,"$f$",Scale(pic,(90,19000)), 0.8W);
label(pic,"$g$",Scale(pic,(90,8000)), 2S);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== (2n^2+3n+4)/(n^2+5n+6) ======
picture pic;
int picnum = 9;

size(pic,4.5cm);

real f(real x) {
  return 2x**2+3*x+4;
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
real ymax=6;

// scale
real scalefactor = 20/ymax;
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
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
// Hack: get the y=2 tick
yaxis(pic, XZero,
      ymin=1.5, ymax=2.5,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=1, 
		beginlabel=true, endlabel=true,Size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+1.5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));
dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
for (int i=ceil(maxnum(xmin,1)); i<=floor(xmax); ++i) {
  dot(pic, Scale(pic,(i,f(i)/g(i))), FCNPEN_SOLID, Fill(white));
}
label(pic,"$f/g$",Scale(pic,(90,2)), 2N);
// asymptote
yequals(pic, 2,   
	xmin=0.4, xmax=xmax,
        p=AXISPEN+linetype(new real[] {6,6}),
	ticks=NoTicks,
        arrow=None);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Illustrate f=O(g) ======
picture pic;
int picnum=10;

size(pic,4cm,IgnoreAspect);

// limits
real xmin=0; 
real xmax=100;
real ymin=0;
real ymax=100;


// scale
real scalefactor=1;
scale(pic,Linear,Linear(scalefactor));

path g=Scale(pic,(0,0))
  ..Scale(pic,(10,5))
  ..Scale(pic,(20,15))
  ..Scale(pic,(30,20))
  ..Scale(pic,(40,45))
  ..Scale(pic,(60,60))
  ..Scale(pic,(80,70))
  ..Scale(pic,(100,100));
path f=Scale(pic,(0,2))
  ..Scale(pic,(10,5))
  ..Scale(pic,(20,10))
  ..Scale(pic,(30,30))
  ..Scale(pic,(40,40))
  ..Scale(pic,(60,53))
  ..Scale(pic,(80,60))
  ..Scale(pic,(100,63));
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
draw(pic, f, FCNPEN_SOLID);
draw(pic, g, second_pen);


// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("%",TICLABELPEN), Step=10, step=5,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xaxis(pic,YZero,
      xmin=35, xmax=45,
      RightTicks(Label("$N$",TICLABELPEN), Step=10, step=10,
		 beginlabel=true, endlabel=true,
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
      LeftTicks(Label("%",TICLABELPEN), Step=10, step=5, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

// dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
// pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
label(pic,"$g$",Scale(pic,(90,90)), 0.25W);
label(pic,"$f$",Scale(pic,(80,60)), 2SE);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Illustrate f=O(g) ======
picture pic;
int picnum=11;

size(pic,4cm,IgnoreAspect);

// limits
real xmin=0; 
real xmax=100;
real ymin=0;
real ymax=100;


// scale
real scalefactor=1;
scale(pic,Linear,Linear(scalefactor));

path g=Scale(pic,(0,0))
  ..Scale(pic,(10,5))
  ..Scale(pic,(20,15))
  ..Scale(pic,(30,20))
  ..Scale(pic,(40,45))
  ..Scale(pic,(60,60))
  ..Scale(pic,(80,70))
  ..Scale(pic,(100,100));
path f=Scale(pic,(0,2))
  ..Scale(pic,(10,5))
  ..Scale(pic,(20,10))
  ..Scale(pic,(30,30))
  ..Scale(pic,(40,40))
  ..Scale(pic,(60,62))
  ..Scale(pic,(80,68))
  ..Scale(pic,(100,87));
pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
draw(pic, f, FCNPEN_SOLID);
draw(pic, g, second_pen);


// xaxis  Draw axis without arrow, then draw without ticks and the arrow
//  far enough out to not hit a tick
xaxis(pic,YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(Label("%",TICLABELPEN), Step=10, step=5,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xaxis(pic,YZero,
      xmin=35, xmax=45,
      RightTicks(Label("$N$",TICLABELPEN), Step=10, step=10,
		 beginlabel=true, endlabel=true,
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
      LeftTicks(Label("%",TICLABELPEN), Step=10, step=5, 
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      arrow=None);
xequals(pic, 0,   
	ymin=ymin, ymax=ymax+5,
        p=AXISPEN,
	ticks=NoTicks,
        arrow=Arrow(TeXHead,axis_arrow_size));

// dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
// pen second_pen = FCNPEN_NOCOLOR+highlightcolor+opacity(.5,"Normal");
label(pic,"$g$",Scale(pic,(90,90)), 0.25W);
label(pic,"$f$",Scale(pic,(80,70)), 4E);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





path ellipse(pair c, real a, real b)
{
  return shift(c)*scale(a,b)*unitcircle;
}


// ============== Illustrate f=Theta(g) ======
picture pic;
int picnum=12;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

real a=0.15, b=0.1;
real WEDGE_TOP = 0.45*SET_TOP;
pair w=(0.5*SET_RT+0.5*a,WEDGE_TOP);
path wedgecap = ellipse(w, a, b);

// make two lines tangent to wedgecap, one on left and one on right
real wc_t_l=2.0, wc_t_r=0.17;  // cubic spline parameter on wedgecap
pair d_l=dir(wedgecap,wc_t_l); // dir of tangent
path wedge_left=point(wedgecap,wc_t_l)--(point(wedgecap,wc_t_l)+5*d_l);
pair d_r=dir(wedgecap,wc_t_r);  // dir_of_tangent
path wedge_right=point(wedgecap,wc_t_r)--(point(wedgecap,wc_t_r)-5*d_r);

// intersect those lines with the set boundary
real[] left_intersection=intersect(wedge_left,set_bound);
real[] right_intersection=intersect(wedge_right,set_bound);
path wedge=(subpath(wedgecap,wc_t_r,wc_t_l)
	    &subpath(wedge_left,0,left_intersection[0])
	    &subpath(set_bound,left_intersection[1],right_intersection[1]))
          --cycle;
path wedge_edge=subpath(wedge_left,left_intersection[0],0)
		 &subpath(wedgecap,wc_t_l,wc_t_r)
		 &subpath(wedge_right,0,right_intersection[0]);

// draw it all
filldraw(pic,set_bound, AXISPEN, fillpen=backgroundcolor);
filldraw(pic,wedge,lightcolor,fillpen=white);
filldraw(pic,wedgecap,lightcolor,fillpen=white);
draw(pic,wedge_edge,highlightcolor);
draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Illustrate O(n^3) and O(n^2) ======
picture pic;
int picnum=13;

unitsize(pic,1cm);

// bounds 
// real SET_TOP=1.75;
// real SET_RT=1.4;
// path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

real a=0.15, b=0.1;
// n^3
real WEDGE_TOP0 = 0.55*SET_TOP;
pair w0=(0.5*SET_RT+0.5*a,WEDGE_TOP0);
path wedgecap0 = ellipse(w0, a, b);
// n^2
real WEDGE_TOP1 = 0.25*SET_TOP;
pair w1=(0.5*SET_RT+0.5*a,WEDGE_TOP1);
path wedgecap1 = ellipse(w1, a, b);

// make two lines tangent to wedgecap, one on left and one on right
real wc0_t_l=2.0, wc0_t_r=0.18;  // cubic spline parameter on wedgecap
pair d0_l=dir(wedgecap0,wc0_t_l); // dir of tangent
path wedge0_left=point(wedgecap0,wc0_t_l)--(point(wedgecap0,wc0_t_l)+5*d0_l);
pair d0_r=dir(wedgecap0,wc0_t_r);  // dir_of_tangent
path wedge0_right=point(wedgecap0,wc0_t_r)--(point(wedgecap0,wc0_t_r)-5*d0_r);

real wc1_t_l=2.0, wc1_t_r=0.15;  // cubic spline parameter on wedgecap
pair d1_l=dir(wedgecap1,wc1_t_l); // dir of tangent
path wedge1_left=point(wedgecap1,wc1_t_l)--(point(wedgecap1,wc1_t_l)+5*d1_l);
pair d1_r=dir(wedgecap1,wc1_t_r);  // dir_of_tangent
path wedge1_right=point(wedgecap1,wc1_t_r)--(point(wedgecap1,wc1_t_r)-5*d1_r);

// intersect those lines with the set boundary
real[] left0_intersection=intersect(wedge0_left,set_bound);
real[] right0_intersection=intersect(wedge0_right,set_bound);
path wedge0=(subpath(wedgecap0,wc0_t_r,wc0_t_l)
	    &subpath(wedge0_left,0,left0_intersection[0])
	    &subpath(set_bound,left0_intersection[1],right0_intersection[1]))
          --cycle;
path wedge0_edge=subpath(wedge0_left,left0_intersection[0],0)
		 &subpath(wedgecap0,wc0_t_l,wc0_t_r)
		 &subpath(wedge0_right,0,right0_intersection[0]);
real[] left1_intersection=intersect(wedge1_left,set_bound);
real[] right1_intersection=intersect(wedge1_right,set_bound);
path wedge1=(subpath(wedgecap1,wc1_t_r,wc1_t_l)
	    &subpath(wedge1_left,0,left1_intersection[0])
	    &subpath(set_bound,left1_intersection[1],right1_intersection[1]))
          --cycle;
path wedge1_edge=subpath(wedge1_left,left1_intersection[0],0)
		 &subpath(wedgecap1,wc1_t_l,wc1_t_r)
		 &subpath(wedge1_right,0,right1_intersection[0]);

// draw it all
filldraw(pic,set_bound, AXISPEN, fillpen=backgroundcolor);
filldraw(pic,wedge0,lightcolor,fillpen=white);
filldraw(pic,wedgecap0,lightcolor,fillpen=white);
draw(pic,wedge0_edge,highlightcolor);

filldraw(pic,wedge1,lightcolor,fillpen=white);
filldraw(pic,wedgecap1,lightcolor,fillpen=white);
draw(pic,wedge1_edge,highlightcolor);
draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





