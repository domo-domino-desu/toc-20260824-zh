// utm2.asy
//  Sketch of UTM, showing buffer and both tape halves 

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

string s = "       X111...B11...Y11B1.......1Z1B1....1B  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,15,"$q_i$",tape_length);

draw(p, "Tape left", tape_label_path(0,6), LeftSide, L_PEN);
draw(p, "Buffer", tape_label_path(8,13), LeftSide, L_PEN);
draw(p, "Machine", tape_label_path(15,32), LeftSide, L_PEN);
draw(p, "Tape right", tape_label_path(34,40), LeftSide, L_PEN);

shipout("utm2",p);

