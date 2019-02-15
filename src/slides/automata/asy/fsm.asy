// fsa.asy
//  circle diagrams of a FSA

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
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
// defaultnodestyle=nodestyle(xmargin=1pt,
// 			   black,  // label
// 			   drawfn=FillDrawer(verylightcolor,boldcolor));

// defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+boldcolor,
// 			   arrow=Arrow(6,filltype=FillDraw(lightcolor,black))
// 			   );
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;

string OUTPUT_FN = "fsm%02d";



// ============== At least two 1's ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
q2=ncircle("$q_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// edges
draw(pic,
     (q0..bend..q1).l("\str{1}"), 
     (q0..loop(N)).l("\str{0}"), 
     (q1..bend..q2).l("\str{1}"),
     (q1..loop(N)).l("\str{0}"),
     (q2..loop(N)).l("\str{0},\str{1}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== HEF ================
picture pic;
int picnum = 1;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  e=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
vlayout(v, q1, e);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{H}").style("leftside"), 
     (q0--e).l("other"), 
     (q1..bend(-20)..q2).l("\str{E}").style("leftside"),
     (q1--e).l("other"),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2--e).l("other"),
     (q3--e).l("any").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== HEF+more ================
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  e=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
vlayout(v, q1, e);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{H}").style("leftside"), 
     (q0--e).l("other"), 
     (q1..bend(-20)..q2).l("\str{E}").style("leftside"),
     (q1--e).l("other"),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2--e).l("other").style("leftside"),
     (q3..loop(N)).l("any")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== suffix HEF with any prefix ================
picture pic;
int picnum = 3;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{H}").style("leftside"), 
     (q0..loop(N)).l("other"), 
     (q1..bend(-20)..q2).l("\str{E}").style("leftside"),
     (q1..loop(N)).l("\str{H}"),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2..bend(-20)..q0).l("other").style("leftside"),
     (q3..bend(-35)..q0).l("any").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







