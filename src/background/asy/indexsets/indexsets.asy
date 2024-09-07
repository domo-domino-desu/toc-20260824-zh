// indexsets.asy
//   equivalence classes, with some included

// import settings;
settings.outformat="pdf";

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

// ==========================================
// Format of the names of the files produced
string OUTPUT_FILE = "indexsets%03d";  


size(0,0);  // units are big points: 72 is 1inch

real wd=3cm;
real ht=2cm;

path universe = box((0,0), (wd,ht));

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

// Seed the random number generator
// Comment the next two lines and comment the seconds_seed setting,
// then run a few until you get one you like.  Then install it as
// the fixed seconds_seed.
// int seconds_seed = seconds();
// write(format("Seed for srand is %d",seconds_seed));
int seconds_seed = 1614082795;
srand(seconds_seed);

// Generate the equivalence classes
path classes[][];

for(int r=0; r<num_rows; ++r) {
  path[] rw;
  for(int c=0; c<num_cols; ++c){
    rw.push(make_tile(horiz_size,vert_size));
  }
  classes.push(rw);
}

// Get the tile where it lays
path get_tile(path[][] classes, int r, int c){
  return shift((num_cols-1-c)*horiz_size,(num_rows-1-r)*vert_size)*classes[num_rows-1-r][num_cols-1-c];
}



// =================== Universe with equivalence classes =========
picture pic;
int picnum = 0;

// Draw the equivalence classes
pen fp;
for(int r=0; r<num_rows; ++r) {
  for(int c=0; c<num_cols; ++c){
    if (unitrand()<=0.1) {  // Color a few of the index sets
      fp=lightcolor;
    } else {
      fp=white;
    }
    filldraw(pic,shift((num_cols-1-c)*horiz_size,(num_rows-1-r)*vert_size)*classes[num_rows-1-r][num_cols-1-c],MAINPEN+LIGHTPEN+grayed,fillpen=fp);
  }
}

label(pic, "$\cdots$",(wd-0.5cm,ht/2.0));

clip(pic, universe);
draw(pic, universe,MAINPEN+LIGHTPEN+miterjoin);

shipout(format(OUTPUT_FILE,picnum),pic);




// Seed the random number generator to place the points
// Comment the next two lines and comment the seconds_seed setting,
// then run a few until you get one you like.  Then install it as
// the fixed seconds_seed.
// int seconds_seed = seconds();
int seconds_seed = 1725571541;
// write(format("Seed for srand is %d",seconds_seed));
srand(seconds_seed);

// Find positions for the points
pair[] pts_in_tile;
int num_pts_in_tile;
for(int r=0; r<num_rows; ++r) {
  for(int c=0; c<num_cols; ++c){
    path tile;
    // tile = get_tile(classes,r,c);
    transform t = shift((num_cols-1-c)*horiz_size,(num_rows-1-r)*vert_size);
    if (unitrand() < 0.5) {
      num_pts_in_tile = 3;
    } else {
      num_pts_in_tile = 4;
    }
    if (num_pts_in_tile==3) {
      pts_in_tile.push( t* (horiz_size*(0.1+0.23*unitrand()), vert_size*(0.1+0.8*unitrand())) );  // 0.33-0.075=0.255
      pts_in_tile.push( t* (horiz_size*(0.33+0.33*unitrand()), vert_size*(0.1+0.8*unitrand())) );  // 
      pts_in_tile.push( t* (horiz_size*(0.67+0.23*unitrand()), vert_size*(0.1+0.8*unitrand())) );  // 0.33-0.075=0.255
    } else {
      pts_in_tile.push( t* (horiz_size*(0.075+0.425*unitrand()), vert_size*(0.0075+0.425*unitrand())) ); // 0.5-0.075=0.425
      pts_in_tile.push( t* (horiz_size*(0.075+0.425*unitrand()), vert_size*(0.5+0.425*unitrand())) ); // 
      pts_in_tile.push( t* (horiz_size*(0.5+0.425*unitrand()), vert_size*(0.0075+0.425*unitrand())) ); // 
      pts_in_tile.push( t* (horiz_size*(0.5+0.425*unitrand()), vert_size*(0.5+0.425*unitrand())) ); //
    }
  }
}

// =================== Universe with Turing machine dots =========
picture pic;
int picnum = 1;

// Draw the points
dotfactor = 2;
for (pair p: pts_in_tile) {
  dot(pic, p, highlightcolor);
}

label(pic, "$\cdots$",(wd-0.5cm,ht/2.0));

clip(pic, universe);
draw(pic, universe,MAINPEN+LIGHTPEN+miterjoin);

shipout(format(OUTPUT_FILE,picnum),pic);


//  .............. add the behavior classes ..............
picture pic;
int picnum = 2;

path tile;
// Draw the tiles
for(int r=0; r<num_rows; ++r) {
  for(int c=0; c<num_cols; ++c){
    tile = get_tile(classes,r,c);
    filldraw(pic, get_tile(classes,r,c), MAINPEN+LIGHTPEN+grayed,fillpen=fp);
  }
}
// Add the points
dotfactor = 2;
for (pair p: pts_in_tile) {
  dot(pic, p, highlightcolor);
}

label(pic, "$\cdots$",(wd-0.5cm,ht/2.0));

clip(pic, universe);
draw(pic, universe,MAINPEN+LIGHTPEN+miterjoin);

shipout(format(OUTPUT_FILE,picnum),pic);




//  .............. color some tiles ..............
picture pic;
int picnum = 3;

path tile;
// Draw the points
for(int r=0; r<num_rows; ++r) {
  for(int c=0; c<num_cols; ++c){
    tile = get_tile(classes,r,c);
    if (unitrand()<=0.1) {  // Color a few of the index sets
      filldraw(pic, get_tile(classes,r,c), MAINPEN+LIGHTPEN+grayed,fillpen=lightcolor);
    } else {
      filldraw(pic, get_tile(classes,r,c), MAINPEN+LIGHTPEN+grayed,fillpen=white);
    }
  }
}
// Add the points
dotfactor = 2;
for (pair p: pts_in_tile) {
  dot(pic, p, highlightcolor);
}

label(pic, "$\cdots$",(wd-0.5cm,ht/2.0));

clip(pic, universe);
draw(pic, universe,MAINPEN+LIGHTPEN+miterjoin);

shipout(format(OUTPUT_FILE,picnum),pic);
