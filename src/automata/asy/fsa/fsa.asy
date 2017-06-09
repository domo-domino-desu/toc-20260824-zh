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

string OUTPUT_FN = "fsa%02d";



// ============== Power toggle ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_{\text{on}}$"),
q1=ncircle("$q_{\text{off}}$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);

// edges
draw(pic,
     (q0..bend..q1).l("$\str{toggle}$"), 
     (q1..bend..q0).l("$\str{toggle}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== Turnstile ================
picture pic;
int picnum = 1;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_{\text{init}}$"),
     q1=ncircle("$q_{\text{one}}$"),
     q2=ncircle("$q_{\text{ready}}$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// edges
draw(pic,
     (q0..bend..q1).l("$\str{token}$"),
     (q0..loop(S)).l("\str{push}"),
     (q1..bend..q2).l("$\str{token}$"),
     (q1..loop(S)).l("\str{push}"),
     (q2..loop(S)).l("\str{token}"),
     (q2..bend..q0).l("$\str{push}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== vending machine ================
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q5=ncircle("$q_5$"), 
     q10=ncircle("$q_{10}$"), 
     q15=ncircle("$q_{15}$"), 
     q20=ncircle("$q_{20}$"), 
     q25=ncircle("$q_{25}$"), 
     q30=ncircle("$q_{30}$"); 

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q5, q10, q15, q20, q25, q30);

// edges
draw(pic,
     (q0..bend..q5).l("\str{n}"),
     (q0..loop(S)).l("push"),
     (q5..bend..q10).l("\str{n}"),
     (q5..loop(S)).l("push"),
     (q10..bend..q15).l("\str{n}"),
     (q10..loop(S)).l("push"),
     (q15..bend..q20).l("\str{n}"),
     (q15..loop(S)).l("push"),
     (q20..bend..q25).l("\str{n}"),
     (q20..loop(S)).l("push"),
     (q25..bend..q30).l("\str{n}"),
     (q25..loop(S)).l("push"),
     (q30..bend(15)..q0).l("push"),
     (q30..loop(N)).l("\str{n}")
);

// draw nodes after edges so arrows are OK
draw(pic, q0, q5, q10, q15, q20, q25, q30);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== vending machine, dimes  ================
picture pic;
int picnum = 3;
setdefaultstatediagramstyles() ;

draw(pic,
     (q0..bend..q10).l("\str{d}"),
     (q5..bend..q15).l("\str{d}"),
     (q10..bend..q20).l("\str{d}"),
     (q15..bend..q25).l("\str{d}"),
     (q20..bend..q30).l("\str{d}"),
     (q25..bend(-20)..q30).l("\str{d}"),
     (q30..loop(N)).l("\str{d}")
 );

// draw nodes after edges so arrows are OK
draw(pic, q0, q5, q10, q15, q20, q25, q30);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== vending machine, quarters  ================
picture pic;
int picnum = 4;
setdefaultstatediagramstyles() ;

draw(pic,
     (q0..bend(20)..q25).l("\str{q}"),
     (q5..bend(20)..q30).l("\str{q}"),
     (q10..bend(-30)..q30).l(Label("\str{q}",Relative(0.1))).style("leftside"),
     (q15..bend(-27.5)..q30).l(Label("\str{q}",Relative(0.1))).style("leftside"),
     (q20..bend(-25)..q30).l(Label("\str{q}",Relative(0.1))).style("leftside"),
     (q25..bend(-20)..q30).l(Label("\str{q}",Relative(0.1))).style("leftside"),
     (q30..loop(N)).l("q")
 );

// draw nodes after edges so arrows are OK
draw(pic, q0, q5, q10, q15, q20, q25, q30);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ============== vending machine, all  ================
picture pic;
int picnum = 5;
setdefaultstatediagramstyles() ;

// edges
draw(pic,
     (q0..bend..q5).l("n"),
     (q5..bend..q10).l("n"),
     (q10..bend..q15).l("n"),
     (q15..bend..q20).l("n"),
     (q20..bend..q25).l("n"),
     (q25..bend..q30).l("n"),
     (q30..bend(15)..q0).l("push")
);

draw(pic,
     (q0..bend..q10).l("d"),
     (q5..bend..q15).l("d"),
     (q10..bend..q20).l("d"),
     (q15..bend..q25).l("d"),
     (q20..bend..q30).l("d")
 );

draw(pic,
     (q0..bend(20)..q25).l("q"),
     (q5..bend(20)..q30).l("q")
 );

// draw nodes after edges so arrows are OK
draw(pic, q0, q5, q10, q15, q20, q25, q30);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== multiple of four ================
picture pic;
int picnum = 6;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);
vlayout(v, q1, q2);
vlayout(v, q0, q3);

// edges
draw(pic,
     (q0--q1).l("$\str{1}$"),
     (q0..loop(W)).l("\str{0}"),
     (q1--q2).l("$\str{1}$"),
     (q1..loop(E)).l("\str{0}"),
     (q2--q3).l("$\str{1}$"),
     (q2..loop(E)).l("\str{0}"),
     (q3--q0).l("$\str{1}$"),
     (q3..loop(W)).l("\str{0}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== FSM picture ================
picture pic;
int picnum = 7;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(v, q2, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{+},\str{-}"),
     (q1--q2).l("\str{1},...,\str{9}"),
     (q0..bendleft..q2).l("\str{1},...,\str{9}").style("leftside"),
     (q0..bend(10)..e).l("other"),
     (q1--e).l("other").style("leftside"),
     (q2--e).l("other").style("leftside"),
     (q2..loop(E)).l("\str{0},..,\str{9}"),
     (e..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0,q1,q2,e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== accept valid integer ================
picture pic;
int picnum = 8;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(v, q2, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{+},\str{-}"),
     (q1--q2).l("\str{1},...,\str{9}"),
     (q0..bendleft..q2).l("\str{1},...,\str{9}").style("leftside"),
     (q0..bend(10)..e).l("other"),
     (q1--e).l("other").style("leftside"),
     (q2--e).l("other").style("leftside"),
     (q2..loop(E)).l("\str{0},..,\str{9}"),
     (e..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0,q1,q2,e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== filename extensions ================
picture pic;
int picnum = 9;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$");  
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$",ns_accepting); 
node q7=ncircle("$q_7$");  
node q8=ncircle("$q_8$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

layout(30.0, (1/Cos(30.0))*u, q0, q1);
hlayout(1*u, q1, q2, q3);
hlayout(1*u, q0, q4, q5, q6);
layout(-30.0, (1/Cos(-30.0))*u, q4, q7);
hlayout(1*u, q7, q8);
hlayout(4*u, q0, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{j}"),
     (q1--q2).l("\str{p}"),
     (q2--q3).l("\str{g}"),
     (q0--q4).l("\str{p}"),
     (q4--q5).l("\str{n}"),
     (q5--q6).l("\str{g}"),
     (q4--q7).l("\str{d}"),
     (q7--q8).l("\str{f}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== filename extensions, with errors ================
picture pic;
int picnum = 10;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$");  
// node q3=ncircle("$q_3$",ns_accepting); 
// node q4=ncircle("$q_4$"); 
// node q5=ncircle("$q_5$");  
// node q6=ncircle("$q_6$",ns_accepting); 
// node q7=ncircle("$q_7$");  
// node q8=ncircle("$q_8$",ns_accepting); 
// node e=ncircle("$e$"); 

// calculate nodes position
// layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.75cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// layout(30.0, (1/Cos(30.0))*u, q0, q1);
// hlayout(1*u, q1, q2, q3);
// hlayout(1*u, q0, q4, q5, q6);
// layout(-30.0, (1/Cos(-30.0))*u, q4, q7);
// hlayout(1*u, q7, q8);
// hlayout(4*u, q0, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{j}"),
     (q1--q2).l("\str{p}"),
     (q2--q3).l("\str{g}"),
     (q0--q4).l("\str{p}"),
     (q4--q5).l("\str{n}"),
     (q5--q6).l("\str{g}"),
     (q4--q7).l("\str{d}"),
     (q7--q8).l("\str{f}")
);
draw(pic,
     (q0..bend(-60)..e).l(Label("other",Relative(0.1))).style("leftside"),
     (q1..bend(-48.5)..e).l(Label("other",Relative(0.1))).style("leftside"),
     (q2..bend(-45)..e).l(Label("other",Relative(0.1))).style("leftside"),
     (q3--e).l("any"),
     (e..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== at least two a's, even number b's ================
picture pic;
int picnum = 11;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_0$"); 
node q4=ncircle("$q_1$"); 
node q5=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(v, q0, q3);
hlayout(u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1--q2).l("\str{a}"),
     (q2..loop(E)).l("\str{a}"),
     (q3--q4).l("\str{a}"),
     (q0..bend..q3).l("\str{b}"),
     (q3..bend..q0).l("\str{b}"), 
     (q4--q5).l("\str{a}"),
     (q1..bend..q4).l("\str{b}"),
     (q4..bend..q1).l("\str{b}"), 
     (q5..loop(E)).l("\str{a}"),
     (q2..bend..q5).l("\str{b}"),
     (q5..bend..q2).l("\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// // ............................ P_add
// picture pic;
// int picnum = 1;
// unitsize(pic,1pt);

// // define nodes
// // node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
// node q0=ncircle("$q_0$"),
//      q1=ncircle("$q_1$"),
//      q2=ncircle("$q_2$"),
//      q3=ncircle("$q_3$"),
//      q4=ncircle("$q_4$");

// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(u, q0, q1, q2, q3, q4);

// // draw nodes
// draw(pic, q0, q1, q2, q3, q4);

// // draw edges
// draw(pic,
//      (q0--q1).l("\scriptsize $\blank,\str{1}$"), 
//      (q0..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
//      // (q1--q2).l("\scriptsize $\blank,\str{L}$").style("leftside"),
//      // (q1--q1).l(Label("\scriptsize $10$",position=Relative(0.7))),
//      (q1--q2).l("\scriptsize $\blank,\str{L}$"),
//      (q1..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
//      (q2--q3).l("\scriptsize $\blank,\str{R}$"),
//      (q2..loop(S)).l("\scriptsize $\str{1},\str{L}$"),
//      (q3--q4).l("\scriptsize $\str{1},\blank$"),
//      (q3..loop(S)).l("\scriptsize $\blank,\str{R}$")
//     );
// shipout(format("circlediagram%02d",picnum),pic,format="pdf");

