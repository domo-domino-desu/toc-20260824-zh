// xygraphs.asy
//  Graphs of fcns

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

string OUTPUT_FN = "xygraphs%02d";

import graph;
// some parameters
real axis_arrow_size = 0.35mm;
real axis_tick_size = 0.75mm;




// ============== compare number primes less than n with lg n ================
picture pic;
int picnum = 0;
size(pic,5cm);
real scalefactor = 1000;
scale(pic,Linear(scalefactor),Linear(5000));

// n, number of primes less than or equal to n 
//   100, 25
//   1000, 168,
// 5000, 669
//   10000, 1229
//   50000, 5133
//   100000, 9592
//   250000, 22044
//   500000, 41538
//   750000, 60238
//   1000000, 78498

// limits
real xmin=1;  // lg(xmin)=0
real xmax=1000000;
real ymin=0;
real ymax=100000;

// fcns
real f(real x) {return x/log(x);}
real g(real x) {return 10*log(x)/log(2);}  // they left out log2

// curves
path f=graph(pic,f,xmin+1,xmax,n=400);
draw(pic,f,MAINPEN+linewidth(0.4pt)+highlightcolor);
label(pic,"$x/\ln(x)$",Scale(pic,(900000,70000)),SE,TICLABELPEN+highlightcolor);

// draw the curves
// dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
// for (int i=ceil(xmin);i<=floor(xmax); ++i) {
//   dot(pic, Scale(pic,(i,f(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
//   dot(pic, Scale(pic,(i,g(i))), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
// }
// label the curves
pair [] pts = {(100,25),
               (1000,168),
               (5000,669),
               (10000,1229),
               (50000,5133),
               (100000,9592),
               (200000,17984),
               (300000,25977),
               (400000,33860),
               // (250000,22044),
               (500000,41538),
               (600000,49098),
               (700000,56543),
               // (750000,60238),
               (800000,63951),
               (900000,71274),
               (1000000,78498)
};

dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
for(pair pt: pts) {
   dot(pic, Scale(pic,pt), FCNPEN_SOLID, Fill(FCNPEN_SOLID));
}
// label(pic,"$(500\,000,41\,538)$",Scale(pic,(500000,41538)),NW,TICLABELPEN);
label(pic,"$(1\,000\,000,78\,498)$",Scale(pic,(1000000,78498)),N,TICLABELPEN);

// axes
xaxis(pic,YZero,
      xmin-1, xmax+75000,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=500000, step=100000,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));
yaxis(pic,XZero,
      ymin, ymax+10000-1,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=50000, step=10000,
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
// label(pic,"$\sqrt{n}$",Scale(pic,(700000,f(700000))),2N,TICLABELPEN);
// label(pic,"$10\lg(n)$",Scale(pic,(700000,g(700000))),2N,TICLABELPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




