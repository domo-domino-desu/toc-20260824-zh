// machine.asy
//  circle diagram of a TM

import settings;
// settings.dir="..";  // make it able to see jh.asy 
// settings.outformat="pdf";  // some kind of weird bug; if you uncomment this, and leave in the shipout(..,format="pdf") then it does not trim whitespace
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
cd("../../../asy/share");  // so it can see tm_share.asy
import tm_share;
import tape;
cd("");



string OUTPUT_FN = "machine%02d";

// ============== Finite state machine picture ================
picture pic;
int picnum = 0;
unitsize(pic,22.5pt);
// size3(pic,0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

triple view_from = (32,12,10);
currentprojection=orthographic(view_from);
currentlight=light(view_from);

tm_draw(pic=pic);
tm_draw_start_button(pic);
tm_draw_halt_light(pic,tm_halt_label="\textsf{Accept}");
tm_draw_rt_tape(pic,"1001010");

draw((0,0)--(1,1),red);
dot(pic,(0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== FSM with an attached pushdown stack ================
picture pic;
int picnum = 1;
unitsize(pic,22.5pt);
// size(pic,0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

triple view_from = (32,12,10);
currentprojection=orthographic(view_from);
currentlight=light(view_from);

triple eb_origin = (-4,-2,0);  // where external box is shifted
draw_wire(pic,tm_origin=tm_origin,eb_origin=eb_origin);

eb_box_outside=tm_box_outside;
transform3 t=shift(eb_origin);
eb_draw(pic, t=t, eb_label="\textsf{LIFO}", eb_material=eb_box_outside);
tm_draw_lf_tape(pic);
tm_draw(pic);
tm_draw_start_button(pic);
tm_draw_halt_light(pic, tm_halt_label="\textsf{Accept}");
tm_draw_rt_tape(pic, "[[][]]");

dot((0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Pushdown stack ================

// draw a stack character 
void draw_stackchar(picture pic=currentpicture, pair loc=(0,0), string c=""){
  real wd=0.025cm;
  real ht=0.6*wd;
  
  path b = (-0.5*wd,-0.5*ht)--(0.5*wd,-0.5*ht)--(0.5*wd,0.5*ht)--(-0.5*wd,0.5*ht)--cycle;
  filldraw(pic,shift(loc)*b,fillpen=backgroundcolor,drawpen=boldcolor);
  label(pic, c, loc);
}

//............
picture pic;
int picnum = 2;
unitsize(pic,1cm);

real u=1;
real v=0.6*u;
real stack_separator = 0.0*u;

path stack = (-0.6*u,0*v) -- (-0.6*u,-4.6*v) -- (0.6*u,-4.6*v) -- (0.6*u,0*v) -- cycle;  
fill(pic, stack, lightcolor);

draw_stackchar(pic, (0,0*v), "\str{g3}");
draw_stackchar(pic, (0,(-1*v)-stack_separator), "\str{g0}");
draw_stackchar(pic, (0,-2*v-stack_separator), "\str{g2}");
// dot(pic,(0,-4.5*v),invisible);  // keep all stacks same hgt

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


//............
picture pic;
int picnum = 3;
unitsize(pic,1cm);

real u=1;
real v=0.6*u;
real stack_separator = 0.0*u;

path stack = (-0.6*u,0*v) -- (-0.6*u,-4.6*v) -- (0.6*u,-4.6*v) -- (0.6*u,0*v) -- cycle;  
fill(pic, stack, lightcolor);

draw_stackchar(pic, (0,(0*v)), "\str{g1}");
draw_stackchar(pic, (0,-1*v-stack_separator), "\str{g3}");
draw_stackchar(pic, (0,-2*v-stack_separator), "\str{g0}");
draw_stackchar(pic, (0,-3*v-stack_separator), "\str{g2}");
// dot(pic,(0,-4.5*v),invisible);  // keep all stacks same hgt

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


//............
picture pic;
int picnum = 4;
unitsize(pic,1cm);

real u=1;
real v=0.6*u;
real stack_separator = 0.0*u;

path stack = (-0.6*u,0*v) -- (-0.6*u,-4.6*v) -- (0.6*u,-4.6*v) -- (0.6*u,0*v) -- cycle;  
fill(pic, stack, lightcolor);

draw_stackchar(pic, (0,(0*v)), "\str{g0}");
draw_stackchar(pic, (0,-1*v-stack_separator), "\str{g1}");
draw_stackchar(pic, (0,-2*v-stack_separator), "\str{g3}");
draw_stackchar(pic, (0,-3*v-stack_separator), "\str{g0}");
draw_stackchar(pic, (0,-4*v-stack_separator), "\str{g2}");
// dot(pic,(0,-4.5*v),invisible);  // keep all stacks same hgt

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


//............
picture pic;
int picnum = 5;
unitsize(pic,1cm);

real u=1;
real v=0.6*u;
real stack_separator = -0.0*u;

path stack = (-0.6*u,0*v) -- (-0.6*u,-4.6*v) -- (0.6*u,-4.6*v) -- (0.6*u,0*v) -- cycle;  
fill(pic, stack, lightcolor);

draw_stackchar(pic, (0,(0*v)), "\str{g1}");
draw_stackchar(pic, (0,-1*v-stack_separator), "\str{g3}");
draw_stackchar(pic, (0,-2*v-stack_separator), "\str{g0}");
draw_stackchar(pic, (0,-3*v-stack_separator), "\str{g2}");
// draw_stackchar(pic, (0,4*v+stack_separator), "$g_1$");
// dot(pic,(0,-4.5*v),invisible);  // keep all stacks same hgt
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// --------- Evolution of pda calculation ----------
real tape_length = 100pt;
real stack_length = 60pt;
real separator = 20pt;

picture pic;
int picnum=6;
pic=pda(" [[]][]",1,"$q_0$", new string[] {"$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=7;
pic=pda(" [[]][]",2,"$q_0$", new string[] {"\str{g0}", "$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=8;
pic=pda(" [[]][]",3,"$q_0$", new string[] {"\str{g0}", "\str{g0}", "$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=9;
pic=pda(" [[]][]",4,"$q_0$", new string[] {"\str{g0}", "$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=10;
pic=pda(" [[]][]",5,"$q_0$", new string[] {"$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=11;
pic=pda(" [[]][]",6,"$q_0$", new string[] {"\str{g0}", "$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=12;
pic=pda(" [[]][]",7,"$q_0$", new string[] {"$\bot$"},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

picture pic;
int picnum=13;
pic=pda(" [[]][]",8,"$q_1$", new string[] {},tape_length,stack_length,separator);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

