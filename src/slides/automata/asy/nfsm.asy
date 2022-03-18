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
import jhnode;
cd("");


// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;

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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
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




// ============== An a three from the end ================
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

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0..loop(W)).l("\str{a},\str{b}"),
     (q0--q1).l("\str{a}"), 
     (q1--q2).l("\str{a},\str{b}"), 
     (q2--q3).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM ends in aa, bb, or cc ==
picture pic;
int picnum = 10;
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

q1.pos = new_node_pos_h(q0, 35, 1*u);
hlayout(1*u, q1, q2, q3);
// q6.pos = new_node_pos(q0, 0, 1*u);
hlayout(1*u, q0, q4, q5, q6);
q7.pos = new_node_pos_h(q0, -35, 1*u);
hlayout(1*u, q7, q8, q9);

// draw edges
draw(pic,
     (q0--q1).l("$\varepsilon$"),
     (q1--q2).l("\str{a}"),
     (q2--q3).l("\str{a}"),
     (q0--q4).l("$\varepsilon$"),
     (q4--q5).l("\str{b}"),
     (q5--q6).l("\str{b}"),
     (q0--q7).l("$\varepsilon$"),
     (q7--q8).l("\str{c}"),
     (q8--q9).l("\str{c}")
);

// draw nodes after edges
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Suffix of HEF ================
picture pic;
int picnum = 11;
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

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0..loop(W)).l("any"),
     (q0--q1).l("\str{H}"), 
     (q1--q2).l("\str{E}"), 
     (q2--q3).l("\str{F}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Prefix ab suffix ac ================
picture pic;
int picnum = 12;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1, q2);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1--q2).l("\str{b}"), 
     (q2..loop(S)).l("any") 
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ..................................
picture pic;
int picnum = 13;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q3, q4, q5);

// edges
draw(pic,
     (q3--q4).l("\str{a}"),
     (q3..loop(S)).l("any"),
     (q4--q5).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..........................................
picture pic;
int picnum = 14;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1, q2, q3, q4, q5);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1--q2).l("\str{b}"), 
     (q2..loop(S)).l("any"), 
     (q2--q3).l("$\varepsilon$"),
     (q3--q4).l("\str{a}"),
     (q3..loop(S)).l("any"),
     (q4--q5).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..........................................
picture pic;
int picnum = 15;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$"),
  q6=ncircle("$q_6$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

q1.pos = new_node_pos_h(q0, 35, 1*u);
q4.pos = new_node_pos_h(q0, -35, 1*u);
hlayout(u, q1, q2, q3);
hlayout(u, q4, q5, q6);

// edges
draw(pic,
     (q0--q1).l("$\varepsilon$"),
     (q0--q4).l("$\varepsilon$"),
     (q1--q2).l("\str{a}"), 
     (q2--q3).l("\str{b}"),
     (q3..loop(E)).l("any"), 
     (q4--q5).l("\str{a}"),
     (q4..loop(N)).l("any"),
     (q5--q6).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5, q6);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======= nfsm example .*10*1.* =========================
picture pic;
int picnum = 16;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = .9u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0--q1).l("\str{1}"),
     (q0..loop(W)).l("any"),
     (q1..loop(N)).l("\str{0}"), 
     (q1--q2).l("\str{1}"),
     (q2..loop(E)).l("any") 
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== breadth-first search of all derivations  ================
//  ranks 0-1
picnum = 17;  
picture p;

defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);


// define nodes
node Snode=nbox("\terminal{S}"),
TbU=nbox("\terminal{TbU}");
     // aTbU=nbox("\terminal{aTbU}"),
     // epsbU=nbox("$\terminal{$\varepsilon$bU}$=\terminal{bU}"),
     // TbaU=nbox("\terminal{TbaU}"),
     // TbbU=nbox("\terminal{TbbU}"),
     // Tbeps=nbox("$\terminal{Tb$\varepsilon$}=\terminal{Tb}$"),
     // aaTbU=nbox("\terminal{aaTbU}"),
     // aepsbU=nbox("$\terminal{a$\varepsilon$bU}=\terminal{abU}$"),
     // baU=nbox("\terminal{baU}"),
     // bbU=nbox("\terminal{bbU}"),
     // beps=nbox("$\terminal{b$\varepsilon$}=\terminal{b}$"),
     // aTbaU=nbox("\terminal{aTbaU}"),
     // epsbaU=nbox("$\terminal{$\varepsilon$baU}=\terminal{baU}$"),
     // TbaaU=nbox("\terminal{TbaaU}"),
     // TbabU=nbox("\terminal{TbabU}"),
     // Tbaeps=nbox("$\terminal{Tba$\varepsilon$}=\terminal{Tba}$"),
     // aTbbU=nbox("\terminal{aTbbU}"),
     // epsbbU=nbox("$\terminal{$\varepsilon$bbU}=\terminal{bbU}$"),
     // TbbaU=nbox("\terminal{TbbaU}"),
     // TbbbU=nbox("\terminal{TbbbU}"),
     // Tbbeps=nbox("$\terminal{Tbb$\varepsilon$}=\terminal{Tbb}$"),
     // aTb=nbox("\terminal{aTb}"),
     // epsb=nbox("$\terminal{$\varepsilon$b}=\terminal{b}$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.4*u;                 // vertical

// rank 0
Snode.pos=(0*u,0*v);
// rank 1
TbU.pos=(0*u,-1*v);
// // rank 2
// aTbU.pos=(-2.75*u,-2*v);
// epsbU.pos=(-1.75*u,-2*v);
// TbaU.pos=(-0.4*u,-2*v);
// TbbU.pos=(0.5*u,-2*v);
// Tbeps.pos=(2*u,-2*v);
// // rank 3
// aaTbU.pos=(-3.5*u,-3*v);
// aepsbU.pos=(-3.25*u,-3.5*v);
// //
// baU.pos=(-2.5*u,-3*v);
// bbU.pos=(-2.35*u,-3.5*v);
// beps.pos=(-2.2*u,-4*v);
// //
// aTbaU.pos=(-1.5*u,-3*v);
// epsbaU.pos=(-1.25*u,-3.5*v);
// TbaaU.pos=(-.90*u,-4*v);
// TbabU.pos=(-0.6*u,-4.5*v);
// Tbaeps.pos=(-0.3*u,-5*v);
// //
// aTbbU.pos=(1.75*u,-3*v);
// epsbbU.pos=(1.5*u,-3.5*v);
// TbbaU.pos=(1.25*u,-4*v);
// TbbbU.pos=(1*u,-4.5*v);
// Tbbeps.pos=(0.75*u,-5*v);
// //
// aTb.pos=(2.5*u,-3*v);
// epsb.pos=(2.35*u,-3.5*v);

// draw edges
draw(p,
     (Snode--TbU),  // rank 0 to rank 1
     (Snode--TbU)  // oddball bug; have to draw a single edge twice.
     // (TbU--aTbU),  // rank 1 to rank 2
     // (TbU--epsbU),
     // (TbU--TbaU),
     // (TbU--TbbU),
     // (TbU--Tbeps),
     // (aTbU--aaTbU),  // rank 2 to rank 3
     // (aTbU--aepsbU),
     // (epsbU--baU),
     // (epsbU--bbU),
     // (epsbU--beps),
     // (TbaU--aTbaU),
     // (TbaU--epsbaU),
     // (TbaU--TbaaU),
     // (TbaU--TbabU),
     // (TbaU--Tbaeps),     
     // (TbbU--aTbbU),
     // (TbbU--epsbbU),
     // (TbbU--TbbaU),
     // (TbbU--TbbbU),
     // (TbbU--Tbbeps),
     // (Tbeps--aTb),
     // (Tbeps--epsb)
    );

// draw nodes
draw(p,
     Snode,
     TbU
     // aTbU, epsbU, TbaU, TbbU, Tbeps,
     // aaTbU, aepsbU, baU, bbU, beps, 
     //   aTbaU, epsbaU, TbaaU, TbabU, Tbaeps,
     //   aTbbU, epsbbU, TbbaU, TbbbU, Tbbeps, 
     //   aTb, epsb 
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ........  ranks 0-2 ........................................
picnum = 18;  
picture p;

defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);


// define nodes
node Snode=nbox("\terminal{S}"),
     TbU=nbox("\terminal{TbU}"),
     aTbU=nbox("\terminal{aTbU}"),
     epsbU=nbox("$\terminal{$\varepsilon$bU}$=\terminal{bU}"),
     TbaU=nbox("\terminal{TbaU}"),
     TbbU=nbox("\terminal{TbbU}"),
     Tbeps=nbox("$\terminal{Tb$\varepsilon$}=\terminal{Tb}$");
     // aaTbU=nbox("\terminal{aaTbU}"),
     // aepsbU=nbox("$\terminal{a$\varepsilon$bU}=\terminal{abU}$"),
     // baU=nbox("\terminal{baU}"),
     // bbU=nbox("\terminal{bbU}"),
     // beps=nbox("$\terminal{b$\varepsilon$}=\terminal{b}$"),
     // aTbaU=nbox("\terminal{aTbaU}"),
     // epsbaU=nbox("$\terminal{$\varepsilon$baU}=\terminal{baU}$"),
     // TbaaU=nbox("\terminal{TbaaU}"),
     // TbabU=nbox("\terminal{TbabU}"),
     // Tbaeps=nbox("$\terminal{Tba$\varepsilon$}=\terminal{Tba}$"),
     // aTbbU=nbox("\terminal{aTbbU}"),
     // epsbbU=nbox("$\terminal{$\varepsilon$bbU}=\terminal{bbU}$"),
     // TbbaU=nbox("\terminal{TbbaU}"),
     // TbbbU=nbox("\terminal{TbbbU}"),
     // Tbbeps=nbox("$\terminal{Tbb$\varepsilon$}=\terminal{Tbb}$"),
     // aTb=nbox("\terminal{aTb}"),
     // epsb=nbox("$\terminal{$\varepsilon$b}=\terminal{b}$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.4*u;                 // vertical

// rank 0
Snode.pos=(0*u,0*v);
// rank 1
TbU.pos=(0*u,-1*v);
// rank 2
aTbU.pos=(-2.75*u,-2*v);
epsbU.pos=(-1.75*u,-2*v);
TbaU.pos=(-0.4*u,-2*v);
TbbU.pos=(0.5*u,-2*v);
Tbeps.pos=(2*u,-2*v);
// // rank 3
// aaTbU.pos=(-3.5*u,-3*v);
// aepsbU.pos=(-3.25*u,-3.5*v);
// //
// baU.pos=(-2.5*u,-3*v);
// bbU.pos=(-2.35*u,-3.5*v);
// beps.pos=(-2.2*u,-4*v);
// //
// aTbaU.pos=(-1.5*u,-3*v);
// epsbaU.pos=(-1.25*u,-3.5*v);
// TbaaU.pos=(-.90*u,-4*v);
// TbabU.pos=(-0.6*u,-4.5*v);
// Tbaeps.pos=(-0.3*u,-5*v);
// //
// aTbbU.pos=(1.75*u,-3*v);
// epsbbU.pos=(1.5*u,-3.5*v);
// TbbaU.pos=(1.25*u,-4*v);
// TbbbU.pos=(1*u,-4.5*v);
// Tbbeps.pos=(0.75*u,-5*v);
// //
// aTb.pos=(2.5*u,-3*v);
// epsb.pos=(2.35*u,-3.5*v);

// draw edges
draw(p,
     (Snode--TbU),  // rank 0 to rank 1
     (TbU--aTbU),  // rank 1 to rank 2
     (TbU--epsbU),
     (TbU--TbaU),
     (TbU--TbbU),
     (TbU--Tbeps)
     // (aTbU--aaTbU),  // rank 2 to rank 3
     // (aTbU--aepsbU),
     // (epsbU--baU),
     // (epsbU--bbU),
     // (epsbU--beps),
     // (TbaU--aTbaU),
     // (TbaU--epsbaU),
     // (TbaU--TbaaU),
     // (TbaU--TbabU),
     // (TbaU--Tbaeps),     
     // (TbbU--aTbbU),
     // (TbbU--epsbbU),
     // (TbbU--TbbaU),
     // (TbbU--TbbbU),
     // (TbbU--Tbbeps),
     // (Tbeps--aTb),
     // (Tbeps--epsb)
    );

// draw nodes
draw(p,
     Snode,
     TbU,
     aTbU, epsbU, TbaU, TbbU, Tbeps
     // aaTbU, aepsbU, baU, bbU, beps, 
     //   aTbaU, epsbaU, TbaaU, TbabU, Tbaeps,
     //   aTbbU, epsbbU, TbbaU, TbbbU, Tbbeps, 
     //   aTb, epsb 
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// .............. all three ranks ...............
picnum = 19;  
picture p;

defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);


// define nodes
node Snode=nbox("\terminal{S}"),
     TbU=nbox("\terminal{TbU}"),
     aTbU=nbox("\terminal{aTbU}"),
     epsbU=nbox("$\terminal{$\varepsilon$bU}$=\terminal{bU}"),
     TbaU=nbox("\terminal{TbaU}"),
     TbbU=nbox("\terminal{TbbU}"),
     Tbeps=nbox("$\terminal{Tb$\varepsilon$}=\terminal{Tb}$"),
     aaTbU=nbox("\terminal{aaTbU}"),
     aepsbU=nbox("$\terminal{a$\varepsilon$bU}=\terminal{abU}$"),
     baU=nbox("\terminal{baU}"),
     bbU=nbox("\terminal{bbU}"),
     beps=nbox("$\terminal{b$\varepsilon$}=\terminal{b}$"),
     aTbaU=nbox("\terminal{aTbaU}"),
     epsbaU=nbox("$\terminal{$\varepsilon$baU}=\terminal{baU}$"),
     TbaaU=nbox("\terminal{TbaaU}"),
     TbabU=nbox("\terminal{TbabU}"),
     Tbaeps=nbox("$\terminal{Tba$\varepsilon$}=\terminal{Tba}$"),
     aTbbU=nbox("\terminal{aTbbU}"),
     epsbbU=nbox("$\terminal{$\varepsilon$bbU}=\terminal{bbU}$"),
     TbbaU=nbox("\terminal{TbbaU}"),
     TbbbU=nbox("\terminal{TbbbU}"),
     Tbbeps=nbox("$\terminal{Tbb$\varepsilon$}=\terminal{Tbb}$"),
     aTb=nbox("\terminal{aTb}"),
     epsb=nbox("$\terminal{$\varepsilon$b}=\terminal{b}$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.4*u;                 // vertical

// rank 0
Snode.pos=(0*u,0*v);
// rank 1
TbU.pos=(0*u,-1*v);
// rank 2
aTbU.pos=(-2.75*u,-2*v);
epsbU.pos=(-1.75*u,-2*v);
TbaU.pos=(-0.4*u,-2*v);
TbbU.pos=(0.5*u,-2*v);
Tbeps.pos=(2*u,-2*v);
// rank 3
aaTbU.pos=(-3.5*u,-3*v);
aepsbU.pos=(-3.25*u,-3.5*v);
//
baU.pos=(-2.5*u,-3*v);
bbU.pos=(-2.35*u,-3.5*v);
beps.pos=(-2.2*u,-4*v);
//
aTbaU.pos=(-1.5*u,-3*v);
epsbaU.pos=(-1.25*u,-3.5*v);
TbaaU.pos=(-.90*u,-4*v);
TbabU.pos=(-0.6*u,-4.5*v);
Tbaeps.pos=(-0.3*u,-5*v);
//
aTbbU.pos=(1.75*u,-3*v);
epsbbU.pos=(1.5*u,-3.5*v);
TbbaU.pos=(1.25*u,-4*v);
TbbbU.pos=(1*u,-4.5*v);
Tbbeps.pos=(0.75*u,-5*v);
//
aTb.pos=(2.5*u,-3*v);
epsb.pos=(2.35*u,-3.5*v);

// draw edges
draw(p,
     (Snode--TbU),  // rank 0 to rank 1
     (TbU--aTbU),  // rank 1 to rank 2
     (TbU--epsbU),
     (TbU--TbaU),
     (TbU--TbbU),
     (TbU--Tbeps),
     (aTbU--aaTbU),  // rank 2 to rank 3
     (aTbU--aepsbU),
     (epsbU--baU),
     (epsbU--bbU),
     (epsbU--beps),
     (TbaU--aTbaU),
     (TbaU--epsbaU),
     (TbaU--TbaaU),
     (TbaU--TbabU),
     (TbaU--Tbaeps),     
     (TbbU--aTbbU),
     (TbbU--epsbbU),
     (TbbU--TbbaU),
     (TbbU--TbbbU),
     (TbbU--Tbbeps),
     (Tbeps--aTb),
     (Tbeps--epsb)
    );

// draw nodes
draw(p,
     Snode,
     TbU,
     aTbU, epsbU, TbaU, TbbU, Tbeps,
     aaTbU, aepsbU, baU, bbU, beps, 
       aTbaU, epsbaU, TbaaU, TbabU, Tbaeps,
       aTbbU, epsbbU, TbbaU, TbbbU, Tbbeps, 
       aTb, epsb 
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");




// ============== NFSM to convert to DFSM ================
picture pic;
int picnum = 20;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q3=ncircle("$q_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// edges
draw(pic,
     (q0..bend(20)..q1).l("\str{1}"), 
     (q0..loop(N)).l("\str{0},\str{1}"),
     (q1..bend(20)..q0).l("\str{1}"), 
     (q1--q2).l("\str{1}"), 
     (q2..loop(N)).l("\str{0}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== NFSM with epsilon moves to convert to DFSM ================
picture pic;
int picnum = 21;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node s0=ncircle("$s_0$"),
  s1=ncircle("$s_1$"),
  s2=ncircle("$s_2$",ns_accepting),
  s3=ncircle("$s_3$"),
  s4=ncircle("$s_4$"),
  s5=ncircle("$s_5$",ns_accepting),
  s6=ncircle("$s_6$"),
  s7=ncircle("$s_7$"),
  s8=ncircle("$s_8$",ns_accepting),
  s9=ncircle("$s_9$",ns_accepting),
  s10=ncircle("$s_{10}$"),
  s11=ncircle("$s_{11}$",ns_accepting),
  s12=ncircle("$s_{12}$",ns_accepting),
  s13=ncircle("$s_{13}$"),
  s14=ncircle("$s_{14}$",ns_accepting),
  s15=ncircle("$s_{15}$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

s0.pos = (1*u,3.5*v);
s1.pos = (0.75*u,0.5*v);
s2.pos = (1.5*u,2*v);
s3.pos = (4*u,4*v);
s4.pos = (3*u,3*v);
s5.pos = (2*u,1*v);
s6.pos = (4*u,1*v);
s7.pos = (2.5*u,2*v);
s8.pos = (5*u,4*v);
s9.pos = (2*u,3*v);
s10.pos = (6*u,4*v);
s11.pos = (0.5*u,-0.5*v);
s12.pos = (3.75*u,2.25*v);
s13.pos = (5*u,1*v);
s14.pos = (5.5*u,2.5*v);
s15.pos = (3*u,0*v);

// edges
draw(pic,
     (s0..loop(W)).l("\str{0},\str{1}"), 
     (s1--s15).l("\str{0}"), 
     (s1--s5).l("\str{1}"), 
     (s2--s5).l("\str{0}"),
     (s2..loop(W)).l("\str{1}"), 
     (s3--s12).l("\str{0}"), 
     (s3--s14).l(Label("\str{1}",Relative(0.15))), 
     (s4--s12).l("\str{0}"), 
     (s4--s2).l(Label("\str{1}",Relative(0.20))), 
     (s5--s15).l("\str{0}"), 
     (s5..loop(E)).l("\str{1}"), 
     (s6--s15).l(Label("\str{0},\str{1}",Relative(0.25))), 
     (s7..bend(-20)..s15).l("\str{0}"), 
     (s7--s5).l("\str{1}"), 
     (s8--s12).l("\str{0}"), 
     (s8--s14).l(Label("\str{1}",Relative(0.15))), 
     (s9..bend..s12).l("\str{0}"), 
     (s9--s2).l("\str{1}"), 
     (s10--s12).l(Label("\str{0}",Relative(0.15))),
     (s10--s14).l("\str{1}"), 
     (s11--s15).l("\str{0},\str{1}"), 
     (s12--s15).l("\str{0}"), 
     (s12--s5).l(Label("\str{1}",Relative(0.30))).style("leftside"), 
     (s13--s15).l(Label("\str{0},\str{1}",Relative(0.25))).style("leftside"), 
     (s14--s12).l("\str{0}"), 
     (s14..loop(E)).l("\str{1}"), 
     (s15..loop(S)).l("\str{0},\str{1}") 
     );

// draw nodes after edges so arrows are OK
draw(pic, s0, s1, s2, s3,
          s4, s5, s6, s7,
          s8, s9, s10, s11,
          s12, s13, s14, s15);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




