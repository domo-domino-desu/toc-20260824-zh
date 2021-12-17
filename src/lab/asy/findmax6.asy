// findmax6.asy
//  Findmax machine, done 

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

string s = "  ..B11S11B1BTB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,7,"$q_{40}$",tape_length);

// draw(p, "Interval", tape_label_path(6,10), LeftSide, L_PEN);

shipout("findmax6",p);

