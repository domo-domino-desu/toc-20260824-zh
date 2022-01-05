// sub3.asy
//  UTM substitution, collapse copy k past tape end

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

string s = "  ..SB11B1BTB11B111BBWB11BB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,4,"$q_{p}$",tape_length);

draw(p, "$k$", tape_label_path(6,7), LeftSide, L_PEN);
draw(p, "$k$", tape_label_path(23,24), LeftSide, L_PEN);
draw(p, "$I_1$", tape_label_path(13,18), LeftSide, L_PEN);

shipout("sub3",p);

