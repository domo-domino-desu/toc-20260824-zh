// findmax5.asy
//  Findmax machine, do next number 

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

string s = "  ..B1GSHHJHJTB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,12,"$q_{11}$",tape_length);

// draw(p, "Interval", tape_label_path(6,10), LeftSide, L_PEN);

shipout("findmax5",p);

