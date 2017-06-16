// nfsm.asy
//  circle diagrams of a NFSM

import settings;
// settings.dir="..";  // make it able to see jh.asy 
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
cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
import node;
cd("");


// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

string OUTPUT_FN = "nfsm%02d";



// ============== First NFSM ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0--q1).l("\str{0}"), 
     (q0..loop(N)).l("\str{0},\str{1}"),
     (q1--q2).l("\str{0}"), 
     (q2--q3).l("\str{1}") 
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Rotating the turnstile symbol ================
picture pic;
int picnum = 1;
unitsize(pic,1pt);

label(pic, "$\vdash$", (0,0), green);
// for (int i=-2; i<2; ++i) {
//   draw(pic, (10*i,-30)--(10*i,30), red);
// }
// for (int j=-2; j<2; ++j) {
//   draw(pic, (-30,10*j)--(30,10*j), red);
// }
// dot(pic, (0,0));
label(pic, shift(-1.65pt,-0.33pt)*rotate(35)*shift(1.65pt,0.33pt)*"$\vdash$", (0,0));
pen p=linewidth(1.5pt)+red;
dot(pic, (-1.7pt,-0.33pt), p);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Computation history for first NFSM; iniital ================
picture pic;
int picnum = 2;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
// draw(pic, (0.5,4.85)--(0.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
// label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// // Add action up to second input
// label(pic, "$q_0$",(1,1),p);
// label(pic, "$q_1$",(1,-0.5),p);
// draw(pic, (1.5,4.85)--(1.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
// label(pic, "$\vdash$",(1.5,-0.5),p);

// // Add action up to third input
// label(pic, "$q_0$",(2,2),p);
// label(pic, "$q_1$",(2,0.5),p);
// label(pic, "$q_2$",(2,-0.5),p);
// draw(pic, (2.5,4.85)--(2.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
// label(pic, "$\vdash$",(2.5,0.5),p);

// // Add action up to fourth input
// label(pic, "$q_0$",(3,3),p);
// label(pic, "$q_1$",(3,1.5),p);
// label(pic, "$q_2$",(3,0.5),p);
// draw(pic, (3.5,4.85)--(3.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
// label(pic, "$\vdash$",(3.5,1.5),p);

// // Add action up to fifth (final) input
// label(pic, "$q_0$",(4,4),p);
// label(pic, "$q_1$",(4,2.5),p);
// label(pic, "$q_2$",(4,1.5),p);
// draw(pic, (4.5,4.85)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
// label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
// label(pic, "$\vdash$",(4.5,1.5),p);

// // States after final input
// label(pic, "$q_0$",(5,4.5),p);
// label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


picture pic;
int picnum = 3;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p);
label(pic, "$q_1$",(1,-0.5),p);
// draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
// label(pic, "$\vdash$",(1.5,-0.5),p);

// // Add action up to third input
// label(pic, "$q_0$",(2,2),p);
// label(pic, "$q_1$",(2,0.5),p);
// label(pic, "$q_2$",(2,-0.5),p);
// draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
// label(pic, "$\vdash$",(2.5,0.5),p);

// // Add action up to fourth input
// label(pic, "$q_0$",(3,3),p);
// label(pic, "$q_1$",(3,1.5),p);
// label(pic, "$q_2$",(3,0.5),p);
// draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
// label(pic, "$\vdash$",(3.5,1.5),p);

// // Add action up to fifth (final) input
// label(pic, "$q_0$",(4,4),p);
// label(pic, "$q_1$",(4,2.5),p);
// label(pic, "$q_2$",(4,1.5),p);
// draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
// label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
// label(pic, "$\vdash$",(4.5,1.5),p);

// // States after final input
// label(pic, "$q_0$",(5,4.5),p);
// label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


picture pic;
int picnum = 4;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
// p=GRAYPEN;
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p);
label(pic, "$q_1$",(1,-0.5),p);
draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
label(pic, "$\vdash$",(1.5,-0.5),p);

// Add action up to third input
label(pic, "$q_0$",(2,2),p);
label(pic, "$q_1$",(2,0.5),p);
label(pic, "$q_2$",(2,-0.5),p);
// draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
// label(pic, "$\vdash$",(2.5,0.5),p);

// // Add action up to fourth input
// label(pic, "$q_0$",(3,3),p);
// label(pic, "$q_1$",(3,1.5),p);
// label(pic, "$q_2$",(3,0.5),p);
// draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
// label(pic, "$\vdash$",(3.5,1.5),p);

// // Add action up to fifth (final) input
// label(pic, "$q_0$",(4,4),p);
// label(pic, "$q_1$",(4,2.5),p);
// label(pic, "$q_2$",(4,1.5),p);
// draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
// label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
// label(pic, "$\vdash$",(4.5,1.5),p);

// // States after final input
// label(pic, "$q_0$",(5,4.5),p);
// label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



picture pic;
int picnum = 5;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
// p=GRAYPEN;
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p);
label(pic, "$q_1$",(1,-0.5),p);
draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
label(pic, "$\vdash$",(1.5,-0.5),p);

// Add action up to third input
label(pic, "$q_0$",(2,2),p);
label(pic, "$q_1$",(2,0.5),p);
label(pic, "$q_2$",(2,-0.5),p);
draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
label(pic, "$\vdash$",(2.5,0.5),p);

// Add action up to fourth input
label(pic, "$q_0$",(3,3),p);
label(pic, "$q_1$",(3,1.5),p);
label(pic, "$q_2$",(3,0.5),p);
// draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
// label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
// label(pic, "$\vdash$",(3.5,1.5),p);

// // Add action up to fifth (final) input
// label(pic, "$q_0$",(4,4),p);
// label(pic, "$q_1$",(4,2.5),p);
// label(pic, "$q_2$",(4,1.5),p);
// draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
// label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
// label(pic, "$\vdash$",(4.5,1.5),p);

// // States after final input
// label(pic, "$q_0$",(5,4.5),p);
// label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



picture pic;
int picnum = 6;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
// p=GRAYPEN;
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p);
label(pic, "$q_1$",(1,-0.5),p);
draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
label(pic, "$\vdash$",(1.5,-0.5),p);

// Add action up to third input
label(pic, "$q_0$",(2,2),p);
label(pic, "$q_1$",(2,0.5),p);
label(pic, "$q_2$",(2,-0.5),p);
draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
label(pic, "$\vdash$",(2.5,0.5),p);

// Add action up to fourth input
label(pic, "$q_0$",(3,3),p);
label(pic, "$q_1$",(3,1.5),p);
label(pic, "$q_2$",(3,0.5),p);
draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
label(pic, "$\vdash$",(3.5,1.5),p);

// Add action up to fifth (final) input
label(pic, "$q_0$",(4,4),p);
label(pic, "$q_1$",(4,2.5),p);
label(pic, "$q_2$",(4,1.5),p);
// draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
// label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
// label(pic, "$\vdash$",(4.5,1.5),p);

// // States after final input
// label(pic, "$q_0$",(5,4.5),p);
// label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


picture pic;
int picnum = 7;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p);
// p=GRAYPEN;
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p);
label(pic, "$q_1$",(1,-0.5),p);
draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
label(pic, "$\vdash$",(1.5,-0.5),p);

// Add action up to third input
label(pic, "$q_0$",(2,2),p);
label(pic, "$q_1$",(2,0.5),p);
label(pic, "$q_2$",(2,-0.5),p);
draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
label(pic, "$\vdash$",(2.5,0.5),p);

// Add action up to fourth input
label(pic, "$q_0$",(3,3),p);
label(pic, "$q_1$",(3,1.5),p);
label(pic, "$q_2$",(3,0.5),p);
draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
label(pic, "$\vdash$",(3.5,1.5),p);

// Add action up to fifth (final) input
label(pic, "$q_0$",(4,4),p);
label(pic, "$q_1$",(4,2.5),p);
label(pic, "$q_2$",(4,1.5),p);
draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
label(pic, "$\vdash$",(4.5,1.5),p);

// States after final input
label(pic, "$q_0$",(5,4.5),p);
label(pic, "$q_3$",(5,1.5),p);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


picture pic;
int picnum = 8;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0$",(0,0),p+highlightcolor);
// p=GRAYPEN;
draw(pic, (0.5,4.75)--(0.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.5,0.45),p);

// Add action up to second input
label(pic, "$q_0$",(1,1),p+highlightcolor);
label(pic, "$q_1$",(1,-0.5),p);
draw(pic, (1.5,4.75)--(1.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(1.5,(1-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(1.5,(1+0.45)),p);
label(pic, "$\vdash$",(1.5,-0.5),p);

// Add action up to third input
label(pic, "$q_0$",(2,2),p+highlightcolor);
label(pic, "$q_1$",(2,0.5),p);
label(pic, "$q_2$",(2,-0.5),p);
draw(pic, (2.5,4.75)--(2.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(2.5,(2-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(2.5,(2+0.45)),p);
label(pic, "$\vdash$",(2.5,0.5),p);

// Add action up to fourth input
label(pic, "$q_0$",(3,3),p);
label(pic, "$q_1$",(3,1.5),p+highlightcolor);
label(pic, "$q_2$",(3,0.5),p);
draw(pic, (3.5,4.75)--(3.5,-1),GRAYSTRIPE);
label(pic, yield_t_down*"$\vdash$",(3.5,(3-0.25)),p);
label(pic, yield_t_up*"$\vdash$",(3.5,(3+0.45)),p);
label(pic, "$\vdash$",(3.5,1.5),p);

// Add action up to fifth (final) input
label(pic, "$q_0$",(4,4),p);
label(pic, "$q_1$",(4,2.5),p);
label(pic, "$q_2$",(4,1.5),p+highlightcolor);
draw(pic, (4.5,4.75)--(4.5,-1),GRAYSTRIPE);  // was down to -0.75
label(pic, rotate(35)*"$\vdash$",(4.5,(4+0.25)),p);
label(pic, "$\vdash$",(4.5,1.5),p);

// States after final input
label(pic, "$q_0$",(5,4.5),p);
label(pic, "$q_3$",(5,1.5),p+highlightcolor);

// legend at top of graphic
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.35));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "$0$",(0.5, 5));
label(pic, "$0$",(1.5, 5));
label(pic, "$0$",(2.5, 5));
label(pic, "$0$",(3.5, 5));
label(pic, "$1$",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "$3$",(3, -1.3));
label(pic, "$4$",(4, -1.3));
label(pic, "$5$",(5, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



