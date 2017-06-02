// beacon.asy

// These imports go in all .asy files to keep constants such as colors.
import settings;
settings.outformat="pdf";
settings.render=0;

// unitsize(1cm);

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");  // set to path to common asy dir
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");  // set to path to common asy dir
import jh;
cd("");
// import node;

import life;
string fn = "beacon";

int dex = 0;
for (int dex=0; dex<=10; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}
