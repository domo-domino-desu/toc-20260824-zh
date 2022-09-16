// utm1.asy
//  Sketch of UTM, showing buffer 

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

string s = "  X111...B11...Y11B1.......1Z1B1....1BW  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,15,"$q_i$",tape_length);

draw(p, "Buffer", tape_label_path(3,14), LeftSide, L_PEN);
draw(p, "Machine", tape_label_path(16,27), LeftSide, L_PEN);
draw(p, "Tape", tape_label_path(29,37), LeftSide, L_PEN);

shipout("utm1",p);

