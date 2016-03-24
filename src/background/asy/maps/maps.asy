// maps.asy
//  Illustrate functions

import settings;
settings.outformat="pdf";
settings.render=0;

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");
import jh;
cd("");

// Draw a set bean
path setbean(real h=1, real v=1) {
  path p;
  p = (0,0)..(0,v)..(h,v)..tension(1.2)..(h,-v)..(0,-v)..cycle;
  return p;
}

real h, v;  // horizontal and vertical units for beans
h = 0.70; v = h; 
real DOMAINTOCODOMAIN = 3*h;

// Onto map
picture pic;
int picnum = 0;
unitsize(pic,1cm);

path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
filldraw(pic,domain,fillpen=lightcolor,drawpen=LIGHTPEN);
filldraw(pic,codomain,fillpen=lightcolor,drawpen=LIGHTPEN);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<4; ++i) {
  domainpoint[i] = (0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<3; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
maparrow[3] = domainpoint[3]{dir(15)}..codomainpoint[2];
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[2];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[1];
maparrow[0] = domainpoint[0]{dir(10)}..codomainpoint[0];
for (int i; i<4; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+highlightcolor);
}
shipout(format("maps%02d",picnum),pic,format="pdf");


// One to one map
picture pic;
int picnum = 1;
unitsize(pic,1cm);

path domain, codomain;
domain = setbean(h,v);
codomain = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
filldraw(pic,domain,fillpen=lightcolor,drawpen=LIGHTPEN);
filldraw(pic,codomain,fillpen=lightcolor,drawpen=LIGHTPEN);
// points
pair[] domainpoint, codomainpoint;
for (int i; i<3; ++i) {
  domainpoint[i] = (0.5*h,((-1/2)+0.1)*v+(i/2)*(1)*v);
  dot(pic,domainpoint[i],DARKPEN+black);
}
for (int i; i<4; ++i) {
  codomainpoint[i] = shift(DOMAINTOCODOMAIN,0)*(0.5*h,((-2/3)+0.1)*v+(i/3)*(4/3)*v);
  dot(pic,codomainpoint[i],DARKPEN+black);
}
path[] maparrow;
maparrow[2] = domainpoint[2]{dir(15)}..codomainpoint[3];
maparrow[1] = domainpoint[1]{dir(15)}..codomainpoint[2];
maparrow[0] = domainpoint[0]{dir(15)}..codomainpoint[1];
for (int i; i<3; ++i) {
  draw(pic,subpath(maparrow[i],0.08,0.92),bar=BeginBar(2),arrow=EndArrow(TeXHead),LIGHTPEN+highlightcolor);
}
shipout(format("maps%02d",picnum),pic,format="pdf");


// // Parameters
// real horiz_gap = 1;
// real vert_gap = 1*horiz_gap; // how far to raise numbers in row above

// nodestyle ns_noborder=nodestyle(drawfn=None);
// defaultnodestyle=ns_noborder;
// defaultdrawstyle=drawstyle(p=red+fontsize(9pt), arrow=Arrow(DefaultHead, filltype=Fill(red)));  // seems to have no effect?

// defaultlayoutrel = false;
// defaultlayoutskip = 0.5cm;
// real u = defaultlayoutskip;  // usual unit

// // Correspondence between {0,1}xN and N
// int num_pics = 7;
// int col_hgt = 4;   // how far up to show? 
// for (int picnum=0; picnum <= num_pics; ++picnum) {
//    // debugging: write(stdout,"Here.");
//    picture pic;
//    // unitsize(pic,1cm);
//    // dot(pic,(-.5,0),invisible);
//    // dot(pic,(1.5*horiz_gap,0)+(.5,col_hgt*vert_gap),invisible);
//    // define nodes
//    node[] n = ncircles( "$\sequence{0,0}$",
//      "$\sequence{1,0}$",
//      "$\sequence{0,1}$",
//      "$\sequence{1,1}$",
//      "$\sequence{0,2}$",
//      "$\sequence{1,2}$",
//      "$\sequence{0,3}$",
//      "$\sequence{1,3}$",
//      "\raisebox{0.75ex}{$\vdots$}",
//      "\raisebox{0.75ex}{$\vdots$}" );
//    // layout
//    defaultlayoutrel = false;
//    // gridlayout((5,2), (1.5cm, -0.5cm), n);
//    gridlayout((5,2), (3u, -u), n);
//    // draw nodes
//    draw(pic, n[0], n[1], n[2], n[3], n[4],
// 	   n[5], n[6], n[7], n[8], n[9] );
//    // draw any edges
//    if (picnum > 0) {
//      draw(pic, n[picnum-1] -- n[picnum], DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
//    }
//   shipout(format("correspondences1%03d",picnum),pic,format="pdf");
// }


// // Correspondence between NxN and N
// node[] n = ncircles(
// 		    "$\sequence{0,0}$",  // node 0
// 		    "$\sequence{1,0}$",  // 1
// 		    "$\sequence{2,0}$",  // 2
// 		    "$\sequence{3,0}$",  // 3
// 		    "$\sequence{0,1}$",  // 4
// 		    "$\sequence{1,1}$",  // 5
// 		    "$\sequence{2,1}$",  // 6
// 		    "$\sequence{3,1}$",  // 7
// 		    "$\sequence{0,2}$",  // 8
// 		    "$\sequence{1,2}$",  // 9
// 		    "$\sequence{2,2}$",  // 10
// 		    "$\sequence{3,2}$",  // 11
// 		    "$\sequence{0,3}$",  // 12
// 		    "$\sequence{1,3}$",  // 13
// 		    "$\sequence{2,3}$",  // 14
// 		    "$\sequence{3,3}$" ); // 15
// node[] m = ncircles(
// 		    "$\ldots$", 
// 		    "$\ldots$", 
// 		    "$\ldots$", 
// 		    "\raisebox{0.75ex}{$\vdots$}",
// 		    "\raisebox{0.75ex}{$\vdots$}",
// 		    "\raisebox{0.75ex}{$\vdots$}" 
// 		    );   
// int[] node_list_order = {0,
// 			 4, 1,
// 			 8, 5, 2,
// 			 12, 9, 6, 3};
// // layout
// defaultlayoutrel = false;
// gridlayout((4,4), (3u, -u), n);
// hlayout(2u, n[3], m[0]);
// vlayout(-u, m[0], m[1], m[2] );
// vlayout(-u, n[12], m[3]);
// vlayout(-u, n[13], m[4]);
// vlayout(-u, n[14], m[5]);

// // Animate the correspondence
// int num_pics = 9;
// int col_hgt = 4;   // how far up to show? 
// for (int picnum=0; picnum <= num_pics; ++picnum) {
//   picture pic;
//    // debugging: write(stdout,"Here.");
//    // picture pic;
//    // node[] n = ncircles(
//    // 		       "$\sequence{0,0}$",  // node 0
//    // 		       "$\sequence{1,0}$",  // 1
//    // 		       "$\sequence{2,0}$",  // 2
//    // 		       "$\sequence{3,0}$",  // 3
//    // 		       "$\sequence{0,1}$",  // 4
//    // 		       "$\sequence{1,1}$",  // 5
//    // 		       "$\sequence{2,1}$",  // 6
//    // 		       "$\sequence{3,1}$",  // 7
//    // 		       "$\sequence{0,2}$",  // 8
//    // 		       "$\sequence{1,2}$",  // 9
//    // 		       "$\sequence{2,2}$",  // 10
//    // 		       "$\sequence{3,2}$",  // 11
//    // 		       "$\sequence{0,3}$",  // 12
//    // 		       "$\sequence{1,3}$",  // 13
//    // 		       "$\sequence{2,3}$",  // 14
//    // 		       "$\sequence{3,3}$" ); // 15
//    // node[] m = ncircles(
//    // 		       "$\ldots$", 
//    // 		       "$\ldots$", 
//    // 		       "$\ldots$", 
//    // 		       "\raisebox{0.75ex}{$\vdots$}",
//    // 		       "\raisebox{0.75ex}{$\vdots$}",
//    // 		       "\raisebox{0.75ex}{$\vdots$}" 
//    // 		       );   
//    //   // "\raisebox{0.75ex}{$\vdots$}",
//    //   // "\raisebox{0.75ex}{$\vdots$}" );
//    // int[] node_list_order = {0,
//    // 			    4, 1,
//    // 			    8, 5, 2,
//    // 			    12, 9, 6, 3
//    // };
//    // // layout
//    // defaultlayoutrel = false;
//    // gridlayout((4,4), (1.5cm, -0.5cm), n);
//    // hlayout(1cm, n[3], m[0]);
//    // vlayout(-0.5cm, m[0], m[1], m[2] );
//    // vlayout(-0.5cm, n[12], m[3]);
//    // vlayout(-0.5cm, n[13], m[4]);
//    // vlayout(-0.5cm, n[14], m[5]);
//    // draw nodes
//    draw(pic, n[0], n[1], n[2], n[3], n[4],
// 	n[5], n[6], n[7], n[8], n[9],
// 	n[10], n[11], n[12], n[13], n[14],
// 	n[15]);
//    draw(pic, m[0], m[1], m[2], m[3], m[4], m[5] );
//    // draw any edges
//    if (picnum > 0) {
//      draw(pic, n[node_list_order[picnum-1]] -- n[node_list_order[picnum]],
// 	  DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
//    }
//   shipout(format("correspondences2%03d",picnum),pic,format="pdf");
// }


// // Bring out diagonals
// picture pic;
// int picnum = 0;
// path diag[];  // diagonals
// diag[1] = n[4].pos--n[1].pos;
// diag[2] = n[8].pos--n[2].pos;
// diag[3] = n[12].pos--n[3].pos;
// // extend the diagonals until they meet the boundary
// pair yaxispts[], xaxispts[];
// yaxispts[0]=(-2u,0);
// yaxispts[1]=(-2u,5u);
// xaxispts[0]=(0,-2u);
// xaxispts[1]=(12u,-2u);
// // Long diagonals by extending diagonals on either end, drawing, then cropping
// path longdiag[];  // extend the diagonals on either end
// longdiag[1]=extension(yaxispts[0],yaxispts[1],n[4].pos,n[1].pos)--extension(xaxispts[0],xaxispts[1],n[4].pos,n[1].pos);
// longdiag[2]=extension(yaxispts[0],yaxispts[1],n[8].pos,n[2].pos)--extension(xaxispts[0],xaxispts[1],n[8].pos,n[2].pos);
// longdiag[3]=extension(yaxispts[0],yaxispts[1],n[12].pos,n[3].pos)--extension(xaxispts[0],xaxispts[1],n[12].pos,n[3].pos);
// // 0-th diagonal needs another point
// pair diagzpt = n[0].pos+(n[4].pos-n[1].pos); // make slope so it is parallel
// longdiag[0]=extension(yaxispts[0],yaxispts[1],n[0].pos,diagzpt)--extension(xaxispts[0],xaxispts[1],n[0].pos,diagzpt);
// // Now draw them, then crop
// pen diagpen = linecap(0)+lightcolor+linewidth(1.5pt);
// draw(pic,longdiag[0],diagpen);
// draw(pic,longdiag[1],diagpen);
// draw(pic,longdiag[2],diagpen);
// draw(pic,longdiag[3],diagpen);
// pair cropcorners[];
// cropcorners[0] = (-0.8u,-.28u);
// cropcorners[1] = (-0.8u,4.5u);
// cropcorners[2] = (11.75u,4.5u);
// cropcorners[3] = (11.75u,-.28u);
// clip(pic,cropcorners[0]--cropcorners[1]--cropcorners[2]--cropcorners[3]--cycle);
// draw(pic, n[0], n[1], n[2], n[3], n[4],
// 	n[5], n[6], n[7], n[8], n[9],
// 	n[10], n[11], n[12], n[13], n[14],
// 	n[15]);
// draw(pic, m[0], m[1], m[2], m[3], m[4], m[5] );
// // horizontal line, labelling the diagonals
// path cropline = cropcorners[0]--cropcorners[3];
// path xaxis = shift(0u,-.2u)*cropline;
// draw(pic,xaxis); // horizontal axis
// real shrinklabeloffset = 1.0;  // bring labels closer to cropline? make 0.8
// label(pic,"{\strut \tabulartext{Diagonal}\hspace*{2em}}",point(cropline,0.0),shrinklabeloffset*S);
// label(pic,"\strut $0$",intersectionpoint(longdiag[0],cropline),shrinklabeloffset*S);
// label(pic,"\strut $1$",intersectionpoint(longdiag[1],cropline),shrinklabeloffset*S);
// label(pic,"\strut $2$",intersectionpoint(longdiag[2],cropline),shrinklabeloffset*S);
// label(pic,"\strut $3$",intersectionpoint(longdiag[3],cropline),shrinklabeloffset*S);
// // centerAtOrigin(pic);
// shipout(format("correspondences3%03d",picnum),pic,format="pdf");
