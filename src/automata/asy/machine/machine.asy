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
cd("");



string OUTPUT_FN = "machine";

// I cannot eliminate tons of white space around the left and right of this
// picture.  I've trimmed in the latex doc by eye, but that is obviously a
// kludge

// ============== Finite state machine picture ================
// picture pic;
int picnum = 0;
// unitsize(80pt);
size(0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

triple view_from = (32,12,10);
currentprojection=orthographic(view_from);
currentlight=light(view_from);

tm_draw();
tm_draw_start_button();
tm_draw_halt_light(tm_halt_label="\textsf{Accept}");
tm_draw_rt_tape("1001010");

dot((0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),format="pdf");
