// pda.asy
//  Diagrams for Pushdown machines

import settings;
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


string OUTPUT_FN = "pda%02d";


path ellipse(pair c, real a, real b)
{
  return shift(c)*scale(a,b)*unitcircle;
}

// ============== Chomsky languages ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);

real u = 2.5cm;
real v = 0.7*u;
// universal set
path universe = (0,0)--(1.25u,0)--(1.25u,v)--(0,v)--cycle;
draw(pic,universe,MAINPEN);
// label("All languages over $\B$",point(universe,1.8),E);

// FSA's
real rotation_angle = 20;
pair regular_langs_center = (0.2u,0.2v);
real regular_langs_major_axis = 0.15u;
real regular_langs_minor_axis = 0.12v;
path regular_langs = ellipse(regular_langs_center,
			     regular_langs_major_axis,
			     regular_langs_minor_axis);

// dot(pic,point(regular_langs,4),green);
// PDA langs
pair far_end_pda = xscale(1.45)*point(regular_langs,4);
path pda_langs = subpath(regular_langs,1.25,2.75)..far_end_pda..cycle;

pair far_end_npda = xscale(2.0)*point(regular_langs,4);
path npda_langs = subpath(regular_langs,1.20,2.80)..far_end_npda..cycle;

// TM langs
pair far_end_tm = xscale(3.0)*point(regular_langs,4);
path tm_langs = subpath(regular_langs,1.20,2.80)..far_end_tm..cycle;

// draw them
pair oset = (-0.00075u,0v);
transform r = rotate(rotation_angle,regular_langs_center);
filldraw(pic,r*tm_langs,fillpen=highlight_light+opacity(0.5),drawpen=MAINPEN);
label(pic,"\tiny $D$",point(tm_langs,3.35),oset,p=NODEPEN);
filldraw(pic,r*npda_langs,fillpen=bold_light+opacity(0.5),drawpen=MAINPEN);
label(pic,"\tiny $C$",point(npda_langs,3.35),oset,p=NODEPEN);
filldraw(pic,r*pda_langs,fillpen=lightcolor,drawpen=MAINPEN);
label(pic,"\tiny $B$",point(pda_langs,3.35),oset,p=NODEPEN);
filldraw(pic,r*regular_langs,fillpen=backgroundcolor+opacity(0.5),drawpen=MAINPEN);
label(pic,"\tiny $A$",regular_langs_center,p=NODEPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


