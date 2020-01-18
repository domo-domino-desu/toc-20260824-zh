// correspondences.asy
//  Animate correspondences between countable sets 

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);

// Get stuff common to all .asy files
// cd junk is needed for relative import
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy/");
import jh;
cd("");
// import node;

// Parameters
real horiz_gap = 1;
real vert_gap = 1*horiz_gap; // how far to raise numbers in row above

nodestyle ns_noborder=nodestyle(drawfn=None);
defaultnodestyle=ns_noborder;
defaultdrawstyle=drawstyle(p=red+fontsize(9pt), arrow=Arrow(DefaultHead, filltype=Fill(red)));  // seems to have no effect?

defaultlayoutrel = false;
defaultlayoutskip = 0.5cm;
real u = defaultlayoutskip;  // usual unit

// Correspondence between {0,1}xN and N
int num_pics = 8;
int col_hgt = 4;   // how far up to show? 
for (int picnum=0; picnum <= num_pics; ++picnum) {
   // debugging: write(stdout,"Here.");
   picture pic;
   // unitsize(pic,1cm);
   // dot(pic,(-.5,0),invisible);
   // dot(pic,(1.5*horiz_gap,0)+(.5,col_hgt*vert_gap),invisible);
   // define nodes
   node[] n = ncircles( "$\sequence{0,0}$",
     "$\sequence{1,0}$",
     "$\sequence{0,1}$",
     "$\sequence{1,1}$",
     "$\sequence{0,2}$",
     "$\sequence{1,2}$",
     "$\sequence{0,3}$",
     "$\sequence{1,3}$",
     "\raisebox{0.75ex}{$\vdots$}",
     "\raisebox{0.75ex}{$\vdots$}" );
   // layout
   defaultlayoutrel = false;
   // gridlayout((5,2), (1.5cm, -0.5cm), n);
   gridlayout((5,2), (3u, -u), n);
   // draw nodes
   draw(pic, n[0], n[1], n[2], n[3], n[4],
	   n[5], n[6], n[7], n[8], n[9] );
   // draw any edges
   if ((picnum > 0) && (picnum < 8)) {
     draw(pic, n[picnum-1] -- n[picnum], DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
   }
   if (picnum == 8) {
     for (int pn =1; pn < 8; ++pn) {
       draw(pic, n[pn-1] -- n[pn], DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
     }
   }
  shipout(format("correspondences1%03d",picnum),pic,format="pdf");
}


// ===================================================
// Correspondence between NxN and N
// TODO: The first arrow, in picnum=1, does not show.
node[] n = nboxes(
		    "$\sequence{0,0}$",  // node 0
		    "$\sequence{1,0}$",  // 1
		    "$\sequence{2,0}$",  // 2
		    "$\sequence{3,0}$",  // 3
		    "$\sequence{0,1}$",  // 4
		    "$\sequence{1,1}$",  // 5
		    "$\sequence{2,1}$",  // 6
		    "$\sequence{3,1}$",  // 7
		    "$\sequence{0,2}$",  // 8
		    "$\sequence{1,2}$",  // 9
		    "$\sequence{2,2}$",  // 10
		    "$\sequence{3,2}$",  // 11
		    "$\sequence{0,3}$",  // 12
		    "$\sequence{1,3}$",  // 13
		    "$\sequence{2,3}$",  // 14
		    "$\sequence{3,3}$" ); // 15
node[] m = ncircles(
		    "$\ldots$", 
		    "$\ldots$", 
		    "$\ldots$", 
		    "\raisebox{0.75ex}{$\vdots$}",
		    "\raisebox{0.75ex}{$\vdots$}",
		    "\raisebox{0.75ex}{$\vdots$}" 
		    );   
int[] node_list_order = {0,
			 4, 1,
			 8, 5, 2,
			 12, 9, 6, 3};
// layout
defaultlayoutrel = false;
gridlayout((4,4), (3u, -1.25u), n);  // was -u
hlayout(2u, n[3], m[0]);
vlayout(-u, m[0], m[1], m[2] );
vlayout(-u, n[12], m[3]);
vlayout(-u, n[13], m[4]);
vlayout(-u, n[14], m[5]);

// Animate the correspondence
int num_pics = 10;  // one extra for poster=last, for dumb PDF readers
int col_hgt = 4;   // how far up to show? 
for (int picnum=0; picnum <= num_pics; ++picnum) {
  picture pic;
   // debugging: write(stdout,"Here.");
   // picture pic;
   // node[] n = ncircles(
   // 		       "$\sequence{0,0}$",  // node 0
   // 		       "$\sequence{1,0}$",  // 1
   // 		       "$\sequence{2,0}$",  // 2
   // 		       "$\sequence{3,0}$",  // 3
   // 		       "$\sequence{0,1}$",  // 4
   // 		       "$\sequence{1,1}$",  // 5
   // 		       "$\sequence{2,1}$",  // 6
   // 		       "$\sequence{3,1}$",  // 7
   // 		       "$\sequence{0,2}$",  // 8
   // 		       "$\sequence{1,2}$",  // 9
   // 		       "$\sequence{2,2}$",  // 10
   // 		       "$\sequence{3,2}$",  // 11
   // 		       "$\sequence{0,3}$",  // 12
   // 		       "$\sequence{1,3}$",  // 13
   // 		       "$\sequence{2,3}$",  // 14
   // 		       "$\sequence{3,3}$" ); // 15
   // node[] m = ncircles(
   // 		       "$\ldots$", 
   // 		       "$\ldots$", 
   // 		       "$\ldots$", 
   // 		       "\raisebox{0.75ex}{$\vdots$}",
   // 		       "\raisebox{0.75ex}{$\vdots$}",
   // 		       "\raisebox{0.75ex}{$\vdots$}" 
   // 		       );   
   //   // "\raisebox{0.75ex}{$\vdots$}",
   //   // "\raisebox{0.75ex}{$\vdots$}" );
   // int[] node_list_order = {0,
   // 			    4, 1,
   // 			    8, 5, 2,
   // 			    12, 9, 6, 3
   // };
   // // layout
   // defaultlayoutrel = false;
   // gridlayout((4,4), (1.5cm, -0.5cm), n);
   // hlayout(1cm, n[3], m[0]);
   // vlayout(-0.5cm, m[0], m[1], m[2] );
   // vlayout(-0.5cm, n[12], m[3]);
   // vlayout(-0.5cm, n[13], m[4]);
   // vlayout(-0.5cm, n[14], m[5]);
   // draw nodes
   draw(pic, n[0], n[1], n[2], n[3], n[4],
	n[5], n[6], n[7], n[8], n[9],
	n[10], n[11], n[12], n[13], n[14],
	n[15]);
   draw(pic, m[0], m[1], m[2], m[3], m[4], m[5] );
   // draw any edges
   if ((picnum > 0) && (picnum < num_pics)) {
     draw(pic, n[node_list_order[picnum-1]] -- n[node_list_order[picnum]],
	  DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
   }
   if (picnum == num_pics) {  // to show up if pdf reader does not animate
     for (int pn = 1; pn<num_pics; ++pn) {
       draw(pic, n[node_list_order[pn-1]] -- n[node_list_order[pn]],
	    DARKPEN+light_color, arrow=Arrow(DefaultHead, filltype=Fill(DARKPEN+light_color), size=4));
     }
   }
  shipout(format("correspondences2%03d",picnum),pic,format="pdf");
}


// Bring out diagonals
picture pic;
int picnum = 0;
path diag[];  // diagonals
diag[1] = n[4].pos--n[1].pos;
diag[2] = n[8].pos--n[2].pos;
diag[3] = n[12].pos--n[3].pos;
// extend the diagonals until they meet the boundary
pair yaxispts[], xaxispts[];
yaxispts[0]=(-2u,0);
yaxispts[1]=(-2u,5u);
xaxispts[0]=(0,-2u);
xaxispts[1]=(12u,-2u);
// Long diagonals by extending diagonals on either end, drawing, then cropping
path longdiag[];  // extend the diagonals on either end
longdiag[1]=extension(yaxispts[0],yaxispts[1],n[4].pos,n[1].pos)--extension(xaxispts[0],xaxispts[1],n[4].pos,n[1].pos);
longdiag[2]=extension(yaxispts[0],yaxispts[1],n[8].pos,n[2].pos)--extension(xaxispts[0],xaxispts[1],n[8].pos,n[2].pos);
longdiag[3]=extension(yaxispts[0],yaxispts[1],n[12].pos,n[3].pos)--extension(xaxispts[0],xaxispts[1],n[12].pos,n[3].pos);
// 0-th diagonal needs another point
pair diagzpt = n[0].pos+(n[4].pos-n[1].pos); // make slope so it is parallel
longdiag[0]=extension(yaxispts[0],yaxispts[1],n[0].pos,diagzpt)--extension(xaxispts[0],xaxispts[1],n[0].pos,diagzpt);
// Now draw them, then crop
pen diagpen = linecap(0)+lightcolor+linewidth(1.5pt);
draw(pic,longdiag[0],diagpen);
draw(pic,longdiag[1],diagpen);
draw(pic,longdiag[2],diagpen);
draw(pic,longdiag[3],diagpen);
pair cropcorners[];
cropcorners[0] = (-0.8u,-.28u);
cropcorners[1] = (-0.8u,4.5u);
cropcorners[2] = (11.75u,4.5u);
cropcorners[3] = (11.75u,-.28u);
clip(pic,cropcorners[0]--cropcorners[1]--cropcorners[2]--cropcorners[3]--cycle);
draw(pic, n[0], n[1], n[2], n[3], n[4],
	n[5], n[6], n[7], n[8], n[9],
	n[10], n[11], n[12], n[13], n[14],
	n[15]);
draw(pic, m[0], m[1], m[2], m[3], m[4], m[5] );
// horizontal line, labelling the diagonals
path cropline = cropcorners[0]--cropcorners[3];
path xaxis = shift(0u,-.2u)*cropline;
draw(pic,xaxis); // horizontal axis
real shrinklabeloffset = 1.0;  // bring labels closer to cropline? make 0.8
label(pic,"{\strut \tabulartext{Diagonal}\hspace*{2em}}",point(cropline,0.0),shrinklabeloffset*S);
label(pic,"\strut $0$",intersectionpoint(longdiag[0],cropline),shrinklabeloffset*S);
label(pic,"\strut $1$",intersectionpoint(longdiag[1],cropline),shrinklabeloffset*S);
label(pic,"\strut $2$",intersectionpoint(longdiag[2],cropline),shrinklabeloffset*S);
label(pic,"\strut $3$",intersectionpoint(longdiag[3],cropline),shrinklabeloffset*S);
// centerAtOrigin(pic);
shipout(format("correspondences3%03d",picnum),pic,format="pdf");


// ========= Exercises =================================
string OUTPUT_FN = "correspondences%03d";
import graph;


// ==========================================
// Correspondence between (0,1) and (0,\infty) for exercises
int picnum = 0;
picture pic;
unitsize(pic,0.75cm);
real u=1;
real v=u;

real proj_fcn(real x) {
  return x/(x+1);
}

pair origin = (0*u,0*v);
pair proj_point = (-1*u,1*v);  // point making projection
real x = 3.3*u;    // how far out on x-axis is location of x
pair xloc = (x,0*v);  // pt on x-axis
pair yloc = (0*u,proj_fcn(x));  // projected-to pt on y-axis

draw(pic,proj_point--xloc,DARKPEN+linewidth(1pt)+lightcolor);
label(pic,"\raisebox{3pt}{$P$}",proj_point,W);
draw(pic,origin--(0*u,1.35*v),DARKPEN,Arrow(TeXHead));  // y-axis 
// label(pic,"\tiny $0$",(0*u,0*v),S);
draw(pic,(0*u,1*v)--((0*u,1*v)-(-0.1u,0v)),DARKPEN);  // tick at (0,1)
  label(pic,"\tiny $y=1$",(0*u,1*v),E);
// label(pic,"\tiny $0$",(0*u,0*v),W);
draw(pic,origin--(7*u,0*v),DARKPEN,Arrow(TeXHead));  // x-axis
dotfactor = 3;
dot(pic,proj_point,DARKPEN, filltype=Fill(white));
// draw(pic,(xloc--(xloc-(0u,0.05v))),DARKPEN);
dot(pic,xloc,DARKPEN, filltype=Fill(white));
  label(pic,"$x$",xloc,S);
// draw(pic,(yloc--(yloc-(0.05u,0v))),DARKPEN);
dot(pic,yloc,DARKPEN, filltype=Fill(white));
  label(pic,"$f(x)$",yloc,SW);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ====================
// two correspondences from (3,5) to (-1,10)

int picnum = 1;
picture pic;
unitsize(pic,0.35cm);
real u=1;
real v=u;

scale(pic,Linear(3),Linear);  // make the y-axis 1/3 as tall

real f0(real x) {
  return (11/2)*(x-3)-1;
}

real xmin = 3.0;
real xmax = 5.0;
real ymin = f0(xmin);
real ymax = f0(xmax);

real[] xMajorTicks={3,4,5};
real[] xMinorTicks={};
real[] yMajorTicks={-1,1,3,5,7,9}; 
real[] yMinorTicks={0,2,4,6,8,10}; 

arrowbar axisarrow = Arrows(TeXHead);

path g = graph(pic, f0,xmin,xmax);
draw(pic, g, FCNPEN+highlightcolor);
xaxis(pic, "$x$",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(xMajorTicks,xMinorTicks),
      EndArrow(TeXHead));           // arrow on rhs only
yaxis(pic, "$y$",XEquals(xmin-0.5),
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f_0(x)=\frac{11}{2}(x-3)-1$}", Scale(pic,(4,1.5)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......................................
int picnum = 2;
picture pic;
unitsize(pic,0.35cm);
real u=1;
real v=u;

scale(pic,Linear(3),Linear);  // make the y-axis 1/3 as tall

real f1(real x) {
  return (11/4)*(x-3)^2-1;
}

real xmin = 3.0;
real xmax = 5.0;
real ymin = f1(xmin);
real ymax = f1(xmax);

real[] xMajorTicks={3,4,5};
real[] xMinorTicks={};
real[] yMajorTicks={-1,1,3,5,7,9}; 
real[] yMinorTicks={0,2,4,6,8,10}; 

arrowbar axisarrow = Arrows(TeXHead);

path g = graph(pic, f1,xmin,xmax);
draw(pic, g, FCNPEN+highlightcolor);
xaxis(pic, "$x$",YZero(extend=false),
      xmin=xmin-0.5, xmax=xmax+0.5,
      RightTicks(xMajorTicks,xMinorTicks),
      EndArrow(TeXHead));           // arrow on rhs only
yaxis(pic, "$y$",XEquals(xmin-0.5),
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f_1(x)=\frac{11}{4}(x-3)^2-1$}", Scale(pic,(4.25,1.5)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// .......................................
int picnum = 3;
picture pic;
unitsize(pic,0.60cm);
real u=1;
real v=u;

scale(pic,Linear(1/3),Linear);  // make the y-axis 3x as tall

real f(real x) {
  return x/(x+1);
}

real xmin = 0;
real xmax = 20.0;
real ymin = 0;
real ymax = f(xmax);

real[] xMajorTicks={5,10,15};
real[] xMinorTicks={1,2,3,4,6,7,8,9,11,12,13,14,16,17,18,19};
real[] yMajorTicks={1}; 
real[] yMinorTicks={}; 

arrowbar axisarrow = Arrows(TeXHead);

path grph = graph(pic, f,xmin,xmax);
draw(pic, Scale(pic,(0+0.5,1))--Scale(pic,(20,1)), DASHPEN);
draw(pic, grph, FCNPEN+highlightcolor);
xaxis(pic, Label("\raisebox{10pt}[0pt][0pt]{\makebox[0em][l]{\hspace*{2.5pt}$x$}}",E),YZero(extend=false),
      xmin=xmin, xmax=xmax+0.5,
      RightTicks(xMajorTicks,xMinorTicks),
      EndArrow(TeXHead));           // arrow on rhs only
yaxis(pic, Label("\makebox[0em][l]{\hspace*{7.5pt}\raisebox{32.5pt}[0pt][0pt]{$y$}}",W),XZero,
      ymin=ymin-0.5, ymax=ymax+0.5,
      LeftTicks(yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f(x)=x/(x+1)$}", Scale(pic,(8.25,1.75)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===============================================
int picnum = 4;
picture pic;
unitsize(pic,1cm);
real u=1;
real v=u;

scale(pic,Linear(1/2),Linear);  // make the y-axis 2x as tall

real f(real x) {
  return (atan(x)+(pi/2.0))/pi;
}

real xmin = -6;
real xmax = 6;
real ymin = -0.5;
real ymax = 1.75;

real[] xMajorTicks={-5,-3,-1,1,3,5};
real[] xMinorTicks={-4,-2,2,4};
real[] yMajorTicks={1}; 
real[] yMinorTicks={}; 

arrowbar axisarrow = Arrows(TeXHead);

path grph = graph(pic, f,xmin,xmax);
draw(pic, Scale(pic,(xmin,1))--Scale(pic,(xmax,1)), DASHPEN);
draw(pic, grph, FCNPEN+highlightcolor);
xaxis(pic, Label("\setlength{\unitlength}{1cm}\begin{picture}(0,0)\put(0,0.35){$x$}\end{picture}"),YZero(extend=false),
      xmin=xmin, xmax=xmax,
      RightTicks(xMajorTicks,xMinorTicks),
      axisarrow);           // arrow on both sides
yaxis(pic, Label("\setlength{\unitlength}{1cm}\begin{picture}(0,0)\put(0.2,-0.2){$y$}\end{picture}"),XZero,
      ymin=ymin, ymax=ymax,
      LeftTicks(yMajorTicks,yMinorTicks),
      axisarrow);

label(pic, "{\footnotesize $f(x)=(\arctan(x)+(\pi/2))/\pi$}", Scale(pic,(2.25,1.4)), E);
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
