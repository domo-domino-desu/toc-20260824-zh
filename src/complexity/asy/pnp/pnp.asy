// bigo.asy
//  Graphs and info about big-O

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jh;

string OUTPUT_FN = "pnp%02d";

path ellipse(pair c, real a, real b) {
  return shift(c)*scale(a,b)*unitcircle;
}

pair randpt(real xmin=0, real xmax=1, real ymin=0, real ymax=1) {
  return ((xmax-xmin)*unitrand()+xmin, (ymax-ymin)*unitrand()+ymin); 
}





// ============== Poset of all languages of bitstrings ======
picture pic;
int picnum=0;

unitsize(pic,1cm);

// seed the random number generator;
//   If seconds() then uncomment to show on screen to save the number for later
// I've used the same number also for pic 3.
int srand_seed = 1512905530; // seconds();
// write(format("PNP.ASY: Picture 3: srand_seed is %d",srand_seed));
srand(srand_seed); 

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// Determine bounds of set_bound
picture set_bound_pic;
draw(set_bound_pic,set_bound,AXISPEN);
pair set_bound_min=min(set_bound_pic,user=true);
pair set_bound_max=max(set_bound_pic,user=true);

// Pick some points; they must be inside the set_bound
pair[] pts;
int numpts=30;
bool flag=false;
pair onept;
real padding=0.25; // min dist between points
for(int i=0; i<numpts; ++i) {
  flag=false;
  int tries=0; // watch for inf loop
  while(flag==false){
    if(tries>100) {
      write("Too many tries; making fewer points");
      break;
    } else {
      tries=tries+1;
    }
    // pick a point at random
    onept = randpt(set_bound_min.x,set_bound_max.x,set_bound_min.y,set_bound_max.y);
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
    flag=flag && inside(set_bound,onept);
  }
  // write(format("i=%d",i));
  pts[i] = onept;
}
// Now draw edges
real edge_threshold = 0.10;
for(int i=0; i<pts.length; ++i) {
  for(int j=i+1; j<pts.length; ++j){
    if (unitrand() < edge_threshold) {
      draw(pic, pts[i]--pts[j],backgroundcolor);
    }
  }
}
for(int i=0; i<pts.length; ++i){
  filldraw(pic, shift(pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 
draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........  make the legend words ............
picture pic;
int picnum=1;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;

dot(pic,(-1.5,0),invisible);   // set it by eye to make letters shown
label(pic,"\makebox[0em][r]{Slow}",(0,SET_TOP),backgroundcolor);
label(pic,"\makebox[0em][r]{$\vdots$\hspace*{1.0em}}",(0,0.6*SET_TOP),backgroundcolor);
label(pic,"\makebox[0em][r]{Fast}",(0,0),backgroundcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Illustrate P ======
picture pic;
int picnum=2;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// real a=0.35, b=1.5;
// real WEDGE_TOP = 0.45*SET_TOP;
// pair w=(0.5*SET_RT+0.5*a,WEDGE_TOP);
// path wedgecap = ellipse(w, a, b);

// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
draw(pic,p,AXISPEN);
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out where the path P meets the set boundary
path p_boundary = buildcycle(set_bound,p);

// Make a shape to intersect with the P region, to form the n, n^2, etc's
real a=0.75, b=0.30;
path fcurve_ellipse = ellipse((0,0),a,b);
// draw(pic,fcurve_ellipse,black);
// dot(pic,point(fcurve_ellipse,2),blue);
pair fcurve_bl = (point(fcurve_ellipse,2).x,-1);
pair fcurve_br = (point(fcurve_ellipse,0).x,-1);
path fcurve=subpath(fcurve_ellipse,0.0,2.0)
  ..point(fcurve_ellipse,2)--fcurve_bl--fcurve_br--point(fcurve_ellipse,0)..cycle;


// Make the shaded paths
// fill(pic,p_boundary,backgroundcolor+opacity(0.2));
int num_shades = 10;  // greater than 2
for (int i=0; i<num_shades; ++i) {
  real ystart = -0.28;
  real yend = point(fcurve_ellipse,1).y; 
  path oi = shift(boundbot.x+.4,ystart+(i*(1/(num_shades-2)))*(yend-ystart))*fcurve;
  fill(pic,buildcycle(oi,p_boundary),backgroundcolor+opacity((-0.8/(num_shades-1))*i+0.9));
}

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Collection of all langugaes ======
picture pic;
int picnum=3;

unitsize(pic,1cm);

// seed the random number generator;
//   If seconds() then uncomment to show on screen to save the number for later
// I've used the same number also for pic 1.
int srand_seed = 1512905530; // seconds();
// write(format("PNP.ASY: Picture 3: srand_seed is %d",srand_seed));
srand(srand_seed); 

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// Determine bounds of set_bound
picture set_bound_pic;
draw(set_bound_pic,set_bound,AXISPEN);
pair set_bound_min=min(set_bound_pic,user=true);
pair set_bound_max=max(set_bound_pic,user=true);

// Pick some points; they must be inside the set_bound
pair[] pts;
int numpts=30;
bool flag=false;
pair onept;
real padding=0.25; // min dist between points
for(int i=0; i<numpts; ++i) {
  flag=false;
  int tries=0; // watch for inf loop
  while(flag==false){
    if(tries>100) {
      write("Too many tries; making fewer points");
      break;
    } else {
      tries=tries+1;
    }
    // pick a point at random
    onept = randpt(set_bound_min.x,set_bound_max.x,set_bound_min.y,set_bound_max.y);
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
    flag=flag && inside(set_bound,onept);
  }
  // write(format("i=%d",i));
  pts[i] = onept;
}

// Draw all the points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, shift(pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== Illustrate P and NP ======

// ................. NP strict superset .............
picture pic;
int picnum=4;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out where the path P meets the set boundary
path p_boundary = buildcycle(set_bound,p);
filldraw(pic,p_boundary,backgroundcolor+opacity(0.2),boldcolor);


// Make NP boundary
pair npboundrt = point(set_bound,2.5);
pair np1 = (0.425*(boundbot.x+boundrt.x),boundrt.y+0.6);
pair np2 = (0.625*(boundbot.x+boundrt.x),boundrt.y+0.6);
// dot(pic,np1,green);
// dot(pic,np2,green);
path np = boundbot{(0.1,2)} :: np1 .. np2 .. npboundrt;

path np_boundary = buildcycle(set_bound,np);
filldraw(pic,np_boundary,backgroundcolor+opacity(0.2),highlightcolor);

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ................. NP  same set .............
picture pic;
int picnum=5;

unitsize(pic,1cm);

filldraw(pic,p_boundary,backgroundcolor+opacity(0.4),highlightcolor);

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");








// ============== NP complete ======

picture pic;
int picnum=6;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// P and NP
// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out where the path P meets the set boundary
path p_boundary = buildcycle(set_bound,p);
// filldraw(pic,p_boundary,backgroundcolor+opacity(0.2),boldcolor);
draw(pic,p_boundary,boldcolor+opacity(0.3));


// Make NP boundary
pair npboundrt = point(set_bound,2.5);
pair np1 = (0.425*(boundbot.x+boundrt.x),boundrt.y+0.6);
pair np2 = (0.625*(boundbot.x+boundrt.x),boundrt.y+0.6);
// dot(pic,npboundrt,green);
// dot(pic,np1,green);
// dot(pic,np2,green);
path np = boundbot{(0.1,2)} :: np1 .. np2 .. npboundrt;

path np_boundary = buildcycle(set_bound,np);
draw(pic,np_boundary,boldcolor);

// NP hard
// pick points on the boundary to intersect
pair nphardboundrt = npboundrt;  //  point(set_bound,2.275);
pair nphardboundtop = point(set_bound,3.4);
// dot(pic,nphardboundrt,red);
// dot(pic,nphardboundtop,red);
path nphard = nphardboundtop{S} .. np1 .. nphardboundrt;
path nphard_region = buildcycle(set_bound,nphard);
filldraw(pic,nphard_region,backgroundcolor+opacity(0.2),boldcolor);
// // dot(pic,p1,green);
// // dot(pic,p2,green);
// // dot(pic,p3,green);
path np_complete = buildcycle(np,nphard);
filldraw(pic,np_complete,fillpen=highlightcolor+opacity(0.25),drawpen=highlightcolor);

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== EXP ======
picture pic;
int picnum=7;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out where the path P meets the set boundary
path p_boundary = buildcycle(set_bound,p);
filldraw(pic,p_boundary,backgroundcolor+opacity(0.2),boldcolor);


// Make NP boundary
pair npboundrt = point(set_bound,2.5);
pair np1 = (0.425*(boundbot.x+boundrt.x),boundrt.y+0.6);
pair np2 = (0.625*(boundbot.x+boundrt.x),boundrt.y+0.6);
// dot(pic,np1,green);
// dot(pic,np2,green);
path np = boundbot{(0.1,2)} :: np1 .. np2 .. npboundrt;

path np_boundary = buildcycle(set_bound,np);
filldraw(pic,np_boundary,backgroundcolor+opacity(0.2),boldcolor);

// Make EXP boundary
pair expboundrt = point(set_bound,2.7);
pair exp1 = (0.425*(boundbot.x+boundrt.x),boundrt.y+0.9);
pair exp2 = (0.625*(boundbot.x+boundrt.x),boundrt.y+0.9);
// dot(pic,exp1,green);
// dot(pic,exp2,green);
path exp = boundbot{(0.1,2)} :: exp1 .. exp2 .. expboundrt;

path exp_boundary = buildcycle(set_bound,exp);
filldraw(pic,exp_boundary,backgroundcolor+opacity(0.2),highlightcolor);

draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== Illustrate <_p, on P ======
picture pic;
int picnum=8;

unitsize(pic,1cm);

// use seconds() to try verious random pics, then save one I like
int srand_seed = 1607967264; // seconds();
// write(format("PNP.ASY: Picture 8: srand_seed is %d",srand_seed));  // when trying random seeds, can save ones that I like
srand(srand_seed); 

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// Find the horizontal and vertical limits of the box around the bean 
real max_horiz_extent_time = maxtimes(set_bound)[0];
real max_vert_extent_time = maxtimes(set_bound)[1];
real max_horiz_coord = point(set_bound,max_horiz_extent_time).x;
real max_vert_coord = point(set_bound,max_vert_extent_time).y;
real min_horiz_extent_time = mintimes(set_bound)[0];
real min_vert_extent_time = mintimes(set_bound)[1];
real min_horiz_coord = point(set_bound,min_horiz_extent_time).x;
real min_vert_coord = point(set_bound,min_vert_extent_time).y;
// dot(pic, (min_horiz_coord,min_vert_coord), blue);  // have a look

// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out where the path P meets the set boundary
path p_boundary = buildcycle(set_bound,p);

// Pick some points; they must be inside the p_boundary
pair[] p_pts;    // points in P
pair[] nonp_pts;   // points not in P
int numpts_horiz=10;
int numpts_vert=10;
int numpts = 100;
pair candidate_pt;  // pt we test to see if it is inside 
// generate points inside P
for (int i=0; i<=numpts; ++i) {
    candidate_pt = randpt(min_horiz_coord,max_horiz_coord,min_vert_coord,max_vert_coord);
    // write(format("candidate_pt.x=%f ",candidate_pt.x));
    // write(format("candidate_pt.y=%f",candidate_pt.y));
    if (inside(p_boundary,candidate_pt)) {
      p_pts.push(candidate_pt);
    } else {
      if (inside(set_bound,candidate_pt)) {
	nonp_pts.push(candidate_pt);
      }
    }
}


// for (int h=0; h<=numpts_horiz; ++h) {
//   // write(format("  h=%d",h));
//   for (int v=0; v<=numpts_vert; ++v) {
//     // write(format("    v=%d",v));
//     candidate_pt = ( (h/numpts_horiz)*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, (v/numpts_vert)*(max_vert_coord-min_vert_coord)+min_vert_coord );
//     if (inside(p_boundary,candidate_pt)) {
//       pts.push(candidate_pt);
//     }
//   }
// }

// Now draw edges
// First the non-P langs
real edge_threshold = 0.0025;  // chance an edge gets drawn
for(int i=0; i<nonp_pts.length; ++i) {
  for (int j=0; j<nonp_pts.length; ++j) {
    if (unitrand() < edge_threshold) {
      draw(pic, nonp_pts[i]--nonp_pts[j],backgroundcolor);
    }
  }
}
// Draw the boundary of the universe, and of P
draw(pic,set_bound, AXISPEN);
draw(pic,p,AXISPEN);
// Now the P lang edges
real edge_threshold = 0.05;  // chance an edge gets drawn
for(int i=0; i<p_pts.length; ++i) {
  for (int j=0; j<p_pts.length; ++j) {
    if (unitrand() < edge_threshold) {
      draw(pic, p_pts[i]--p_pts[j],highlightcolor);
    }
  }
}
// write(format("p_pts.length=%d",p_pts.length));
// write(format("nonp_pts.length=%d",nonp_pts.length));
// Draw the non-P points
for(int i=0; i<nonp_pts.length; ++i){
  filldraw(pic, shift(nonp_pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 
// Draw the P points
for(int i=0; i<p_pts.length; ++i){
  filldraw(pic, shift(p_pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ................... Illustrate <_p, on P ..........
picture pic;
int picnum=9;

unitsize(pic,1cm);

// use seconds() to try verious random pics, then save one I like
int srand_seed = 1608295644; // seconds();
// write(format("PNP.ASY: Picture 9: srand_seed is %d",srand_seed));  // when trying random seeds, can save ones that I like
srand(srand_seed); 

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

// Find the horizontal and vertical limits of the box around the bean 
real max_horiz_extent_time = maxtimes(set_bound)[0];
real max_vert_extent_time = maxtimes(set_bound)[1];
real max_horiz_coord = point(set_bound,max_horiz_extent_time).x;
real max_vert_coord = point(set_bound,max_vert_extent_time).y;
real min_horiz_extent_time = mintimes(set_bound)[0];
real min_vert_extent_time = mintimes(set_bound)[1];
real min_horiz_coord = point(set_bound,min_horiz_extent_time).x;
real min_vert_coord = point(set_bound,min_vert_extent_time).y;
// dot(pic, (min_horiz_coord,min_vert_coord), blue);  // have a look

// pick points on the boundary to intersect
pair boundbot = point(set_bound,1.5);
pair boundrt = point(set_bound,2.275);
pair p1 = (0.4*(boundbot.x+boundrt.x),boundrt.y+0.1);
pair p2 = (0.60*(boundbot.x+boundrt.x),boundrt.y+0.2);
// pair p3 = (0.75*(boundbot.x+boundrt.x),boundrt.y+0.1);
path p = boundbot{(0.1,1)} :: p1 .. p2 .. {SE}boundrt;
// dot(pic,p1,green);
// dot(pic,p2,green);
// dot(pic,p3,green);

// Figure out the path that borders P incl bean boundary
path p_boundary = buildcycle(set_bound,p);

// Pick some points; they must be inside the p_boundary
pair[] p_pts;    // points in P
pair[] nonp_pts;   // points not in P
pair[] candidate_pts = {
  // P pts
  (0.82*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.25*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.70*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.09*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.5*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.04*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.60*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.35*(max_vert_coord-min_vert_coord)+min_vert_coord),
  // Non-P pts
  (0.20*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.20*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.70*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.90*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.150*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.87*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.40*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.95*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.10*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.50*(max_vert_coord-min_vert_coord)+min_vert_coord),
  (0.30*(max_horiz_coord-min_horiz_coord)+min_horiz_coord, 0.30*(max_vert_coord-min_vert_coord)+min_vert_coord)
};
// write(format("   number of candidate_points: %d",candidate_pts.length));
int num_pts = candidate_pts.length;
pair candidate_pt;  // pt we test to see if it is inside 
// place points inside and outside P
for (int i=0; i<num_pts; ++i) {
  candidate_pt = candidate_pts.pop(); // iterate through array from back
    // write(format("candidate_pt.x=%f ",candidate_pt.x));
    // write(format("candidate_pt.y=%f",candidate_pt.y));
    if (inside(p_boundary,candidate_pt)) {
      p_pts.push(candidate_pt);
      // write(format("   point number %d is in P",i));
    } else {
      if (inside(set_bound,candidate_pt)) {
	nonp_pts.push(candidate_pt);
	// write(format("   point number %d is in non-P",i));
      } else {
	// write(format("   point number %d is not in set",i));
      }
    }
}

// Now draw edges
// First the non-P langs
// non-P to non-P
real edge_threshold = 0.25;  // chance an edge gets drawn
for(int i=0; i<nonp_pts.length; ++i) {
  for (int j=0; j<nonp_pts.length; ++j) {
    if (unitrand() < edge_threshold) {
      draw(pic, nonp_pts[i]--nonp_pts[j],backgroundcolor);
    }
  }
}
// non-P to P
for(int i=0; i<nonp_pts.length; ++i) {
  for (int j=0; j<p_pts.length; ++j) {
    draw(pic, nonp_pts[i]--p_pts[j],backgroundcolor);
  }
}

// Draw the boundary of the universe, and of P
draw(pic,set_bound, AXISPEN);
draw(pic,p,AXISPEN);

// Now the P lang edges
for(int i=0; i<p_pts.length; ++i) {
  for (int j=0; j<p_pts.length; ++j) {
      draw(pic, p_pts[i]--p_pts[j],highlightcolor);
  }
}

// write(format("p_pts.length=%d",p_pts.length));
// write(format("nonp_pts.length=%d",nonp_pts.length));
// Draw the non-P points
for(int i=0; i<nonp_pts.length; ++i){
  filldraw(pic, shift(nonp_pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 
// Draw the P points
for(int i=0; i<p_pts.length; ++i){
  filldraw(pic, shift(p_pts[i])*scale(0.025)*unitcircle, boldcolor, fillpen=white);
} 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== Illustrate f=Theta(g) ======
picture pic;
int picnum=20;

unitsize(pic,1cm);

// bounds 
real SET_TOP=1.75;
real SET_RT=1.4;
path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

real a=0.15, b=0.1;
real WEDGE_TOP = 0.45*SET_TOP;
pair w=(0.5*SET_RT+0.5*a,WEDGE_TOP);
path wedgecap = ellipse(w, a, b);

// make two lines tangent to wedgecap, one on left and one on right
real wc_t_l=2.0, wc_t_r=0.17;  // cubic spline parameter on wedgecap
pair d_l=dir(wedgecap,wc_t_l); // dir of tangent
path wedge_left=point(wedgecap,wc_t_l)--(point(wedgecap,wc_t_l)+5*d_l);
pair d_r=dir(wedgecap,wc_t_r);  // dir_of_tangent
path wedge_right=point(wedgecap,wc_t_r)--(point(wedgecap,wc_t_r)-5*d_r);

// intersect those lines with the set boundary
real[] left_intersection=intersect(wedge_left,set_bound);
real[] right_intersection=intersect(wedge_right,set_bound);
path wedge=(subpath(wedgecap,wc_t_r,wc_t_l)
	    &subpath(wedge_left,0,left_intersection[0])
	    &subpath(set_bound,left_intersection[1],right_intersection[1]))
          --cycle;
path wedge_edge=subpath(wedge_left,left_intersection[0],0)
		 &subpath(wedgecap,wc_t_l,wc_t_r)
		 &subpath(wedge_right,0,right_intersection[0]);

// draw it all
filldraw(pic,set_bound, AXISPEN, fillpen=backgroundcolor);
filldraw(pic,wedge,lightcolor,fillpen=white);
filldraw(pic,wedgecap,lightcolor,fillpen=white);
draw(pic,wedge_edge,highlightcolor);
draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Illustrate O(n^3) and O(n^2) ======
picture pic;
int picnum=21;

unitsize(pic,1cm);

// bounds 
// real SET_TOP=1.75;
// real SET_RT=1.4;
// path set_bound=(0,0.5*SET_TOP)..(0,0)..(SET_RT,0)..(SET_RT,SET_TOP)..(0,SET_TOP)..cycle;

real a=0.15, b=0.1;
// n^3
real WEDGE_TOP0 = 0.55*SET_TOP;
pair w0=(0.5*SET_RT+0.5*a,WEDGE_TOP0);
path wedgecap0 = ellipse(w0, a, b);
// n^2
real WEDGE_TOP1 = 0.25*SET_TOP;
pair w1=(0.5*SET_RT+0.5*a,WEDGE_TOP1);
path wedgecap1 = ellipse(w1, a, b);

// make two lines tangent to wedgecap, one on left and one on right
real wc0_t_l=2.0, wc0_t_r=0.18;  // cubic spline parameter on wedgecap
pair d0_l=dir(wedgecap0,wc0_t_l); // dir of tangent
path wedge0_left=point(wedgecap0,wc0_t_l)--(point(wedgecap0,wc0_t_l)+5*d0_l);
pair d0_r=dir(wedgecap0,wc0_t_r);  // dir_of_tangent
path wedge0_right=point(wedgecap0,wc0_t_r)--(point(wedgecap0,wc0_t_r)-5*d0_r);

real wc1_t_l=2.0, wc1_t_r=0.15;  // cubic spline parameter on wedgecap
pair d1_l=dir(wedgecap1,wc1_t_l); // dir of tangent
path wedge1_left=point(wedgecap1,wc1_t_l)--(point(wedgecap1,wc1_t_l)+5*d1_l);
pair d1_r=dir(wedgecap1,wc1_t_r);  // dir_of_tangent
path wedge1_right=point(wedgecap1,wc1_t_r)--(point(wedgecap1,wc1_t_r)-5*d1_r);

// intersect those lines with the set boundary
real[] left0_intersection=intersect(wedge0_left,set_bound);
real[] right0_intersection=intersect(wedge0_right,set_bound);
path wedge0=(subpath(wedgecap0,wc0_t_r,wc0_t_l)
	    &subpath(wedge0_left,0,left0_intersection[0])
	    &subpath(set_bound,left0_intersection[1],right0_intersection[1]))
          --cycle;
path wedge0_edge=subpath(wedge0_left,left0_intersection[0],0)
		 &subpath(wedgecap0,wc0_t_l,wc0_t_r)
		 &subpath(wedge0_right,0,right0_intersection[0]);
real[] left1_intersection=intersect(wedge1_left,set_bound);
real[] right1_intersection=intersect(wedge1_right,set_bound);
path wedge1=(subpath(wedgecap1,wc1_t_r,wc1_t_l)
	    &subpath(wedge1_left,0,left1_intersection[0])
	    &subpath(set_bound,left1_intersection[1],right1_intersection[1]))
          --cycle;
path wedge1_edge=subpath(wedge1_left,left1_intersection[0],0)
		 &subpath(wedgecap1,wc1_t_l,wc1_t_r)
		 &subpath(wedge1_right,0,right1_intersection[0]);

// draw it all
filldraw(pic,set_bound, AXISPEN, fillpen=backgroundcolor);
filldraw(pic,wedge0,lightcolor,fillpen=white);
filldraw(pic,wedgecap0,lightcolor,fillpen=white);
draw(pic,wedge0_edge,highlightcolor);

filldraw(pic,wedge1,lightcolor,fillpen=white);
filldraw(pic,wedgecap1,lightcolor,fillpen=white);
draw(pic,wedge1_edge,highlightcolor);
draw(pic,set_bound, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======== Try a different graphic ====================================
string OUTPUT_FN = "pnp1%03d";

// REG: https://math.stackexchange.com/a/84070/12012

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
  path pt_path = shift(pt)*scale(0.02)*unitcircle;
  return pt_path;
}

// seed the random number generator;
//   If seconds() then uncomment to show on screen to save the number for later
int srand_seed = 1619633659;
// int srand_seed = seconds();
// write(format("PNP.ASY: srand_seed for point-picking is %d",srand_seed));
srand(srand_seed); 

// Use that seed to pick some points; they must be inside the UNIVERSE
pair[] pts;
int numpts=25;
bool flag=false;
pair onept;  // a candidate point
real padding=0.15; // min dist between points
for(int i=0; i<numpts; ++i) {
  flag=false;
  int tries=0; // watch for inf loop
  while(flag==false){
    if(tries>100) {
      write("Too many tries; making fewer points");
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

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ..... Labeled universe .............
picture pic;
int picnum=1;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

// Draw points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 

label(pic,"{\scriptsize All languages:}", (-0.5*UNIVERSE_WD,0.9*UNIVERSE_HT),2*W);

label(pic,"{\scriptsize Langs with fast algorithms}", (0.5*UNIVERSE_WD,0.1*UNIVERSE_HT),2*E);
label(pic,"{\scriptsize \hspace*{4em}$\vdots$}", (0.5*UNIVERSE_WD,0.375*UNIVERSE_HT),2*E);
label(pic,"\makebox[\width][l]{\scriptsize Langs with slow algorithms}", (0.5*UNIVERSE_WD,0.55*UNIVERSE_HT),2*E);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


real REC_HGT = 1.8;
// ........... Label REC ..........
picture pic;
int picnum=2;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of Recursive langugages
// Recursive langs
// draw(pic, parabola(0.25,1.8), blue);
path rec_arc = parabolic_arc(0.25,REC_HGT);

// RE langs
real re_start = 0.80*length(rec_arc);
path re_arc = point(UNIVERSE, 1.15){(1,1.1)}..{dir(rec_arc,re_start)}point(rec_arc,re_start);

// Fill before draw
path re_area = buildcycle(re_arc,rec_arc,UNIVERSE);
fill(pic,re_area,backgroundcolor+gray(0.1));
// draw(pic,re_area, blue);
path rec_area = buildcycle(rec_arc,UNIVERSE);
fill(pic,rec_area,backgroundcolor);
// draw(pic,rec_area, blue);

draw(pic, rec_arc, base_region_pen);
draw(pic, re_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label them
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.77*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{RE}}",(label_x,0.5*label_y),W); 

// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........... Label P ..........
picture pic;
int picnum=3;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P
path P_arc = parabolic_arc(1.5,0.8);

path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........... Label P=NP ..........
picture pic;
int picnum=4;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P=NP
path P_arc = parabolic_arc(1.5,0.8); 

path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;

draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\P=\NP$}",(label_x,0.5*label_y),E); 

// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........... Label P and NP ..........
picture pic;
int picnum=5;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P and NP langugages as unequal
path P_arc = parabolic_arc(1.5,0.8); 
path NP_arc = parabolic_arc(1.85,1.0); 

path NP_area = buildcycle(NP_arc,UNIVERSE);
fill(pic, NP_area, backgroundcolor+gray(0.1));
path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);

draw(pic, P_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\P$}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.39*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\NP$}",(label_x,0.5*label_y),W); 


// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........... Label P and NP and EXP ..........
picture pic;
int picnum=6;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P and NP langugages as unequal
path P_arc = parabolic_arc(1.5,0.8); 
path NP_arc = parabolic_arc(1.85,1.0); 
path EXP_arc = parabolic_arc(2.10,1.2); 

// Fill before draw
path EXP_area = buildcycle(EXP_arc,UNIVERSE);
fill(pic, EXP_area, backgroundcolor+gray(0.15));
path NP_area = buildcycle(NP_arc,UNIVERSE);
fill(pic, NP_area, backgroundcolor+gray(0.09));
path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);

draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
draw(pic, EXP_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.32*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\P$}",(label_x,0.5*label_y),E); 

real label_x = 0.95*UNIVERSE_WD;
real label_y = 0.38*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\NP$}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.47*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\EXP$}",(label_x,0.5*label_y),W); 


// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ........... Label P and NP and NP Hard ..........
picture pic;
int picnum=7;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P and NP langugages as unequal
path P_arc = parabolic_arc(1.5,0.8); 
path NP_arc = parabolic_arc(1.85,1.0); 
path NP_hard_arc = parabolic_arc(-0.75,0.9); 

path rec_arc = parabolic_arc(0.25,REC_HGT);  // copied from pic 2

// Fill before draw
path NP_area = buildcycle(NP_arc,UNIVERSE);
fill(pic, NP_area, backgroundcolor+gray(0.09));
path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);
// path NP_hard_area = buildcycle(UNIVERSE,NP_hard_arc);
path NP_hard_area = buildcycle(subpath(UNIVERSE,0,2),rec_arc,subpath(UNIVERSE,2,4),NP_hard_arc);

real NP_hard_min_time = dirtime(NP_hard_arc,(1,0));
pair NP_hard_min = point(NP_hard_arc,NP_hard_min_time); 
radialshade(pic,NP_hard_area,backgroundcolor,NP_hard_min,0,
	                     white,NP_hard_min,0.4*UNIVERSE_HT);

path np_complete = buildcycle(NP_arc, NP_hard_arc);
fill(pic, np_complete, backgroundcolor+highlightcolor);

// draw's after fill's
draw(pic, P_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
draw(pic, NP_hard_arc, base_region_pen);
// (note that we cover the stubs at end)

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\P$}",(label_x,0.5*label_y),E); 

real label_x = 0.95*UNIVERSE_WD;
real label_y = 0.38*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\NP$}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y_bot = 0.37*UNIVERSE_HT;
real label_y_top = 0.70*UNIVERSE_HT;
draw(pic,// (label_x+0.5*WHISKER_WD,label_y_top)--
     (label_x,label_y_top)--(label_x,label_y_bot)--(label_x+0.5*WHISKER_WD,label_y_bot), squarebraces_label_pen);
label(pic,"{\scriptsize \compclass{NP} hard}",(label_x,0.5*(label_y_top-label_y_bot)+label_y_bot),W); 

// Locate NP Complete
pair np_complete = (0,0.38*UNIVERSE_HT);
path NP_complete_tag = np_complete{(1,2)}
                       .. tension 1.6 .. np_complete+(0.32*UNIVERSE_WD,0.25*UNIVERSE_HT)
                       .. tension 0.8 .. np_complete+(0.36*UNIVERSE_WD,0.23*UNIVERSE_HT)
                       .. tension 1.2 .. {E}(np_complete+(0.60*UNIVERSE_WD,0.3*UNIVERSE_HT));
draw(pic,NP_complete_tag,THINPEN);
label(pic,"{\scriptsize $\NP$ complete}",np_complete+(0.60*UNIVERSE_WD,0.3*UNIVERSE_HT),E); 

// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Connect some problems to depict \leq_p ======
picture pic;
int picnum=8;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

// Find the region of Recursive langugages
path rec_arc = parabolic_arc(0.25,1.8); 
// draw(pic, rec_arc, base_region_pen+opacity(0.5)); // not show?

path non_rec_langs = buildcycle(UNIVERSE, rec_arc); // the non-recursive langs

// Draw the region of P langugages
path P_arc = parabolic_arc(1.5,0.8); 
// Find region where langs are in P
path p_langs = buildcycle(P_arc,UNIVERSE);

// Draw edges

// use seconds() to try verious random pics, then save one I like
int srand_seed = 1619633854; // 
// int srand_seed = seconds();
// write(format("PNP.ASY: Picture 1008: srand_seed for edge-picking is %d",srand_seed));  // when trying random seeds, can save ones that I like
srand(srand_seed); 

int numedges = floor(numpts/2);
for (int i=0; i<numedges; ++i) {
  int firstpt_dex = floor((pts.length-0.01)*unitrand());
  pair firstpt = pts[firstpt_dex];
  int secondpt_dex = floor((pts.length-0.01)*unitrand());
  pair secondpt = pts[secondpt_dex];
  if (inside(p_langs,firstpt) && inside(p_langs,secondpt)) {
      draw(pic, firstpt--secondpt, highlightcolor);
  } else {
    if (!inside(non_rec_langs,firstpt) && !inside(non_rec_langs,secondpt)) {
      draw(pic, firstpt--secondpt, backgroundcolor);
    }
  }
}

// Every pt in P is connected to every other point
for (int i=0; i<numpts; ++i) {
  pair firstpt = pts[i];
  if (inside(p_langs,firstpt)) {
    for (int j=0; j<numpts; ++j) {
      if (i != j) {
	pair secondpt = pts[j];
	if (inside(p_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, highlightcolor);
	} else {
	  if (!inside(non_rec_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, backgroundcolor);
	  }
	}
      }
    }
  }
}
// Connect points in P to other points in P, on top of all other connections
for (int i=0; i<numpts; ++i) {
  pair firstpt = pts[i];
  if (inside(p_langs,firstpt)) {
    for (int j=0; j<numpts; ++j) {
      if (i != j) {
	pair secondpt = pts[j];
	if (inside(p_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, highlightcolor);
	}
      }
    }
  }
}

// Draw the boundary of P
draw(pic, P_arc, base_region_pen);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Label them
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize $\P$}",(label_x,0.5*label_y),E); 

real label_x = -0.70*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),W); 

// Draw points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== Cone that is \bigOh(g) ======
picture pic;
int picnum=9;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

path equiv_ellipse = shift(-0.05*UNIVERSE_WD,0.55*UNIVERSE_HT)*scale(0.07)*ellipse((0,0),1,0.6);
// draw(pic,equiv_ellipse, red);
real ellipse_left_time = 1.9; // path time on left side of ellipse for int
real ellipse_right_time = 0.1;  // On right side
// Make line on left extending from ellipse to the edge of the universe 
path wedge_left_line = point(equiv_ellipse, ellipse_left_time)
  -- (point(equiv_ellipse,ellipse_left_time) + 5*dir(equiv_ellipse,ellipse_left_time));
// path wedge_left = point(wedge_left_line,0)
//   -- point(wedge_left_line, intersect(UNIVERSE, wedge_left_line)[1]);
// // draw(pic,wedge_left, blue);
// // Make line on right extending from ellipse to the edge of the universe 
path wedge_right_line = point(equiv_ellipse,ellipse_right_time)
  -- (point(equiv_ellipse,ellipse_right_time) - 5*dir(equiv_ellipse,ellipse_right_time));
// path wedge_right = point(wedge_right_line,0)
//   -- point(wedge_right_line, intersect(UNIVERSE, wedge_right_line)[1]);
path bigo_wedge = subpath(equiv_ellipse, ellipse_right_time, ellipse_left_time)
  .. tension 20 .. subpath(UNIVERSE, intersect(UNIVERSE, wedge_left_line)[0], 0)
  .. subpath(UNIVERSE, length(UNIVERSE), intersect(UNIVERSE, wedge_right_line)[0])
  .. tension 20 .. cycle;
filldraw(pic, bigo_wedge, backgroundcolor, THINPEN);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Cone that is \bigOh(g), with equiv class ======
picture pic;
int picnum=10;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

path equiv_ellipse = shift(-0.05*UNIVERSE_WD,0.55*UNIVERSE_HT)*scale(0.07)*ellipse((0,0),1,0.6);
// draw(pic,equiv_ellipse, red);
real ellipse_left_time = 1.9; // path time on left side of ellipse for int
real ellipse_right_time = 0.1;  // On right side
// Make line on left extending from ellipse to the edge of the universe 
path wedge_left_line = point(equiv_ellipse, ellipse_left_time)
  -- (point(equiv_ellipse,ellipse_left_time) + 5*dir(equiv_ellipse,ellipse_left_time));
// path wedge_left = point(wedge_left_line,0)
//   -- point(wedge_left_line, intersect(UNIVERSE, wedge_left_line)[1]);
// // draw(pic,wedge_left, blue);
// // Make line on right extending from ellipse to the edge of the universe 
path wedge_right_line = point(equiv_ellipse,ellipse_right_time)
  -- (point(equiv_ellipse,ellipse_right_time) - 5*dir(equiv_ellipse,ellipse_right_time));
// path wedge_right = point(wedge_right_line,0)
//   -- point(wedge_right_line, intersect(UNIVERSE, wedge_right_line)[1]);
path bigo_wedge = subpath(equiv_ellipse, ellipse_right_time, ellipse_left_time)
  .. tension 20 .. subpath(UNIVERSE, intersect(UNIVERSE, wedge_left_line)[0], 0)
  .. subpath(UNIVERSE, length(UNIVERSE), intersect(UNIVERSE, wedge_right_line)[0])
  .. tension 20 .. cycle;
filldraw(pic, bigo_wedge, backgroundcolor, THINPEN);
filldraw(pic, equiv_ellipse, highlightcolor+opacity(0.5), THINPEN+dotted);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ................... Cones that are \bigOh(g) and \bigOh(f) .......
picture pic;
int picnum=11;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

path equiv_ellipse = shift(-0.05*UNIVERSE_WD,0.55*UNIVERSE_HT)*scale(0.07)*ellipse((0,0),1,0.6);
// draw(pic,equiv_ellipse, red);
real ellipse_left_time = 1.9; // path time on left side of ellipse for int
real ellipse_right_time = 0.1;  // On right side
// Make line on left extending from ellipse to the edge of the universe 
path wedge_left_line = point(equiv_ellipse, ellipse_left_time)
  -- (point(equiv_ellipse,ellipse_left_time) + 5*dir(equiv_ellipse,ellipse_left_time));
// // Make line on right extending from ellipse to the edge of the universe 
path wedge_right_line = point(equiv_ellipse,ellipse_right_time)
  -- (point(equiv_ellipse,ellipse_right_time) - 5*dir(equiv_ellipse,ellipse_right_time));
path bigo_wedge = subpath(equiv_ellipse, ellipse_right_time, ellipse_left_time)
  .. tension 20 .. subpath(UNIVERSE, intersect(UNIVERSE, wedge_left_line)[0], 0)
  .. subpath(UNIVERSE, length(UNIVERSE), intersect(UNIVERSE, wedge_right_line)[0])
  .. tension 20 .. cycle;
filldraw(pic, bigo_wedge, backgroundcolor, THINPEN);

path equiv_ellipse_f = shift(-0.07*UNIVERSE_WD,0.30*UNIVERSE_HT)*scale(0.04)*ellipse((0,0),1,0.6);
// draw(pic,equiv_ellipse, red);
// real ellipse_left_time = 1.9; // path time on left side of ellipse for int
// real ellipse_right_time = 0.1;  // On right side
// Make line on left extending from ellipse to the edge of the universe 
path wedge_left_line_f = point(equiv_ellipse_f, ellipse_left_time)
  -- (point(equiv_ellipse_f,ellipse_left_time) + 5*dir(equiv_ellipse_f,ellipse_left_time));
// // Make line on right extending from ellipse to the edge of the universe 
path wedge_right_line_f = point(equiv_ellipse_f,ellipse_right_time)
  -- (point(equiv_ellipse_f,ellipse_right_time) - 5*dir(equiv_ellipse_f,ellipse_right_time));
path bigo_wedge_f = subpath(equiv_ellipse_f, ellipse_right_time, ellipse_left_time)
  .. tension 20 .. subpath(UNIVERSE, intersect(UNIVERSE, wedge_left_line_f)[0], 0)
  .. subpath(UNIVERSE, length(UNIVERSE), intersect(UNIVERSE, wedge_right_line_f)[0])
  .. tension 20 .. cycle;
filldraw(pic, bigo_wedge_f, backgroundcolor+gray(0.1),THINPEN);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.55*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\bigOh(g)$}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\bigOh(f)$}",(label_x,0.5*label_y),W); 


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ........... Exercise: Label sets on P and NP and NP Hard graph ..........
picture pic;
int picnum=12;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Draw the region of P and NP langugages as unequal
path P_arc = parabolic_arc(1.5,0.8); 
path NP_arc = parabolic_arc(1.85,1.0); 
path NP_hard_arc = parabolic_arc(-0.75,0.9); 

path rec_arc = parabolic_arc(0.25,REC_HGT);  // copied from pic 2
// RE langs  (added from Fig 107)
real re_start = 0.80*length(rec_arc);
path re_arc = point(UNIVERSE, 1.15){(1,1.1)}..{dir(rec_arc,re_start)}point(rec_arc,re_start);

// Fill before draw
path NP_area = buildcycle(NP_arc,UNIVERSE);
fill(pic, NP_area, backgroundcolor+gray(0.09));
path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic, P_area, backgroundcolor);
// path NP_hard_area = buildcycle(UNIVERSE,NP_hard_arc);
path NP_hard_area = buildcycle(subpath(UNIVERSE,0,2),rec_arc,subpath(UNIVERSE,2,4),NP_hard_arc);

real NP_hard_min_time = dirtime(NP_hard_arc,(1,0));
pair NP_hard_min = point(NP_hard_arc,NP_hard_min_time); 
radialshade(pic,NP_hard_area,backgroundcolor,NP_hard_min,0,
	                     white,NP_hard_min,0.4*UNIVERSE_HT);

path np_complete = buildcycle(NP_arc, NP_hard_arc);
fill(pic, np_complete, backgroundcolor+highlightcolor);

// draw's after fill's
draw(pic, P_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
draw(pic, NP_hard_arc, base_region_pen);
draw(pic, rec_arc, base_region_pen);  // added from fig 1007
draw(pic, re_arc, base_region_pen);  // added from fig 1007
// (note that we cover the stubs at end)

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.30*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\P$}",(label_x,0.5*label_y),E); 

real label_x = 0.95*UNIVERSE_WD;
real label_y = 0.38*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"{\scriptsize $\NP$}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y_bot = 0.37*UNIVERSE_HT;
real label_y_top = 0.70*UNIVERSE_HT;
draw(pic,// (label_x+0.5*WHISKER_WD,label_y_top)--
     (label_x,label_y_top)--(label_x,label_y_bot)--(label_x+0.5*WHISKER_WD,label_y_bot), squarebraces_label_pen);
label(pic,"{\scriptsize \compclass{NP} hard}",(label_x,0.5*(label_y_top-label_y_bot)+label_y_bot),W); 

real label_x = -1.5*UNIVERSE_WD;
real label_y_bot = 0.00*UNIVERSE_HT;
real label_y_top = 0.70*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y_top)--
     (label_x,label_y_top)--(label_x,label_y_bot)--(label_x+0.5*WHISKER_WD,label_y_bot), squarebraces_label_pen);
label(pic,"{\scriptsize $\compclass{Rec}$}",(label_x,0.5*(label_y_top-label_y_bot)+label_y_bot),W); 

real label_x = -1.95*UNIVERSE_WD;
real label_y_bot = 0.00*UNIVERSE_HT;
real label_y_top = 0.77*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y_top)--
     (label_x,label_y_top)--(label_x,label_y_bot)--(label_x+0.5*WHISKER_WD,label_y_bot), squarebraces_label_pen);
label(pic,"{\scriptsize $\compclass{RE}$}",(label_x,0.5*(label_y_top-label_y_bot)+label_y_bot),W); 

// Locate NP Complete
pair np_complete = (0,0.38*UNIVERSE_HT);
path NP_complete_tag = np_complete{(1,1)}
                       .. tension 1.6 .. np_complete+(0.33*UNIVERSE_WD,0.22*UNIVERSE_HT)
                       .. tension 0.8 .. np_complete+(0.36*UNIVERSE_WD,0.21*UNIVERSE_HT)
                       .. tension 1.2 .. {NE}(np_complete+(0.60*UNIVERSE_WD,0.3*UNIVERSE_HT));
draw(pic,NP_complete_tag,THINPEN+gray(0.5));
label(pic,"{\scriptsize $\NP$ complete}",np_complete+(0.60*UNIVERSE_WD,0.3*UNIVERSE_HT),E); 

// Draw points
// for(int i=0; i<pts.length; ++i){
//   filldraw(pic, make_pt_path(pts[i]), THINPEN+boldcolor, fillpen=white);
// } 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// =============================================================
// Pictues with NP not across whole width

string OUTPUT_FN = "pnp2%03d";

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
  path pt_path = shift(pt)*scale(0.02)*unitcircle;
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
// write(format("PNP.ASY: srand_seed for point-picking is %d",srand_seed));
int srand_seed = 1650314745;
srand(srand_seed); 

// Use that seed to pick some points; they must be inside the UNIVERSE
pair[] pts;
int numpts=30;
bool flag=false;
pair onept;  // a candidate point
real padding=0.15; // min dist between points
for(int i=0; i<numpts; ++i) {
  flag=false;
  int tries=0; // watch for inf loop
  while(flag==false){
    if(tries>100) {
      write("Too many tries; making fewer points");
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

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ..... Labeled universe .............
picture pic;
int picnum=1;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

// Draw points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 

label(pic,"{\scriptsize All languages:}", (-0.5*UNIVERSE_WD,0.9*UNIVERSE_HT),2*W);

label(pic,"{\scriptsize Langs with fast algorithms}", (0.5*UNIVERSE_WD,0.1*UNIVERSE_HT),2*E);
label(pic,"{\scriptsize \hspace*{4em}$\vdots$}", (0.5*UNIVERSE_WD,0.375*UNIVERSE_HT),2*E);
label(pic,"\makebox[\width][l]{\scriptsize Langs with slow algorithms}", (0.5*UNIVERSE_WD,0.55*UNIVERSE_HT),2*E);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// Draw the region of Recursive langugages
// Recursive langs
real REC_HGT = 1.8;
path rec_arc = parabolic_arc(0.25,REC_HGT);

// RE langs
real re_start = 0.80*length(rec_arc);
path re_arc = point(UNIVERSE, 1.15){(1,1.0)}..{dir(rec_arc,re_start)}point(rec_arc,re_start);
// path re_arc = point(UNIVERSE, 1.15)..{dir(rec_arc,re_start)}point(rec_arc,re_start);

// ........... Label REC ..........
picture pic;
int picnum=2;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path re_area = buildcycle(re_arc,rec_arc,UNIVERSE);
fill(pic,re_area,backgroundcolor+gray(0.1));

// draw(pic,re_area, blue);
path rec_area = buildcycle(rec_arc,UNIVERSE);
fill(pic,rec_area,backgroundcolor);

draw(pic, rec_arc, base_region_pen);
draw(pic, re_arc, base_region_pen);
// (note that we cover the stubs at end)

// Label them
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
draw(pic,(label_x-0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x-0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),E); 

real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.77*UNIVERSE_HT;
draw(pic,(label_x+0.5*WHISKER_WD,label_y)--(label_x,label_y)--(label_x,0)--(label_x+0.5*WHISKER_WD,0), squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{RE}}",(label_x,0.5*label_y),W); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// Complexity class P
real P_HGT = 0.6;
path P_arc = parabolic_arc(0.25,P_HGT);


// ------------------- P -------------------
picture pic;
int picnum=3;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs below)

// Put in the line with bars and label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ------------------- P and NP -------------------
// Complexity class NP

// NP arc
real NP_start = 0.80*length(P_arc);
path NP_arc = point(UNIVERSE, 0.55){(1,1.00)}..{dir(P_arc,NP_start)}point(P_arc,NP_start);


// ............................
picture pic;
int picnum=4;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path NP_area = buildcycle(NP_arc,P_arc,UNIVERSE);
fill(pic,NP_area,backgroundcolor+gray(0.1));

// Fill before draw
path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);

// Draw
draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs below)

// Put in the P line with bars and label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Put in the NP line with bars and label it
real label_x = -0.65*UNIVERSE_WD;
real label_y = 0.325*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{NP}}",(label_x,0.5*label_y),W); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... P=NP ..................
picture pic;
int picnum=5;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
// path NP_area = buildcycle(NP_arc,subpath(P_arc,NP_start,length(P_arc)),UNIVERSE);
// fill(pic,NP_area,backgroundcolor);

// Fill before draw
path P_area = buildcycle(P_arc,UNIVERSE);
fill(pic,P_area,backgroundcolor);

// Draw
// draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs below)

// Put in the P line with bars and label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}=\compclass{NP}}",(label_x,0.5*label_y),E); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ------------------- P, NP, and EXP -------------------
// Complexity class NP

// NP arc
real EXP_start = 0.85*length(P_arc);
path EXP_arc = point(UNIVERSE, 0.63){dir(NP_arc,0)}..{dir(P_arc,EXP_start)}point(P_arc,EXP_start);


// ............................
picture pic;
int picnum=6;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path EXP_area = buildcycle(EXP_arc,P_arc,UNIVERSE);
fill(pic,EXP_area,backgroundcolor+gray(0.2));

// Fill before draw
// path NP_area = buildcycle(NP_arc,P_arc,UNIVERSE);
fill(pic,NP_area,backgroundcolor+gray(0.1));

// Fill before draw
// path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);

// Draw
draw(pic, EXP_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
// (note that we cover the stubs below)

// Put in the P line with bars and label it
real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Put in the NP line with bars and label it
real label_x = -0.6*UNIVERSE_WD;
real label_y = 0.3*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{NP}}",(label_x,0.5*label_y),W); 

// Put in the EXP line with bars and label it
real label_x = -1.0*UNIVERSE_WD;
real label_y = 0.38*UNIVERSE_HT;
path exp_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,exp_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{EXP}}",(label_x,0.5*label_y),W); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ------------------- P and NP and NP hard -------------------
// 

// NP hard arc
// Make longer arc, then cut it off at intersection with UNIVERSE
path NP_hard_arc_full = point(NP_arc, 0){(1,0.05)}::point(NP_arc,0.5){(0.5,1.0)}..(point(NP_arc,0.5).x+0.125*UNIVERSE_WD,UNIVERSE_HT);
real[][] hard_arc_times = intersections(NP_hard_arc_full,subpath(UNIVERSE,0,3));
// write(format("first time is %f", hard_arc_times[1][0]));
// write(format("  second time is %f", hard_arc_times[1][1]));
path NP_hard_arc = subpath(NP_hard_arc_full, 0, hard_arc_times[1][0]);



// .............NP hard ...............
picture pic;
int picnum=7;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Make top of NP area unioed P area
pair P_NP_arc_t = intersect(P_arc,NP_arc)[0];   
path NP_arc_full = NP_arc&subpath(P_arc,P_NP_arc_t.x,length(P_arc));

// Fill before draw
// path NP_area = buildcycle(NP_arc,P_arc,UNIVERSE);
// fill(pic,NP_area,backgroundcolor);
path NP_area = buildcycle(NP_arc_full,UNIVERSE);
fill(pic,NP_area,backgroundcolor);

// Fill before draw
path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);

// Have NP hard area fade out near rec boundary
// path NP_hard_area = buildcycle(subpath(UNIVERSE,0,2),rec_arc,NP_hard_arc);
path NP_hard_area = buildcycle(subpath(UNIVERSE,0,3),NP_hard_arc_full);
real NP_hard_min_time = dirtime(NP_hard_arc,(1,0));
pair NP_hard_min = point(NP_hard_arc,NP_hard_min_time); 
// radialshade(pic,NP_hard_area,backgroundcolor,NP_hard_min,0,
// 	                     white,NP_hard_min,0.45*UNIVERSE_HT);
fill(pic,NP_hard_area,backgroundcolor+gray(0.1));

// Color NP complete area highlight color
path NP_complete_area = buildcycle(NP_hard_arc,NP_arc);
fill(pic,NP_complete_area,backgroundcolor+highlightcolor);

// Draw region boundaries
draw(pic, NP_hard_arc, base_region_pen);
// draw(pic, P_arc,gray(0.5));
// pair P_NP_arc_t = intersect(P_arc,NP_arc)[0]; // adjoin NP_arc to rt of P_arc  
draw(pic, NP_arc_full, base_region_pen);
// (note that we cover the stubs below)

// Put in the P line with bars and label it
// real label_x = 0.55*UNIVERSE_WD;
// real label_y = 0.225*UNIVERSE_HT;
// path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
// draw(pic,p_halfbar,squarebraces_label_pen);
// label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Put in the NP line with bars and label it
//  was: real label_x = 0.9*UNIVERSE_WD;
real label_x = 0.60*UNIVERSE_WD;
real label_y = 0.325*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{NP}}",(label_x,0.5*label_y),E); 

// Put in the NP hard line with bars and label it
real label_x = -0.65*UNIVERSE_WD;
real label_y_top = 1.0*UNIVERSE_HT;
real label_y_bot = 0.275*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y_top)--(label_x,label_y_bot),(0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{NP} hard}",(label_x,0.5*(label_y_top+label_y_bot)),W); 

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Locate NP Complete, make a path to the tag
pair np_complete = (-0.25*UNIVERSE_WD,0.295*UNIVERSE_HT);
path NP_complete_tag = np_complete{(-1,-0.1)} .. {W}(np_complete+(-0.45*UNIVERSE_WD,-0.175*UNIVERSE_HT));
draw(pic,NP_complete_tag,THINPEN);
label(pic,"{\scriptsize $\NP$ complete}",np_complete+(-0.45*UNIVERSE_WD,-0.17*UNIVERSE_HT),W); 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ---------------- Connect some problems to depict \leq_p ----------
picture pic;
int picnum=8;

unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);
// (note that  we cover the stubs at end)

// Find the area containing noncomputable langugages
// path rec_arc = parabolic_arc(0.25,1.8); 
// draw(pic, rec_arc, base_region_pen+opacity(0.5)); // not show?

path non_rec_langs = buildcycle(UNIVERSE, rec_arc); // the non-recursive langs

// Find the are of P langugages
path p_langs = buildcycle(P_arc,UNIVERSE);

// pts is an array of points from figure number 0.
// Draw edges
// seed the random number generator;
//   If seconds() then uncomment to show on screen to save the number for later
// int srand_seed = seconds();
// write(format("PNP.ASY: srand_seed for edges is %d",srand_seed));
int srand_seed = 1650318522;
srand(srand_seed); 

int numedges = floor(numpts/2);
for (int i=0; i<numedges; ++i) {
  int firstpt_dex = floor((pts.length-0.01)*unitrand());
  pair firstpt = pts[firstpt_dex];
  int secondpt_dex = floor((pts.length-0.01)*unitrand());
  pair secondpt = pts[secondpt_dex];
  if (inside(p_langs,firstpt) && inside(p_langs,secondpt)) {
      draw(pic, firstpt--secondpt, highlightcolor);
  } else {
    if (!inside(non_rec_langs,firstpt)
	&& !inside(non_rec_langs,secondpt)
	&& unitrand() < 0.4) {
      draw(pic, firstpt--secondpt, backgroundcolor);
    } else {  // non recursive languages
      if (unitrand() < 0.95) {
        draw(pic, firstpt--secondpt, backgroundcolor);
      }
    }
  }
}

// Every pt in P is connected to every other point
for (int i=0; i<numpts; ++i) {
  pair firstpt = pts[i];
  if (inside(p_langs,firstpt)) {
    for (int j=0; j<numpts; ++j) {
      if (i != j) {
	pair secondpt = pts[j];
	if (inside(p_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, highlightcolor);
	} else {
	  // if (!inside(non_rec_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, backgroundcolor);
	  // }
	}
      }
    }
  }
}
// Connect points in P to other points in P, redrawn, over all other connections
for (int i=0; i<numpts; ++i) {
  pair firstpt = pts[i];
  if (inside(p_langs,firstpt)) {
    for (int j=0; j<numpts; ++j) {
      if (i != j) {
	pair secondpt = pts[j];
	if (inside(p_langs,secondpt)) {
	  draw(pic, firstpt--secondpt, highlightcolor);
	}
      }
    }
  }
}

// Draw the boundary of P
draw(pic, P_arc, base_region_pen);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Label them
real label_x = -0.70*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
// draw(pic,p_halfbar,squarebraces_label_pen);
// label(pic,"\makebox[\width][r]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),W); 

real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 


// Draw points
for(int i=0; i<pts.length; ++i){
  filldraw(pic, make_pt_path(pts[i]), boldcolor, fillpen=white);
} 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............. Exercise to locate languages ...............
picture pic;
int picnum=12;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path NP_area = buildcycle(NP_arc,P_arc,UNIVERSE);
fill(pic,NP_area,backgroundcolor+gray(0.1));

// Fill before draw
path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);

// Have NP hard area fade out near rec boundary
real NP_hard_min_time = dirtime(NP_hard_arc,(1,0));
pair NP_hard_min = point(NP_hard_arc,NP_hard_min_time); 
path NP_hard_area = buildcycle(subpath(UNIVERSE,0,3),NP_hard_arc_full);
// radialshade(pic,NP_hard_area,backgroundcolor,NP_hard_min,0,
// 	                     white,NP_hard_min,0.45*UNIVERSE_HT);
fill(pic,NP_hard_area,backgroundcolor);

// Color NP complete area highlight color
path NP_complete_area = buildcycle(NP_hard_arc,NP_arc);
fill(pic,NP_complete_area,backgroundcolor+highlightcolor);

// Draw region boundaries
draw(pic, NP_hard_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
draw(pic, rec_arc, base_region_pen);
draw(pic, re_arc, base_region_pen);
// (note that we cover the stubs at end)

// Put in the P line with bars and label it
real label_x = 0.55*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Put in the NP line with bars and label it
real label_x = 0.9*UNIVERSE_WD;
real label_y = 0.325*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{NP}}",(label_x,0.5*label_y),E); 

// Put in the NP hard line with bars and label it
real label_x = -0.65*UNIVERSE_WD;
real label_y_top = 1.0*UNIVERSE_HT;
real label_y_bot = 0.275*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y_top)--(label_x,label_y_bot),(0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{NP} hard}",(label_x,0.5*(label_y_top+label_y_bot)),W);

// Rec label
real label_x = -1.55*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),W); 

// RE label
real label_x = -2.0*UNIVERSE_WD;
real label_y = 0.77*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{RE}}",(label_x,0.5*label_y),W); 


// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

// Locate NP Complete, make a path to the tag
// pair np_complete = (-0.25*UNIVERSE_WD,0.295*UNIVERSE_HT);
// path NP_complete_tag = np_complete{(-1,-0.1)} .. {W}(np_complete+(-0.45*UNIVERSE_WD,-0.175*UNIVERSE_HT));
// draw(pic,NP_complete_tag,THINPEN);
// label(pic,"{\scriptsize $\NP$ complete}",np_complete+(-0.45*UNIVERSE_WD,-0.17*UNIVERSE_HT),W); 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



path trim_ends(path p, real trim_start, real trim_end) {
  path start_circle = circle( point(p,0), trim_start );
  path end_circle = circle( point(p,length(p)), trim_end );
  real start_t = intersections(p, start_circle)[0][0];
  real[][] int_times = intersections(p, end_circle); 
  real end_t = int_times[int_times.length-1][0];
  return subpath(p, start_t, end_t);
}




// ............. Exercise to locate languages ...............
picture pic;
int picnum=13;
unitsize(pic,1cm);

// Draw the universe of all langugaes
filldraw(pic,UNIVERSE, white, AXISPEN);

// Fill before draw
path NP_area = buildcycle(NP_arc,P_arc,UNIVERSE);
fill(pic,NP_area,backgroundcolor+gray(0.1));

// Fill before draw
path p_area = buildcycle(P_arc,UNIVERSE);
fill(pic,p_area,backgroundcolor);

// NP hard area
real NP_hard_min_time = dirtime(NP_hard_arc,(1,0));
pair NP_hard_min = point(NP_hard_arc,NP_hard_min_time); 
path NP_hard_area = buildcycle(subpath(UNIVERSE,0,3),NP_hard_arc_full);
// radialshade(pic,NP_hard_area,backgroundcolor,NP_hard_min,0,
// 	                     white,NP_hard_min,0.45*UNIVERSE_HT);
fill(pic,NP_hard_area,backgroundcolor);

// Color NP complete area highlight color
path NP_complete_area = buildcycle(NP_hard_arc,NP_arc);
fill(pic,NP_complete_area,backgroundcolor+highlightcolor);

// Draw region boundaries
draw(pic, NP_hard_arc, base_region_pen);
draw(pic, NP_arc, base_region_pen);
draw(pic, P_arc, base_region_pen);
draw(pic, rec_arc, base_region_pen);
draw(pic, re_arc, base_region_pen);
// (note that we cover the stubs at end)

// Put in the P line with bars and label it
real label_x = 0.55*UNIVERSE_WD;
real label_y = 0.225*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{P}}",(label_x,0.5*label_y),E); 

// Put in the NP line with bars and label it
real label_x = 0.9*UNIVERSE_WD;
real label_y = 0.325*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y)--(label_x,0),(-0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{NP}}",(label_x,0.5*label_y),E); 

// Put in the NP hard line with bars and label it
real label_x = -0.65*UNIVERSE_WD;
real label_y_top = 1.0*UNIVERSE_HT;
real label_y_bot = 0.275*UNIVERSE_HT;
path np_halfbar = halfbar((label_x,label_y_top)--(label_x,label_y_bot),(0.5*WHISKER_WD,0));
draw(pic,np_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{NP} hard}",(label_x,0.5*(label_y_top+label_y_bot)),W);

// Rec label
real label_x = -1.55*UNIVERSE_WD;
real label_y = 0.68*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][r]{\scriptsize \compclass{Rec}}",(label_x,0.5*label_y),W); 

// RE label
real label_x = -2.0*UNIVERSE_WD;
real label_y = 0.77*UNIVERSE_HT;
path p_halfbar = halfbar((label_x,label_y)--(label_x,0),(0.5*WHISKER_WD,0));
draw(pic,p_halfbar,squarebraces_label_pen);
label(pic,"\makebox[\width][l]{\scriptsize \compclass{RE}}",(label_x,0.5*label_y),W); 

// Four sets given in the problem
pair K = point(re_arc,0.325);
pair SAT = point(NP_arc,0.3);
pair L = (0,0.25);  // Dijkstra's algorithm is sub-quadratic
pair emptyset = point(UNIVERSE,0);

real label_x = 0.65*UNIVERSE_WD;
real label_y = 0.90*UNIVERSE_HT;
pair K_pt = (label_x,label_y);
pair SAT_pt = (label_x,label_y-0.33);
pair L_pt = (label_x,label_y-0.67);
pair emptyset_pt = (label_x,label_y-1.00);
label(pic,"\makebox[\width][r]{\scriptsize $K$}", K_pt,E); 
label(pic,"\makebox[\width][r]{\scriptsize $\SAT$}", SAT_pt,E); 
label(pic,"\makebox[\width][r]{\scriptsize $\lang$}", L_pt,E); 
label(pic,"\makebox[\width][r]{\scriptsize $\emptyset$}", emptyset_pt,E); 
path K_curve = trim_ends(K_pt{W}..{SW}K, 0.0, 0.1); 
path SAT_curve = trim_ends(SAT_pt{W}..{SW}SAT, 0.0, 0.1); 
path L_curve = trim_ends(L_pt{W}..{SW}L, 0.0, 0.1); 
path emptyset_curve = trim_ends(emptyset_pt{W}..{SW}emptyset, 0.0, 0.1); 
draw(pic,K_curve,gray(0.7));
draw(pic,SAT_curve,gray(0.7));
draw(pic,L_curve,gray(0.7));
draw(pic,emptyset_curve,gray(0.7));
// dotfactor = 4;
// dot(pic,K,black);
// dot(pic,SAT,black);
// dot(pic,L,black);
// dot(pic,emptyset,black);

// Cover stubs extending into boundary
draw(pic,UNIVERSE, AXISPEN);

filldraw(pic, circle(K, 0.03), white, black);
filldraw(pic, circle(SAT, 0.03), white, black);
filldraw(pic, circle(L, 0.03), white, black);
filldraw(pic, circle(emptyset, 0.03), white, black);

// Locate NP Complete, make a path to the tag
// pair np_complete = (-0.25*UNIVERSE_WD,0.295*UNIVERSE_HT);
// path NP_complete_tag = np_complete{(-1,-0.1)} .. {W}(np_complete+(-0.45*UNIVERSE_WD,-0.175*UNIVERSE_HT));
// draw(pic,NP_complete_tag,THINPEN);
// label(pic,"{\scriptsize $\NP$ complete}",np_complete+(-0.45*UNIVERSE_WD,-0.17*UNIVERSE_HT),W); 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







