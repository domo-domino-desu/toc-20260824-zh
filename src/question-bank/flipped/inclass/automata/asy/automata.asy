// automata.asy
//  Draw automata

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import
cd("../../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../../asy");
import jhnode;
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



// =========================================
string OUTPUT_FN = "automata%03d";


// ======================== at least one a and at least one b =============
int picnum = 0;
picture pic;

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

hlayout(u, q0, q1);
vlayout(1*v, q0, q2);
hlayout(1*u, q2, q3);

// edges
draw(pic,
     (q0--q1).l("$\str{a}$"),
     (q0--q2).l("\str{b}"),
     (q1..loop(E)).l("$\str{a}$"),
     (q1--q3).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2..loop(W)).l("$\str{b}$"),
     (q3..loop(E)).l("$\str{a},\str{b}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ======================== fewer than 3 a's =============
int picnum = 1;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
     q1=ncircle("$q_1$",ns_accepting),
     q2=ncircle("$q_2$",ns_accepting),
     q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0--q1).l("$\str{a}$"),
     (q0..loop(N)).l("\str{b}"),
     (q1--q2).l("$\str{a}$"),
     (q1..loop(N)).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2..loop(N)).l("$\str{b}$"),
     (q3..loop(N)).l("$\str{a},\str{b}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ================ ends in ab =============
int picnum = 2;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// edges
draw(pic,
     (q0--q1).l("$\str{a}$").style("leftside"),
     (q0..loop(N)).l("\str{b}"),
     (q1..loop(N)).l("\str{a}"),
     (q1--q2).l("$\str{b}$").style("leftside"),
     (q2..bend(-25)..q1).l("\str{a}"),
     (q2..bend(-25)..q0).l("$\str{b}$").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ================  a^nb^m  n,m\geq 2 =============
int picnum = 3;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$"),
     q4=ncircle("$q_4$",ns_accepting),
     q5=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3, q4);
vlayout(1*v, q2, q5);

// edges
draw(pic,
     (q0--q1).l("$\str{a}$"),
     (q0--q5).l("\str{b}"),
     (q1--q2).l("$\str{a}$"),
     (q1--q5).l("\str{b}"),
     (q2..loop(N)).l("$\str{a}$"),
     (q2--q3).l("\str{b}"),
     (q3--q5).l("$\str{a}$"),
     (q3--q4).l("\str{b}"),
     (q4..loop(N)).l("$\str{b}$"),
     (q4--q5).l("\str{a}"),
     (q5..loop(S)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4,
       q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ================  a^nb^ma^p  m=2 =============
int picnum = 4;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$",ns_accepting),
     q3=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(1*v, q1, q3);

// edges
draw(pic,
     (q0..loop(N)).l("\str{a}"),
     (q0--q1).l("$\str{b}$"),
     (q1--q3).l("$\str{a}$"),
     (q1--q2).l("\str{b}"),
     (q2..loop(N)).l("$\str{a}$"),
     (q2--q3).l("\str{b}"),
     (q3..loop(S)).l("$\str{a},\str{b}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2,
       q3
       );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ================  sigma represents a multiple of 5 =============
int picnum = 5;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 2.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);

// edges
draw(pic,
     (q0..loop(N)).l("\str{1},\str{2},\str{3},\str{4},\str{6},\str{7},\str{8},\str{9}"),
     (q0..bend..q1).l("$\str{0},\str{5}$"),
     (q1..bend..q0).l("\str{1},\str{2},\str{3},\str{4},\str{6},\str{7},\str{8},\str{9}"),
     (q1..loop(N)).l("$\str{0},\str{5}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1
       );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


