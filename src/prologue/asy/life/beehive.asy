// beehive.asy

// These imports go in all .asy files to keep constants such as colors.
import settings;
settings.outformat="pdf";
settings.render=0;

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

import life;
string fn = "beehive";

int dex = 0;
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}
