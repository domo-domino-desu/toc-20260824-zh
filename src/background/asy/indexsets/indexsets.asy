// indexsets.asy
//   equivalence classes, with some included

import settings;
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

size(0,0);  // units are big points: 72 is 1inch

real wd=3cm;
real ht=2cm;

path universe = box((0,0), (wd,ht));
// upper left
// real ul_x=.35wd;
// real ul_y=.65ht;
// path ul = (0,ht)--(ul_x,ht){down}..{left}(0,ul_y)--cycle;
// // lower left
// real ll_x=.40wd;
// real ll_y=.35ht;
// path ll = (0,0)--(ll_x,0){up}..{left}(0,ll_y)--cycle;
// // mid_left
// real ml_top_frac = 1.4;
// pair ml_top=point(ul,ml_top_frac);
// real ml_bot_frac = 1.5;
// pair ml_bot=point(ll,ml_bot_frac);
// path ml = point(ll, 2.0)--point(ul, 2.0)
//   & subpath(ul, 2.0, ml_top_frac)
//   & ml_top{(1,-2)}..{(-1,-3)}ml_bot
//   & subpath(ll, ml_bot_frac, 2.0)
//   & point(ll, 2.0)--cycle;

path make_tile(real h,real  v){
  path p = (0,0)..(0.5,-0.15*unitrand())..(1,0)
        ..(1+0.15*unitrand(),0.5)..(1,1)
	..(0.5,1+0.15*unitrand())..(0,1)
	..(-0.15*unitrand(),0.5)..cycle;
  return scale(h,v)*p;
}


int num_rows=6;  // number boxes vertically
int num_cols=5;  // number boxes horizontally
real horiz_size=10.85;
real vert_size=9.5;

// seed the random number gnerator
srand(seconds());

// Generate the equivalence classes
path classes[][];

for(int r=0; r<num_rows; ++r) {
  path[] rw;
  for(int c=0; c<num_cols; ++c){
    rw.push(make_tile(horiz_size,vert_size));
  }
  classes.push(rw);
}

// Draw the equivalence classes
pen fp;
for(int r=0; r<num_rows; ++r) {
  for(int c=0; c<num_cols; ++c){
    if (unitrand()<=0.1) {  // Color a few of the index sets
      fp=mediumgray;
    } else {
      fp=white;
    }
    filldraw(shift((num_cols-1-c)*horiz_size,(num_rows-1-r)*vert_size)*classes[num_rows-1-r][num_cols-1-c],MAINPEN+LIGHTPEN+blue,fillpen=fp);
  }
}

label("$\cdots$",(wd-0.5cm,ht/2.0));

// draw(ul,MAINPEN+LIGHTPEN);
// draw(ll,MAINPEN+LIGHTPEN);
// draw(ml,MAINPEN+LIGHTPEN);
// draw(subpath(ml, 3.0, 4.0), red);

clip(universe);
draw(universe,MAINPEN+DARKPEN+miterjoin);

