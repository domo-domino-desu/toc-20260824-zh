// circuit.asy
//  Draw circuits for chapter on complexity

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jh;
import circuit;
cd("");
// cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
// import node;
// cd("");


string OUTPUT_FN = "circuit%03d";

// nodestyle ns_bleachedbg=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 				  drawfn=FillDrawer(backgroundcolor+white,black));
// nodestyle ns_bg=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 			  drawfn=FillDrawer(backgroundcolor,black));
// nodestyle ns_bleachedbold=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 				    drawfn=FillDrawer(bold_light,black));
// nodestyle ns_light=nodestyle(xmargin=1pt,textpen=NODEPEN,
// 			     drawfn=FillDrawer(lightcolor,black));

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
label(pic,"$P(x_0,x_1,x_2)$",(7*u,0*v),N);

// layer 0
filldraw(pic,shift(-1*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_2$}",(-1*u,8*v));
filldraw(pic,shift(-0.5*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_1$}",(-0.5*u,8*v));
filldraw(pic,shift(0*u,8*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"\smash[b]{$x_0$}",(0*u,8*v));

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






