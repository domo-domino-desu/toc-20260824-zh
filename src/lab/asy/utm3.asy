// utm3.asy
//  Sketch of UTM, moving machine description one char to right, or left 

import settings;
settings.outformat="pdf";
settings.render=0;

// cd needed for relative import 
cd("../../asy");
import tape;
cd("");

picture p;
pen L_PEN = blue;  // pen used to label the tape
unitsize(p,1pt);

string s = "  ..BX111B11Y11B1B1BZ1B1..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,12,"$q_{i}$",tape_length);

draw(p, "$M$'s left tape\strut", tape_label_path(0,4), LeftSide, L_PEN);
draw(p, "Buffer\strut", tape_label_path(6,11), LeftSide, L_PEN);
draw(p, "Machine $M$\strut", tape_label_path(13,19), LeftSide, L_PEN);
draw(p, "$M$'s right tape\strut", tape_label_path(21,27), LeftSide, L_PEN);

shipout("utm3",p);

