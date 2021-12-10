// utm3c.asy
//  Sketch of UTM, moving machine description one char to right, cover the initial B

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

string s = "  1B1111S111B11B11B1B1BBT1B1111  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,23,"$q_{10}$",tape_length);

draw(p, "Tape left", tape_label_path(0,7), LeftSide, L_PEN);
draw(p, "Interval", tape_label_path(9,23), LeftSide, L_PEN);
draw(p, "Tape right", tape_label_path(25,32), LeftSide, L_PEN);

shipout("utm3c",p);

