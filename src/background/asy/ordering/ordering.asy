// ordering.asy
//  Preorder of Turing reduction

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jh;

string OUTPUT_FN = "ordering%03d";

path ellipse(pair c, real a, real b) {
  return shift(c)*scale(a,b)*unitcircle;
}

pair randpt(real xmin=0, real xmax=1, real ymin=0, real ymax=1) {
  return ((xmax-xmin)*unitrand()+xmin, (ymax-ymin)*unitrand()+ymin); 
}








// These apply to all the diagrams
real UNIVERSE_HT = 2.5;
real UNIVERSE_WD = UNIVERSE_HT*(-1)*(1-sqrt(5))/2;
// write(format("UNIVERSE_WD=%f",UNIVERSE_WD));
real HGT_FACTOR = 0.65;
path UNIVERSE=(0,0).. tension 1.20 ..(-0.5*UNIVERSE_WD,HGT_FACTOR*UNIVERSE_HT){up}..(0,UNIVERSE_HT)..(0.5*UNIVERSE_WD,HGT_FACTOR*UNIVERSE_HT){down}.. tension 1.20 ..cycle;

real WHISKER_WD = 0.20;  // width of whisker for labels

// Produce an arc above the base of the region, for P, NP, etc.
// Goos quad_coeff is 3, good const_term is 0.6, 0.7-ish

path parabola(real quad_coeff, real const_term) {
  path p;
  int n = 100;  // number of subdivisions
  real start = -0.5*UNIVERSE_WD;
  real end = 0.5*UNIVERSE_WD;
  for(int i=0; i <= n; ++i) {
    real next_x = start+(i/n)*(end-start);
    pair next_point = (next_x, const_term-quad_coeff*next_x*next_x);
    p = p .. next_point;
  }
  return p;
}

path parabolic_arc(real quad_coeff, real const_term) {
  path p = parabola(quad_coeff, const_term);
  real[][] ints = intersections(UNIVERSE, p);
  path p_arc = subpath(p, ints[0][1], ints[1][1]);
  return p_arc;
}


// Produce an arc above the base of the region, for P, NP, etc.
//  hgt a negative number such as -.5, -.6, -.7
path base_region_arc(real hgt) {
  path ellipse_whole = ellipse((0,hgt),UNIVERSE_WD,-hgt*UNIVERSE_HT);
  real[][] ints = intersections(UNIVERSE, ellipse_whole);
  path ellipse_arc = subpath(ellipse_whole, ints[0][1], ints[1][1]);
  return ellipse_arc;
}

pen base_region_pen = highlightcolor+linecap(1);
pen squarebraces_label_pen = currentpen+linecap(1)+linejoin(0);

path make_pt_path(pair pt) {
  path pt_path = shift(pt)*scale(0.002)*unitcircle;
  return pt_path;
}


// Draw a line like a square bracket.
//   pth  path
//   br  pair; the tips of the bar; perhaps (-0.5*WHISKER_WD,0)
path halfbar(path pth,
	     pair br) {
  pair start_br = point(pth,0)+br;
  pair end_br = point(pth,length(pth))+br;
  return(start_br--point(pth,0)
         & pth &
         point(pth,length(pth))--end_br);      
}




// seed the random number generator;
//   If seconds() then uncomment to show on screen to save the number for later
// int srand_seed = seconds();
int srand_seed = 1650314745;
// write(format("PNP.ASY: srand_seed for point-picking is %d",srand_seed));
srand(srand_seed); 

// Use that seed to pick some points; they must be inside the UNIVERSE
pair[] pts;
int numpts=100;
bool flag=false;
pair onept;  // a candidate point
real padding=0.15; // min dist between points
for(int i=0; i<numpts; ++i) {
  flag=false;
  int tries=0; // watch for inf loop
  while(flag==false){
    if(tries>1000) {
      // Be quieter: write("Too many tries; making fewer points");
      break;
    } else {
      tries=tries+1;
    }
    // pick a point at random
    onept = randpt(-0.5*UNIVERSE_WD,0.5*UNIVERSE_WD,0,UNIVERSE_HT);
    // write(format("  onept.x=%f",onept.x));
    // write(format("  onept.y=%f",onept.y));
    // Check that it is not too close to another point
    flag=true;
    for(pair k : pts){
      if(length(onept-k)<padding){
	flag=false;
      }
    }
    // Check that it is inside the set bound
    flag=flag && (inside(UNIVERSE,make_pt_path(onept))==1);
  }
  // write(format("i=%d",i));
  pts[i] = onept;
}
// write(format("  Number of points is %d",pts.length));



// ============== Universe of all problems ======
picture pic;
int picnum=0;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

// Draw points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum), pic);



// ..... Labeled universe .............
// picture pic;
// int picnum=1;

// unitsize(pic,1cm);

// // Draw the universe of all langugaes
// filldraw(pic,UNIVERSE, white, AXISPEN);
// // (note that  we cover the stubs at end)

// // Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
// } 

// label(pic,"{\scriptsize All languages:}", (-0.5*UNIVERSE_WD,0.9*UNIVERSE_HT),2*W);

// label(pic,"{\scriptsize Langs with fast algorithms}", (0.5*UNIVERSE_WD,0.1*UNIVERSE_HT),2*E);
// label(pic,"{\scriptsize \hspace*{4em}$\vdots$}", (0.5*UNIVERSE_WD,0.375*UNIVERSE_HT),2*E);
// label(pic,"\makebox[\width][l]{\scriptsize Langs with slow algorithms}", (0.5*UNIVERSE_WD,0.55*UNIVERSE_HT),2*E);

// // Cover stubs extending into boundary
// draw(pic,UNIVERSE, AXISPEN);

// shipout(format(OUTPUT_FN,picnum), pic);



// // Draw the region of Recursive langugages
// // Recursive langs
// real REC_HGT = 1.8;
// path rec_arc = parabolic_arc(0.25,REC_HGT);

// // RE langs
// real re_start = 0.80*length(rec_arc);
// path re_arc = point(UNIVERSE, 1.15){(1,1.0)}..{dir(rec_arc,re_start)}point(rec_arc,re_start);
// // path re_arc = point(UNIVERSE, 1.15)..{dir(rec_arc,re_start)}point(rec_arc,re_start);

// // ........... Label REC ..........
// picture pic;
// int picnum=2;

// unitsize(pic,1cm);

// // Draw the universe of all langugaes
// filldraw(pic,UNIVERSE, white, AXISPEN);

// // Fill before draw
// path re_area = buildcycle(re_arc,rec_arc,UNIVERSE);
// fill(pic,re_area,backgroundcolor+gray(0.1));

// // draw(pic,re_area, blue);
// path rec_area = buildcycle(rec_arc,UNIVERSE);
// fill(pic,rec_area,backgroundcolor);

// draw(pic, rec_arc, base_region_pen);
// draw(pic, re_arc, base_region_pen);
// // (note that we cover the stubs at end)

// // Label them
// real label_x = 0.65*UNIVERSE_WD;
// real label_y = 0.68*UNIVERSE_HT;
// draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
// label(pic,"\makebox[\width][l]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),E); 

// real label_x = -0.65*UNIVERSE_WD;
// real label_y = 0.77*UNIVERSE_HT;
// draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
// label(pic,"\makebox[\width][r]{\scriptsize \compclass{RE}}",(label_x,0.5*label_y),W); 

// // Cover stubs extending into boundary
// draw(pic,UNIVERSE, AXISPEN);

// shipout(format(OUTPUT_FN,picnum), pic);



// // Complexity class P
// real P_HGT = 0.6;
// path P_arc = parabolic_arc(0.25,P_HGT);

pair K_loc = (point(UNIVERSE, 0).x,1.1);
path CE_bnd = (point(UNIVERSE, 0){N}..K_loc
	       &K_loc..point(UNIVERSE,3.5)
               &subpath(UNIVERSE,3.5,4.0))--cycle;


// --------  CE sets -------------------
picture pic;
int picnum=0;
	       
unitsize(pic,0,1.0cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

filldraw(pic, CE_bnd, fillpen=backgroundcolor, drawpen=AXISPEN);

picture K_sets=new picture;
filldraw(K_sets, circle(K_loc, 0.15), fillpen=backgroundcolor, drawpen=AXISPEN);
clip(K_sets, CE_bnd);
add(pic, K_sets);

picture comp_sets=new picture;
filldraw(comp_sets, circle(point(UNIVERSE, 0), 0.15), fillpen=backgroundcolor, drawpen=AXISPEN);
clip(comp_sets, UNIVERSE);
clip(comp_sets, CE_bnd);
add(pic, comp_sets);

// Add points in the K and comp regions to pts
pts.push( K_loc+(0.05,-0.05) );
// pts.push( K_loc );  // K point
pts.push( point(UNIVERSE, 0)+(0.05,0.075) );
// pts.push( point(UNIVERSE, 0)+(0.00,0.01) ); // emptyset point
// pair KK_loc = (0,K_loc.y+0.20*UNIVERSE_HT);
// pts.push( KK_loc);

// Draw points
picture points=new picture;
for(int i=0; i<pts.length; ++i){
  filldraw(points, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 
clip(points, UNIVERSE);
add(pic, points);

// Put in the line with bars and label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = K_loc.y;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize c.e. sets}",(label_x,0.5*label_y),E); 

// Label sets
path labelpath = (0,0){(1,0.2)}..(0.325*UNIVERSE_WD,0.01*UNIVERSE_HT)
                    ..(0.375*UNIVERSE_WD,-0.01*UNIVERSE_HT)
                    ..{(1,0.2)}(.7*UNIVERSE_WD,0*UNIVERSE_HT);

// Label empty set
real label_x = -0.7*UNIVERSE_WD;
pair emptyset_loc = point(UNIVERSE, 0)+(0.00,0.01);
filldraw(pic, make_pt_path(emptyset_loc), highlightcolor, fillpen=white);
draw(pic, shift(label_x,0)*labelpath, highlightcolor+linewidth(0.10pt)+squarecap, Margin(1.25,1));
label(pic,"\makebox[\width][r]{\scriptsize $\emptyset$}",(label_x,0), highlightcolor);
// Label K
filldraw(pic, make_pt_path(K_loc), highlightcolor, fillpen=white);
draw(pic, shift(label_x,K_loc.y)*labelpath, highlightcolor+linewidth(0.10pt)+squarecap, Margin(1.25,0.75));
label(pic,"\makebox[\width][r]{\scriptsize $K$}",(label_x,K_loc.y), highlightcolor); 
//Label K^K
pair KK_loc = (0,K_loc.y+0.20*UNIVERSE_HT);
filldraw(pic, make_pt_path(KK_loc), highlightcolor, fillpen=white);
draw(pic, shift(label_x,KK_loc.y)*labelpath, highlightcolor+linewidth(0.10pt)+squarecap, Margin(2.25,0.5));
label(pic,"\makebox[\width][r]{\scriptsize $K^K$}",(label_x,KK_loc.y), highlightcolor);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum), pic);









