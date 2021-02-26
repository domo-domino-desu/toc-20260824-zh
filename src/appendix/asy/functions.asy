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

import fontsize;  // allow nonstandard font sizes
import graph;


// ========= Exercises =================================
string OUTPUT_FN = "functions%03d";


// ==========================================
// xy graph of y=x^3
int picnum = 0;
picture pic;
unitsize(pic,0.07cm);
real u=1;
real v=u;

scale(pic,Linear(5),Linear);  // make the y-axis 1/5 as tall

real f(real x) {
  return x^3;
}

real xmin = -3.0;
real xmax = 3.0;
real ymin = f(xmin);
real ymax = f(xmax);

real[] xMajorTicks={2};
real[] xMinorTicks={-3,-1,1,3};
real[] yMajorTicks={-20,-10,10,20}; 
real[] yMinorTicks={-25,-15,-5,5,15,25}; 

arrowbar axisarrow = Arrows(TeXHead);

path f_graph = graph(pic, f, xmin, xmax);
draw(pic, f_graph, MAINPEN+linewidth(0.6pt)+highlightcolor);
xaxis(pic, "",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(format="\scriptsize $%.4g$",xMajorTicks,xMinorTicks),
      axisarrow);
yaxis(pic, "",XZero(),
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(format="\scriptsize $%.4g$",yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "$\scriptsize f(x)=x^3$", Scale(pic,(1,-20)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ................................................
// xy graph of y=floor(x)
int picnum = 1;
picture pic;
unitsize(pic,0.5cm);
real u=1;
real v=u;

scale(pic,Linear,Linear);  // make the y-axis 1/5 as tall

real f(real x) {
  return floor(x);
}

real xmin = -3.0;
real xmax = 3.0;
real ymin = f(xmin);
real ymax = f(xmax);

real[] xMajorTicks={-2,2};
real[] xMinorTicks={-3,-1,1,3};
real[] yMajorTicks={-4,2}; 
real[] yMinorTicks={-3,-1,1,3}; 

arrowbar axisarrow = Arrows(TeXHead);

// draw graph as a sequence of line segments because Asy draws stairstep
path f_graph = graph(pic, f, ceil(xmin)-0.5, ceil(xmin)-0.01);
draw(pic, f_graph, MAINPEN+highlightcolor);
for(int i=ceil(xmin); i < floor(xmax); ++i) {
  path f_graph = graph(pic, f, i, i+0.99);
  draw(pic, f_graph, MAINPEN+highlightcolor);
}
path f_graph = graph(pic, f, floor(xmax), floor(xmax)+0.5);
draw(pic, f_graph, MAINPEN+highlightcolor);
// put in open and closed dots
dotfactor=7;
for(int i=ceil(xmin); i < floor(xmax)+1; ++i) {
  dot(pic, Scale(pic,(i,f(i)-1)), MAINPEN+highlightcolor+linewidth(0.6pt), FillDraw(drawpen=MAINPEN+highlightcolor+linewidth(0.6pt),fillpen=white));
  dot(pic, Scale(pic,(i,f(i))), MAINPEN+highlightcolor+linewidth(0.6pt), FillDraw(drawpen=FCNPEN+highlightcolor+linewidth(0.6pt),fillpen=MAINPEN+highlightcolor));
}

xaxis(pic, "",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(format="\scriptsize $%.4g$",xMajorTicks,xMinorTicks),
      axisarrow);
yaxis(pic, "",XZero(),
      ymin=ymin-1.5, ymax=ymax+0.5,
      LeftTicks(format="\scriptsize $%.4g$",yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "$\scriptsize f(x)=\floor{x}$", Scale(pic,(1,-3)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// =================================================
// bean graph
real h, v;  // horizontal and vertical units for beans
h = 0.70; v = h; 
real DOMAINTOCODOMAIN = 3*h;

// ..............................................
// generic map
int picnum = 2;
picture pic;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.75*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle F,F}$", domainpoint[3], W);
label(pic, "${\scriptscriptstyle F,T}$", domainpoint[2], W);
label(pic, "${\scriptscriptstyle T,F}$", domainpoint[1], W);
label(pic, "${\scriptscriptstyle T,T}$", domainpoint[0], W);
for (int i; i<2; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.2)*v+(i/2)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle F}$", codomainpoint[1], E);
label(pic, "${\scriptscriptstyle T}$", codomainpoint[0], E);
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[1];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[0];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[0];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[1];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// now the arrows, wider and in white first
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<4; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<2; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
// now arrows narrower
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............................................
// onto map
int picnum = 3;
picture pic;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[2];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[1];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// now the arrows, wider and in white first
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<4; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
// now arrows narrower
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ......................................
// One to one map
picture pic;
int picnum = 4;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
for (int i; i<3; ++i) {
  domainpoint[i] = (0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[3];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[2];
maparrow[0] = domainpoint[0]{dir(15)}..codomainpoint[1];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<3; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ..............................................
// parallel lines map
int picnum = 5;
picture pic;
unitsize(pic,0.75cm);
// Establish the stuff to draw
real SEPARATION = -1.5;
real xmin = -3;
real xmax = 3;
path domain, codomain;
domain = (xmin-0.5,0)--(xmax+0.5,0);
codomain = (xmin-0.5,SEPARATION)--(xmax+0.5,SEPARATION);
// ticks ..
real TICLENGTH = 0.2;
for (int i=-3; i<4; ++i) {
  draw(pic,(i,0)--(i,TICLENGTH), DARKPEN);
  label(pic,format("\scriptsize $%d$",i),(i,0+TICLENGTH), N);
  draw(pic,(i,SEPARATION)--(i,SEPARATION-TICLENGTH), DARKPEN);
  label(pic,format("\scriptsize $%d$",i),(i,SEPARATION-TICLENGTH), S);
}
// draw the domain and codomain
draw(pic,domain,Arrows(TeXHead));
draw(pic,codomain,Arrows(TeXHead));

for (int i=-3; i<0; ++i) {
  path a = (i,0){(1,i)}.. tension 1.25 and 1.1 .. {(1,i)}(abs(i),SEPARATION);
  draw(pic,subpath(a,0.04,0.96),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
for (int i=0; i<4; ++i) {
  path a = (i,0)--(abs(i),SEPARATION);
  draw(pic,subpath(a,0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===================================
// Correspondence
picture pic;
int picnum = 6;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(0)}..codomainpoint[0];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[3];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[2];
maparrow[0] = domainpoint[0]{dir(15)}..codomainpoint[1];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<4; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ..............................................
// parallel lines map  N <--> primes
int picnum = 7;
picture pic;
unitsize(pic,0.65cm);
// Establish the stuff to draw
real SEPARATION = -1.25;
real xmin = 0;
real xmax = 7;
int[] primes = {2,3,5,7,11,13,17,19};
pair[] domain;
pair[] codomain;
// draw the natural numbers as dots
for (int i=0; i<8; ++i) {
  domain[i] = (i,0);
  dot(pic, domain[i], DARKPEN);
  label(pic,format("\scriptsize $%d$",i), domain[i], N);
  codomain[i] = (i,SEPARATION);
  dot(pic, codomain[i], DARKPEN);
  label(pic,format("\scriptsize $%d$",primes[i]), codomain[i], S);
  path c = domain[i] -- codomain[i];
  draw(pic, subpath(c,0.10,0.90),LIGHTPEN+ARROWCOLOR,bar=BeginBar(2),EndArrow(TeXHead));
}
// draw ldots
domain[8] = (8,0);
codomain[8] = (8,SEPARATION);
label(pic, "\ldots", domain[8]);
label(pic, "\ldots", codomain[8]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===================================
// Exercise: two fcns, one with an inverse and one without 

// .......... function f ...................
picture pic;
int picnum = 8;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
for (int i; i<3; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i/2)*(4/3)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 0}$", domainpoint[0], W);
label(pic, "${\scriptscriptstyle 1}$", domainpoint[1], W);
label(pic, "${\scriptscriptstyle 2}$", domainpoint[2], W);
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/2)*(4/3)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 10}$", codomainpoint[0], E);
label(pic, "${\scriptscriptstyle 11}$", codomainpoint[1], E);
label(pic, "${\scriptscriptstyle 12}$", codomainpoint[2], E);

path[] maparrow;
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[1];
maparrow[0] = domainpoint[0]{dir(15)}..codomainpoint[0];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<3; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ................ function g ....................
picture pic;
int picnum = 9;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
for (int i; i<3; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i/2)*(4/3)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 0}$", domainpoint[0], W);
label(pic, "${\scriptscriptstyle 1}$", domainpoint[1], W);
label(pic, "${\scriptscriptstyle 2}$", domainpoint[2], W);
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/2)*(4/3)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 10}$", codomainpoint[0], E);
label(pic, "${\scriptscriptstyle 11}$", codomainpoint[1], E);
label(pic, "${\scriptscriptstyle 12}$", codomainpoint[2], E);

path[] maparrow;
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[0];
maparrow[0] = domainpoint[0]{dir(15)}..codomainpoint[0];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<3; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ==========================================
// Exercise: If $\composed{g}{f}$ is onto, is $f$ onto?
//  If it is one-to-one, is $g$ one-to-one?
picture pic;
int picnum = 10;
unitsize(pic,1cm);

// Establish all the stuff to draw
path D, C, B;
D = setbean(h,v);
C = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
B = shift(2*DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] Dpoint, Cpoint, Bpoint;
for (int i; i<2; ++i) {
  Dpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i)*(3/3)*v);
  dot(pic,Dpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 0}$", Dpoint[0], W);
label(pic, "${\scriptscriptstyle 1}$", Dpoint[1], W);
for (int i; i<3; ++i) {
  Cpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/2)*(4/3)*v);
  dot(pic,Cpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 10}$", Cpoint[0], N);
label(pic, "${\scriptscriptstyle 11}$", Cpoint[1], N);
label(pic, "${\scriptscriptstyle 12}$", Cpoint[2], N);
for (int i; i<2; ++i) {
  Bpoint[i] = shift(2*DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i)*(3/3)*v);
  dot(pic,Bpoint[i],DARKPEN+black);
}
label(pic, "${\scriptscriptstyle 20}$", Bpoint[0], E);
label(pic, "${\scriptscriptstyle 21}$", Bpoint[1], E);

path[] DCmaparrow;
DCmaparrow[1] = Dpoint[1]{dir(15)}..Cpoint[2];
DCmaparrow[0] = Dpoint[0]{dir(15)}..Cpoint[1];
path[] CBmaparrow;
CBmaparrow[2] = Cpoint[2]{dir(15)}..Bpoint[1];
CBmaparrow[1] = Cpoint[1]{dir(15)}..Bpoint[0];
CBmaparrow[0] = Cpoint[0]{dir(15)}..Bpoint[0];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,D,LIGHTPEN);
draw(pic,C,LIGHTPEN);
draw(pic,B,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<2; ++i) {
  draw(pic,subpath(DCmaparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(CBmaparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,D,BEANCOLOR);
fill(pic,C,BEANCOLOR);
fill(pic,B,BEANCOLOR);
for (int i; i<2; ++i) {
  dot(pic,Dpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  dot(pic,Cpoint[i],DARKPEN+black);
}
for (int i; i<2; ++i) {
  dot(pic,Bpoint[i],DARKPEN+black);
}
for (int i; i<2; ++i) {
  draw(pic,subpath(DCmaparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(CBmaparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

