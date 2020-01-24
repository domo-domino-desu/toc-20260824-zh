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
import flowchart;  // imports jh
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




// ......................................
// Both one to one, and onto, map
picture pic;
int picnum = 4;
unitsize(pic,1cm);

// Establish all the stuff to draw
path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
pair[] domainpoint, codomainpoint;
int NUMPOINTS = 20;
for (int i; i<NUMPOINTS; ++i) {
  domainpoint[i] = (0.5*h,(1.05)*v-(1/(i+2))*(4)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*domainpoint[i];
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
for (int i; i<NUMPOINTS; ++i) {
  maparrow[i] = domainpoint[i]{dir(15)}..codomainpoint[i];
}
// now draw; want white area around map arrow thru the border
// First the outlines
draw(pic,domain,LIGHTPEN);
draw(pic,codomain,LIGHTPEN);
// Next the arrow, wider, in white
for (int i; i<NUMPOINTS; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),arrow=Arrows(TeXHead),DARKPEN+white);
}
// Now fill, draw dots, and draw arrows narrow
fill(pic,domain,BEANCOLOR);
fill(pic,codomain,BEANCOLOR);
for (int i; i<NUMPOINTS; ++i) {
  dot(pic,domainpoint[i],DARKPEN+black);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
for (int i; i<NUMPOINTS; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),arrow=Arrows(TeXHead),LIGHTPEN+ARROWCOLOR);
}

// label(pic,"{\tiny$\vdots$}",shift(0.5*DOMAINTOCODOMAIN,0)*(0.5*h,1.3*v));
shipout(format("background%02d",picnum),pic,format="pdf");




// ......................................
// Drop a program to disc, get a number

import labelpath;
picture pic;
int picnum = 5;
unitsize(pic,0.4cm);

// Source doc
pair pt1=(0.1,3);
pair pt2=(0.075,3.1);
pair pt3=(-0.1,3.5);
path src_edge = (0,0){pt2-(0,0)}..tension 1 and 2 ..pt1..pt2..pt3..tension 2 and 1 ..{(0,5)-pt3}(0,5.0);
path src_other_edge = shift(3.75,0)*src_edge;
path paper = src_edge--reverse(src_other_edge)--cycle;
// dot(pic,pt1,green);
// dot(pic,pt2,green);
// dot(pic,pt3,green);
draw(pic,paper,miterjoin+lightcolor);
label(pic,"\tiny \texttt{(def (f x y)}",pt3,NE);
label(pic,"\tiny \hspace*{0.5cm}$\vdots$",pt1,E);

real disc_radius = 8;
pair disc_center = (1.825,-1*disc_radius-2);
real disc_track_sector_radius = disc_radius - 1;
path disc = arc(disc_center, disc_radius, 120, 60, CW);
path track_sector = arc(disc_center, disc_track_sector_radius, 120, 60, CW);
draw(pic,disc,lightcolor);
labelpath(pic,"\tiny \texttt{1101010}",track_sector,highlightcolor);
label(pic,"$\Updownarrow$",(disc_center.x,-1));
shipout(format("background%02d",picnum),pic,format="pdf");



// ======================================================
// s-m-n theorem before and after

picture pic;
int picnum = 6;
// unitsize(pic,1cm);

// define nodes
node start=nroundbox("Start");
node read=nbox(minipage2("Read x0\\ Read x1\\ Read x2"));
node dosomething=nbox("Do something");
node output=nbox("Output something");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.35*v,start,read);
vlayout(1.45*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");

// .....................
picture pic;
int picnum = 7;
// unitsize(pic,1cm);

// define nodes
node start=nroundbox("Start");
node fix=nbox(minipage2("x0 = 5\\ x1 = 7"));
node read=nbox("Read x2");
node dosomething=nbox("Do something");
node output=nbox("Output something");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.25*v,start,fix);
vlayout(1.25*v,fix,read);
vlayout(1.0*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--fix),
     (fix--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     fix,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");




// ======================================================
// s-m-n family of pgms
picture pic;
int picnum = 8;

// define nodes
node start=nroundbox("Start");
node read=nbox(minipage2("Read base\\ Read exponent"));
node dosomething=nbox("z = base**exponent");
node output=nbox("Print z");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.25*v,start,read);
vlayout(1.30*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");


// ..............................
picture pic;
int picnum = 9;

// define nodes
node start=nroundbox("Start");
// node fix=nbox("exponent = 0");
node read=nbox("Read base");
node dosomething=nbox("z = base**0");
node output=nbox("Print z");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.00*v,start,read);
// vlayout(1.00*v,fix,read);
vlayout(1.00*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     // (fix--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     // fix,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");


// ..............................
picture pic;
int picnum = 10;

// define nodes
node start=nroundbox("Start");
// node fix=nbox("exponent = 1");
node read=nbox("Read base");
node dosomething=nbox("z = base**1");
node output=nbox("Print z");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.00*v,start,read);
// vlayout(1.00*v,fix,read);
vlayout(1.00*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     // (fix--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     // fix,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");


// ..............................
picture pic;
int picnum = 11;

// define nodes
node start=nroundbox("Start");
// node fix=nbox("exponent = 2");
node read=nbox("Read base");
node dosomething=nbox("z = base**2");
node output=nbox("Print z");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.00*v,start,read);
// vlayout(1.00*v,fix,read);
vlayout(1.00*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     // (fix--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     // fix,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");



// ..............................
picture pic;
int picnum = 12;

// define nodes
node start=nroundbox("Start");
// node fix=nbox("exponent = 2");
node read=nbox("Read base");
node dosomething=nbox("z = base**$x$");
node output=nbox("Print z");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.00*v,start,read);
// vlayout(1.00*v,fix,read);
vlayout(1.00*v,read,dosomething);
vlayout(1.0*v,dosomething,output);
vlayout(1.0*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     // (fix--read),
     (read--dosomething),
     (dosomething--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     // fix,
     read,
     dosomething,
     output,
     ending
     );

shipout(format("background%02d",picnum),pic,format="pdf");

