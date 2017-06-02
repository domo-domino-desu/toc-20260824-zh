// test.asy
//  test importing from another directory

import settings;
settings.dir="..";  // have any effect? 
settings.outformat="pdf";

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");  // set to path to common asy dir
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");  // set to path to common asy dir
import jh;
cd("");

import life;

// ======== beacon ========
string fn = "beacon";

int dex = 0;
for (int dex=0; dex<=10; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== beehive ========
string fn = "beehive";

int dex = 0;
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== blinker ========
string fn = "blinker";

int dex = 0;
for (int dex=0; dex<=2; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== block ========
string fn = "block";

int dex = 0;
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== eater ========
string fn = "eater";

int dex = 0;
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== eateranim ========
string fn = "eateranim";

int dex = 0;
for (int dex=0; dex<=35; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== glider ========
string fn = "glider";

int dex = 0;
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== glideranim ========
string fn = "glideranim";

int dex = 0;
for (int dex=0; dex<=16; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== lonely ========
string fn = "lonely";

int dex = 0;
for (int dex=0; dex<=1; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== mwss ========
string fn = "mwss";

int dex = 0;
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== mwssanim ========
string fn = "mwssanim";

int dex = 0;
for (int dex=0; dex<=28; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}


// ======== mwssanim ========
string fn = "rabbits";

int dex = 0;
for (int dex=0; dex<=0; ++dex) {
  picture p = one_gameboard("out",fn,dex,0.25cm);
  shipout(fn+format("%02d",dex), p);
}
