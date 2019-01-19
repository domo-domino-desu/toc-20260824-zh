// background.asy
//  Illustrations for slides

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


// =================================================
// Onto, not one-to-one, map
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
shipout(format("background%02d",picnum),pic,format="pdf");




// ......................................
// One to one, not onto, map
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
shipout(format("background%02d",picnum),pic,format="pdf");



// ......................................
// Neithter one to one, nor onto, map
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
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
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
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("background%02d",picnum),pic,format="pdf");




// ......................................
// Both one to one, and onto, map
picture pic;
int picnum = 3;
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
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
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
}
for (int i; i<3; ++i) {
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+ARROWCOLOR);
}
shipout(format("background%02d",picnum),pic,format="pdf");

