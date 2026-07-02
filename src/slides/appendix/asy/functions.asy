// functions.asy
//  Bean diagrams for slides on functions 

// import settings; 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jhnode;
cd("");

defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;

string OUTPUT_FN = "functions%03d";



// =================================================
// bean graph
real h, v;  // horizontal and vertical units for beans
h = 0.70; v = h; 
real DOMAINTOCODOMAIN = 2*h;

// ..............................................
// collection of sets of fraction representations
int picnum = 0;
picture pic;
unitsize(pic,1cm);

// Draw the beans
path X0, X1, X2, X3;
X0 = setbean(h,v);
X1 = shift(DOMAINTOCODOMAIN,0)*setbean(h,v);
X2 = shift(2*DOMAINTOCODOMAIN,0)*setbean(h,v);
X3 = shift(3*DOMAINTOCODOMAIN,0)*setbean(h,v);

draw(pic, X0);
draw(pic, X1);
draw(pic, X2);
draw(pic, X3);

// Draw the points
pair[] X0point, X1point, X2point, X3point;
for (int i; i<4; ++i) {
  X0point[i] = (0.6*h,((-2/3)+0.2)*v+(i/3)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle (1,2)}$", X0point[3]);
label(pic, "${\scriptscriptstyle (2,4)}$", X0point[2]);
label(pic, "${\scriptscriptstyle (3,6)}$", X0point[1]);
label(pic, "${\scriptscriptstyle (-1,-2)}$", X0point[0]);

for (int i; i<4; ++i) {
  X1point[i] = shift(DOMAINTOCODOMAIN,0)*(0.6*h,((-2/3)+0.2)*v+(i/3)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle (3,4)}$", X1point[3]);
label(pic, "${\scriptscriptstyle (-3,-4)}$", X1point[2]);
label(pic, "${\scriptscriptstyle (6,8)}$", X1point[1]);
label(pic, "${\scriptscriptstyle \vdots}$", X1point[0]);

for (int i; i<4; ++i) {
  X2point[i] = shift(2*DOMAINTOCODOMAIN,0)*(0.6*h,((-2/3)+0.2)*v+(i/3)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle (4,6)}$", X2point[3]);
label(pic, "${\scriptscriptstyle (2,3)}$", X2point[2]);
label(pic, "${\scriptscriptstyle (-2,-3)}$", X2point[1]);
label(pic, "${\scriptscriptstyle \vdots}$", X2point[0]);

for (int i=1; i<4; ++i) {
  X3point[i] = shift(3*DOMAINTOCODOMAIN,0)*(0.6*h,((-2/3)+0.2)*v+(i/3)*(4/3)*v);
}
label(pic, "${\scriptscriptstyle (1,1)}$", X3point[3]);
label(pic, "${\scriptscriptstyle (-2,-2)}$", X3point[2]);
label(pic, "${\scriptscriptstyle \vdots}$", X3point[1]);

pair title = (0.5*h,1.7*v);
label(pic, "$X_0$", title);
label(pic, "$X_1$", shift(DOMAINTOCODOMAIN,0)*title);
label(pic, "$X_2$", shift(2*DOMAINTOCODOMAIN,0)*title);
label(pic, "$X_3$", shift(3*DOMAINTOCODOMAIN,0)*title);
label(pic, "$\ldots$", shift(3.65*DOMAINTOCODOMAIN,0)*title);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
