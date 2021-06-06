// circuit.asy
//  Draw circuits for chapter on complexity

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
import jhcircuit;


string OUTPUT_FN = "circuit%03d";

// nodestyle ns_bleachedbg=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 				  drawfn=FillDrawer(backgroundcolor+white,black));
// nodestyle ns_bg=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 			  drawfn=FillDrawer(backgroundcolor,black));
// nodestyle ns_bleachedbold=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 				    drawfn=FillDrawer(bold_light,black));
// nodestyle ns_light=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 			     drawfn=FillDrawer(lightcolor,black));

// defaultnodestyle=nodestyle(xmargin=1pt,
// 			   textpen=fontsize(7pt),
// 			   drawfn=FillDrawer(verylightcolor,boldcolor));

// defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
// 			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,red)))
  ;
// Pen for edges when Labelled
// pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;


// // 
// defaultlayoutrel = false;

pen circuitcolor = boldcolor;
pen circuitpen = DARKPEN+squarecap+circuitcolor;


// Return a source gate path
path[] sourcegate(real wd) {
  return circle((0,0),wd/2);
};


// ======================== circuit-eval =============
// compute the sum of the bits mod 3.
int picnum = 0;
picture pic;
unitsize(pic,1cm);
// horiz and vert units
real u = 1.5;
real v = 0.55*u;

// size of gates
real and_gate_size = 0.65;
real or_gate_size = and_gate_size;
real not_gate_size = 0.9*and_gate_size;
real source_gate_size = 0.9*and_gate_size;

// wires
real sep = 0.25; // how far apart on the gate to make the wires (this is half)
// bus
path x0_bus = (0*u,4*v)--(0*u,0*v-2*sep*source_gate_size);
  draw(pic,x0_bus,circuitpen);
path x1_bus = (-0.5*u,4*v)--(-0.5*u,0*v-2*sep*source_gate_size);
  draw(pic,x1_bus,circuitpen);
path x2_bus = (-1*u,4*v)--(-1*u,0*v-2*sep*source_gate_size);
  draw(pic,x2_bus,circuitpen);
path x3_bus = (-1.5*u,4*v)--(-1.5*u,0*v-2*sep*source_gate_size);
  draw(pic,x3_bus,circuitpen);

// layer 0 to layer 1
path x0_to_xor=(0*u,0*v-sep*source_gate_size)
                --(1*u,0*v-sep*source_gate_size);
  draw(pic,x0_to_xor,circuitpen);
  dot(pic,(0*u,0*v-sep*source_gate_size));
path x1_to_xor=(-0.5*u,0*v+sep*source_gate_size)
                --(1*u,0*v+sep*source_gate_size);
  draw(pic,x1_to_xor,circuitpen);
  dot(pic,(-0.5*u,0*v+sep*source_gate_size));
path x2_to_xor=(-1*u,1*v-sep*source_gate_size)
                --(1*u,1*v-sep*source_gate_size);
  draw(pic,x2_to_xor,circuitpen);
  dot(pic,(-1*u,1*v-sep*source_gate_size));
path x3_to_xor=(-1.5*u,1*v+sep*source_gate_size)
                --(1*u,1*v+sep*source_gate_size);
  draw(pic,x3_to_xor,circuitpen);
  dot(pic,(-1.5*u,1*v+sep*source_gate_size));
path x0_to_and=(0*u,2*v-sep*source_gate_size)
                --(1*u,2*v-sep*source_gate_size);
  draw(pic,x0_to_and,circuitpen);
  dot(pic,(0*u,2*v-sep*source_gate_size));
path x1_to_and=(-0.5*u,2*v+sep*source_gate_size)
                --(1*u,2*v+sep*source_gate_size);
  draw(pic,x1_to_and,circuitpen);
  dot(pic,(-0.5*u,2*v+sep*source_gate_size));
path x2_to_and=(-1*u,3*v-sep*source_gate_size)
                --(1*u,3*v-sep*source_gate_size);
  draw(pic,x2_to_and,circuitpen);
  dot(pic,(-1*u,3*v-sep*source_gate_size));
path x3_to_and=(-1.5*u,3*v+sep*source_gate_size)
                --(1*u,3*v+sep*source_gate_size);
  draw(pic,x3_to_and,circuitpen);
  dot(pic,(-1.5*u,3*v+sep*source_gate_size));

// layer 1 to layer 2
path xor_bot_to_and=(1*u,0*v)
                --(1.5*u,0*v)
                --(1.5*u,0.5*v-sep*source_gate_size)
                --(2*u,0.5*v-sep*source_gate_size);
  draw(pic,xor_bot_to_and,circuitpen);
path xor_top_to_and=(1*u,1*v)
                --(1.5*u,1*v)
                --(1.5*u,0.5*v+sep*source_gate_size)
                --(2*u,0.5*v+sep*source_gate_size);
  draw(pic,xor_top_to_and,circuitpen);
path and_bot_to_and=(1*u,2*v)
                --(1.5*u,2*v)
                --(1.5*u,2.5*v-sep*source_gate_size)
                --(2*u,2.5*v-sep*source_gate_size);
  draw(pic,and_bot_to_and,circuitpen);
path and_top_to_and=(1*u,3*v)
                --(1.5*u,3*v)
                --(1.5*u,2.5*v+sep*source_gate_size)
                --(2*u,2.5*v+sep*source_gate_size);
  draw(pic,and_top_to_and,circuitpen);


// layer 2 to layer 3
path and_to_equiv=(2*u,0.5*v)
                --(2.5*u,0.5*v)
                --(2.5*u,1.5*v-sep*source_gate_size)
                --(3*u,1.5*v-sep*source_gate_size);
  draw(pic,and_to_equiv,circuitpen);
path or_to_equiv=(2*u,2.5*v)
                --(2.5*u,2.5*v)
                --(2.5*u,1.5*v+sep*source_gate_size)
                --(3*u,1.5*v+sep*source_gate_size);
  draw(pic,or_to_equiv,circuitpen);

// layer 3 and out
path exit_wire = (3*u,1.5*v)--(5*u,1.5*v);
  draw(pic,exit_wire,circuitpen);
  label(pic,"$M(x_0,x_1,x_2,x_3)$",(4.25*u,1.5*v),N);

// layer 0
filldraw(pic,shift(0*u,4*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_0$}",(0*u,4*v));
filldraw(pic,shift(-0.5*u,4*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_1$}",(-0.5*u,4*v));
filldraw(pic,shift(-1*u,4*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_2$}",(-1*u,4*v));
filldraw(pic,shift(-1.5*u,4*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_3$}",(-1.5*u,4*v));

// layer 1
filldraw(pic,shift(1*u,0*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\oplus$}",(1*u,0*v));
filldraw(pic,shift(1*u,1*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\oplus$}",(1*u,1*v));
filldraw(pic,shift(1*u,2*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\wedge$}",(1*u,2*v));
filldraw(pic,shift(1*u,3*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\wedge$}",(1*u,3*v));

// layer 2
filldraw(pic,shift(2*u,0.5*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\wedge$}",(2*u,0.5*v));
filldraw(pic,shift(2*u,2.5*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\vee$}",(2*u,2.5*v));

// layer 3
filldraw(pic,shift(3*u,1.5*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$\equiv$}",(3*u,1.5*v));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ......... sum of bits is even ....................
int picnum = 1;
picture pic;
unitsize(pic,1cm);
// horiz and vert units
real u = 1.4;
real v = 0.6*u;

// size of gates
real and_gate_size = 0.65;
real or_gate_size = and_gate_size;
real not_gate_size = 0.5*and_gate_size;
real source_gate_size = 0.9*and_gate_size;

// wires
real sep = 0.3; // how far apart on the gate to make the wires (this is half)
// layer 0 to layer 2
//   first clause
path x0_bus=(0*u,8*v)--(0*u,0*v-2*sep*and_gate_size);   
   draw(pic,x0_bus,circuitpen);
path x1_bus=(-0.5*u,8*v)--(-0.5*u,0*v-2*sep*and_gate_size);
   draw(pic,x1_bus,circuitpen);
path x2_bus=(-1*u,8*v)--(-1*u,0*v-2*sep*and_gate_size);
   draw(pic,x2_bus,circuitpen);
path x0_to_first_clause=(0*u,6*v-sep*and_gate_size)
  --(3*u,6*v-sep*and_gate_size);
   draw(pic,x0_to_first_clause,circuitpen);
   dot(pic,(0*u,6*v-sep*and_gate_size));
path x1_to_first_clause=(-0.5*u,7*v-sep*and_gate_size)
  --(2*u,7*v-sep*and_gate_size);
   draw(pic,x1_to_first_clause,circuitpen);
   dot(pic,(-0.5*u,7*v-sep*and_gate_size));
path x2_to_first_clause=(-1*u,7*v+sep*and_gate_size)
  --(2*u,7*v+sep*and_gate_size);
   draw(pic,x2_to_first_clause,circuitpen);
   dot(pic,(-1*u,7*v+sep*and_gate_size));
// second clause
path x0_to_sec_clause=(0*u,4*v-sep*and_gate_size)
  --(3*u,4*v-sep*and_gate_size);
   draw(pic,x0_to_sec_clause,circuitpen);
   dot(pic,(0*u,4*v-sep*and_gate_size));
path x1_to_sec_clause=(-0.5*u,5*v-sep*and_gate_size)
  --(2*u,5*v-sep*and_gate_size);
   draw(pic,x1_to_sec_clause,circuitpen);
   dot(pic,(-0.5*u,5*v-sep*and_gate_size));
path x2_to_sec_clause=(-1*u,5*v+sep*and_gate_size)
  --(2*u,5*v+sep*and_gate_size);
   draw(pic,x2_to_sec_clause,circuitpen);
   dot(pic,(-1*u,5*v+sep*and_gate_size));
// third clause
path x0_to_third_clause=(0*u,2*v-sep*and_gate_size)
  --(3*u,2*v-sep*and_gate_size);
   draw(pic,x0_to_third_clause,circuitpen);
   dot(pic,(0*u,2*v-sep*and_gate_size));
path x1_to_third_clause=(-0.5*u,3*v-sep*and_gate_size)
  --(2*u,3*v-sep*and_gate_size);
   draw(pic,x1_to_third_clause,circuitpen);
   dot(pic,(-0.5*u,3*v-sep*and_gate_size));
path x2_to_third_clause=(-1*u,3*v+sep*and_gate_size)
  --(2*u,3*v+sep*and_gate_size);
   draw(pic,x2_to_third_clause,circuitpen);
   dot(pic,(-1*u,3*v+sep*and_gate_size));
// fourth clause
path x0_to_fourth_clause=(0*u,0*v-sep*and_gate_size)
  --(3*u,0*v-sep*and_gate_size);
   draw(pic,x0_to_fourth_clause,circuitpen);
   dot(pic,(0*u,0*v-sep*and_gate_size));
path x1_to_fourth_clause=(-0.5*u,1*v-sep*and_gate_size)
  --(2*u,1*v-sep*and_gate_size);
   draw(pic,x1_to_fourth_clause,circuitpen);
   dot(pic,(-0.5*u,1*v-sep*and_gate_size));
path x2_to_fourth_clause=(-1*u,1*v+sep*and_gate_size)
  --(2*u,1*v+sep*and_gate_size);
   draw(pic,x2_to_fourth_clause,circuitpen);
   dot(pic,(-1*u,1*v+sep*and_gate_size));

// layer 2 to layer 3
// first clause
path first_and_to_and=(2*u,7*v)
  --(2.5*u,7*v)
  --(2.5*u,6*v+sep*and_gate_size)
  --(3*u,6*v+sep*and_gate_size);
   draw(pic,first_and_to_and,circuitpen);
// second clause
path sec_and_to_and=(2*u,5*v)
  --(2.5*u,5*v)
  --(2.5*u,4*v+sep*and_gate_size)
  --(3*u,4*v+sep*and_gate_size);
   draw(pic,sec_and_to_and,circuitpen);
// third clause
path third_and_to_and=(2*u,3*v)
  --(2.5*u,3*v)
  --(2.5*u,2*v+sep*and_gate_size)
  --(3*u,2*v+sep*and_gate_size);
   draw(pic,third_and_to_and,circuitpen);
// fourth clause
path fourth_and_to_and=(2*u,1*v)
  --(2.5*u,1*v)
  --(2.5*u,0*v+sep*and_gate_size)
  --(3*u,0*v+sep*and_gate_size);
   draw(pic,fourth_and_to_and,circuitpen);

// layer 5 to layers 4, 5, 6
// to layer 4
path first_to_top_or=(3*u,6*v)
  --(3.5*u,6*v)
  --(3.5*u,4*v+sep*and_gate_size)
  --(4*u,4*v+sep*and_gate_size);
   draw(pic,first_to_top_or,circuitpen);
path second_to_top_or=(3*u,4*v)
  --(3.5*u,4*v)
  --(3.5*u,4*v-sep*and_gate_size)
  --(4*u,4*v-sep*and_gate_size);
   draw(pic,second_to_top_or,circuitpen);
// to layer 5
path top_or_to_mid_or=(4*u,4*v)
  --(4.5*u,4*v)
  --(4.5*u,2*v+sep*and_gate_size)
  --(5*u,2*v+sep*and_gate_size);
   draw(pic,top_or_to_mid_or,circuitpen);
path third_to_mid_or=(3*u,2*v)
  --(3.5*u,2*v)
  --(3.5*u,2*v-sep*and_gate_size)
  --(5*u,2*v-sep*and_gate_size);
   draw(pic,third_to_mid_or,circuitpen);
// to layer 6
path mid_or_to_bot_or=(5*u,2*v)
  --(5.5*u,2*v)
  --(5.5*u,0*v+sep*and_gate_size)
  --(6*u,0*v+sep*and_gate_size);
   draw(pic,mid_or_to_bot_or,circuitpen);
path fourth_to_bot_or=(3*u,0*v)
  --(3.5*u,0*v)
  --(3.5*u,0*v-sep*and_gate_size)
  --(6*u,0*v-sep*and_gate_size);
   draw(pic,fourth_to_bot_or,circuitpen);
// edit wire
path exit_wire=(6*u,0*v)
  --(7.5*u,0*v);
   draw(pic,exit_wire,circuitpen);
label(pic,"$f(b_0,b_1,b_2)$",(7*u,0*v),N);

// layer 0
filldraw(pic,shift(-1*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$b_2$}",(-1*u,8*v));
filldraw(pic,shift(-0.5*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$b_1$}",(-0.5*u,8*v));
filldraw(pic,shift(0*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$b_0$}",(0*u,8*v));

// layer 1
// first clause
filldraw(pic,shift(1*u,7*v+sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(1*u,7*v-sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(1*u,6*v-sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
// second clause
filldraw(pic,shift(1*u,5*v+sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
// third clause
filldraw(pic,shift(1*u,3*v-sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
// fourth clause
filldraw(pic,shift(1*u,3*v-sep*and_gate_size)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);

// layer 2
filldraw(pic,shift(2*u,7*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(2*u,5*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(2*u,3*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(2*u,1*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);

// layer 3
filldraw(pic,shift(3*u,6*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(3*u,4*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(3*u,2*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(3*u,0*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);

// layer 4, 5, 6
filldraw(pic,shift(4*u,4*v)*orgate(or_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(5*u,2*v)*orgate(or_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(6*u,0*v)*orgate(or_gate_size),drawpen=circuitpen,fillpen=white);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........ AND gate ...............
int picnum = 2;
picture pic;
unitsize(pic,1cm);

// Have to repeat these because of the unitsize?
// horiz and vert units
real u = 1.5;
real v = 0.55*u;

// size of gates
real and_gate_size = 0.3;
real or_gate_size = and_gate_size;
real not_gate_size = 0.9*and_gate_size;
real source_gate_size = 0.9*and_gate_size;


// AND gate
draw(pic,andgate(and_gate_size));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ........ OR gate ...............
int picnum = 3;
picture pic;
unitsize(pic,1cm);

// Have to repeat these because of the unitsize?
// horiz and vert units
real u = 1.5;
real v = 0.55*u;

// size of gates
real and_gate_size = 0.3;
real or_gate_size = and_gate_size;
real not_gate_size = 0.9*and_gate_size;
real source_gate_size = 0.9*and_gate_size;

// OR gate
draw(pic,orgate(or_gate_size));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ........ NOT gate ...............
int picnum = 4;
picture pic;
unitsize(pic,1cm);

// Have to repeat these because of the unitsize?
// horiz and vert units
real u = 1.5;
real v = 0.55*u;

// size of gates
real and_gate_size = 0.3;
real or_gate_size = and_gate_size;
real not_gate_size = 0.9*and_gate_size;
real source_gate_size = 0.9*and_gate_size;

// NOT gate
draw(pic,notgate(not_gate_size));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======== Node circuits ====================

// ........ compute the sum of the bits mod 3. ...............
int picnum = 5;
picture pic;
// unitsize(pic,1cm);

setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

defaultlayoutrel = false;  // not relative layout

node b0=ncircle("$b_0$"),
     b1=ncircle("$b_1$"),
     b2=ncircle("$b_2$"),
     b3=ncircle("$b_3$"),
     and1=ncircle("$\wedge$"),
     and2=ncircle("$\wedge$"),
     and3=ncircle("$\wedge$"),
     xor1=ncircle("$\oplus$"),
     xor2=ncircle("$\oplus$"),
     or1=ncircle("$\vee$"),
     equiv=ncircle("$\equiv$"),
     exit=nbox("$f(b_0,b_1,b_2,b_3)$",ns_noborder);

// calculate nodes position
real u=1.5cm;
real v=0.55*u;
vlayout(1*v, b0, b1, b2, b3);
hlayout(1*u, b0, xor1);
vlayout(1*v, xor1, and1, xor2, and2);
and3.pos=(xor1.pos.x+1*u, (xor1.pos.y+and1.pos.y)/2);
or1.pos=(and2.pos.x+1*u, (xor2.pos.y+and2.pos.y)/2);
equiv.pos = (and3.pos.x+1*u, (and3.pos.y+or1.pos.y)/2);
hlayout(1*u, equiv, exit);

// draw edges
draw(pic,
     (b0--xor1),
     (b0--and1),
     (b1--xor1),
     (b1--and1),
     (b2--xor2),
     (b2--and2),
     (b3--xor2),
     (b3--and2),
     (xor1--and3),
     (xor2--and3),
     (and1--or1),
     (and2--or1),
     (and3--equiv),
     (or1--equiv)
     // (equiv--exit)
);

// draw nodes
draw(pic,
     b0, b1, b2, b3,
     and1, and2, and3, xor1, xor2, or1, equiv, exit
     );


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........ sum of the bits is even ...............
int picnum = 6;
picture pic;
// unitsize(pic,1cm);

setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

defaultlayoutrel = false;  // not relative layout

node b0=ncircle("$b_0$"),
     b1=ncircle("$b_1$"),
     b2=ncircle("$b_2$"),
     clause1_and1=ncircle("$f_0$"),
     clause1_and2=ncircle("$f_1$"),
     clause2_and1=ncircle("$f_2$"),
     clause2_and2=ncircle("$\wedge$"),
     clause3_and1=ncircle("$f_1$"),
     clause3_and2=ncircle("$\wedge$"),
     clause4_and1=ncircle("$\wedge$"),
     clause4_and2=ncircle("$f_1$"),
     or1=ncircle("$\vee$"),
     or2=ncircle("$\vee$"),
     or3=ncircle("$\vee$"),
     exit=nbox("$f(b_0,b_1,b_2)$",ns_noborder);

// calculate nodes position
real u=1.25cm;
real v=0.7*u;

vlayout(2*v, clause1_and1,  clause2_and1, clause3_and1, clause4_and1);
clause1_and2.pos = clause1_and1.pos+(1*u,-1*v);
vlayout(2*v, clause1_and2,  clause2_and2, clause3_and2, clause4_and2);
hlayout(1*u, clause2_and2, or1);
hlayout(2*u, clause3_and2, or2);
hlayout(3*u, clause4_and2, or3);
hlayout(1*u, or3, exit);
b0.pos = clause2_and1.pos-(1.5*u,-0.5*v);
vlayout(2*v, b0, b1, b2);

// draw edges
draw(pic,
     (b0--clause1_and2),
     (b0--clause2_and2),
     (b0--clause3_and2),
     (b0--clause4_and2),
     (b1--clause1_and1),
     (b1--clause2_and1),
     (b1--clause3_and1),
     (b1--clause4_and1),
     (b2--clause1_and1),
     (b2--clause2_and1),
     (b2--clause3_and1),
     (b2--clause4_and1),
     (clause1_and1--HV--clause1_and2),
     (clause2_and1--HV--clause2_and2),
     (clause3_and1--HV--clause3_and2),
     (clause4_and1--HV--clause4_and2),
     (clause1_and2--HV--or1),
     (clause2_and2--or1),
     (or1--HV--or2),
     (clause3_and2--or2),
     (or2--HV--or3),
     (clause4_and2--or3)
);

// draw nodes
draw(pic,
     b0, b1, b2,
     clause1_and1, clause1_and2,
     clause2_and1, clause2_and2,
     clause3_and1, clause3_and2,
     clause4_and1, clause4_and2,
     or1, or2, or3, exit
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






