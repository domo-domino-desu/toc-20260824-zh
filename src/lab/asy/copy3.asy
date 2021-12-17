// copy3.asy
//  Copy machine, done

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

string s = "  ..BS11BB11BT11BB..  ";
real tape_length = tape_contents_length(s);

tape_draw(p,s,5,"$q_{20}$",tape_length);

// draw(p, "Source", tape_label_path(6,8), LeftSide, L_PEN);
// draw(p, "Target", tape_label_path(14,16), LeftSide, L_PEN);

shipout("copy3",p);

