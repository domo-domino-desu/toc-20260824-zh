// ndtm.asy
//  Drawings for nondeterministic Turing machines

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jhnode;
import tape;

// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));


// rotate to make the edges of the tree
transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(40)*shift(1.65pt,0.33pt);


string OUTPUT_FN = "ndtm%03d";



// ============== Computation tree of NDTM ================


picture pic;
int picnum = 0;
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);
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
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.45));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
label(pic, "\str{0}",(2.5, 5));
label(pic, "\str{0}",(3.5, 5));
label(pic, "\str{1}",(4.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
// draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
// label(pic, "$0$",(0, -1.3));
// label(pic, "$1$",(1, -1.3));
// label(pic, "$2$",(2, -1.3));
// label(pic, "$3$",(3, -1.3));
// label(pic, "$4$",(4, -1.3));
// label(pic, "$5$",(5, -1.3));
// label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Computation tree of NDTM ================


picture pic;
int picnum = 1;
unitsize(pic,2.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

// step 0
picture tape_pic;
string tape_string;
tape_string = " 00 ";
tape_draw(tape_pic, tape_string, 1, "$\state{0}$", tape_contents_length(tape_string));
add(pic, tape_pic, (0,0), above=true);

// step 1, from top to bottom
picture tape_pic;
tape_string = " 00 ";
tape_draw(tape_pic, tape_string, 2, "$\state{1}$", tape_contents_length(tape_string));
add(pic, tape_pic, (1,1.5), above=true);
label(pic, yield_t_up*"\textcolor{highlightcolor}{$\vdash$}",(0.65,1.10),p);

picture tape_pic;
tape_string = " 10 ";
tape_draw(tape_pic, tape_string, 1, "$\state{2}$", tape_contents_length(tape_string));
add(pic, tape_pic, (1,-0.5), above=true);
label(pic, yield_t_down*"$\vdash$",(0.65,-0.05),p);

// step 2, from top to bottom
picture tape_pic;
tape_string = " 01 ";
tape_draw(tape_pic, tape_string, 2, "$\state{3}$", tape_contents_length(tape_string));
add(pic, tape_pic, (2,2.75), above=true);
label(pic, yield_t_up*"$\vdash$",(1.65,2.45),p);

picture tape_pic;
tape_string = " 0  ";
tape_draw(tape_pic, tape_string, 2, "$\state{1}$", tape_contents_length(tape_string));
add(pic, tape_pic, (2,1.25), above=true);
label(pic, yield_t_down*"\textcolor{highlightcolor}{$\vdash$}",(1.65,1.45),p);

picture tape_pic;
tape_string = " 10 ";
tape_draw(tape_pic, tape_string, 1, "$\state{2}$", tape_contents_length(tape_string));
add(pic, tape_pic, (2,-0.5), above=true);
label(pic, "$\vdash$",(1.65,-0.25),p);

// step 3, from top to bottom
picture tape_pic;
tape_string = " 00 ";
tape_draw(tape_pic, tape_string, 2, "$\state{3}$", tape_contents_length(tape_string));
add(pic, tape_pic, (3,2.75), above=true);
label(pic, "$\vdash$",(2.65,2.95),p);

picture tape_pic;
tape_string = " 10 ";
tape_draw(tape_pic, tape_string, 1, "$\state{2}$", tape_contents_length(tape_string));
add(pic, tape_pic, (3,-0.5), above=true);
label(pic, "$\vdash$",(2.65,-0.25),p);
label(pic, "$\cdots$",(3.65,-0.25),p);

pen GRAYBRANCH = linewidth(0.215cm)+squarecap+highlightcolor+opacity(0.1);  // 
path ed = (0,0)--(1,0);
draw(pic, shift(0.45,0.65)*rotate(68.5)*xscale(0.85)*ed, GRAYBRANCH);
draw(pic, shift(1.55,1.55)*rotate(-52.75)*xscale(0.32)*ed,  GRAYBRANCH);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





