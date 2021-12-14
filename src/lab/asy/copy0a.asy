// copy0a.asy
//  Copy machine, the after view

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

string s = "  S111B11B..1T111B..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,2,"$q_5$",tape_length);

// draw(p, "Interval", tape_label_path(3,12), LeftSide, L_PEN);

shipout("copy0a",p);

