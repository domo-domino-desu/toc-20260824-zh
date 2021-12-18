// match0.asy
//  Match machine, before view

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

string s = "  ..BS11BB1BT11B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,5,"$q_0$",tape_length);

draw(p, "$x_s$", tape_label_path(6,7), LeftSide, L_PEN);
draw(p, "$x_t$", tape_label_path(13,14), LeftSide, L_PEN);

shipout("match0",p);

