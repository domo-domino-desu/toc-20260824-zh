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
int picnum = 0;
picture pic;
unitsize(pic,1cm);
// horiz and vert units
real u = 1.5;
real v = 0.7*u;

// size of gates
real and_gate_size = 0.7;
real or_gate_size = and_gate_size;
real not_gate_size = 0.65;
real source_gate_size = 0.8*and_gate_size;

// wires
// layer 0 to layer 1
path x0_to_or=(0*u,0*v)
                 --(0.5*u,0*v)
                 --(0.5*u,0*v-(1/6)*or_gate_size)
                 --(1*u,0*v-(1/6)*or_gate_size);
  draw(pic,x0_to_or,circuitpen);
path x1_to_or=(0*u,1*v-(1/6)*source_gate_size)
                --(0.5*u,1*v-(1/6)*source_gate_size)
                --(0.5*u,0*v+(1/6)*or_gate_size)
                --(1*u,0*v+(1/6)*or_gate_size);
  draw(pic,x1_to_or,circuitpen);
path x1_to_and=(0*u,1*v+(1/6)*source_gate_size)
                --(0.5*u,1*v+(1/6)*source_gate_size)
                --(0.5*u,2*v-(1/6)*and_gate_size)
                --(1*u,2*v-(1/6)*and_gate_size);
  draw(pic,x1_to_and,circuitpen);
path x2_to_and=(0*u,2*v)
                --(0.5*u,2*v)
                --(0.5*u,2*v+(1/6)*and_gate_size)
                --(1*u,2*v+(1/6)*and_gate_size);
  draw(pic,x2_to_and,circuitpen);
// layer 1 to layer 2
path and_to_not=(1*u,2*v+(1/6)*and_gate_size)
                 --(1.5*u,2*v+(1/6)*and_gate_size)
                 --(1.5*u,2*v)
                 --(2*u,2*v);
  draw(pic,and_to_not,circuitpen);
path and_to_and=(1*u,2*v-(1/6)*and_gate_size)
                 --(1.5*u,2*v-(1/6)*and_gate_size)
                 --(1.5*u,0*v+(1/6)*and_gate_size)
                 --(2*u,0*v+(1/6)*and_gate_size);
  draw(pic,and_to_and,circuitpen);
path or_to_and=(1*u,0*v)
                 --(1.5*u,0*v)
                 --(1.5*u,0*v-(1/6)*and_gate_size)
                 --(2*u,0*v-(1/6)*and_gate_size);
  draw(pic,or_to_and,circuitpen);
// layer 2 to layer 3
path not_to_final_or=(2*u,2*v)
                 --(2.5*u,2*v)
                 --(2.5*u,1*v+(1/6)*or_gate_size)
                 --(3*u,1*v+(1/6)*or_gate_size);
  draw(pic,not_to_final_or,circuitpen);
path and_to_final_or=(2*u,0*v)
                 --(2.5*u,0*v)
                 --(2.5*u,1*v-(1/6)*or_gate_size)
                 --(3*u,1*v-(1/6)*or_gate_size);
  draw(pic,and_to_final_or,circuitpen);
// layer 3 and out
path final_or_to_infty=(3*u,1*v)
                 --(4*u,1*v);
  draw(pic,final_or_to_infty,circuitpen);
  label(pic,"$C(x_0,x_1,x_2)$",(4*u,1*v),N);

// layer 0
filldraw(pic,shift(0*u,2*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"{$x_2$}",(0*u,2*v));
filldraw(pic,shift(0*u,1*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"{$x_1$}",(0*u,1*v));
filldraw(pic,shift(0*u,0*v)*sourcegate(source_gate_size),drawpen=circuitpen,fillpen=white);
  label(pic,"{$x_0$}",(0*u,0*v));

// layer 1
filldraw(pic,shift(1*u,2*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(1*u,0*v)*orgate(or_gate_size),drawpen=circuitpen,fillpen=white);
// // layer 2
filldraw(pic,shift(2*u,2*v)*notgate(not_gate_size),drawpen=circuitpen,fillpen=white);
filldraw(pic,shift(2*u,0*v)*andgate(and_gate_size),drawpen=circuitpen,fillpen=white);
// // layer 3
filldraw(pic,shift(3*u,1*v)*orgate(or_gate_size),drawpen=circuitpen,fillpen=white);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






