// complexity.asy
//  diagrams for slides for complexity

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jh;
cd("");
cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
import node;
cd("");


// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

import graph;

string OUTPUT_FN = "complexity%02d";



// ============== g<f but f is O(g) ================
picture pic;
int picnum = 0;
unitsize(pic,0.75cm);
scale(pic,Linear,Linear(.05));
// function
real g(real x) {return 3*x*x;}
real f(real x) {return 4*x*x;}

xaxis(pic,"",ticks=RightTicks(Label("$%.3g$"),
			      Step=1,step=1,
			      Size=3, size=3),
      above=false);
yaxis(pic,"",ticks=LeftTicks(Label("$%.3g$"),
			      Step=50,step=50,
			     Size=3, size=3),
      above=false);
draw(pic,graph(pic,g,0,5.25,operator ..),FCNPEN_SOLID+boldcolor);
label(pic,"$g(x)=4x^2$",Scale(pic,(3.5,g(3.5))),E);
draw(pic,graph(pic,f,0,5.25,operator ..),FCNPEN_SOLID+boldcolor);
label(pic,"$f(x)=3x^2$",Scale(pic,(4.5,f(4.5))),W);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== h is O(g) ================
picture pic;
int picnum = 1;
unitsize(pic,0.75cm);
scale(pic,Linear,Linear(.05));
// function
real g(real x) {return 3*x*x;}
real h(real x) {return 3*x+10;}

xaxis(pic,"",ticks=RightTicks(Label("$%.3g$"),
			      Step=1,step=1,
			      Size=3, size=3),
      above=false);
yaxis(pic,"",ticks=LeftTicks(Label("$%.3g$"),
			      Step=50,step=50,
			     Size=3, size=3),
      above=false);
draw(pic,graph(pic,g,0,5.25,operator ..),FCNPEN_SOLID+boldcolor);
label(pic,"$g(x)=3x^2$",Scale(pic,(3.5,g(3.5))),E);
draw(pic,graph(pic,h,0,5.25,operator ..),FCNPEN_SOLID+boldcolor);
label(pic,"$h(x)=3x+10$",Scale(pic,(3,h(3))),SE);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ================ Hamiltonian path ===============
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;
defaultdrawstyle=drawstyle(p=EDGEPEN_TT,
  			     arrow=None);

// define nodes
node
  v0=ncircle("$v_0$"), 
  v1=ncircle("$v_1$"),
  v2=ncircle("$v_2$"),
  v3=ncircle("$v_3$"),
  v4=ncircle("$v_4$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(v, v0, v1, v2);
v3.pos = (u,v0.pos.y-0.5*v); // new_node_pos_h(v0, (3.14159/2)-atan(0.5*(v/u)), 1.0*u);
vlayout(v, v3, v4);
  
// edges
draw(pic,
     (v0--v3),  
     (v1--v3),  
     (v2--v3),  
     (v0--v4),  
     (v1--v4),  
     (v2--v4)
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






