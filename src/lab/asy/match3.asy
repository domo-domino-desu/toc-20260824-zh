// match3.asy
//  Match machine, 1's after T end with 1's after S 

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

string s = "  ..BSGGBB1BTHHB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,15,"$q_{11}$",tape_length);

// draw(p, "$x_s$", tape_label_path(6,7), LeftSide, L_PEN);
// draw(p, "$x_t$", tape_label_path(13,14), LeftSide, L_PEN);

shipout("match3",p);

