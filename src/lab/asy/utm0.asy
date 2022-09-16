// utm0.asy
//  Sketch of UTM, showing initial configuration

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

string s = "  Y11B1.......1Z1B1....1BW  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,2,"$q_0$",tape_length);

draw(p, "Machine number", tape_label_path(3,14), LeftSide, L_PEN);
draw(p, "Starting tape", tape_label_path(16,24), LeftSide, L_PEN);

shipout("utm0",p);

