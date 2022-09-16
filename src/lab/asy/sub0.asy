// sub0.asy
//  UTM substitution, before

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

string s = "  ..SB11B1BT111B11B111BBW..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{0}$",tape_length);

draw(p, "$k$", tape_label_path(6,7), LeftSide, L_PEN);
draw(p, "$I_0$", tape_label_path(12,14), LeftSide, L_PEN);
draw(p, "$I_1$", tape_label_path(16,23), LeftSide, L_PEN);

shipout("sub0",p);

