// move0.asy
//  Move the universal machine, before view

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

string s = "  ..BSB1BTB11B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,5,"$q_0$",tape_length);

draw(p, "$x$", tape_label_path(11,12), LeftSide, L_PEN);
// draw(p, "Target", tape_label_path(14,15), LeftSide, L_PEN);

shipout("move0",p);

