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
     (q0..loop(W)).l("\str{0},\str{1}"),
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




// ============== Second NFSM; substring of aa or bb ================
picture pic;
int picnum = 9;
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
real v = .9u;

hlayout(u, q0, q1);
vlayout(v, q0, q2);
hlayout(u, q2, q3);

// edges
draw(pic,
     (q0..loop(W)).l("\str{a},\str{b}"),
     (q0--q1).l("\str{a}"), 
     (q0--q2).l("\str{b}"), 
     (q1--q3).l("\str{a}"), 
     (q2--q3).l("\str{b}"),
     (q3..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Second NFSM; substring of aa or bb ================
picture pic;
int picnum = 10;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1);

// edges
draw(pic,
     (q0..bend..q1).l("\str{a}"), 
     (q1..bend..q0).l("\str{c}") 
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Garage door listener ================
picture pic;
int picnum = 11;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$"),
  q6=ncircle("$q_6$"),
q7=ncircle("$q_7$", ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1, q2, q3, q4, q5, q6, q7);

// edges
draw(pic,
     (q0..loop(W)).l("\str{0},\str{1}"), 
     (q0--q1).l("\str{0}"), 
     (q1--q2).l("\str{1}"), 
     (q2--q3).l("\str{0}"), 
     (q3--q4).l("\str{1}"), 
     (q4--q5).l("\str{1}"), 
     (q5--q6).l("\str{1}"), 
     (q6--q7).l("\str{0}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== epsilon-transitions, NFSM of valid integers ================
picture pic;
int picnum = 12;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$", ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1, q2, q3, q4, q5, q6, q7);

// edges
draw(pic, 
     (q0--q1).l("\str{+},\str{-},$\varepsilon$"), 
     (q1--q2).l("\str{1},...,\str{9}"), 
     (q2..loop(E)).l("\str{0},...\str{9}") 
    );

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== epsilon-transitions, join of two machines ================
picture pic;
int picnum = 13;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$", ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$", ns_accepting),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(3*u, q0, q3);
q1.pos = new_node_pos(q0, 45, 1*v);
q2.pos = new_node_pos(q0, 135, 1*v);
q4.pos = new_node_pos(q3, -45, 1*v);
q5.pos = new_node_pos(q3, -135, 1*v);


// edges
draw(pic, 
     (q0--q1).l("\str{a}"), 
     (q1--q2).l("\str{a}"), 
     (q2--q0).l("\str{b}"), 
     (q0--q3).l("$\varepsilon$"), 
     (q3..loop(S)).l("\str{a}"), 
     (q3--q4).l("\str{a}"), 
     (q4--q5).l("\str{b}"), 
     (q5--q3).l("\str{a}") 
    );

// draw nodes after edges
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== epsilon-transitions, or of two machines ================
picture pic;
int picnum = 14;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting);  
node r0=ncircle("$r_0$",ns_accepting); 
node r1=ncircle("$r_1$");
node s0=ncircle("$s_0$");
node t=ncircle("$t$",ns_accepting);  

// calculate nodes position
real u=2.25cm;  // horizontal
real v=0.8*u;   // vertical
q0.pos = new_node_pos(s0, 20, 0.33*v);
r0.pos = new_node_pos(s0, -20, -0.33*v);
hlayout(1*u, q0, q1, q2);
hlayout(1*u, r0, r1);

// draw edges
draw(pic,
     (s0--q0).l("$\varepsilon$"),
     (s0--r0).l("$\varepsilon$"),
     (q0--q1).l("\str{a}"),
     (q0..loop(N)).l("\str{a},\str{b}"),
     (q1--q2).l("\str{b}"),
     (r0..bend..r1).l("\str{a}"),
     (r1..bend..r0).l("\str{c}")
     // (s0--q0).l("$\varepsilon$"),
     // (s0--r0).l("$\varepsilon$"),
     // (q2--t).l("$\varepsilon$"),
     // (r0..bend(40)..t).l("$\varepsilon$")
);

// draw nodes after edges
draw(pic, s0, q0,q1,q2, r0,r1);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== epsilon-transitions, star of two machines ================
picture pic;
int picnum = 15;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=2.25cm;
hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1--q2).l("\str{b}"),
     (q2..bend(25)..q0).l("$\varepsilon$")
);

// draw nodes after edges
draw(pic, q0, q1, q2);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM without epsilon transitions, for proof of equivalence ==
picture pic;
int picnum = 16;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.75cm;
hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{a}"),
     (q0--q1).l("\str{a}"),
     (q1--q2).l("\str{b}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== DFSM , for proof of equivalence ==
picture pic;
int picnum = 17;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node s0=ncircle("$s_0$"); 
node s1=ncircle("$s_1$",ns_accepting);  
node s2=ncircle("$s_2$");  
node s3=ncircle("$s_3$",ns_accepting);  
node s4=ncircle("$s_4$",ns_accepting);  
node s5=ncircle("$s_5$",ns_accepting);  
node s6=ncircle("$s_6$",ns_accepting);  
node s7=ncircle("$s_7$",ns_accepting);  

// calculate nodes position
real u=1.75cm;  // horiz scale
real v=0.9*u;   // vert scale
s0.pos = (0*u, 0*v);
s3.pos = new_node_pos_h(s0, -45, 1*u);
s6.pos = new_node_pos_h(s3, 30, 1*u);
s4.pos = new_node_pos_h(s3, 0, 1*u);
// s2.pos = new_node_pos_h(s3, -50, 1*u);
s2.pos = new_node_pos(s3, -90, -0.75*v);
s1.pos = new_node_pos_h(s4, 40, 1*u);
s5.pos = new_node_pos_h(s4, 15, 1*u);
s7.pos = new_node_pos_h(s4, -15, 1*u);


// draw edges
draw(pic,
     (s0..loop(W)).l("\str{a},\str{b}"),
     (s1..bend..s0).l("\str{b}"),
     (s1--s4).l("\str{a}"),
     (s2--s0).l("\str{a}").style("leftside"),
     // (s2..bend(-30)..s3).l(Label("\str{b}",Relative(0.75))).style("leftside"),
     (s2--s3).l("\str{b}").style("leftside"),
     (s3--s0).l("\str{a},\str{b}"),
     (s4..loop(S)).l("\str{a}"),
     (s4--s3).l("\str{b}"),
     (s5--s4).l("\str{a}"),
     (s5..bend..s0).l("\str{b}"),
     (s6--s0).l("\str{a}"),
     (s6--s3).l("\str{b}"),
     (s7--s4).l("\str{a}"),
     (s7..bend(-50)..s3).l("\str{b}").style("leftside")
);

// draw nodes after edges
draw(pic, s0, s1, s2, s3, s4, s5, s6, s7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== NFSM with epsilon transitions, for proof of equivalence ==
picture pic;
int picnum = 18;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$");  
node q3=ncircle("$q_3$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=01.0*u;  // vertical

hlayout(1*u, q0, q1);
vlayout(1*v, q0, q2);
hlayout(1*u, q2, q3);

// draw edges
draw(pic,
     (q0..bend..q2).l("\str{a}"),
     (q0--q3).l("$\varepsilon$").style("leftside"),
     (q1--q0).l("$\varepsilon$"),
     (q2..bend..q0).l("\str{b}"),
     // (q2--q3).l("\str{b}"),
     (q3..loop(E)).l("\str{a}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, shortest strings ==
picture pic;
int picnum = 19;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{a}"),
     (q0--q1).l("\str{a},\str{b}"),
     (q1--q2).l("$\varepsilon$"),
     (q2..loop(E)).l("\str{b}"),
     (q2..bend..q0).l("\str{b}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, local phone numbers ==
picture pic;
int picnum = 20;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$");  
node q3=ncircle("$q_3$");  
node q4=ncircle("$q_4$");  
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$");  
node q7=ncircle("$q_7$");  
node q8=ncircle("$q_8$",ns_accepting);  

// calculate nodes position
real u=1.75cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2, q3, q4, q5, q6, q7, q8);

// draw edges
draw(pic,
     (q0--q1).l("\str{0},..\str{9}"),
     (q1--q2).l("\str{0},..\str{9}"),
     (q2--q3).l("\str{0},..\str{9}"),
     (q3--q4).l("\rule[-0\baselineskip]{0pt}{0.55\baselineskip}\str{-}"),
     (q4--q5).l("\str{0},..\str{9}"),
     (q5--q6).l("\str{0},..\str{9}"),
     (q6--q7).l("\str{0},..\str{9}"),
     (q7--q8).l("\str{0},..\str{9}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7, q8);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, convert to DFSM ==
picture pic;
int picnum = 21;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{0}"),
     (q0--q1).l("\str{0}"),
     (q1--q2).l("\str{0},\str{1}"),
     (q2..bend..q0).l("\str{1}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== NFSM exercise, convert to DFSM ==
picture pic;
int picnum = 22;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(2*u, q0, q2);
q1.pos = new_node_pos_h(q0, -30, 1*u);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{0}"),
     (q0--q1).l("\str{0}"),
     (q0..bend(-15)..q2).l("$\varepsilon$").style("leftside"),
     (q1--q2).l("\str{0},\str{1}"),
     (q2..bend(-15)..q0).l("\str{1}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== NFSM exercise, final character appear twice ==
picture pic;
int picnum = 23;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting);  
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$",ns_accepting); 
node q7=ncircle("$q_7$");  
node q8=ncircle("$q_8$"); 
node q9=ncircle("$q_9$",ns_accepting); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

q1.pos = new_node_pos_h(q0, 45, 1*u);
hlayout(1*u, q1, q2, q3);
// q6.pos = new_node_pos(q0, 0, 1*u);
hlayout(1*u, q0, q4, q5, q6);
q7.pos = new_node_pos_h(q0, -45, 1*u);
hlayout(1*u, q7, q8, q9);

// draw edges
draw(pic,
     (q0--q1).l("$\varepsilon$"),
     (q1..loop(N)).l("\str{2},\str{3}"),
     (q1--q2).l("\str{1}"),
     (q2..loop(N)).l("\str{2},\str{3}"),
     (q2--q3).l("\str{1}"),
     (q0--q4).l("$\varepsilon$"),
     (q4..loop(N)).l("\str{1},\str{3}"),
     (q4--q5).l("\str{2}"),
     (q5..loop(N)).l("\str{1},\str{3}"),
     (q5--q6).l("\str{2}"),
     (q0--q7).l("$\varepsilon$"),
     (q7..loop(N)).l("\str{1},\str{2}"),
     (q7--q8).l("\str{3}"),
     (q8..loop(N)).l("\str{1},\str{2}"),
     (q8--q9).l("\str{3}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== NFSM exercise, final character appear twice ==
picture pic;
int picnum = 24;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting);  
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$",ns_accepting); 
node q7=ncircle("$q_7$");  
node q8=ncircle("$q_8$"); 
node q9=ncircle("$q_9$",ns_accepting); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

q1.pos = new_node_pos_h(q0, 45, 1*u);
hlayout(1*u, q1, q2, q3);
// q6.pos = new_node_pos(q0, 0, 1*u);
hlayout(1*u, q0, q4, q5, q6);
q7.pos = new_node_pos_h(q0, -45, 1*u);
hlayout(1*u, q7, q8, q9);

// draw edges
draw(pic,
     (q0--q1).l("$\varepsilon$"),
     (q1..loop(N)).l("\str{2},\str{3}"),
     (q1--q2).l("\str{1}"),
     // (q2..loop(N)).l("\str{2},\str{3}"),
     (q2--q3).l("\str{1}"),
     (q0--q4).l("$\varepsilon$"),
     (q4..loop(N)).l("\str{1},\str{3}"),
     (q4--q5).l("\str{2}"),
     (q5..loop(N)).l("\str{1}"),
     (q5--q6).l("\str{2}"),
     (q0--q7).l("$\varepsilon$"),
     (q7..loop(N)).l("\str{1},\str{2}"),
     (q7--q8).l("\str{3}"),
     (q8..loop(N)).l("\str{1},\str{2}"),
     (q8--q9).l("\str{3}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, omit at least one character ==
picture pic;
int picnum = 25;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$",ns_accepting);  
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

q1.pos = new_node_pos_h(q0, 45, 1*u);
hlayout(1*u, q0, q2);
q3.pos = new_node_pos_h(q0, -45, 1*u);

// draw edges
draw(pic,
     (q0--q1).l("$\varepsilon$"),
     (q1..loop(N)).l("\str{a},\str{b}"),
     (q0--q2).l("$\varepsilon$"),
     (q2..loop(N)).l("\str{a},\str{c}"),
     (q0--q3).l("$\varepsilon$"),
     (q3..loop(N)).l("\str{b},\str{c}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== NFSM exercise, accept only the empty string ==
picture pic;
int picnum = 26;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical


// draw edges

// draw nodes after edges
draw(pic, q0);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, any string but the empty one ==
picture pic;
int picnum = 27;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0--q1).l("\str{a},\str{b},\str{c}"),
     (q1..loop(E)).l("\str{a},\str{b},\str{c}")
);

// draw nodes after edges
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, any string but the empty one ==
picture pic;
int picnum = 28;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q1--q2).l("\str{1}"),
     (q1..loop(E)).l("\str{0},\str{1}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM exercise, describe language accepted ==
picture pic;
int picnum = 29;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q1--q2).l("\str{1}"),
     (q0..bend..q2).l("\str{0}"),
     (q1..loop(N)).l("\str{0}"),
     (q2..loop(N)).l("\str{1}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== NFSM exercise, describe strings accepted ==
picture pic;
int picnum = 30;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{0},\str{1}"),
     (q1--q2).l("\str{1}"),
     (q0..bend..q2).l("$\varepsilon$"),
     (q2..loop(E)).l("\str{1}")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== NFSM exercise, circle of epsilons ======
picture pic;
int picnum = 31;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$");  

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(2*u, q0, q2);
q1.pos = new_node_pos_h(q0, -30, 1*u);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{0}"),
     (q0--q1).l("\str{0},$\varepsilon$"),
     (q0..bend(-15)..q2).l("$\varepsilon$").style("leftside"),
     (q1--q2).l("\str{1},$\varepsilon$"),
     (q2..bend(-15)..q0).l("\str{1},$\varepsilon$")
);

// draw nodes after edges
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Kleene's Theorem; machine for emptyset ======
picture pic;
int picnum = 32;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

// draw edges

// draw nodes after edges
draw(pic, q0);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Kleene's Theorem; machine for emptystring ======
picture pic;
int picnum = 33;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical

// draw edges

// draw nodes after edges
draw(pic, q0);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Kleene's Theorem; machine for one-char regex ======
picture pic;
int picnum = 34;
unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_0$",ns_accepting); 

// calculate nodes position
real u=1.5cm;  // horizontal  
real v=1.0*u;  // vertical
hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q1).l("\str{a}")
     );

// draw nodes after edges
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





