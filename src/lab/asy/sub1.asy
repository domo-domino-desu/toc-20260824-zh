// sub1.asy
//  UTM substitution, collapse

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

string s = "  ..S11B1BTB11B111BBW111B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{0}$",tape_length);

// draw(p, "$k$", tape_label_path(5,6), LeftSide, L_PEN);
draw(p, "$I_0$", tape_label_path(21,23), LeftSide, L_PEN);
draw(p, "$I_1$", tape_label_path(12,17), LeftSide, L_PEN);

shipout("sub1",p);

