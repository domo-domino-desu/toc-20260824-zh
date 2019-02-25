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
     (q3--e).l("any").style("leftside"),
     (e..loop(W)).l("any")
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
     (q0--e).l(Label("other",Relative(0.3))), 
     (q1..bend(-20)..q2).l("\str{E}").style("leftside"),
     (q1--e).l(Label("other",Relative(0.3))),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2--e).l(Label("other",Relative(0.3))).style("leftside"),
     (q3..loop(N)).l("any"),
     (e..loop(W)).l("any")
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
     (q1..bend(-20)..q0).l("other"),
     (q1..loop(N)).l("\str{H}"),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2..bend(-20)..q1).l("\str{H}"),
     (q2..bend(-30)..q0).l(Label("other",Relative(0.25))).style("leftside"),
     (q3..bend(-20)..q1).l(Label("\str{H}",Relative(0.2))),
     (q3..bend(-35)..q0).l("other").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== substring of HEF ================
picture pic;
int picnum = 4;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{H}").style("leftside"), 
     (q0..loop(N)).l("other"), 
     (q1..bend(-20)..q2).l("\str{E}").style("leftside"),
     (q1..bend(-20)..q0).l("other"),
     (q1..loop(N)).l("\str{H}"),
     (q2..bend(-20)..q3).l("\str{F}").style("leftside"),
     (q2..bend(-20)..q1).l("\str{H}"),
     (q2..bend(-25)..q0).l("other").style("leftside"),
     (q3..loop(E)).l("any")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== consisting of zero or more repetitions of HEF ================
picture pic;
int picnum = 5;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  e=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(v, q1, e);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{H}"), 
     (q0--e).l(Label("other",Relative(0.25))), 
     (q1..bend(-20)..q2).l("\str{E}"),
     (q1--e).l(Label("other",Relative(0.25))),
     (q2..bend(25)..q0).l("\str{F}"),
     (q2--e).l(Label("other",Relative(0.35))),
     (e..loop(S)).l(Label("any",Relative(0.25)))
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== starting with zero or more repetitions of HEF ================
picture pic;
int picnum = 6;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node
  q0=ncircle("$e$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

// hlayout(u, q0);

// edges
draw(pic,
     (q0..loop(E)).l("any"),  // Repeat to get an arrow; bug
     (q0..loop(E)).l("any")  
    );

// draw nodes after edges so arrows are OK
draw(pic, q0);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== CAT or DOG ================
picture pic;
int picnum = 7;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$"),
  q6=ncircle("$q_6$",ns_accepting),
  e=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
vlayout(2*v, q0, q4);
vlayout(v, q2, e);
hlayout(u, q4, q5, q6);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{C}"), 
     (q0--e).l(Label("other",Relative(0.2))), 
     (q1..bend(-20)..q2).l("\str{A}"),
     (q1--e).l(Label("other",Relative(0.1))),
     (q2..bend(-20)..q3).l("\str{T}"),
     (q2--e).l(Label("other",Relative(0.35))).style("leftside"),
     (q3--e).l(Label("any",Relative(0.35))).style("leftside"),
     (e..loop(E)).l("any"),
     (q0..bend(20)..q4).l("\str{D}"), 
     (q4--e).l(Label("other",Relative(0.25))).style("leftside"), 
     (q4..bend(20)..q5).l("\str{O}"),
     (q5--e).l(Label("other",Relative(0.25))),
     (q5..bend(20)..q6).l("\str{G}"),
     (q6--e).l(Label("any",Relative(0.35)))
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, e, q4, q5, q6);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== even number of a's ================
picture pic;
int picnum = 8;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"), 
     (q0..loop(W)).l("\str{b}"), 
     (q1..bend(-20)..q0).l("\str{a}").style("leftside"),
     (q1..loop(E)).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== at least three a's ================
picture pic;
int picnum = 9;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$");
  q3=ncircle("$q_3$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"), 
     (q0..loop(S)).l("\str{b}"), 
     (q1..bend(-20)..q2).l("\str{a}").style("leftside"),
     (q1..loop(S)).l("\str{b}"),
     (q2..bend(-20)..q3).l("\str{a}").style("leftside"),
     (q2..loop(S)).l("\str{b}"),
     (q3..loop(S)).l("any")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






