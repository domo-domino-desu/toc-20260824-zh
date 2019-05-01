// maps.asy
//  Illustrate functions

import settings;
settings.outformat="pdf";
settings.render=0;

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");
import jh;
cd("");

// Draw a set bean
path setbean(real h=1, real v=1) {
  path p;
  p = (0,0)..(0,v)..(h,v)..tension(1.2)..(h,-v)..(0,-v)..cycle;
  return p;
}
pen BEANCOLOR = backgroundcolor;
pen ARROWCOLOR = highlightcolor;

real h, v;  // horizontal and vertical units for beans
h = 0.70; v = h; 
real DOMAINTOCODOMAIN = 3*h;

// Onto map
picture pic;
int picnum = 0;
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
shipout(format("maps%02d",picnum),pic,format="pdf");




// ......................................
// One to one map
picture pic;
int picnum = 1;
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
shipout(format("maps%02d",picnum),pic,format="pdf");





// ......................................
// One to one map, with named elements
picture pic;
int picnum = 2;
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
  label(pic,format("\tiny $%d$",i),domainpoint[i],W);
}
for (int i; i<4; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
  label(pic,format("\tiny $%d$",i),codomainpoint[i],E);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("maps%02d",picnum),pic,format="pdf");



// ......................................
// One to one maps for Schroder-Bernstein
picture pic;
int picnum = 3;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
for (int i; i<3; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(2i/3)*(1)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*domainpoint[i];
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] farrow, garrow;
farrow[2] = domainpoint[2]{dir(10)}..{dir(-30)}codomainpoint[0];
farrow[1] = domainpoint[1]{dir(25)}..{dir(-10)}codomainpoint[2];
farrow[0] = domainpoint[0]{dir(25)}..{dir(-10)}codomainpoint[1];
garrow[2] = codomainpoint[2]{dir(180+20)}..domainpoint[2];
garrow[1] = codomainpoint[1]{dir(180+20)}..domainpoint[1];
garrow[0] = codomainpoint[0]{dir(180+20)}..domainpoint[0];
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<3; ++i) {  // garrows in white
  draw(pic,subpath(garrow[i],0.04,0.96),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
for (int i; i<3; ++i) {  // farrows in white
  draw(pic,subpath(farrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<3; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
  label(pic,format("\tiny $%d$",i),domainpoint[i],W);
}
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
  // label(pic,format("\tiny \str{%s}",i+97),codomainpoint[i],E);
}
// don't know how to get ASCII
label(pic,"\tiny \str{c}",codomainpoint[2],E);
label(pic,"\tiny \str{b}",codomainpoint[1],E);
label(pic,"\tiny \str{a}",codomainpoint[0],E);
for (int i; i<3; ++i) {  // garrows
  draw(pic,subpath(garrow[i],0.04,0.96),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+boldcolor);
}
for (int i; i<3; ++i) { // farrows
  draw(pic,subpath(farrow[i],0.08,0.94),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("maps%02d",picnum),pic,format="pdf");



import graph;

// ......................................
// Correspondences from (0,1) to (0,2)
// Note because of bug you need to run "asy -nosafe fn"
//   https://sourceforge.net/p/asymptote/discussion/409349/thread/f2ecb64b19/
picture pic;
int picnum = 4;
unitsize(pic,1cm);

real f0(real x) {
  return 2*x;
}

// Establish all the stuff to draw
real xmin = -0.25;
real xmax = 1.5;
real ymin = -0.25;
real ymax = 2.5;

arrowbar axisarrow = Arrows(TeXHead);
path horiz_tic = (-0.05,0)--(0,0);
path vert_tic = (0,-0.05)--(0,0);

draw(pic,(xmin,0) -- (xmax,0), boldcolor, arrow=axisarrow);
draw(pic,(0,ymin) -- (0,ymax), boldcolor, arrow = axisarrow);
draw(pic,shift(1,0)*vert_tic);
label(pic,"$\scriptstyle 1$", (1,0), S, boldcolor);
draw(pic,shift(0,2)*horiz_tic);
label(pic,"$\scriptstyle 2$", (0,2), W, boldcolor);

path g0 = graph(f0,0,1);
draw(pic,g0,FCNPEN+highlightcolor+roundcap);

shipout(format("maps%02d",picnum),pic,format="pdf");


// f1
picture pic;
int picnum = 5;
unitsize(pic,1cm);

real f1(real x) {
  return 2-2*x;
}

draw(pic,(xmin,0) -- (xmax,0), boldcolor, arrow=axisarrow);
draw(pic,(0,ymin) -- (0,ymax), boldcolor, arrow = axisarrow);
draw(pic,shift(1,0)*vert_tic);
label(pic,"$\scriptstyle 1$", (1,0), S, boldcolor);
draw(pic,shift(0,2)*horiz_tic);
label(pic,"$\scriptstyle 2$", (0,2), W, boldcolor);

path g1 = graph(f1,0,1);
draw(pic,g1,FCNPEN+highlightcolor+roundcap);

shipout(format("maps%02d",picnum),pic,format="pdf");


// f2
picture pic;
int picnum = 6;
unitsize(pic,1cm);

real f2(real x) {
  return 2*(x**2);
}

draw(pic,(xmin,0) -- (xmax,0), boldcolor, arrow=axisarrow);
draw(pic,(0,ymin) -- (0,ymax), boldcolor, arrow = axisarrow);
draw(pic,shift(1,0)*vert_tic);
label(pic,"$\scriptstyle 1$", (1,0), S, boldcolor);
draw(pic,shift(0,2)*horiz_tic);
label(pic,"$\scriptstyle 2$", (0,2), W, boldcolor);

path g2 = graph(f2,0,1);
draw(pic,g2,FCNPEN+highlightcolor+roundcap);

shipout(format("maps%02d",picnum),pic,format="pdf");




// ======================= exercise: onto map codomain is smaller =
// Onto map
picture pic;
int picnum = 7;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.6*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[2];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[1];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[0];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
label(pic,"$D$",(0,v),NW);
draw(pic,codomain,LIGHTPEN);
label(pic,"$C$",shift(DOMAINTOCODOMAIN,0)*(h,v),NE);
// Label the points
label(pic,"\tiny $d_0$",domainpoint[3],W);
label(pic,"\tiny $d_1$",domainpoint[2],W);
label(pic,"\tiny $d_2$",domainpoint[1],W);
label(pic,"\tiny $d_3$",domainpoint[0],W);
label(pic,"\tiny $c_0$",codomainpoint[2],E);
label(pic,"\tiny $c_1$",codomainpoint[1],E);
label(pic,"\tiny $c_2$",codomainpoint[0],E);
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
shipout(format("maps%02d",picnum),pic,format="pdf");


// .............. Onto map without f^{-1} (c)
picture pic;
int picnum = 8;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.6*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[2];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[1];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[0];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
label(pic,"$\hat{D}$",(0,v),NW);
draw(pic,codomain,LIGHTPEN);
label(pic,"$\hat{C}$",shift(DOMAINTOCODOMAIN,0)*(h,v),NE);
// Label the points
label(pic,"\tiny $d_0$",domainpoint[3],W);
label(pic,"\tiny $d_1$",domainpoint[2],W);
// label(pic,"\tiny $d_2$",domainpoint[1],W);
// label(pic,"\tiny $d_3$",domainpoint[0],W);
label(pic,"\tiny $c_0$",codomainpoint[2],E);
label(pic,"\tiny $c_1$",codomainpoint[1],E);
// label(pic,"\tiny $c_2$",codomainpoint[0],E);
// now the arrows, wider and in white first
for (int i=2; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i=2; i<4; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i=1; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
// now arrows narrower
for (int i=2; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("maps%02d",picnum),pic,format="pdf");



// ======================= exercise: onto map codomain is smaller, alternate ===
// Onto map
picture pic;
int picnum = 9;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.6*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[2];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[1];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[0];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
label(pic,"$D$",(0,v),NW);
draw(pic,codomain,LIGHTPEN);
label(pic,"$C$",shift(DOMAINTOCODOMAIN,0)*(h,v),NE);
// Label the points
label(pic,"\tiny $d_0$",domainpoint[3],W);
label(pic,"\tiny $d_1$",domainpoint[2],W);
label(pic,"\tiny $d_2$",domainpoint[1],W);
label(pic,"\tiny $d_3$",domainpoint[0],W);
label(pic,"\tiny $c_0$",codomainpoint[2],E);
label(pic,"\tiny $c_1$",codomainpoint[1],E);
label(pic,"\tiny $c_2$",codomainpoint[0],E);
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
shipout(format("maps%02d",picnum),pic,format="pdf");


// .............. Onto map without f^{-1} (c)
picture pic;
int picnum = 10;
unitsize(pic,1cm);
// Establish the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.6*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
for (int i; i<4; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[3];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[1];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
// Now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
label(pic,"$D$",(0,v),NW);
draw(pic,codomain,LIGHTPEN);
label(pic,"$C$",shift(DOMAINTOCODOMAIN,0)*(h,v),NE);
// Label the points
label(pic,"\tiny $d_0$",domainpoint[3],W);
label(pic,"\tiny $d_1$",domainpoint[2],W);
label(pic,"\tiny $d_2$",domainpoint[1],W);
label(pic,"\tiny $d_3$",domainpoint[0],W);
label(pic,"\tiny $c_0$",codomainpoint[3],E);
label(pic,"\tiny $c_1$",codomainpoint[2],E);
label(pic,"\tiny $c_2$",codomainpoint[1],E);
label(pic,"\tiny $c_3$",codomainpoint[0],E);
// now the arrows, wider and in white first
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),DARKPEN+white);
}
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<4; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
// now arrows narrower
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("maps%02d",picnum),pic,format="pdf");



