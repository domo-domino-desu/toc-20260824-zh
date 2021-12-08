// utm6.asy
//  Sketch of UTM, substitution (after)

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

string s = "  ..S11BB11T11B11B111BB1B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{j}$",tape_length);

draw(p, "$k$", tape_label_path(5,6), LeftSide, L_PEN);
draw(p, "$I$", tape_label_path(12,22), LeftSide, L_PEN);

shipout("utm6",p);

