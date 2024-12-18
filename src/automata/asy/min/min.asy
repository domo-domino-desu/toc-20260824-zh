// min.asy
//  minimization of fsms

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jhnode;

// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

string OUTPUT_FN = "min%02d";



// ============== First machine to minimize ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  q4=ncircle("$q_4$",ns_accepting),
  q5=ncircle("$q_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

q1.pos = new_node_pos_h(q0, 25, 1*u);
q2.pos = new_node_pos_h(q0, -25, 1*u);
hlayout(1.0*u, q1, q3);


hlayout(1.0*u, q2, q4, q5);

// edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q0--q2).l("\str{1}"),
     (q1--q3).l("\str{1}"),
     (q1--q2).l("\str{0}"),
     (q2..loop(S)).l("\str{0}"),
     (q2--q4).l("\str{1}"),
     (q3..loop(E)).l("\str{0},\str{1}"),
     (q4..loop(S)).l("\str{0},\str{1}"),
     (q5--q4).l("\str{1}").style("leftside"),
     (q5..loop(S)).l("\str{0}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Second machine to minimize ================
picture pic;
int picnum = 1;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting),
  q3=ncircle("$q_3$"),
q4=ncircle("$q_4$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

q1.pos = new_node_pos_h(q0, 35, 1*u);
q2.pos = new_node_pos_h(q0, 0, 1*u);
q3.pos = new_node_pos_h(q0, -35, 1*u);
hlayout(1.0*u, q2, q4);

// edges
draw(pic,
     (q0--q1).l("\str{0}").style("leftside"),
     (q0--q3).l("\str{1}"),
     (q1..bend(30)..q2).l(Label("\str{0}",Relative(0.5))),
     (q2..bend(30)..q1).l(Label("\str{0}",Relative(0.3))),
     (q1--q4).l("\str{1}").style("leftside"),
     (q2--q4).l("\str{1}"),
     (q3--q2).l(Label("\str{0}",Relative(0.3))),
     (q3--q4).l("\str{1}"),
     (q4..loop(E)).l("\str{0},\str{1}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Third machine to minimize ================
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$",ns_accepting),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$",ns_accepting),
  q5=ncircle("$q_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, q0, q1, q3, q4, q5);
q2.pos = new_node_pos(q3, 90, 1*v);

// edges
draw(pic,
     (q0..loop(N)).l("\str{b}"),
     (q0..bend(30)..q1).l("\str{a}"),
     (q1--q3).l("\str{a}"),
     (q1..bend(30)..q0).l("\str{b}"),
     (q2--q1).l("\str{a}"),
     (q2--q4).l("\str{b}").style("leftside"),
     (q3..bend(25)..q5).l("\str{a}"),
     (q3--q2).l("\str{b}"),
     (q4--q3).l("\str{a}"),
     (q4..loop(N)).l("\str{b}"),
     (q5--q4).l("\str{a}"),
     (q5..bend(-35)..q1).l(Label("\str{b}",Relative(0.75)))
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== First table example machine to minimize ================
picture pic;
int picnum = 3;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$",ns_accepting),
  q2=ncircle("$q_2$",ns_accepting),
  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

q1.pos = new_node_pos_h(q0, -20.0, 1*u);
q2.pos = new_node_pos_h(q0, 20.0, 1*u);
hlayout(1.0*u, q2, q4);
hlayout(1.0*u, q1, q3);
hlayout(3.0*u, q0, q5);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q2).l("\str{b}"),
     (q1--q3).l("\str{a}"),
     (q1--q4).l(Label("\str{b}",Relative(0.25))),
     (q2--q3).l(Label("\str{b}",Relative(0.25))).style("leftside"),
     (q2--q4).l("\str{a}").style("leftside"),
     (q3--q5).l("\str{a},\str{b}"),
     (q4--q5).l("\str{a},\str{b}").style("leftside"),
     (q5..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== First table example machine to minimize ================
picture pic;
int picnum = 4;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// // define nodes
// node s0=ncircle("$r_0$"),
//   s1=ncircle("$r_1$"),
//   s2=ncircle("$r_2$",ns_accepting),
//   s3=ncircle("$r_3$",ns_accepting);

// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.75cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(1.0*u, s0, s1, s2, s3);

// // edges
// draw(pic,
//      (s0..bend..s2).l("\str{a},\str{b}"),
//      (s1..bend..s3).l("\str{a},\str{b}"),
//      (s2--s1).l("\str{a},\str{b}"),
//      (s3..loop(E)).l("\str{a},\str{b}")
//     );

// // draw nodes after edges so arrows are OK
// draw(pic, s0, s1, s2, s3);
// define nodes
node r0=ncircle("$r_0$"),
  r1=ncircle("$r_1$",ns_accepting),
  r2=ncircle("$r_2$"),
  r3=ncircle("$r_3$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, r0, r1, r2, r3);

// edges
draw(pic,
     (r0--r1).l("\str{a},\str{b}"),
     (r1--r2).l("\str{a},\str{b}"),
     (r2--r3).l("\str{a},\str{b}"),
     (r3..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, r0, r1, r2, r3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Minimized version of picnum 0 ================
picture pic;
int picnum = 5;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node s0=ncircle("$r_0$"),
  s1=ncircle("$r_1$"),
s2=ncircle("$r_2$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, s0, s1, s2);

// edges
draw(pic,
     (s0--s1).l("\str{0},\str{1}"),
     (s1..loop(N)).l("\str{0}"),
     (s1--s2).l("\str{1}"),
     (s2..loop(N)).l("\str{0},\str{1}")
    );

// draw nodes after edges so arrows are OK
draw(pic, s0, s1, s2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise of Moore's method that takes a long time ============
picture pic;
int picnum = 6;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2, q3, q4);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(S)).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1..loop(S)).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2..loop(S)).l("\str{b}"),
     (q3--q4).l("\str{a}"),
     (q3..loop(S)).l("\str{b}"),
     (q4..loop(S)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Exercise machine to minimize, parity check ================
picture pic;
int picnum = 7;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$",ns_accepting),
  q2=ncircle("$q_2$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, q0, q1, q2);

// edges
draw(pic,
     (q0..loop(N)).l("\str{0}"),
     (q0--q1).l("\str{1}"),
     (q1..loop(N)).l("\str{0}"),
     (q1..bend..q2).l("\str{1}"),
     (q2..bend..q1).l("\str{1}"),
     (q2..loop(N)).l("\str{0}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ......... minimized machine ..............
picture pic;
int picnum = 8;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node r0=ncircle("$r_0$"),
  r1=ncircle("$r_1$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, r0, r1);

// edges
draw(pic,
     (r0..loop(N)).l("\str{0}"),
     (r0..bend..r1).l("\str{1}"),
     (r1..loop(N)).l("\str{0}"),
     (r1..bend..r0).l("\str{1}")
    );

// draw nodes after edges so arrows are OK
draw(pic, r0, r1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Exercise machine to minimize, (ab|ba)* ================
picture pic;
int picnum = 9;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting),
  q3=ncircle("$q_3$"),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$"),
  q6=ncircle("$q_6$"),
  q7=ncircle("$q_7$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, q0, q1, q2, q7);
vlayout(1.0*v, q0, q3);
hlayout(1.0*u, q3, q4, q5, q6);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..bend..q3).l("\str{b}"),
     (q1..bend..q2).l("\str{b}"),
     (q1--q4).l("\str{a}"),
     (q2..bend..q1).l("\str{a}"),
     (q2..bend..q5).l("\str{b}"),
     (q3..bend..q0).l("\str{a}"),
     (q3--q4).l("\str{b}"),
     (q4..loop(S)).l("\str{a},\str{b}"),
     (q5..bend..q2).l("\str{a}"),
     (q5--q4).l("\str{b}"),
     (q6--q5).l("\str{a}"),
     (q6..bend..q7).l("\str{b}"),
     (q7..bend..q6).l("\str{a}"),
     (q7--q2).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ......... minimized machine ..............
picture pic;
int picnum = 10;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node r0=ncircle("$r_0$",ns_accepting),
  r1=ncircle("$r_1$"),
  r2=ncircle("$r_2$"),
  r3=ncircle("$r_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, r0, r1);
vlayout(1.0*u, r0, r2);
hlayout(1.0*u, r2, r3);

// edges
draw(pic,
     (r0..bend..r1).l("\str{a}"),
     (r0..bend..r2).l("\str{b}"),
     (r1--r3).l("\str{a}"),
     (r1..bend..r0).l("\str{b}"),
     (r2..bend..r0).l("\str{a}"),
     (r2--r3).l("\str{b}"),
     (r3..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, r0, r1, r2, r3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Exercise unreachable states ================
picture pic;
int picnum = 11;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting),
  q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, q0, q1, q2);
vlayout(-1.0*v, q1, q3);

// edges
draw(pic,
     (q0..bend..q1).l("\str{a},\str{b}"),
     (q1..bend..q0).l("\str{a}"),
     (q1..bend..q2).l("\str{b}"),
     (q2..bend..q1).l("\str{a},\str{b}"),
     (q3--q1).l("\str{a}"),
     (q3..bend(-20)..q2).l("\str{b}").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ......... Machine with unreachable states removed ..............
picture pic;
int picnum = 12;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$",ns_accepting);
// q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, q0, q1, q2);
// vlayout(1.0*v, q1, q3);

// edges
draw(pic,
     (q0..bend..q1).l("\str{a},\str{b}"),
     (q1..bend..q0).l("\str{a}"),
     (q1..bend..q2).l("\str{b}"),
     (q2..bend..q1).l("\str{a},\str{b}")
     // (q3--q1).l("\str{a}"),
     // (q3..bend..q2).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Exercise unreachable states ================
picture pic;
int picnum = 13;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  q4=ncircle("$q_4$"),
  q5=ncircle("$q_5$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, q0, q1, q2, q3, q4);
vlayout(-1.0*v, q3, q5);

// edges
draw(pic,
     (q0..bend..q1).l("\str{a}").style("leftside"),
     (q0..bend..q3).l("\str{b}").style("leftside"),
     (q1..bend..q0).l("\str{a}"),
     (q1..bend..q3).l(Label("\str{b}",Relative(0.25))).style("leftside"),
     (q2--q1).l("\str{a}"),
     (q2--q5).l("\str{b}"),
     (q3--q4).l("\str{a}, \str{b}"),
     (q4..loop(N)).l("\str{a},\str{b}"),
     (q5--q3).l("\str{a},\str{b}").style("leftside")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Exercise, minimize section starting example ================
picture pic;
int picnum = 14;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes (call them q_i because Asymptote doesn't like r3)
node q0=ncircle("$r_0$"); 
node q1=ncircle("$r_1$"); 
node q2=ncircle("$r_2$"); 
node q3=ncircle("$r_3$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.9*u;

hlayout(1*u, q0, q2);
vlayout(1*v, q0, q1);
hlayout(1*u, q1, q3);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q0--q2).l("\str{1}"),
     (q1..loop(W)).l("\str{0}"),
     (q1--q3).l("\str{1}"),
     (q2..loop(E)).l("\str{1}"),
     (q2--q3).l("\str{0}"),
     (q3..loop(E)).l("\str{0},\str{1}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Exercise, minimize machine with no final states ===========
picture pic;
int picnum = 15;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
vlayout(1*v, q0, q2);
hlayout(1*u, q2, q3);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q0..bend..q2).l("\str{1}"),
     (q1..loop(E)).l("\str{0}"),
     (q1--q3).l("\str{1}"),
     (q2..bend..q0).l("\str{0}").style("leftside"),
     (q2..loop(W)).l("\str{1}"),
     (q3--q0).l("\str{0}"),
     (q3--q2).l("\str{1}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ................. machine with only one state ................
picture pic;
int picnum = 16;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes 
node q0=ncircle("$q_0$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;


// draw edges
draw(pic,
     (q0..loop(E)).l("\str{0},\str{1}"),  //  bug in node for one edge
     (q0..loop(E)).l("\str{0},\str{1}")
);

// draw nodes
draw(pic,
     q0);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Exercise to minimize ================
picture pic;
int picnum = 17;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$",ns_accepting),
  q4=ncircle("$q_4$",ns_accepting),
  q5=ncircle("$q_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

q1.pos = new_node_pos_h(q0, 20, 1*u);
q2.pos = new_node_pos_h(q0, -20, 1*u);
hlayout(1.0*u, q1, q3);
hlayout(1.0*u, q2, q4);
q5.pos = new_node_pos_h(q3, -20, 1*u);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q2).l("\str{b}"),
     (q1..loop(N)).l("\str{a}"),
     (q1--q3).l("\str{b}"),
     (q2..loop(S)).l("\str{a}"),
     (q2--q4).l("\str{b}"),
     (q3..loop(N)).l("\str{a}"),
     (q3--q5).l("\str{b}"),
     (q4..loop(S)).l("\str{a}"),
     (q4--q5).l("\str{b}"),
     (q5..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

//..... minimized version ...................
picture pic;
int picnum = 18;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$r_0$"),
  q1=ncircle("$r_1$"),
  q2=ncircle("$r_2$",ns_accepting),
  q3=ncircle("$r_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, q0, q1, q2, q3);

// edges
draw(pic,
     (q0--q1).l("\str{a},\str{b}"),
     (q1..loop(N)).l("\str{a}"),
     (q1--q2).l("\str{b}"),
     (q2..loop(N)).l("\str{a}"),
     (q2--q3).l("\str{b}"),
     (q3..loop(N)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



//  ======== Brzozowski's algorithm =================
picture pic;
int picnum = 19;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$",ns_accepting),
  q2=ncircle("$q_2$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

q1.pos = new_node_pos_h(q0, 20, 1*u);
q2.pos = new_node_pos_h(q0, -20, 1*u);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q2).l("\str{b}"),
     (q1..loop(E)).l("\str{a},\str{b}"),
     (q2--q1).l("\str{a}"),
     (q2..loop(E)).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


//  ........... Brzozowski's algorithm minimized .........
picture pic;
int picnum = 20;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$r_0$"),  // call it q0 because Asymptote wants r3
  q1=ncircle("$r_1$",ns_accepting);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1*u, q0, q1);

// edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(W)).l("\str{b}"),
     (q1..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ...... Brzozowski's algorithm reverse arrows initial ..
picture pic;
int picnum = 21;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$t_0$",ns_accepting),
  q1=ncircle("$t_1$"),
  q2=ncircle("$t_2$"),
  init=nbox("start",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

q1.pos = new_node_pos_h(q0, 20, 1*u);
q2.pos = new_node_pos_h(q0, -20, 1*u);
vlayout(-0.85*v, q1, init);

// edges
draw(pic,
     (init--q1).l(""),
     (q1--q0).l("\str{a}"),
     (q2--q0).l("\str{b}"),
     (q1..loop(E)).l("\str{a},\str{b}"),
     (q1--q2).l("\str{a}"),
     (q2..loop(E)).l("\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, init);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...... Brzozowski's convert nondeterministic to deterministic ..
picture pic;
int picnum = 22;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node u0=ncircle("$u_0$"),
  u1=ncircle("$u_1$",ns_accepting),
  u2=ncircle("$u_2$"),
  u3=ncircle("$u_3$"),
  u4=ncircle("$u_4$",ns_accepting),
  u5=ncircle("$u_5$",ns_accepting),
  u6=ncircle("$u_6$"),
  u7=ncircle("$u_7$",ns_accepting),
  init=nbox("start",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, u0, u1, u3);
vlayout(1*v, u3, u5);
vlayout(1.15*v, u0, u2, u7);
vlayout(1.0*v, u2, u7);
hlayout(-0.85*u, u2, init);
hlayout(1*u, u7, u4, u6);
// q1.pos = new_node_pos_h(q0, 20, 1*u);
// q2.pos = new_node_pos_h(q0, -20, 1*u);
// vlayout(-0.85*v, q1, init);

// edges
draw(pic,
     (init--u2).l(""),
     (u0..loop(W)).l("\str{a},\str{b}"),
     (u1--u0).l("\str{a},\str{b}"),
     (u2--u7).l("\str{a}"),
     (u2..loop(N)).l("\str{b}"),
     (u3..bend..u0).l("\str{a}"),
     (u3--u5).l("\str{b}"),
     (u4--u7).l("\str{a}"),
     (u4--u2).l("\str{b}"),
     (u5--u0).l("\str{a}"),
     (u5..loop(E)).l("\str{b}"),
     (u6..bend(-25)..u7).l("\str{a},\str{b}").style("leftside"),
     (u7..loop(W)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, u0, u1, u2, u3, u4, u5, u6, u7, init);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ...... Brzozowski's second reverse the arrows ..
picture pic;
int picnum = 23;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node v2=ncircle("$v_2$",ns_accepting),
  v7=ncircle("$v_7$"),
  init=nbox("start",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, v2, v7);
vlayout(-0.85*v, v7, init);

// edges
draw(pic,
     (init--v7).l(""),
     (v2..loop(W)).l("\str{b}"),
     (v7--v2).l("\str{a}"),
     (v7..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, v2, v7, init);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...... Brzozowski's deterministic version of second reverse .....
picture pic;
int picnum = 24;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node w0=ncircle("$w_0$"), 
  w1=ncircle("$w_1$",ns_accepting),
  w2=ncircle("$w_2$"),
  w3=ncircle("$w_3$",ns_accepting),
  init=nbox("start",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1.0*u, w0, w1);
vlayout(1.0*v, w0, w2);
hlayout(1.0*u, w2, w3);
vlayout(0.85*v, w2, init);

// edges
draw(pic,
     (init--w2).l(""),
     (w0..loop(W)).label("\str{a},\str{b}"), 
     (w1--w0).l("\str{a}"),
     (w1..loop(E)).l("\str{b}"),
     (w2..loop(W)).l("\str{b}"),
     (w2--w3).l("\str{a}"),
     (w3..loop(E)).l("\str{a},\str{b}")
    );

// draw nodes after edges so arrows are OK
draw(pic, w0, w1, w2, w3, init);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

