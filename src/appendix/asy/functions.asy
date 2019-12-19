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

real[] xMajorTicks={-2,2};
real[] xMinorTicks={-3,-1,1,3};
real[] yMajorTicks={-20,-10,10,20}; 
real[] yMinorTicks={-25,-15,-5,5,15,25}; 

arrowbar axisarrow = Arrows(TeXHead);

path f_graph = graph(pic, f, xmin, xmax);
draw(pic, f_graph, FCNPEN+highlightcolor);
xaxis(pic, "",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(format="\scriptsize $%.4g$",xMajorTicks,xMinorTicks),
      axisarrow);
yaxis(pic, "",XZero(),
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(format="\scriptsize $%.4g$",yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f(x)=x^3$}", Scale(pic,(1,-20)), E);
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

real[] xMajorTicks={-3,-2,-1,1,2,3};
real[] xMinorTicks={};
real[] yMajorTicks={-4,-2,2}; 
real[] yMinorTicks={-3,-1,1,3}; 

arrowbar axisarrow = Arrows(TeXHead);

// draw graph as a sequence of line segments because Asy draws stairstep
path f_graph = graph(pic, f, ceil(xmin)-0.5, ceil(xmin)-0.01);
draw(pic, f_graph, FCNPEN+highlightcolor);
for(int i=ceil(xmin); i < floor(xmax); ++i) {
  path f_graph = graph(pic, f, i, i+0.99);
  draw(pic, f_graph, FCNPEN+highlightcolor);
}
path f_graph = graph(pic, f, floor(xmax), floor(xmax)+0.5);
draw(pic, f_graph, FCNPEN+highlightcolor);
// put in open and closed dots
dotfactor=7;
for(int i=ceil(xmin); i < floor(xmax)+1; ++i) {
  dot(pic, Scale(pic,(i,f(i)-1)), FCNPEN+highlightcolor+linewidth(0.6pt), FillDraw(drawpen=FCNPEN+highlightcolor+linewidth(0.6pt),fillpen=white+opacity(0.5)));
  dot(pic, Scale(pic,(i,f(i))), FCNPEN+highlightcolor+linewidth(0.6pt), FillDraw(drawpen=FCNPEN+highlightcolor+linewidth(0.6pt),fillpen=FCNPEN+highlightcolor+opacity(0.99)));
}

xaxis(pic, "",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(format="\scriptsize $%.4g$",xMajorTicks,xMinorTicks),
      axisarrow);
yaxis(pic, "",XZero(),
      ymin=ymin-1.5, ymax=ymax+0.5,
      LeftTicks(format="\scriptsize $%.4g$",yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f(x)=\floor{x}$}", Scale(pic,(1,-3)), E);
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
