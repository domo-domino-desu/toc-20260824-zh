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
unitsize(pic,1.5cm,0.8cm);

pen p;
pen GRAYPEN = gray(0.8);
pen GRAYSTRIPE = linewidth(0.5cm)+squarecap+gray(0.95);

transform yield_t_down=shift(-1.65pt,-0.33pt)*rotate(-22.5)*shift(1.65pt,0.33pt);
transform yield_t_up=shift(-1.65pt,-0.33pt)*rotate(60)*shift(1.65pt,0.33pt);
setdefaultparsetreestyles();

p=MAINPEN;
// Action to left of first input
label(pic, "$q_0,\text{`$\bot$'}$",(0,0),p);
// draw(pic, (0.5,4.85)--(0.5,-1),GRAYSTRIPE);
// label(pic, yield_t_down*"$\vdash$",(0.5,-0.25),p);
label(pic, yield_t_up*"$\vdash$",(0.15,0.45),p);
label(pic, "\makebox[\width][l]{$q_1,\text{`$\bot$'}$}",(0.30,1.00),p);
label(pic, yield_t_up*"$\vdash$",(0.50,1.50),p);
label(pic, "\makebox[\width][l]{$q_1,\text{`$\bot$'}$}",(0.60,2.10),p);

// // Add action up to second input
label(pic, "$\vdash$",(1.00,0),p);
label(pic, "\makebox[\width][l]{$q_0,\text{`\str{g0}$\bot$'}$}",(1.75,0.00),p);
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
label(pic, "\makebox[0pt][c]{\textit{Input}}",(2.5,5.45));
// draw(pic, (-0.5,5.15)--(5.5,5.15),black+linewidth(0.4));
label(pic, "\str{0}",(0.5, 5));
label(pic, "\str{0}",(1.5, 5));
draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));
// at bottom of graphic
draw(pic, (-0.5,-1)--(5.5,-1),black+linewidth(0.4));
label(pic, "$0$",(0, -1.3));
label(pic, "$1$",(1, -1.3));
label(pic, "$2$",(2, -1.3));
label(pic, "\makebox[0pt][c]{\textit{Step}}",(2.5,-1.65));
//draw(pic, (-0.5, 4.75)--(5.5, 4.75),black+linewidth(0.4));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




