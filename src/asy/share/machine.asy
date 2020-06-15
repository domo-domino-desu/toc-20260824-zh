// machine.asy
//  circle diagram of a TM

import settings;
// settings.dir="..";  // make it able to see jh.asy 
// settings.outformat="pdf";  // some kind of weird bug; if you uncomment this, and leave in the shipout(..,format="pdf") then it does not trim whitespace
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("..");
import settexpreamble;
cd("");
settexpreamble();
cd("..");
import jh;
cd("");
// cd("../../../asy/share");  // so it can see tm_share.asy
import tm_share;
import tape;
cd("");

string OUTPUT_FN = "machine%02d";

triple view_from = (32,12,10);

// ============== Turing machine picture ================
picture pic;
int picnum = 0;
unitsize(pic,22.5pt);
// size3(pic,0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

currentprojection=orthographic(view_from);
currentlight=light(view_from);

tm_draw_lf_tape(pic);
tm_draw(pic=pic);
tm_draw_start_button(pic);
tm_draw_halt_light(pic,tm_halt_label="\textsf{Halt}");
tm_draw_rt_tape(pic,"1001010 1001000");

// draw((0,0)--(1,1),red);
// dot(pic,(0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== TM with an K oracle ================
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

transform3 t=shift(eb_origin);
eb_draw(pic, t=t, eb_label="\textsf{K}");
tm_draw_lf_tape(pic);
tm_draw(pic);
tm_draw_start_button(pic);
tm_draw_halt_light(pic, tm_halt_label="\textsf{Accept}");
tm_draw_rt_tape(pic, "1001010 1001000");

// dot((0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Finite state machine picture ================
picture pic;
int picnum = 2;
unitsize(pic,22.5pt);
// size3(pic,0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

currentprojection=orthographic(view_from);
currentlight=light(view_from);

tm_draw(pic=pic);
tm_draw_start_button(pic);
tm_draw_halt_light(pic,tm_halt_label="\textsf{Accept}");
tm_draw_rt_tape(pic,"10110");

draw((0,0)--(1,1),red);
dot(pic,(0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== FSM with an attached pushdown stack ================
picture pic;
int picnum = 3;
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
tm_draw_rt_tape(pic, "[[][]][]");

dot((0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



