// utm4.asy
//  Sketch of UTM, copying 1's

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

string s = "  ..S11B1BBT111B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{200}$",tape_length);

draw(p, "Target", tape_label_path(5,7), LeftSide, L_PEN);
draw(p, "Source", tape_label_path(12,14), LeftSide, L_PEN);

shipout("utm4",p);

