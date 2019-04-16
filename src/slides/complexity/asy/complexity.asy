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
import flowchart;
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
// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;


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

// ........ no path ............
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;
//defaultdrawstyle=drawstyle(p=EDGEPEN_TT,
//  			     arrow=None);

// define nodes
node
  v0=ncircle("$v_0$"), 
  v1=ncircle("$v_1$"),
  v2=ncircle("$v_2$"),
  v3=ncircle("$v_3$"),
  v4=ncircle("$v_4$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.2cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(v, v0, v1, v2);
v3.pos = (u,v0.pos.y-0.5*v); 
vlayout(v, v3, v4);
  
// edges
draw(pic,
     (v0--v3).style(undirectededgestyle),  
     (v1--v3).style(undirectededgestyle),  
     (v2--v3).style(undirectededgestyle),  
     (v0--v4).style(undirectededgestyle),  
     (v1--v4).style(undirectededgestyle),  
     (v2--v4).style(undirectededgestyle)
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ........ path; Gas, Water, Electricity graph ............
picture pic;
int picnum = 3;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
node
  v0=ncircle("$v_0$"), 
  v1=ncircle("$v_1$"),
  v2=ncircle("$v_2$"),
  v3=ncircle("$v_3$"),
  v4=ncircle("$v_4$"),
  v5=ncircle("$v_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.2cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(v, v0, v1, v2);
hlayout(u, v0, v3);
vlayout(v, v3, v4, v5);
  
// edges
draw(pic,
     (v0--v3).style(undirectededgestyle),
     (v0--v4).style(undirectededgestyle),
     (v0--v5).style(undirectededgestyle),
     (v1--v3).style(undirectededgestyle),
     (v1--v4).style(undirectededgestyle),
     (v1--v5).style(undirectededgestyle),
     (v2--v3).style(undirectededgestyle),
     (v2--v4).style(undirectededgestyle),
     (v2--v5).style(undirectededgestyle)
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4, v5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======== Shortest path =============
// From https://www.cs.princeton.edu/~rs/AlgsDS07/15ShortestPaths.pdf
picture pic;
int picnum = 4;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
node
  v0=ncircle("$v_0$"), 
  v1=ncircle("$v_1$"),
  v2=ncircle("$v_2$"),
  v3=ncircle("$v_3$"),
  v4=ncircle("$v_4$"),
  v5=ncircle("$v_5$"),
  v6=ncircle("$v_6$"),
  v7=ncircle("$v_7$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, v0, v2);
v1.pos = new_node_pos_h(v0, 30.0, 1.0*u);
hlayout(u, v1, v5);
vlayout(1.8*v, v5, v3);
hlayout(1.5*u, v2, v4);
hlayout(2*u, v3, v7);
hlayout(0.9*u, v4, v6);

  
// edges
draw(pic,
     (v0--v1).l("$9$"),
     (v0--v2).l(Label("$14$",edge_text_pen+black)).style(drawstyle(edge_text_pen+highlightcolor,Arrow(6))),
     (v0--v3).l("$15$"),
     (v1--v5).l("$24$").style("leftside"),
     (v2--v3).l("$5$"),
     (v2--v4).l("$30$"),
     (v2--v5).l(Label("$18$",edge_text_pen+black)).style(drawstyle(edge_text_pen+highlightcolor,Arrow(6))),
     (v3--v4).l("$20$"),
     (v3--v7).l("$44$"),
     (v4--v6).l("$11$"),
     (v4--v7).l(Label("$16$",edge_text_pen+black)).style(drawstyle(edge_text_pen+highlightcolor,Arrow(6))),
     (v5--v4).l(Label("$2$",edge_text_pen+black)).style(drawstyle(edge_text_pen+highlightcolor,Arrow(6))),
     (v5..bend(-55)..v7).l("$19$").style("leftside"),
     (v6--v5).l("$6$"),
     (v6--v7).l("$6$")
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4, v5, v6, v7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======== assignment graph coloring =============
picture pic;
int picnum = 5;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
node
  v0=ncircle("$v_0$"), 
  v1=ncircle("$v_1$"),
  v2=ncircle("$v_2$"),
  v3=ncircle("$v_3$"), 
  v4=ncircle("$v_4$"),
  v5=ncircle("$v_5$"),
  v6=ncircle("$v_6$"),
  v7=ncircle("$v_7$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, v0, v1, v2, v3);
vlayout(1*v, v0, v4);
hlayout(u, v4, v5, v6, v7);
  
// edges
draw(pic,
     (v0--v1).style(undirectededgestyle),
     (v0..bend(25)..v2).style(undirectededgestyle),
     (v0..bend(-20)..v3).style(undirectededgestyle),
     (v1--v2).style(undirectededgestyle),
     (v2--v3).style(undirectededgestyle),
     (v2--v4).style(undirectededgestyle),
     (v3--v4).style(undirectededgestyle),
     (v4--v5).style(undirectededgestyle),
     (v5--v6).style(undirectededgestyle),
     (v5..bend(-25)..v7).style(undirectededgestyle),
     (v6--v7).style(undirectededgestyle)
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4, v5, v6, v7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ......................................
picture pic;
int picnum = 6;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
node
  v0=ncircle("$v_0$",ns_bg), 
  v1=ncircle("$v_1$",ns_bleachedbg),
  v2=ncircle("$v_2$",ns_bleachedbold),
  v3=ncircle("$v_3$",ns_light), 
  v4=ncircle("$v_4$",ns_bleachedbg),
  v5=ncircle("$v_5$",ns_bg),
  v6=ncircle("$v_6$",ns_bleachedbold),
  v7=ncircle("$v_7$",ns_light);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, v0, v1, v2, v3);
vlayout(1*v, v0, v4);
hlayout(u, v4, v5, v6, v7);
  
// edges
draw(pic,
     (v0--v1).style(undirectededgestyle),
     (v0..bend(25)..v2).style(undirectededgestyle),
     (v0..bend(-20)..v3).style(undirectededgestyle),
     (v1--v2).style(undirectededgestyle),
     (v2--v3).style(undirectededgestyle),
     (v2--v4).style(undirectededgestyle),
     (v3--v4).style(undirectededgestyle),
     (v4--v5).style(undirectededgestyle),
     (v5--v6).style(undirectededgestyle),
     (v5..bend(-25)..v7).style(undirectededgestyle),
     (v6--v7).style(undirectededgestyle)
    );

// draw nodes after edges so arrows are OK
draw(pic, v0, v1, v2, v3, v4, v5, v6, v7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ......................................
picture pic;
int picnum = 7;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\mathcal{G},v_0,v_1$");
node convert=nbox("Convert to weighted graph $\hat{\mathcal{G}}$");
node oracle=nbox("Solve Shortest Path on $\hat{\mathcal{G}},v_0,v_1$");
node test=nrounddiamond("Path exists?");
node printzero=nbox("Print 0");
node printone=nbox("Print 1");
node dummy=nbox("");  

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.25*v,read,convert);
vlayout(1.25*v,convert,oracle);
vlayout(1.40*v,oracle,test);
vlayout(1.15*v,test,dummy);
hlayout(-2.25*u,dummy,printzero);
hlayout(2.25*u,dummy,printone);

// draw edges
draw(pic,
     (start--read),
     (read--convert),
     (convert--oracle),
     (oracle--test),
     (test..HV..printzero).l("N"),
     (test..HV..printone).l("Y").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     convert,
     oracle,
     test,
     printzero,
     printone
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







