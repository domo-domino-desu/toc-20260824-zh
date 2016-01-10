// lonely.asy

// These imports go in all .asy files to keep constants such as colors.
import settings;
settings.outformat="pdf";
settings.render=0;

// unitsize(1cm);

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../asy/");  // set to path to common asy dir
import settexpreamble;
cd("");
settexpreamble();

cd("../../asy/");  // set to path to common asy dir
import jh;
cd("");
// import node;

import life;

string fn = "lonely";
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "block";
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "beehive";
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "glider";
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "glideranim";
for (int dex=0; dex<=16; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.15cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "glideranimr";
for (int dex=0; dex<=16; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.15cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "eater";
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "eateranim";
for (int dex=0; dex<=35; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.15cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "mwss";
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.20cm);
  shipout(fn+format("%02d",dex), p);
}

string fn = "mwssanim";
for (int dex=0; dex<=28; ++dex) {
  picture p = one_gameboard("life",fn,dex,0.15cm);
  shipout(fn+format("%02d",dex), p);
}
