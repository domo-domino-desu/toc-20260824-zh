// jigsaw.asy
//  For chapter on complexity

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jhnode;

string OUTPUT_FN = "jigsaw%03d";


// Pick number 1 or -1 with 50-50 chance
int in_or_out() {
    if (unitrand() > 0.5) {
       return 1;
    } else {
       return -1;
    }
}

// Return a real uniformily randomly chosen from interval [a..b]
real rand_interval(real a, real b) {
     real tmp = a+(b-a)*unitrand();
     // write(format("tmp is %f",tmp));
     return tmp;
}


// ======================== jigsaw puzzle =============

int picnum = 0;
picture pic;

pen PUZZLE_PEN = linewidth(0.2)+squarecap+gray(0.5);

int HORIZ_PIECES = 12;  // How many pieces from left to right?
int VERT_PIECES = 9;  // How many up to down?

real WIDTH = 2.5cm;
real HEIGHT = (VERT_PIECES/HORIZ_PIECES)*WIDTH;

// Use this to get random seeds, when one looks good, copy it as t=...
// int t = seconds();
// write(format("seconds for random seed is %d",t));
int t=1752328425;
srand(t);

// nominal width, height unit
real u=WIDTH/HORIZ_PIECES;
real v=HEIGHT/VERT_PIECES;

path board = (0,0)--(WIDTH,0)--(WIDTH,HEIGHT)--(0,HEIGHT)--(0,0)--cycle;


// Graphic: The Action and Capture of the Spanish Xebeque Frigate El Gamo
// Clarkson Frederick Stanfield (1793–1867)
// https://commons.wikimedia.org/wiki/File:Capture_of_the_El_Gamo.jpg
label(pic,graphic("../../pix/speedy_and_el_game.eps",format("width=%fpt",1.05*WIDTH)),(WIDTH/2,HEIGHT/2));
clip(pic,board);
layer(pic);

// Piece corners
pair [][] corners;
for (int row_dex=0; row_dex<=HORIZ_PIECES; ++row_dex) {
    pair [] row;
    for (int col_dex=0; col_dex<=VERT_PIECES; ++col_dex) {
    	row.push( (row_dex*u,col_dex*v) );
    }
    corners.push(row);  
}

// Parameters
real TURN_INTERP = 0.33; // Dist from interval start turn happens
real BUMP_PERCENT = 0.25; // How far into piece does bump go?
real CHOKE_PERCENT = 0.25; // How far up bump is choke?
real COLLAR_PERCENT = 0.75; // How far up bump is collar? 

for (int row_dex=1; row_dex<HORIZ_PIECES; ++row_dex) {
    path p = corners[row_dex][0];
    for (int col_dex=0; col_dex<VERT_PIECES; ++col_dex) {
	int side = in_or_out();   // 1 or -1; whether it bumps one way to other
    	pair start = corners[row_dex][col_dex];
    	pair end = corners[row_dex][col_dex+1];
        real bump = rand_interval(0.8,1.2)*BUMP_PERCENT*u*side;
	pair first_turn = interp(start,end,TURN_INTERP)
	     +(rand_interval(-0.05,0.05)*u,rand_interval(-0.01,0.01)*v);
	pair first_choke = interp(start,end,TURN_INTERP) +CHOKE_PERCENT*(bump,0);  
	pair first_collar = interp(start,end,TURN_INTERP) + (rand_interval(-0.35,-0.25),0)+COLLAR_PERCENT*(bump,0);
	pair mid = interp(start,end,0.5)+(bump,0);
	pair second_collar = interp(start,end,1-TURN_INTERP) + (rand_interval(0.25,0.35),0) + COLLAR_PERCENT*(bump,0);
	pair second_choke = interp(start,end,1-TURN_INTERP)+CHOKE_PERCENT*(bump,0);  
	pair second_turn = interp(start,end,1-TURN_INTERP);
	     +(rand_interval(-0.05,0.05)*u,rand_interval(-0.01,0.01)*v);
	p = p..first_turn&first_turn..first_choke..first_collar..mid..second_collar..second_choke..second_turn&second_turn..end;
    }
    draw(pic, p, PUZZLE_PEN);
}

for (int col_dex=1; col_dex<VERT_PIECES; ++col_dex) {
    path p = corners[0][col_dex];
    for (int row_dex=0; row_dex<HORIZ_PIECES; ++row_dex) {
	int side = in_or_out();   // 1 or -1; whether it bumps one way to other
    	pair start = corners[row_dex][col_dex];
    	pair end = corners[row_dex+1][col_dex];
        real bump = rand_interval(0.8,1.2)*BUMP_PERCENT*u*side;
	pair first_turn = interp(start,end,TURN_INTERP)
	     +(rand_interval(-0.01,0.01)*u,rand_interval(-0.05,0.05)*v);
	pair first_choke = interp(start,end,TURN_INTERP) +CHOKE_PERCENT*(0,bump);  
	pair first_collar = interp(start,end,TURN_INTERP) + (0,rand_interval(-0.35,-0.25))+COLLAR_PERCENT*(0,bump);
	pair mid = interp(start,end,0.5)+(0,bump);
	pair second_collar = interp(start,end,1-TURN_INTERP) + (0,rand_interval(0.25,0.35)) + COLLAR_PERCENT*(0,bump);
	pair second_choke = interp(start,end,1-TURN_INTERP)+CHOKE_PERCENT*(0,bump);  
	pair second_turn = interp(start,end,1-TURN_INTERP);
	     +(rand_interval(-0.01,0.01)*u,rand_interval(-0.05,0.05)*v);
	p = p..first_turn&first_turn..first_choke..first_collar..mid..second_collar..second_choke..second_turn&second_turn..end;
    }
    draw(pic, p, PUZZLE_PEN);
}

// dotfactor = 1;
// for (int row_dex=0; row_dex<=HORIZ_PIECES; ++row_dex) {
//     for (int col_dex=0; col_dex<=VERT_PIECES; ++col_dex) {
//     	dot(pic, corners[row_dex][col_dex], red);
//     }
// }

// draw(pic, board, PUZZLE_PEN);

shipout(format(OUTPUT_FN,picnum),pic);




