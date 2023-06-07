// pda.asy
//  Diagrams for Pushdown machines

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jhnode;


string OUTPUT_FN = "pda%02d";


path ellipse(pair c, real majoraxis, real minoraxis)
{
  return shift(c)*scale(majoraxis,minoraxis)*unitcircle;
}

// ============== Chomsky languages ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);

real u = 2.5cm;
real v = 0.7*u;
// universal set
real u_width = 1.25u;
real u_height = 0.9v;
path universe = (0,0)--(u_width,0)--(u_width,u_height)--(0,u_height)--cycle;
draw(pic,universe,MAINPEN);
// label("All languages over $\B$",point(universe,1.8),E);

// FSA's
pair regular_langs_center = (0.0,0.0);
real regular_langs_major_axis = 0.15u;
real regular_langs_minor_axis = 0.12v;
path regular_langs = ellipse(regular_langs_center,
			     regular_langs_major_axis,
			     regular_langs_minor_axis);

// find x coord of focii
real focus_squared = regular_langs_major_axis**2 - regular_langs_minor_axis**2; 

// write(format("regular_langs_major_axis %0.4f",regular_langs_major_axis));
// write(format("regular_langs_minor_axis %0.4f",regular_langs_minor_axis));
// write(format("focus_squared %0.4f",focus_squared));

// dot(pic,point(regular_langs,4),green);
// PDA langs
real pda_langs_major_axis = regular_langs_major_axis*1.45;
real pda_langs_minor_axis = regular_langs_minor_axis*1.4;
pair pda_langs_center = regular_langs_center
  + (pda_langs_major_axis-regular_langs_major_axis,0);
// write(format("pda_langs_major_axis %0.4f",pda_langs_major_axis));
// write(format("pda_langs_minor_axis %0.4f",pda_langs_minor_axis));
path pda_langs = ellipse(pda_langs_center,
			 pda_langs_major_axis,
			 pda_langs_minor_axis);

// NPDA langs
real npda_langs_major_axis = pda_langs_major_axis*1.4;
real npda_langs_minor_axis = pda_langs_minor_axis*1.25;
pair npda_langs_center = pda_langs_center
  + (npda_langs_major_axis-pda_langs_major_axis,0);
// write(format("pda_langs_major_axis %0.4f",pda_langs_major_axis));
// write(format("pda_langs_minor_axis %0.4f",pda_langs_minor_axis));
path npda_langs = ellipse(npda_langs_center,
			 npda_langs_major_axis,
			 npda_langs_minor_axis);

// TM langs
real tm_langs_major_axis = npda_langs_major_axis*1.35;
real tm_langs_minor_axis = npda_langs_minor_axis*1.25;
pair tm_langs_center = npda_langs_center
  + (tm_langs_major_axis-npda_langs_major_axis,0);
// write(format("pda_langs_major_axis %0.4f",pda_langs_major_axis));
// write(format("pda_langs_minor_axis %0.4f",pda_langs_minor_axis));
path tm_langs = ellipse(tm_langs_center,
			tm_langs_major_axis,
			tm_langs_minor_axis);

// draw them
pair oset = (-0.001u,0v);
real rotation_angle = 20;
// transform r = shift(0.2*u_width,0.3*u_height)*rotate(rotation_angle,(0,0));
transform r = shift(0.2*u_width,0.5*u_height);
// filldraw(pic,r*tm_langs,fillpen=highlight_light,drawpen=MAINPEN);
filldraw(pic,r*tm_langs,fillpen=backgroundcolor+gray(0.98),drawpen=MAINPEN);
pair tm_langs_focus = tm_langs_center
  +(sqrt(tm_langs_major_axis**2-tm_langs_minor_axis**2),0);
label(pic,"\tiny $D$",r*tm_langs_focus,oset,p=NODEPEN); // make white bg with ,UnFill
// filldraw(pic,r*npda_langs,fillpen=bold_light,drawpen=MAINPEN);
filldraw(pic,r*npda_langs,fillpen=backgroundcolor+gray(0.15),drawpen=MAINPEN);
pair npda_langs_focus = npda_langs_center
  +(sqrt(npda_langs_major_axis**2-npda_langs_minor_axis**2),0);
label(pic,"\tiny $C$",r*npda_langs_focus,oset,p=NODEPEN);
// filldraw(pic,r*pda_langs,fillpen=lightcolor,drawpen=MAINPEN);
filldraw(pic,r*pda_langs,fillpen=backgroundcolor+gray(0.08),drawpen=MAINPEN);
pair pda_langs_focus = pda_langs_center
  +(sqrt(pda_langs_major_axis**2-pda_langs_minor_axis**2),0);
label(pic,"\tiny $B$",r*pda_langs_focus,oset,p=NODEPEN);
filldraw(pic,r*regular_langs,fillpen=backgroundcolor,drawpen=MAINPEN);
label(pic,"\tiny $A$",r*regular_langs_center,p=NODEPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Computation history for first NPDA ================
picture pic;
int picnum = 1;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
//  label(pic, "\scriptsize 2", (0.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
//  label(pic, "\scriptsize 11", (0.60,0.75), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.0),p);
draw(pic, (1,-0.25)--(1,1.70),GRAYSTRIPE);

// // Add action up to second input
// label(pic, "$\vdash$",(1.00,0),p);
//   label(pic, "\scriptsize 0", (1.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}$\bot$}$}",(1.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(1.50,0.5),p);
//   label(pic, "\scriptsize 7", (1.60,0.5), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{$\str{g0}\bot$}$}",(1.50,1.00),p);
// draw(pic, (2,-0.25)--(2,1.70),GRAYSTRIPE);

// // Add action after second input
// label(pic, "$\vdash$",(2.00,0),p);
//   label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,0.25),p);
//   label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.50),p);
// label(pic, "$\vdash$",(2.00,1.00),p);
//   label(pic, "\scriptsize 9", (2.00,0.85), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(2.50,1.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,1.25),p);
//   label(pic, "\scriptsize 11", (2.60,1.25), background_color);
// label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(2.50,1.50),p);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.80));
label(pic, "\str{0}",(1,1.80));
label(pic, "\str{0}",(2,1.80));
draw(pic, (0, 1.70)--(3.00, 1.70),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(3.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..................................
picture pic;
int picnum = 2;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
//  label(pic, "\scriptsize 2", (0.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
//  label(pic, "\scriptsize 11", (0.60,0.75), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.0),p);
draw(pic, (1,-0.25)--(1,1.70),GRAYSTRIPE);

// Add action up to second input
label(pic, "$\vdash$",(1.00,0),p);
//  label(pic, "\scriptsize 0", (1.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.5),p);
//  label(pic, "\scriptsize 7", (1.60,0.5), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\str{g0}\bot$}$}",(1.50,1.00),p);
draw(pic, (2,-0.25)--(2,1.70),GRAYSTRIPE);

// // Add action after second input
// label(pic, "$\vdash$",(2.00,0),p);
//   label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,0.25),p);
//   label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.50),p);
// label(pic, "$\vdash$",(2.00,1.00),p);
//   label(pic, "\scriptsize 9", (2.00,0.85), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(2.50,1.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,1.25),p);
//   label(pic, "\scriptsize 11", (2.60,1.25), background_color);
// label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(2.50,1.50),p);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.80));
label(pic, "\str{0}",(1,1.80));
label(pic, "\str{0}",(2,1.80));
draw(pic, (0, 1.70)--(3.00, 1.70),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(3.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..................................
picture pic;
int picnum = 3;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
//  label(pic, "\scriptsize 2", (0.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
//  label(pic, "\scriptsize 11", (0.60,0.75), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.0),p);
draw(pic, (1,-0.25)--(1,1.70),GRAYSTRIPE);

// Add action up to second input
label(pic, "$\vdash$",(1.00,0),p);
//  label(pic, "\scriptsize 0", (1.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.5),p);
//  label(pic, "\scriptsize 7", (1.60,0.5), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\str{g0}\bot$}$}",(1.50,1.00),p);
draw(pic, (2,-0.25)--(2,1.70),GRAYSTRIPE);

// Add action after second input
label(pic, "$\vdash$",(2.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,0.25),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.50),p);
label(pic, "$\vdash$",(2.00,1.00),p);
//  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(2.50,1.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,1.25),p);
//  label(pic, "\scriptsize 11", (2.60,1.25), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(2.50,1.50),p);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.80));
label(pic, "\str{0}",(1,1.80));
label(pic, "\str{0}",(2,1.80));
draw(pic, (0, 1.70)--(3.00, 1.70),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(3.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ....... With the instruction numbers ...........................
picture pic;
int picnum = 4;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p+highlightcolor);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  label(pic, "\scriptsize 2", (0.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  label(pic, "\scriptsize 11", (0.60,0.75), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.0),p);
draw(pic, (1,-0.25)--(1,1.70),GRAYSTRIPE);

// Add action up to second input
label(pic, "$\vdash$",(1.00,0),p);
  label(pic, "\scriptsize 0", (1.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}$\bot$}$}",(1.50,0.00),p+highlightcolor);
label(pic, yield_t_north*"$\vdash$",(1.50,0.5),p);
  label(pic, "\scriptsize 7", (1.60,0.5), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\str{g0}\bot$}$}",(1.50,1.00),p+highlightcolor);
draw(pic, (2,-0.25)--(2,1.70),GRAYSTRIPE);

// Add action after second input
label(pic, "$\vdash$",(2.00,0),p);
  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,0.25),p);
  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}$\bot$}$}",(2.50,0.50),p);
label(pic, "$\vdash$",(2.00,1.00),p);
  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(2.50,1.00),p+highlightcolor);
label(pic, yield_t_north*"$\vdash$",(2.50,1.25),p);
  label(pic, "\scriptsize 11", (2.60,1.25), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(2.50,1.50),p+highlightcolor);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.80));
label(pic, "\str{0}",(1,1.80));
label(pic, "\str{0}",(2,1.80));
draw(pic, (0, 1.70)--(3.00, 1.70),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(3.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ========== Same NPDA, but input 1000 ========
picture pic;
int picnum = 5;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  // label(pic, "\scriptsize 2", (0.60,0.4), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  // label(pic, "\scriptsize 11", (0.60,1.20), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.00),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// // Add action after first input
// label(pic, "$\vdash$",(1.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g1}$\bot$}$}",(1.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(1.50,0.25),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(1.50,0.50),p);
// draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// // Add action after second input
// label(pic, "$\vdash$",(2.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,0.50),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,1.00),p);
// draw(pic, (2,-0.25)--(2,1.25),GRAYSTRIPE);

// // Add action after third input
// label(pic, "$\vdash$",(3.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(3.50,0.25),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.50),p);
// label(pic, "$\vdash$",(3.00,1.00),p);
// //  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(3.50,1.00),p);
// draw(pic, (3,-0.25)--(3,1.25),GRAYSTRIPE);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.35));
label(pic, "\str{1}",(1,1.35));
label(pic, "\str{0}",(2,1.35));
label(pic, "\str{0}",(3,1.35));
draw(pic, (0, 1.25)--(4.00, 1.25),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(4.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "$3$",(3.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......................................
picture pic;
int picnum = 6;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  // label(pic, "\scriptsize 2", (0.60,0.4), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  // label(pic, "\scriptsize 11", (0.60,1.20), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.00),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after first input
label(pic, "$\vdash$",(1.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g1}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.25),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(1.50,0.50),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// // Add action after second input
// label(pic, "$\vdash$",(2.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(2.50,0.50),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,1.00),p);
// draw(pic, (2,-0.25)--(2,1.25),GRAYSTRIPE);

// // Add action after third input
// label(pic, "$\vdash$",(3.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(3.50,0.25),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.50),p);
// label(pic, "$\vdash$",(3.00,1.00),p);
// //  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(3.50,1.00),p);
// draw(pic, (3,-0.25)--(3,1.25),GRAYSTRIPE);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.35));
label(pic, "\str{1}",(1,1.35));
label(pic, "\str{0}",(2,1.35));
label(pic, "\str{0}",(3,1.35));
draw(pic, (0, 1.25)--(4.00, 1.25),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(4.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "$3$",(3.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ......................................
picture pic;
int picnum = 7;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  // label(pic, "\scriptsize 2", (0.60,0.4), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  // label(pic, "\scriptsize 11", (0.60,1.20), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.00),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after first input
label(pic, "$\vdash$",(1.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g1}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.25),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(1.50,0.50),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after second input
label(pic, "$\vdash$",(2.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,0.50),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,1.00),p);
draw(pic, (2,-0.25)--(2,1.25),GRAYSTRIPE);

// // Add action after third input
// label(pic, "$\vdash$",(3.00,0),p);
// //  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
// label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.00),p);
// label(pic, yield_t_north*"$\vdash$",(3.50,0.25),p);
// //  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.50),p);
// label(pic, "$\vdash$",(3.00,1.00),p);
// //  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
// label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(3.50,1.00),p);
// draw(pic, (3,-0.25)--(3,1.25),GRAYSTRIPE);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.35));
label(pic, "\str{1}",(1,1.35));
label(pic, "\str{0}",(2,1.35));
label(pic, "\str{0}",(3,1.35));
draw(pic, (0, 1.25)--(4.00, 1.25),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(4.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "$3$",(3.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .....................................
picture pic;
int picnum = 8;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  // label(pic, "\scriptsize 2", (0.60,0.4), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  // label(pic, "\scriptsize 11", (0.60,1.20), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.00),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after first input
label(pic, "$\vdash$",(1.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g1}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.25),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(1.50,0.50),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after second input
label(pic, "$\vdash$",(2.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,0.50),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,1.00),p);
draw(pic, (2,-0.25)--(2,1.25),GRAYSTRIPE);

// Add action after third input
label(pic, "$\vdash$",(3.00,0),p);
//  label(pic, "\scriptsize 3", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(3.50,0.25),p);
//  label(pic, "\scriptsize 7", (2.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.50),p);
label(pic, "$\vdash$",(3.00,1.00),p);
//  label(pic, "\scriptsize 9", (2.00,0.85), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(3.50,1.00),p);
draw(pic, (3,-0.25)--(3,1.25),GRAYSTRIPE);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.35));
label(pic, "\str{1}",(1,1.35));
label(pic, "\str{0}",(2,1.35));
label(pic, "\str{0}",(3,1.35));
draw(pic, (0, 1.25)--(4.00, 1.25),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(4.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "$3$",(3.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .........................................
picture pic;
int picnum = 9;

real u = 2.75cm;
real v = 0.618*u;
unitsize(pic,u,v);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
transform yield_t_north=shift(0pt,0pt)*rotate(90)*shift(0pt,0pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{$\bot$}$",(0.5,0),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.25),p);
  label(pic, "\scriptsize 2", (0.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{$\bot$}$}",(0.5,0.5),p);
label(pic, yield_t_north*"$\vdash$",(0.5,0.75),p);
  label(pic, "\scriptsize 11", (0.60,0.75), background_color);
label(pic, "\makebox[\width][l]{$q_2,\text{$\bot$}$}",(0.5,1.00),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after first input
label(pic, "$\vdash$",(1.00,0),p);
  label(pic, "\scriptsize 1", (1.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g1}$\bot$}$}",(1.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(1.50,0.25),p);
  label(pic, "\scriptsize 8", (1.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(1.50,0.50),p);
draw(pic, (1,-0.25)--(1,1.25),GRAYSTRIPE);

// Add action after second input
label(pic, "$\vdash$",(2.00,0),p);
  label(pic, "\scriptsize 4", (2.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(2.50,0.50),p);
  label(pic, "\scriptsize 7", (2.60,0.50), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g1}$\bot$}$}",(2.50,1.00),p);
draw(pic, (2,-0.25)--(2,1.25),GRAYSTRIPE);

// Add action after third input
label(pic, "$\vdash$",(3.00,0),p);
  label(pic, "\scriptsize 3", (3.00,-0.15), background_color);
label(pic, "\makebox[\width][l]{$q_0,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.00),p);
label(pic, yield_t_north*"$\vdash$",(3.50,0.25),p);
  label(pic, "\scriptsize 7", (3.60,0.25), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g0}\str{g0}\str{g1}$\bot$}$}",(3.50,0.50),p);
label(pic, "$\vdash$",(3.00,1.00),p);
  label(pic, "\scriptsize 9", (3.00,0.85), background_color);
label(pic, "\makebox[\width][l]{$q_1,\text{\str{g1}$\bot$}$}",(3.50,1.00),p);
draw(pic, (3,-0.25)--(3,1.25),GRAYSTRIPE);

// Legend at top of graphic
label(pic, "\makebox[0pt][l]{\textit{Input:}}",(0,1.35));
label(pic, "\str{1}",(1,1.35));
label(pic, "\str{0}",(2,1.35));
label(pic, "\str{0}",(3,1.35));
draw(pic, (0, 1.25)--(4.00, 1.25),black+linewidth(0.4));
// At bottom of graphic
draw(pic, (-0,-0.25)--(4.00,-0.25),black+linewidth(0.4));
label(pic, "$0$",(0.5, -0.35));
label(pic, "$1$",(1.5, -0.35));
label(pic, "$2$",(2.5, -0.35));
label(pic, "$3$",(3.5, -0.35));
label(pic, "\makebox[0pt][l]{\textit{Step:}}",(0,-0.35));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




