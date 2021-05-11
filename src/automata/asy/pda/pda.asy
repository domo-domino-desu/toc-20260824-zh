// pda.asy
//  Diagrams for Pushdown machines

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy/");
import jhnode;
cd("");
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
// cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
// import node;
// cd("");


string OUTPUT_FN = "pda%02d";


path ellipse(pair c, real majoraxis, real minoraxis)
{
  return shift(c)*scale(majoraxis,minoraxis)*unitcircle;
}

// ============== Chomsky languages ================
// picture pic;
// int picnum = 0;
// unitsize(pic,1pt);

// real u = 2.5cm;
// real v = 0.7*u;
// // universal set
// path universe = (0,0)--(1.25u,0)--(1.25u,v)--(0,v)--cycle;
// draw(pic,universe,MAINPEN);
// // label("All languages over $\B$",point(universe,1.8),E);

// // FSA's
// real rotation_angle = 20;
// pair regular_langs_center = (0.2u,0.2v);
// real regular_langs_major_axis = 0.15u;
// real regular_langs_minor_axis = 0.12v;
// path regular_langs = ellipse(regular_langs_center,
// 			     regular_langs_major_axis,
// 			     regular_langs_minor_axis);

// // dot(pic,point(regular_langs,4),green);
// // PDA langs
// pair far_end_pda = xscale(1.45)*point(regular_langs,4);
// path pda_langs = subpath(regular_langs,1.25,2.75)..far_end_pda..cycle;

// pair far_end_npda = xscale(2.0)*point(regular_langs,4);
// path npda_langs = subpath(regular_langs,1.20,2.80)..far_end_npda..cycle;

// // TM langs
// pair far_end_tm = xscale(3.0)*point(regular_langs,4);
// path tm_langs = subpath(regular_langs,1.20,2.80)..far_end_tm..cycle;

// // draw them
// pair oset = (-0.00075u,0v);
// transform r = rotate(rotation_angle,regular_langs_center);
// filldraw(pic,r*tm_langs,fillpen=highlight_light+opacity(0.5),drawpen=MAINPEN);
// label(pic,"\tiny $D$",point(tm_langs,3.35),oset,p=NODEPEN);
// filldraw(pic,r*npda_langs,fillpen=bold_light+opacity(0.5),drawpen=MAINPEN);
// label(pic,"\tiny $C$",point(npda_langs,3.35),oset,p=NODEPEN);
// filldraw(pic,r*pda_langs,fillpen=lightcolor,drawpen=MAINPEN);
// label(pic,"\tiny $B$",point(pda_langs,3.35),oset,p=NODEPEN);
// filldraw(pic,r*regular_langs,fillpen=backgroundcolor+opacity(0.5),drawpen=MAINPEN);
// label(pic,"\tiny $A$",regular_langs_center,p=NODEPEN);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ===========================================
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


