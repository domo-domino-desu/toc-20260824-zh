// utm3d.asy
//  Sketch of UTM, moving machine description one char to right, moved the B to vefore the S

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

string s = "  1B1111BS111B11B11B1B1BT1B1111  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,8,"$q_{30}$",tape_length);

draw(p, "Tape left", tape_label_path(0,8), LeftSide, L_PEN);
draw(p, "Interval", tape_label_path(10,23), LeftSide, L_PEN);
draw(p, "Tape right", tape_label_path(25,32), LeftSide, L_PEN);

shipout("utm3d",p);

