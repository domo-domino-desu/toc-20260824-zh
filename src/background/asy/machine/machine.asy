// machine.asy
//  picture a TM

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



string OUTPUT_FN = "machine%02d";

// I cannot eliminate tons of white space around the left and right of this
// picture.  I've trimmed in the latex doc by eye, but that is obviously a
// kludge

// ============== Turing machine with oracle ================
// picture pic;
int picnum = 0;
// unitsize(80pt);
size(0,50pt);
// size(0,70pt,(0,0),(70pt,70pt));
viewportmargin=(-10pt,10pt);

triple view_from = (32,12,10);
currentprojection=orthographic(view_from);
currentlight=light(view_from);

triple eb_origin = (-4,-2,0);
pen pen(real t){
  return interp(red,blue,1-2*abs(t-0.5));
}

pen wirepen(real t){
  return MAINPEN+boldcolor+white;
}
// wire between TM and external box
path3 wire_center=(tm_origin+(-1,0,0))
  --(tm_origin+(-1,-1,0))
  ..(tm_origin+(-1,-3+0.05*unitrand(),0))
  ..(tm_origin+(-1+0.03*unitrand(),-3.5+0.1*unitrand(),0))
  ..(tm_origin+(-1+0.03*unitrand(),-3+0.1*unitrand(),0))
  ..(eb_origin+(-0.5+0.03*unitrand(),-2+0.03*unitrand(),0))
  ..(eb_origin+(-0.75+0.03*unitrand(),-1+0.03*unitrand(),0))
  ..(eb_origin+(-1,0,0));
// dot(point(wire_center,4),red);
// dot(point(wire_center,5),blue);
// dot(point(wire_center,6),green);
coloredpath cp = coloredpath(scale(0.3)*unitcircle, wirepen);
// draw(tube(wire_center, cp, corner=5, relstep=0));
draw(wire_center,MAINPEN+boldcolor);

transform3 t=shift(eb_origin);
eb_draw(t=t);
tm_draw_lf_tape();
tm_draw();
tm_draw_start_button();
tm_draw_halt_light(tm_halt_label="\textsf{Halt}");
tm_draw_rt_tape("1001010");

dot((0,1.15*tm_ht),invisible);  // little extra vert room
shipout(format(OUTPUT_FN,picnum),format="pdf");
