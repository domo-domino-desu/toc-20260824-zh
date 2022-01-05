// sub4.asy
//  UTM substitution, Move upper k to below interval from R to W 

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

string s = "  ..S11B1BT11R11B111BBWB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{m}$",tape_length);

//draw(p, "$k$", tape_label_path(5,6), LeftSide, L_PEN);
draw(p, "$k$", tape_label_path(11,12), LeftSide, L_PEN);
draw(p, "$I_1$", tape_label_path(14,19), LeftSide, L_PEN);

shipout("sub5",p);

