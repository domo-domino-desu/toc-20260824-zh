// fsa.asy
//  circle diagrams of a FSA

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
node q0=ncircle("$q_{\text{off}}$"),
     q1=ncircle("$q_{\text{on}}$",ns_accepting);

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
     q2=ncircle("$q_{\text{ready}}$",ns_accepting);

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
     q30=ncircle("$q_{30}$",ns_accepting); 

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
node q0=ncircle("$q_0$",ns_accepting),
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
     (q0--q1).l("$\str{1}$").style("leftside"),
     (q0..loop(W)).l("\str{0}"),
     (q1--q2).l("$\str{1}$").style("leftside"),
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
     (q1--q2).l("\str{0},...,\str{9}"),
     (q0..bendleft..q2).l("\str{0},...,\str{9}").style("leftside"),
     (q0..bend(10)..e).l("other"),
     // (q1..loop(S)).l("\str{0}"),
     (q2..loop(E)).l("\str{0},..,\str{9}"),
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
     (q4--q5).l("\str{d}"),
     (q5--q6).l("\str{f}"),
     (q4--q7).l("\str{n}"),
     (q7--q8).l("\str{g}")
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
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$"); 

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
     (q0--q1).l("\str{0}"),
     (q1--q2).l("\str{0}"),
     (q2..loop(E)).l("\str{0}"),
     (q3--q4).l("\str{0}"),
     (q0..bend..q3).l("\str{1}"),
     (q3..bend..q0).l("\str{1}"), 
     (q4--q5).l("\str{0}"),
     (q1..bend..q4).l("\str{1}"),
     (q4..bend..q1).l("\str{1}"), 
     (q5..loop(E)).l("\str{0}"),
     (q2..bend..q5).l("\str{1}"),
     (q5..bend..q2).l("\str{1}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== multiple of three ================
picture pic;
int picnum = 12;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);
layout(-60.0, 1*u, q0, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{1},\str{4},\str{7}"),
     (q0..bend(15)..q2).l(Label("\str{2},\str{5},\str{8}",Relative(0.35))).style("leftside"),
     (q0..loop(W)).l("\str{0},\str{3},\str{6},\str{9}"),
     (q1..bend..q0).l("\str{2},\str{5},\str{8}"),
     (q1..bend(-15)..q2).l(Label("\str{1},\str{4},\str{7}",Relative(0.65))),
     (q1..loop(E)).l("\str{0},\str{3},\str{6},\str{9}"),
     (q2..bend(-50)..q0).l("\str{1},\str{4},\str{7}").style("leftside"),
     (q2..bend(50)..q1).l("\str{2},\str{5},\str{8}"),
     (q2..loop(S)).l("\str{0},\str{3},\str{6},\str{9}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== North American Phone Numbering Plan ================
picture pic;
int picnum = 13;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node opr=ncircle("Op",ns_accepting); 
node t1=ncircle("$\text{Int}_1$"); 
node tn=ncircle("$\text{Int}_n$",ns_accepting); 
node ll1=ncircle("$\text{LL}_1$"); 
node ll2=ncircle("$\text{LL}_2$"); 
node ll3=ncircle("$\text{LL}_3$"); 
node x1=ncircle("$\text{X}_1$"); 
node x2=ncircle("$\text{X}_2$"); 
node x3=ncircle("$\text{X}_3$"); 
node l1=ncircle("$\text{L}_1$"); 
node l2=ncircle("$\text{L}_2$"); 
node l3=ncircle("$\text{L}_3$"); 
node l4=ncircle("$\text{L}_4$"); 
node con=ncircle("Con",ns_accepting); 
node h2=ncircle("$\text{H}_2$"); 
node h3=ncircle("$\text{H}_3$"); 
node help=ncircle("Info",ns_accepting); 
node r2=ncircle("$\text{R}_2$"); 
node r3=ncircle("$\text{R}_3$"); 
node rep=ncircle("Rep",ns_accepting); 
node e2=ncircle("$\text{E}_2$"); 
node e3=ncircle("$\text{E}_3$"); 
node emr=ncircle("Emr",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = 0.9*defaultlayoutskip;
real v = 0.9*u;

real theta=aTan(2*v/u);
layout(theta,(1/Cos(theta))*u, q0, opr);
hlayout(1*u, opr, t1, tn);
real theta=aTan(v/u);
layout(theta,(1/Cos(theta))*u, q0, ll1);
hlayout(1*u, ll1, ll2);
real alpha=aTan(-0.4*v/u);
layout(alpha, (1/Cos(alpha))*u, ll2, ll3);
hlayout(1*u, ll3, x1);
hlayout(5*u, q0, x2);
hlayout(u, x2, x3, l1);
vlayout(1*v, l1, l2, l3, l4, con);
real theta=aTan(-v/u);
layout(theta, (1/Cos(theta))*u, q0, h2);
layout(alpha, (1/Cos(alpha))*u, h2, h3);
hlayout(1*u, h3, help);
real theta=aTan(-2*v/u);
layout(theta, (1/Cos(theta))*u, q0, r2);
layout(alpha, (1/Cos(alpha))*u, r2, r3);
hlayout(1*u, r3, rep);
real theta=aTan(-3*v/u);
layout(theta, (1/Cos(theta))*u, q0, e2);
layout(alpha, (1/Cos(alpha))*u, e2, e3);
hlayout(1*u, e3, emr);

// draw edges
draw(pic,
     (q0--opr).l("\str{0}"),
     (opr--t1).l("\str{1}"),
     (t1--tn).l("$x$"),
     (tn..loop(E)).l("$x$"),
     (q0--ll1).l("\str{1}"),
     (ll1--ll2).l("$n$"),
     (ll2--HV--x3).l("$n$"),
     (ll2--VH--ll3).l("$p$"),
     (ll3--x1).l("$n$"),
     (x1--HV--x2).l("$n$"),
     (q0--x2).l("\str{2},\str{3},\str{5},\str{7},\str{8}"),
     (x2--x3).l("$n$"),
     (x3--l1).l("$x$"),
     (l1--l2).l("$x$"),
     (l2--l3).l("$x$"),
     (l3--l4).l("$x$"),
     (l4--con).l("$x$"),
     (q0--h2).l("4").style("leftside"),
     (h2--HV--x3).l("$0,2,3,\ldots 9$"),
     (h2--VH--h3).l("\str{1}"),
     (h3--help).l("\str{1}"),
     (q0--r2).l("6").style("leftside"),
     (r2--HV--x3).l("$0,2,3,\ldots 9$"),
     (r2--VH--r3).l("\str{1}"),
     (r3--rep).l("\str{1}"),
     (q0--e2).l("9").style("leftside"),
     (e2--HV--x3).l("$0,2,3,\ldots 9$"),
     (e2--VH--e3).l("\str{1}"),
     (e3--emr).l("\str{1}")
);

// draw nodes
draw(pic,
     q0, opr, t1, tn,
     ll1, ll2, ll3, x1,
     x2, x3, l1, l2, l3, l4, con,
     h2, h3, help,
     r2, r3, rep,
     e2, e3, emr);

// draw legend
label(pic,
      "\renewcommand*{\arraystretch}{0.9}
       \begin{tabular}{rl}
         \multicolumn{2}{l}{Legend:} \\ 
         \hspace{2em}$x$  &\str{0},\,\ldots \str{9} \\
                     $n$  &\str{2},\,\ldots \str{9} \\
                     $p$  &\str{0},\,\str{1} 
         \end{tabular}",(7*u,1.45*v));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// for some reason 14-19 got repeated
// ============== exercise of a*ba* ================
// picture pic;
// int picnum = 14;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$",ns_accepting); 
// node q2=ncircle("$q_2$"); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(u, q0, q1, q2);
// // layout(-45.0, 1*u, q0, q2);

// // draw edges
// draw(pic,
//      (q0..loop(S)).l("\str{a}"),
//      (q0--q1).l("\str{b}"),
//      (q1..loop(S)).l("\str{a}"),
//      (q1--q2).l("\str{b}"),
//      (q2..loop(S)).l("\str{a},\str{b}")
// );

// // draw nodes
// draw(pic,
//      q0, q1, q2);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// // ============== extended transition function example ================
// picture pic;
// int picnum = 15;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$",ns_accepting); 
// node q2=ncircle("$q_2$"); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(u, q0, q1, q2);

// // draw edges
// draw(pic,
//      (q0..loop(N)).l("\str{b}"),
//      (q0--q1).l("\str{a}"),
//      (q1..loop(N)).l("\str{a}"),
//      (q1..bend..q2).l("\str{b}"),
//      (q2..bend..q1).l("\str{a}"),
//      (q2..loop(N)).l("\str{b}")
// );

// // draw nodes
// draw(pic,
//      q0, q1, q2);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// // ============== example motivation for myhill nerode ================
// picture pic;
// int picnum = 16;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$"); 
// node q3=ncircle("$q_3$",ns_accepting); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.9*u;

// hlayout(1*u, q0, q2);
// vlayout(1*v, q0, q1);
// hlayout(1*u, q1, q3);

// // draw edges
// draw(pic,
//      (q0--q1).l("\str{0}"),
//      (q0--q2).l("\str{1}"),
//      (q1..loop(W)).l("\str{0}"),
//      (q1--q3).l("\str{1}"),
//      (q2..loop(E)).l("\str{1}"),
//      (q2--q3).l("\str{0}"),
//      (q3..loop(E)).l("\str{0},\str{1}")
// );

// // draw nodes
// draw(pic,
//      q0, q1, q2, q3);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// // ============== example motivation for myhill nerode ================
// picture pic;
// int picnum = 17;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$"); 
// node q3=ncircle("$q_3$",ns_accepting); 
// node q4=ncircle("$q_4$"); 
// node q5=ncircle("$q_5$",ns_accepting); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.9*u;

// hlayout(1*u, q0, q2, q4);
// vlayout(1*v, q0, q1);
// hlayout(1*u, q1, q3, q5);

// // draw edges
// draw(pic,
//      (q0--q1).l("\str{0}"),
//      (q0--q2).l("\str{1}"),
//      (q1..loop(S)).l("\str{0}"),
//      (q1--q3).l("\str{1}"),
//      (q2--q4).l("\str{1}"),
//      (q2--q3).l("\str{0}"),
//      (q3..loop(S)).l("\str{0}"),
//      (q3--q5).l("\str{1}"),
//      (q4..loop(E)).l("\str{1}"),
//      (q4--q5).l("\str{0}"),
//      (q5..loop(S)).l("\str{0},\str{1}")
// );

// // draw nodes
// draw(pic,
//      q0, q1, q2, q3, q4, q5);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// // ============== example for myhill-nerode ends in ab ================
// picture pic;
// int picnum = 18;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$",ns_accepting); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(1*u, q0, q1, q2);

// // draw edges
// draw(pic,
//      (q0..loop(S)).l("\str{b}"),
//      (q0--q1).l("\str{a}"),
//      (q1..loop(S)).l("\str{a}"),
//      (q1--q2).l("\str{b}").style("leftside"),
//      (q2..bend(-30)..q1).l("\str{a}").style("leftside"),
//      (q2..bend..q0).l("\str{b}")
// );

// // draw nodes
// draw(pic,
//      q0, q1, q2);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// // ============== example for myhill-nerode, even length ================
// picture pic;
// int picnum = 19;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$"); 
// node q3=ncircle("$q_2$",ns_accepting); 
// node q4=ncircle("$q_2$",ns_accepting); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;
// layout(theta,(1/Cos(theta))*u, q0, opr);
// hlayout(1*u, opr, t1, tn);
// real theta=aTan(v/u);
// layout(theta,(1/Cos(theta))*u, q0, ll1);
// hlayout(1*u, ll1, ll2);
// real alpha=aTan(-0.4*v/u);
// layout(alpha, (1/Cos(alpha))*u, ll2, ll3);
// hlayout(1*u, ll3, x1);
// hlayout(5*u, q0, x2);
// hlayout(u, x2, x3, l1);
// vlayout(1*v, l1, l2, l3, l4, con);
// real theta=aTan(-v/u);
// layout(theta, (1/Cos(theta))*u, q0, h2);
// layout(alpha, (1/Cos(alpha))*u, h2, h3);
// hlayout(1*u, h3, help);
// real theta=aTan(-2*v/u);
// layout(theta, (1/Cos(theta))*u, q0, r2);
// layout(alpha, (1/Cos(alpha))*u, r2, r3);
// hlayout(1*u, r3, rep);
// real theta=aTan(-3*v/u);
// layout(theta, (1/Cos(theta))*u, q0, e2);
// layout(alpha, (1/Cos(alpha))*u, e2, e3);
// hlayout(1*u, e3, emr);

// // draw edges
// draw(pic,
//      (q0--opr).l("\str{0}"),
//      (opr--t1).l("\str{1}"),
//      (t1--tn).l("$x$"),
//      (tn..loop(E)).l("$x$"),
//      (q0--ll1).l("\str{1}"),
//      (ll1--ll2).l("$n$"),
//      (ll2--HV--x3).l("$n$"),
//      (ll2--VH--ll3).l("$p$"),
//      (ll3--x1).l("$n$"),
//      (x1--HV--x2).l("$n$"),
//      (q0--x2).l("\str{2},\str{3},\str{5},\str{7},\str{8}"),
//      (x2--x3).l("$n$"),
//      (x3--l1).l("$x$"),
//      (l1--l2).l("$x$"),
//      (l2--l3).l("$x$"),
//      (l3--l4).l("$x$"),
//      (l4--con).l("$x$"),
//      (q0--h2).l("4").style("leftside"),
//      (h2--HV--x3).l("$n$"),
//      (h2--VH--h3).l("\str{1}"),
//      (h3--help).l("\str{1}"),
//      (q0--r2).l("6").style("leftside"),
//      (r2--HV--x3).l("$n$"),
//      (r2--VH--r3).l("\str{1}"),
//      (r3--rep).l("\str{1}"),
//      (q0--e2).l("9").style("leftside"),
//      (e2--HV--x3).l("$n$"),
//      (e2--VH--e3).l("\str{1}"),
//      (e3--emr).l("\str{1}")
// );

// // draw nodes
// draw(pic,
//      q0, opr, t1, tn,
//      ll1, ll2, ll3, x1,
//      x2, x3, l1, l2, l3, l4, con,
//      h2, h3, help,
//      r2, r3, rep,
//      e2, e3, emr);

// // draw legend
// label(pic,
//       "\renewcommand*{\arraystretch}{0.9}
//        \begin{tabular}{rl}
//          \multicolumn{2}{l}{Legend:} \\ 
//          \hspace{2em}$x$  &\str{0},\,\ldots \str{9} \\
//                      $n$  &\str{2},\,\ldots \str{9} \\
//                      $p$  &\str{0},\str{1} 
//          \end{tabular}",(7*u,1.45*v));

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise of a*ba* ================
picture pic;
int picnum = 14;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
// layout(-45.0, 1*u, q0, q2);

// draw edges
draw(pic,
     (q0..loop(S)).l("\str{a}"),
     (q0--q1).l("\str{b}"),
     (q1..loop(S)).l("\str{a}"),
     (q1--q2).l("\str{b}"),
     (q2..loop(S)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== extended transition function example ================
picture pic;
int picnum = 15;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(N)).l("\str{b}"),
     (q0--q1).l("\str{a}"),
     (q1..loop(N)).l("\str{a}"),
     (q1..bend..q2).l("\str{b}"),
     (q2..bend..q1).l("\str{a}"),
     (q2..loop(N)).l("\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== example motivation for myhill nerode ================
picture pic;
int picnum = 16;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
      node q0=ncircle("$r_0$"); // call r because it is minimal machine
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





// ============== example motivation for myhill nerode ================
picture pic;
int picnum = 17;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.9*u;

hlayout(1*u, q0, q2, q4);
vlayout(1*v, q0, q1);
hlayout(1*u, q1, q3, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}"),
     (q0--q2).l("\str{1}"),
     (q1..loop(S)).l("\str{0}"),
     (q1--q3).l("\str{1}"),
     (q2--q4).l("\str{1}"),
     (q2--q3).l("\str{0}"),
     (q3..loop(S)).l("\str{0}"),
     (q3--q5).l("\str{1}"),
     (q4..loop(E)).l("\str{1}"),
     (q4--q5).l("\str{0}"),
     (q5..loop(S)).l("\str{0},\str{1}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== example for myhill-nerode ends in ab ================
picture pic;
int picnum = 18;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 

// calculate nodes position
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(S)).l("\str{b}"),
     (q0--q1).l("\str{a}"),
     (q1..loop(S)).l("\str{a}"),
     (q1--q2).l("\str{b}").style("leftside"),
     (q2..bend(-30)..q1).l("\str{a}").style("leftside"),
     (q2..bend..q0).l("\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== example for myhill-nerode, even length, nonminimal =======
picture pic;
int picnum = 19;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;


// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$",ns_accepting); 


// calculate nodes position
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

layout(20.0, 1*u, q0, q1);
hlayout(1*u, q1, q3);
layout(-20.0, 1*u, q0, q2);
hlayout(1*u, q2, q4);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1--q3).l("\str{a},\str{b}"),
     (q3..bend..q1).l("\str{a},\str{b}"),
     (q0--q2).l("\str{b}"),
     (q2--q4).l("\str{a},\str{b}"),
     (q4..bend..q2).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

  


// ============== partition for myhill-nerode, even length, non-minimal =======
picture pic;
int picnum = 20;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

real Mborderpenwidth = 1pt, Lborderpenwidth = 0.5*Mborderpenwidth;
pen Lborderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor;
pen Mborderpen = squarecap+linejoin(0)+linewidth(Mborderpenwidth)+lightcolor;
pen outsideborderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// declare the vert middle boundary (drawn later)
path mid_bound = interp(ul,ur,0.5)
  ..(interp(ul.x,ur.x,0.5)+0.1,interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.5);

// left boundaries
real lft_topbnd_y=0.8*hgt;
real[] lft_top_lft_t = intersections(ul--ll,(0,lft_topbnd_y),(wth,lft_topbnd_y));
pair lft_top_lft = point(ul--ll, lft_top_lft_t[0]);
real[] lft_top_rt_t = intersections(mid_bound,(0,lft_topbnd_y),(wth,lft_topbnd_y));
pair lft_top_rt = point(mid_bound,lft_top_rt_t[0]);
path left_top_bound = lft_top_lft
  ..(0.5*(lft_top_lft+lft_top_rt)+(0,-0.1))
  ..lft_top_rt;
draw(pic,left_top_bound,Mborderpen);
real lft_botbnd_y=0.4*hgt;
real[] lft_bot_lft_t = intersections(ul--ll,(0,lft_botbnd_y),(wth,lft_botbnd_y));
pair lft_bot_lft = point(ul--ll, lft_bot_lft_t[0]);
real[] lft_bot_rt_t = intersections(mid_bound,(0,lft_botbnd_y),(wth,lft_botbnd_y));
pair lft_bot_rt = point(mid_bound,lft_bot_rt_t[0]);
path left_bot_bound = lft_bot_lft
  ..(0.5*(lft_bot_lft+lft_bot_rt)+(0,-0.1))
  ..lft_bot_rt;
draw(pic,left_bot_bound,Mborderpen);
// right boundary
real rt_bnd_y=0.525*hgt;
real[] rt_lft_t = intersections(mid_bound,(0,rt_bnd_y),(wth,rt_bnd_y));
pair rt_lft = point(mid_bound,rt_lft_t[0]);
real[] rt_rt_t = intersections(ur--lr,(0,rt_bnd_y),(wth,rt_bnd_y));
pair rt_rt = point(ur--lr, rt_rt_t[0]);
path rt_bound = rt_lft
  ..(0.5*(rt_lft+rt_rt)+(0,-0.1))
  ..rt_rt;
draw(pic,rt_bound,Mborderpen);

// draw the vert middle boundary
draw(pic,mid_bound,Mborderpen);
draw(pic,mid_bound,Lborderpen);

// Draw the outside border
path Mborder = ll--lr--ur--ul--cycle;
draw(pic,Mborder,outsideborderpen);
// ? I want to draw the L border as on the outside edge of the Mborder
// This shows a gap between the two.
// real Lborderleft = ll.x-0.5*Mborderpenwidth+0.5*Lborderpenwidth;
// real Lborderright = lr.x+0.5*Mborderpenwidth-0.5*Lborderpenwidth;
// real Lborderbot = ll.y-0.5*Mborderpenwidth+0.5*Lborderpenwidth;
// real Lbordertop = ul.y+0.5*Mborderpenwidth-0.5*Lborderpenwidth;
// path Lborder = (Lborderleft,Lborderbot)
//   --(Lborderright,Lborderbot)
//   --(Lborderright,Lbordertop)
//   --(Lborderleft,Lbordertop)
//   --cycle;
// path Lborder=Mborder;
//draw(pic,Lborder,Lborderpen);

// Labels
label(pic,"$\eclass_{\FSM,0}$",(0.25wth,0.875hgt));
label(pic,"$\eclass_{\FSM,3}$",(0.25wth,0.55hgt));
label(pic,"$\eclass_{\FSM,4}$",(0.25wth,0.175hgt));
label(pic,"$\eclass_{\FSM,1}$",(0.75wth,0.725hgt));
label(pic,"$\eclass_{\FSM,2}$",(0.75wth,0.225hgt));
label(pic,"$\eclass_{\lang,0}$",(-0.2wth,0.5hgt));
label(pic,"$\eclass_{\lang,1}$",(1.2wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== partition for myhill-nerode, three parts =======
picture pic;
int picnum = 21;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

real Mborderpenwidth = 1pt, Lborderpenwidth = 0.5*Mborderpenwidth;
pen Lborderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor;
pen Mborderpen = squarecap+linejoin(0)+linewidth(Mborderpenwidth)+lightcolor;
pen outsideborderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// declare the vert left boundary
path left_bound = interp(ul,ur,0.3)
  ..(interp(ul.x,ur.x,0.3)+0.1, interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.3);
// declare the vert right boundary 
path rt_bound = interp(ul,ur,0.65)
  ..(interp(ul.x,ur.x,0.65)+0.1, interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.65);

// Draw the boundaries
draw(pic,left_bound,Mborderpen);
draw(pic,rt_bound,Mborderpen);

// Draw the outside border
path Mborder = ll--lr--ur--ul--cycle;
draw(pic,Mborder,outsideborderpen);

// Labels
label(pic,"$\eclass_{\FSM,0}$",(0.15wth,0.5hgt));
label(pic,"$\eclass_{\FSM,1}$",(0.5wth,0.5hgt));
label(pic,"$\eclass_{\FSM,2}$",(0.85wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: multiple of three, not empty string ================
picture pic;
int picnum = 22;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q3=ncircle("$q_3$",ns_accepting); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q3, q1);
layout(-60.0, 1*u, q3, q2);

// draw edges
draw(pic,
     (q0--q3).l("\str{0},\str{3},\str{6},\str{9}"),
     (q0..bend(-60)..q1).l("\str{1},\str{4},\str{7}").style("leftside"),
     (q0..bend(35)..q2).l("\str{2},\str{5},\str{8}"),
     (q3--q1).l("\str{1},\str{4},\str{7}"),
     (q3..bend(15)..q2).l(Label("\str{2},\str{5},\str{8}",Relative(0.35))).style("leftside"),
     (q3..loop(N)).l("\str{0},\str{3},\str{6},\str{9}"),
     (q1..bend..q3).l("\str{2},\str{5},\str{8}"),
     (q1..bend(-15)..q2).l(Label("\str{1},\str{4},\str{7}",Relative(0.65))),
     (q1..loop(E)).l("\str{0},\str{3},\str{6},\str{9}"),
     (q2..bend(-50)..q3).l("\str{1},\str{4},\str{7}").style("leftside"),
     (q2..bend(50)..q1).l("\str{2},\str{5},\str{8}"),
     (q2..loop(S)).l("\str{0},\str{3},\str{6},\str{9}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: at least two a's ================
picture pic;
int picnum = 23;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(N)).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1..loop(N)).l("\str{b}"),
     (q2..loop(N)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: exactly two a's ================
picture pic;
int picnum = 24;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(N)).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1..loop(N)).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2..loop(N)).l("\str{b}"),
     (q3..loop(N)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: less than three a's ================
picture pic;
int picnum = 25;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(N)).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1..loop(N)).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2..loop(N)).l("\str{b}"),
     (q3..loop(N)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: at least one a followed by at least one b =========
picture pic;
int picnum = 26;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..loop(N)).l("\str{b}"),
     (q1--q2).l("\str{b}"),
     (q1..loop(N)).l("\str{a}"),
     (q2..loop(N)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: accept only 911 =========
picture pic;
int picnum = 27;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting);  
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
vlayout(v, q1, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{9}").style("leftside"),
     (q1--q2).l("\str{1}").style("leftside"),
     (q2--q3).l("\str{1}").style("leftside"),
     (q0--e).l(Label("other",Relative(0.2))),
     (q1--e).l(Label("other",Relative(0.25))),
     (q2--e).l(Label("other",Relative(0.40))),
     (q3..bend(-20)..e).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: fail to accept only 911 =========
picture pic;
int picnum = 28;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$");  
node e=ncircle("$e$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
vlayout(v, q1, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{9}").style("leftside"),
     (q1--q2).l("\str{1}").style("leftside"),
     (q2--q3).l("\str{1}").style("leftside"),
     (q0--e).l(Label("other",Relative(0.2))),
     (q1--e).l(Label("other",Relative(0.25))),
     (q2--e).l(Label("other",Relative(0.40))),
     (q3..bend(-20)..e).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: any substring of abc =========
picture pic;
int picnum = 29;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting);  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"),
     (q0..loop(N)).l("\str{b},\str{c}"),
     (q1..bend(-20)..q2).l("\str{b}").style("leftside"),
     (q1..bend(-20)..q0).l("\str{c}").style("leftside"),
     (q1..loop(N)).l("a"),
     (q2..bend(-20)..q3).l("\str{c}").style("leftside"),
     (q2..bend(-20)..q1).l("a").style("leftside"),
     (q2..bend(-40)..q0).l("b"),
     (q3..loop(N)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: at least two a's and at least two b's =========
picture pic;
int picnum = 30;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$"); 
node q6=ncircle("$q_6$"); 
node q7=ncircle("$q_7$"); 
node q8=ncircle("$q_8$",ns_accepting);  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);
vlayout(v, q0, q3, q6);
hlayout(u, q3, q4, q5);
hlayout(u, q6, q7, q8);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q3).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1--q4).l("\str{b}"),
     (q2..loop(E)).l("\str{a}"),
     (q2--q5).l("\str{b}"),
     (q3--q4).l("\str{a}"),
     (q3--q6).l("\str{b}"),
     (q4--q5).l("\str{a}"),
     (q4--q7).l("\str{b}"),
     (q5--q8).l("\str{b}"),
     (q5..loop(E)).l("\str{a}"),
     (q6--q7).l("\str{a}"),
     (q6..loop(S)).l("\str{b}"),
     (q7--q8).l("\str{a}"),
     (q7..loop(S)).l("\str{b}"),
     (q8..loop(S)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2,
     q3, q4, q5,
     q6, q7, q8);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: rebut: no machine accepts a^nb =========
picture pic;
int picnum = 31;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");  
node q1=ncircle("$q_1$",ns_accepting);  
node q2=ncircle("$q_2$");  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{b}"),
     (q0..loop(N)).l("\str{a}"),
     (q1--q2).l("any"),
     (q2..loop(N)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: input ends in aa =========
picture pic;
int picnum = 32;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");  
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"),
     (q0..loop(W)).l("\str{b}"),
     (q1..bend(-20)..q2).l("\str{a}").style("leftside"),
     (q1..bend(-10)..q0).l("\str{b}").style("leftside"),
     (q2..loop(E)).l("\str{a}"),
     (q2..bend(-35)..q0).l("\str{b}").style("leftside")
);

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== exercise: input is emptystring =========
picture pic;
int picnum = 33;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting);    
node q1=ncircle("$q_1$");  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1);

// draw edges
draw(pic,
     (q0--q1).l("any"),
     (q1..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== exercise: input is emptystring =========
picture pic;
int picnum = 34;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting);    
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");  
node q3=ncircle("$q_3$");  
node q4=ncircle("$q_4$",ns_accepting);  
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$");  
node q7=ncircle("$q_7$");  
node q8=ncircle("$q_8$",ns_accepting);  
node e=ncircle("$e$");  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3, q4);
vlayout(v, q3, e);
vlayout(2v, q0, q5);
hlayout(u, q5, q6, q7, q8);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q5).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1..bend(5)..e).l("\str{b}"),
     (q2--q3).l("\str{a}"),
     (q2--e).l("\str{b}"),
     (q3--q4).l("\str{b}"),
     (q3--e).l("\str{a}"),
     (q4--e).l("any"),
     (q5--q6).l("\str{a}"),
     (q5..bend(-10)..e).l("\str{b}").style("leftside"),
     (q6--q7).l("\str{a}"),
     (q6..bend(-5)..e).l("\str{b}").style("leftside"),
     (q7--q8).l("\str{a}"),
     (q7--e).l("\str{b}").style("leftside"),
     (q8--e).l("any"),
     (e..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4,
     e,
     q5, q6, q7, q8);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== exercise: input is emptystring =========
picture pic;
int picnum = 35;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting);    
node q1=ncircle("$q_1$",ns_accepting);
node q2=ncircle("$q_2$",ns_accepting);  
node e=ncircle("$e$");  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

q1.pos = new_node_pos_h(q0, 15, 1.0*u);
q2.pos = new_node_pos_h(q0, -15, 1.0*u);
hlayout(2*u, q0, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0--q2).l("\str{b}"),
     (q1--e).l("\str{b}"),
     (q1..loop(N)).l("\str{a}"),
     (q2--e).l("\str{a}"),
     (q2..loop(S)).l("\str{b}"),
     (e..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== exercise: rock, paper, scissors =========
picture pic;
int picnum = 36;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");    
node q2=ncircle("$q_2$");    
node q3=ncircle("$q_3$");    
node q4=ncircle("$q_4$",ns_accepting);
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$");  
node q7=ncircle("$q_7$",ns_accepting);  
node q8=ncircle("$q_8$",ns_accepting);  
node q9=ncircle("$q_9$");    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

q1.pos = new_node_pos_h(q0, 30, 1.0*u);
hlayout(1*u, q0, q2);
q3.pos = new_node_pos_h(q0, -30, 1.0*u);
q4.pos = new_node_pos_h(q1, 20, 1.0*u);
hlayout(1*u, q1, q5);
q6.pos = new_node_pos_h(q2, 10, 1.0*u);
q7.pos = new_node_pos_h(q2, -10, 1.0*u);
hlayout(1*u, q3, q8);
q9.pos = new_node_pos_h(q3, -20, 1.0*u);

// draw edges
draw(pic,
     (q0--q1).l("\str{P}"),
     (q0--q2).l("\str{R}"),
     (q0--q3).l("\str{S}"),
     (q1--q4).l("\str{R}"),
     (q1--q5).l("\str{S}"),
     (q2--q6).l("\str{P}"),
     (q2--q7).l("\str{S}"),
     (q3--q8).l("\str{P}"),
     (q3--q9).l("\str{R}")
);

// draw nodes
draw(pic,
     q0,
     q1, q2,
     q3, q4, q5, q6, q7, q8, q9);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: multiple of five ================
picture pic;
int picnum = 37;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(2*u, q0, q1);

// draw edges
draw(pic,
     (q0..bend(-15)..q1).l("\str{0},\str{5}").style("leftside"),
     (q0..loop(W)).l("\str{1},\str{2},\str{3},\str{4},\str{6},\str{7},\str{8},\str{9}"),
     (q1..bend(-15)..q0).l("\str{1},\str{2},\str{3},\str{4},\str{6},\str{7},\str{8},\str{9}").style("leftside"),
     (q1..loop(E)).l("\str{0},\str{5}")
);

// draw nodes
draw(pic,
     q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: no 0's or no 2's ================
picture pic;
int picnum = 38;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, e);

// draw edges
draw(pic,
     (q0--e).l("\str{0},\str{2}"),
     (q0..loop(W)).l("\str{1},\str{3},\str{4},\str{5},\str{6},\str{7},\str{8},\str{9}"),
     (e..loop(E)).l("any")
     );

// draw nodes
draw(pic,
     q0, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: vowels in ascending order ================
picture pic;
int picnum = 39;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{A}"),
     (q0..loop(S)).l("not \str{A}"),
     (q1--q2).l("\str{E}"),
     (q1..loop(S)).l("not \str{E}"),
     (q2--q3).l("\str{I}"),
     (q2..loop(S)).l("not \str{I}"),
     (q3--q4).l("\str{O}"),
     (q3..loop(S)).l("not \str{O}"),
     (q4--q5).l("\str{U}"),
     (q4..loop(S)).l("not \str{U}"),
     (q5..loop(S)).l("any")
     );

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: picture given transition function ================
picture pic;
int picnum = 40;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..bend(-20)..q2).l("\str{a}").style("leftside"),
     (q0..bend(-10)..q1).l("\str{b}"),
     (q1..bend(-30)..q0).l("\str{a}").style("leftside"),
     (q1--q2).l("\str{b}"),
     (q2..loop(E)).l("\str{a},\str{b}")
     );

// draw nodes
draw(pic,
     q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: picture given transition function ================
picture pic;
int picnum = 41;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q2, q3);
vlayout(-0.75*v, q0, q1);
vlayout(0.75*v, q2, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{+},\str{-}").style("leftside"),
     (q0--q2).l("\str{0},\ldots \str{9}"),
     (q1--q2).l("\str{0},\ldots \str{9}"),
     (q2..loop(N)).l("\str{0},\ldots \str{9}"),
     (q2--e).l("other"),
     (q2--q3).l("\str{.}"),
     (q3--e).l("other"),
     (q3..loop(N)).l("\str{0},\ldots \str{9}"),
     (e..loop(W)).l("any")
     );

// draw nodes
draw(pic,
     q0, q1, q2, q3, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: every 1 preceeded and followed by 0 ================
picture pic;
int picnum = 42;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);
vlayout(1*v, q1, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}").style("leftside"),
     (q0--e).l("\str{1}").style("leftside"),
     (q1..loop(N)).l("\str{0}"),
     (q1..bend(-20)..q2).l("\str{1}").style("leftside"),
     (q2..bend(-20)..q1).l("\str{0}").style("leftside"),
     (q2--e).l("\str{1}").style("leftside"),
     (e..loop(E)).l("any")
     );

// draw nodes
draw(pic,
     q0, q1, q2, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: binary, multiple of four ================
picture pic;
int picnum = 43;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
q2.pos = new_node_pos_h(q1, 20.0, 1*u);
q3.pos = new_node_pos_h(q1, -20.0, 1*u);
hlayout(1*u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}").style("leftside"),
     (q0..loop(W)).l("\str{1}"),
     (q1--q2).l("\str{0}").style("leftside"),
     (q1--q3).l("\str{1}").style("leftside"),
     (q2..loop(E)).l("\str{0}"),
     (q2--q3).l("\str{1}"),
     (q3--q4).l("\str{0}"),
     (q3..loop(S)).l("\str{1}"),
     (q4..bend(20)..q3).l("\str{1}"),
     (q4--q5).l("\str{0}").style("leftside"),
     (q5..loop(E)).l("\str{0}"),
     (q5..bend(-20)..q3).l("\str{1}").style("leftside")
     );

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: decimal, even ================
picture pic;
int picnum = 44;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");  
node q1=ncircle("$q_1$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.5*u, q0, q1);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{0}, \str{2}, \str{4}, \str{6}, \str{8}").style("leftside"),
     (q0..loop(W)).l("\str{1}, \str{3}, \str{5}, \str{7}, \str{9}"),
     (q1..bend(-20)..q0).l("\str{1}, \str{3}, \str{5}, \str{7}, \str{9}").style("leftside"),
     (q1..loop(E)).l("\str{0}, \str{2}, \str{4}, \str{6}, \str{8}")
     );

// draw nodes
draw(pic,
     q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: decimal, divisible by 100 ================
picture pic;
int picnum = 45;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
q2.pos = new_node_pos_h(q1, 20.0, 1*u);
q3.pos = new_node_pos_h(q1, -20.0, 1*u);
hlayout(1*u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{0}").style("leftside"),
     (q0..loop(W)).l("\str{1},\ldots{}\,\str{9}"),
     (q1--q2).l("\str{0}").style("leftside"),
     (q1--q3).l("\str{1},\ldots{}\,\str{9}").style("leftside"),
     (q2..loop(E)).l("\str{0}"),
     (q2--q3).l("\str{1},\ldots{}\,\str{9}").style("leftside"),
     (q3--q4).l("\str{0}"),
     (q3..loop(S)).l("\str{1},\ldots{}\,\str{9}"),
     (q4..bend(20)..q3).l("\str{1},\ldots{}\,\str{9}"),
     (q4--q5).l("\str{0}").style("leftside"),
     (q5..loop(E)).l("\str{0}"),
     (q5..bend(-20)..q3).l("\str{1},\ldots{}\,\str{9}").style("leftside")
     );

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
// picture pic;
// int picnum = 45;
// unitsize(pic,1pt);
// setdefaultstatediagramstyles() ;

// // define nodes
// node q0=ncircle("$q_0$"); 
// node q1=ncircle("$q_1$"); 
// node q2=ncircle("$q_2$",ns_accepting); 

// // calculate nodes position
// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.75cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// hlayout(1*u, q0, q1, q2);

// // draw edges
// draw(pic,
//      (q0..bend(-20)..q1).l("\str{0}").style("leftside"),
//      (q0..loop(W)).l("other"),
//      (q1..bend(-20)..q2).l("\str{0}").style("leftside"),
//      (q1..bend(-10)..q0).l("other").style("leftside"),
//      (q2..bend(-35)..q0).l("other").style("leftside"),
//      (q2..loop(E)).l("\str{0}")
//      );

// // draw nodes
// draw(pic,
//      q0, q1, q2);

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: any finite language is the lang of some FSA =======
picture pic;
int picnum = 46;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$");
node ldots=nbox("\makebox[4em][c]{\ldots}",ns_noborder);
node q3=ncircle("$q_{j-1}$");
node q4=ncircle("$q_j$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.10*u, q0, q1, q2, ldots, q3, q4, e);

// draw edges
draw(pic,
     (q0--q1).l("$\sigma[0]$").style("leftside"),
     (q0..bend..e).l(Label("other",Relative(0.2))),
     (q1--q2).l("$\sigma[1]$").style("leftside"),
     (q1..bend..e).l(Label("other",Relative(0.2))),
     (q2--ldots).l("$\sigma[1]$").style("leftside"),
     (ldots--q3).l("$\sigma[j-2]$").style("leftside"),
     (q3--q4).l("$\sigma[j-1]$").style("leftside"),
     (q3..bend..e).l(Label("other",Relative(0.2))),
     (q4--e).l("other"),
     (e..loop(E)).l("other")
     );

// draw nodes
draw(pic,
     q0, q1, q2, ldots, q3, q4, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ...
picture pic;
int picnum = 47;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node ldots0=nbox("\makebox[4em][c]{\ldots}",ns_noborder);
node qi=ncircle("$q_i$"); 
node qi1=ncircle("$q_{i+1}$");
node ldots1=nbox("\makebox[4em][c]{\ldots}",ns_noborder);
node qj=ncircle("$q_j$",ns_accepting);  
node qj1=ncircle("$q_{j+1}$");  
node ldots2=nbox("\makebox[4em][c]{\ldots}",ns_noborder);
node qn=ncircle("$q_n$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.10*u, q0, ldots0, qi, qi1, ldots1, qj, e);
qj1.pos = new_node_pos_h(qi, -25, 1.10*u);
hlayout(1.10*u, qj1, ldots2, qn);

// draw edges
draw(pic,
     (q0--ldots0).l("$\alpha[0]$").style("leftside"),
     (ldots0--qi).l("$\alpha[-1]$").style("leftside"),
     (qi--qi1).l("$\sigma_k[i]$").style("leftside"),
     (qi1--ldots1),
     (ldots1--qj).l("$\sigma_k[-1]$").style("leftside"),
     (qi--qj1).l("$\sigma_{k+1}[i]$"),
     (qj1--ldots2),
     (ldots2--qn).l("$\sigma_{k+1}[-1]$")
     );

// draw nodes
draw(pic,
     q0, ldots0, qi, qi1, ldots1, qj, qj1, ldots2, qn, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: no more than one aa ==================
picture pic;
int picnum = 48;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$",ns_accepting);
node q3=ncircle("$q_3$",ns_accepting);
node q4=ncircle("$q_4$",ns_accepting); 
node e=ncircle("$e$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2, q3, q4);
vlayout(1*v, q3, e);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"),
     (q0..loop(N)).l("\str{b}"),
     (q1..bend(-20)..q0).l("\str{b}").style("leftside"),
     (q1..bend(-20)..q2).l("\str{a}").style("leftside"),
     (q2--e).l("\str{a}"),
     (q2..bend(-20)..q3).l("\str{b}").style("leftside"),
     (q3..bend(-20)..q4).l("\str{a}").style("leftside"),
     (q3..loop(N)).l("\str{b}"),
     (q4--e).l("\str{a}").style("leftside"),
     (q4..bend(-20)..q3).l("\str{b}").style("leftside"),
     (e..loop(E)).l("any")
     );

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== exercise: tic-tac-toe =========
picture pic;
int picnum = 49;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");    
node q2=ncircle("$q_2$");    
node q3=ncircle("$q_3$");    
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");  
node q6=ncircle("$q_6$");  
node ldots0=nbox("\makebox[4em][c]{\ldots}",ns_noborder);  
node ldots1=nbox("\makebox[4em][c]{\ldots}",ns_noborder);  
node ldots2=nbox("\makebox[4em][c]{\ldots}",ns_noborder);    
node ldots3=nbox("\makebox[4em][c]{\ldots}",ns_noborder);    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

q1.pos = new_node_pos_h(q0, 15, 1.0*u);
q2.pos = new_node_pos_h(q0, -15, 1.0*u);
q3.pos = new_node_pos_h(q1, 20, 1.0*u);
hlayout(1*u, q1, q4);
hlayout(1*u, q2, q5);
q6.pos = new_node_pos_h(q2, -20, 1.0*u);
hlayout(0.5*u, q3, ldots0);
hlayout(0.5*u, q4, ldots1);
hlayout(0.5*u, q5, ldots2);
hlayout(0.5*u, q6, ldots3);

// draw edges
draw(pic,
     (q0--q1).l("\str{X}").style("leftside"),
     (q0--q2).l("\str{E}"),
     (q1--q3).l("\str{X}").style("leftside"),
     (q1--q4).l("\str{E}"),
     (q2--q5).l("\str{X}").style("leftside"),
     (q2--q6).l("\str{E}")
);

// draw nodes
draw(pic,
     q0,
     q1, q2,
     q3, q4, q5, q6,
     ldots0, ldots1, ldots2, ldots3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== exercise: find minimum pumping length =========
picture pic;
int picnum = 50;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting);    
node q1=ncircle("$q_1$");    
node q2=ncircle("$q_2$");    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
vlayout(1*v, q0, q2);

// draw edges
draw(pic,
     (q0..bend..q1).l("\str{0}").style("leftside"),
     (q0--q2).l("\str{1}"),
     (q1..bend..q0).l("\str{1}"),
     (q1--q2).l("\str{0}").style("leftside"),
     (q2..loop(E)).l("any")
);

// draw nodes
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: two loops a problem for PL? =========
picture pic;
int picnum = 51;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_{i_1}$");    
node q2=ncircle("$q_{i_2}$");    
node q3=ncircle("$q_{i_3}$");    
node q4=ncircle("$q_{i_4}$");    
node q5=ncircle("$q_{i_5}$");    
node q6=ncircle("$q_{i_6}$");    
node q7=ncircle("$q_{i_7}$");    
node q8=ncircle("$q_{i_8}$",ns_accepting);    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1*u, q0, q1, q4, q5, q8);
q2.pos = new_node_pos(q1, 60, 1*v);
hlayout(-1*u, q2, q3);
q6.pos = new_node_pos(q5, 60, 1*v);
hlayout(-1*u, q6, q7);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1..bend..q2).l("\str{a}"),
     (q2..bend..q3).l("\str{b}"),
     (q3..bend..q1).l("\str{b}"),
     (q1--q4).l("\str{a}"),
     (q4--q5).l("\str{b}"),
     (q5..bend..q6).l("\str{b}"),
     (q6..bend..q7).l("\str{b}"),
     (q7..bend..q5).l("\str{a}"),
     (q5--q8).l("\str{a}")
);

// draw nodes
draw(pic, q0, q1, q2, q3, q4, q5, q6, q7, q8);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== exercise: language of comment strings =========
picture pic;
int picnum = 52;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");    
node q2=ncircle("$q_2$");    
node q3=ncircle("$q_3$");    
node q4=ncircle("$q_4$",ns_accepting);    
node e=ncircle("$e$");    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1*u, q0, q1, q2, q3, q4);
vlayout(1*v,q2, e);

// draw edges
draw(pic,
     (q0--q1).l("\str{/}").style("leftside"),
     (q0..bend..e).l(Label("other",Relative(0.25))),
     (q1--q2).l("\str{\#}").style("leftside"),
     (q1..bend..e).l(Label("other",Relative(0.35))),
     (q2--q3).l("\str{\#}").style("leftside"),
     (q2..loop(N)).l("other"),
     (q2--e).l(Label("\str{/}, \str{\#}",Relative(0.3))),
     (q3--q4).l("\str{/}").style("leftside"),
     (q3..bend(-20)..e).l(Label("other",Relative(0.25))).style("leftside"),
     (q4..bend(-20)..e).l(Label("any",Relative(0.25))).style("leftside"),
     (e..loop(S)).l("any")
);

// draw nodes
draw(pic, q0, q1, q2, q3, q4, e);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ==== exercise: describe states before machine =======
// .......... at least one a and at least one b ................
int picnum = 53;
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


// .............. fewer than 3 a's .............
int picnum = 54;
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



// ................ ends in ab ..............
int picnum = 55;
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


// .................  a^nb^m  n,m\geq 2 ...........
int picnum = 56;
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



// ................  a^nb^ma^p  m=2 ...............
int picnum = 57;
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




// ========== wolf-goat-cabbage-crossing ==============
int picnum = 58;
picture pic;

unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$"),
     q4=ncircle("$q_4$"),
     q5=ncircle("$q_5$"),
     q6=ncircle("$q_6$"),
     q7=ncircle("$q_7$"),
     q8=ncircle("$q_8$"),
     q9=ncircle("$q_9$",ns_accepting),
     error=ncircle("$e$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = u;

hlayout(u, q0, q5, q2, q6, q1, q7, q4);
vlayout(1*v, q2, q8);
// q3.pos = new_node_pos(q7, -120, -0.75*v);
vlayout(1*v, q7, q3);
vlayout(1*v, q4, q9);
vlayout(1*v, q0, error);

// edges
draw(pic,
     (q0..bend..q5).l("\str{g}"),
     (q5..bend..q0).l("\str{g}"),
     (q5..bend..q2).l("$\str{n}$"),
     (q2..bend..q5).l("$\str{n}$"),
     (q2..bend..q6).l("$\str{c}$"),
     (q6..bend..q2).l("$\str{c}$"),
     (q6..bend..q1).l("$\str{g}$"),
     (q1..bend..q6).l("$\str{g}$"),
     (q1..bend..q7).l("$\str{w}$"),
     (q7..bend..q1).l("$\str{w}$"),
     (q7..bend..q4).l("$\str{n}$"),
     (q4..bend..q7).l("$\str{n}$"),
     (q2..bend..q8).l("$\str{w}$"),
     (q8..bend..q2).l("$\str{w}$"),
     (q7..bend..q3).l("$\str{c}$"),
     (q3..bend..q7).l("$\str{c}$"),
     (q4--q9).l("$\str{g}$"),
     (q9..loop(E)).l("$\str{w,g,c,n}$"),
     (error..loop(E)).l("$\str{w,g,c,n}$"),
     (q8--q6).l("$\str{n}$"),
     (q3..bend(15)..q8).l("$\str{g}$"),
     (q8..bend(15)..q3).l("$\str{g}$")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, 
     q3, q4, q5,
     q6, q7, q8,
     q9, error
       );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== partition of universe of strings into five parts =======
picture pic;
int picnum = 59;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

// pens to draw inside borders
real borderpenwidth = 1pt;
pen borderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor; // or lightcolor?
pen universe_borderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// grid to help placing
// for (int row=1; row<10; ++row) {
//   draw(pic, (0,row*hgt/10)--(wth,row*hgt/10), blue+linewidth(0.2pt));
// }
// for (int col=1; col<10; ++col) {
//   draw(pic, (col*wth/10,0)--(col*wth/10,hgt), blue+linewidth(0.2pt));    
// }

// boundaries of regions
path universe_border = ll--lr--ur--ul--cycle;
path r0_border = point(universe_border,3.35){E}
      :: point(universe_border,2.6)-(0.1*wth,0.3*hgt)
      :: {N}point(universe_border,2.6);
path r2_border = point(universe_border,3.65){E+0.1*N}
      .. point(universe_border,0.5)+(-0.125*wth,0.35*hgt)
      .. point(universe_border,0.5);
path r1_border = point(r0_border,1.75)
      .. (0.5*wth,0.5*hgt)
      .. point(r2_border,1.5);
path r3_border = point(r1_border,0.85)
      .. (0.85*wth,0.65*hgt)
      .. point(universe_border,1.8);
// dot(pic, (0.85*wth,0.65*hgt), green);

// Draw borders
draw(pic, r0_border, borderpen);
draw(pic, r1_border, borderpen);
draw(pic, r2_border, borderpen);
draw(pic, r3_border, borderpen);

// Draw the outside border
draw(pic,universe_border,universe_borderpen);

// Labels
label(pic,"$\eclass_{\lang,0}$",(0.175wth,0.85hgt));
label(pic,"$\eclass_{\lang,1}$",(0.375wth,0.55hgt));
label(pic,"$\eclass_{\lang,2}$",(0.25wth,0.2hgt));
label(pic,"$\eclass_{\lang,3}$",(0.7wth,0.8hgt));
label(pic,"$\eclass_{\lang,4}$",(0.775wth,0.3hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== password requirements ================
picture pic;
int picnum = 60;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$");  
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

layout(15.0, (1/Cos(15.0))*u, q0, q1);
layout(-15.0, (1/Cos(-15.0))*u, q0, q2);
hlayout(1*u, q1, q3);
hlayout(1*u, q2, q4);

// draw edges
draw(pic,
     (q0..loop(W)).l("else"),
     (q0--q1).l("\str{a},$\ldots$,\str{z}").style("leftside"),
     (q1..loop(N)).l("not \str{A},$\ldots$\,\str{Z}"),
     (q0--q2).l("\str{A},$\ldots$\,\str{Z}"),
     (q1--q3).l("\str{A},$\ldots$\,\str{Z}").style("leftside"),
     (q2..loop(S)).l("not \str{a},$\ldots$\,\str{z}"),
     (q2--q4).l("\str{a},$\ldots$\,\str{z}"),
     (q3..loop(E)).l("any"),
     (q4..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== partition for myhill-nerode, even length language-related ====
// See also picnum 77
picture pic;
int picnum = 61;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

real Mborderpenwidth = 1pt, Lborderpenwidth = 0.5*Mborderpenwidth;
pen Lborderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor;
pen Mborderpen = squarecap+linejoin(0)+linewidth(Mborderpenwidth)+lightcolor;
pen outsideborderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// declare the vert middle boundary (drawn later)
path mid_bound = interp(ul,ur,0.5)
  ..(interp(ul.x,ur.x,0.5)+0.1,interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.5);

// left boundaries
// real lft_topbnd_y=0.8*hgt;
// real[] lft_top_lft_t = intersections(ul--ll,(0,lft_topbnd_y),(wth,lft_topbnd_y));
// pair lft_top_lft = point(ul--ll, lft_top_lft_t[0]);
// real[] lft_top_rt_t = intersections(mid_bound,(0,lft_topbnd_y),(wth,lft_topbnd_y));
// pair lft_top_rt = point(mid_bound,lft_top_rt_t[0]);
// path left_top_bound = lft_top_lft
//   ..(0.5*(lft_top_lft+lft_top_rt)+(0,-0.1))
//   ..lft_top_rt;
// draw(pic,left_top_bound,Mborderpen);
// real lft_botbnd_y=0.4*hgt;
// real[] lft_bot_lft_t = intersections(ul--ll,(0,lft_botbnd_y),(wth,lft_botbnd_y));
// pair lft_bot_lft = point(ul--ll, lft_bot_lft_t[0]);
// real[] lft_bot_rt_t = intersections(mid_bound,(0,lft_botbnd_y),(wth,lft_botbnd_y));
// pair lft_bot_rt = point(mid_bound,lft_bot_rt_t[0]);
// path left_bot_bound = lft_bot_lft
//   ..(0.5*(lft_bot_lft+lft_bot_rt)+(0,-0.1))
//   ..lft_bot_rt;
// draw(pic,left_bot_bound,Mborderpen);
// // right boundary
// real rt_bnd_y=0.525*hgt;
// real[] rt_lft_t = intersections(mid_bound,(0,rt_bnd_y),(wth,rt_bnd_y));
// pair rt_lft = point(mid_bound,rt_lft_t[0]);
// real[] rt_rt_t = intersections(ur--lr,(0,rt_bnd_y),(wth,rt_bnd_y));
// pair rt_rt = point(ur--lr, rt_rt_t[0]);
// path rt_bound = rt_lft
//   ..(0.5*(rt_lft+rt_rt)+(0,-0.1))
//   ..rt_rt;
// draw(pic,rt_bound,Mborderpen);

// draw the vert middle boundary
// draw(pic,mid_bound,Mborderpen);
draw(pic,mid_bound,Lborderpen);

// Draw the outside border
path Mborder = ll--lr--ur--ul--cycle;
draw(pic,Mborder,outsideborderpen);

// Labels
// label(pic,"$\eclass_{\FSM,0}$",(0.25wth,0.875hgt));
// label(pic,"$\eclass_{\FSM,3}$",(0.25wth,0.55hgt));
// label(pic,"$\eclass_{\FSM,4}$",(0.25wth,0.175hgt));
// label(pic,"$\eclass_{\FSM,1}$",(0.75wth,0.725hgt));
// label(pic,"$\eclass_{\FSM,2}$",(0.75wth,0.225hgt));
label(pic,"$\eclass_{\lang,0}$",(0.25wth,0.5hgt));
label(pic,"$\eclass_{\lang,1}$",(0.75wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ====== partition for myhill-nerode, even length, non-minimal machine =======
picture pic;
int picnum = 62;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

real Mborderpenwidth = 1pt, Lborderpenwidth = 0.5*Mborderpenwidth;
pen Lborderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor;
pen Mborderpen = squarecap+linejoin(0)+linewidth(Mborderpenwidth)+lightcolor;
pen outsideborderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// declare the vert middle boundary (drawn later)
path mid_bound = interp(ul,ur,0.5)
  ..(interp(ul.x,ur.x,0.5)+0.1,interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.5);

// left boundaries
real lft_topbnd_y=0.8*hgt;
real[] lft_top_lft_t = intersections(ul--ll,(0,lft_topbnd_y),(wth,lft_topbnd_y));
pair lft_top_lft = point(ul--ll, lft_top_lft_t[0]);
real[] lft_top_rt_t = intersections(mid_bound,(0,lft_topbnd_y),(wth,lft_topbnd_y));
pair lft_top_rt = point(mid_bound,lft_top_rt_t[0]);
path left_top_bound = lft_top_lft
  ..(0.5*(lft_top_lft+lft_top_rt)+(0,-0.1))
  ..lft_top_rt;
draw(pic,left_top_bound,Mborderpen);
real lft_botbnd_y=0.4*hgt;
real[] lft_bot_lft_t = intersections(ul--ll,(0,lft_botbnd_y),(wth,lft_botbnd_y));
pair lft_bot_lft = point(ul--ll, lft_bot_lft_t[0]);
real[] lft_bot_rt_t = intersections(mid_bound,(0,lft_botbnd_y),(wth,lft_botbnd_y));
pair lft_bot_rt = point(mid_bound,lft_bot_rt_t[0]);
path left_bot_bound = lft_bot_lft
  ..(0.5*(lft_bot_lft+lft_bot_rt)+(0,-0.1))
  ..lft_bot_rt;
draw(pic,left_bot_bound,Mborderpen);
// right boundary
real rt_bnd_y=0.525*hgt;
real[] rt_lft_t = intersections(mid_bound,(0,rt_bnd_y),(wth,rt_bnd_y));
pair rt_lft = point(mid_bound,rt_lft_t[0]);
real[] rt_rt_t = intersections(ur--lr,(0,rt_bnd_y),(wth,rt_bnd_y));
pair rt_rt = point(ur--lr, rt_rt_t[0]);
path rt_bound = rt_lft
  ..(0.5*(rt_lft+rt_rt)+(0,-0.1))
  ..rt_rt;
draw(pic,rt_bound,Mborderpen);

// draw the vert middle boundary
draw(pic,mid_bound,Mborderpen);
// draw(pic,mid_bound,Lborderpen);

// Draw the outside border
path Mborder = ll--lr--ur--ul--cycle;
draw(pic,Mborder,outsideborderpen);

// Labels
label(pic,"$\eclass_{\FSM,0}$",(0.25wth,0.875hgt));
label(pic,"$\eclass_{\FSM,3}$",(0.25wth,0.55hgt));
label(pic,"$\eclass_{\FSM,4}$",(0.25wth,0.175hgt));
label(pic,"$\eclass_{\FSM,1}$",(0.75wth,0.725hgt));
label(pic,"$\eclass_{\FSM,2}$",(0.75wth,0.225hgt));
// label(pic,"$\eclass_{\lang,0}$",(-0.2wth,0.5hgt));
// label(pic,"$\eclass_{\lang,1}$",(1.2wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Myhill-Nerode example, minimal machine ================
picture pic;
int picnum = 63;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$",ns_accepting); 
node q1=ncircle("$\eclass_{\lang,1}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 2.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0..bend..q1).l("\str{a},\str{b}"),
     (q1..bend..q0).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Myhill-Nerode  partition of strings into five parts =======
picture pic;
int picnum = 64;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

// pens to draw inside borders
real borderpenwidth = 1pt;
pen borderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+highlightcolor; // or lightcolor?
pen universe_borderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// grid to help placing
// for (int row=1; row<10; ++row) {
//   draw(pic, (0,row*hgt/10)--(wth,row*hgt/10), blue+linewidth(0.2pt));
// }
// for (int col=1; col<10; ++col) {
//   draw(pic, (col*wth/10,0)--(col*wth/10,hgt), blue+linewidth(0.2pt));    
// }

// boundaries of regions
path universe_border = ll--lr--ur--ul--cycle;
path r0_border = point(universe_border,3.35){E}
      :: point(universe_border,2.6)-(0.1*wth,0.3*hgt)
      :: {N}point(universe_border,2.6);
path r1_border = point(r0_border,1.65)
  ..(0.46*wth,0.45*hgt)
  .. point(universe_border,0.42);
//dot(pic, (0.46*wth,0.45*hgt), green);

// Draw borders
draw(pic, r0_border, borderpen);
draw(pic, r1_border, borderpen);

// Draw the outside border
draw(pic,universe_border,universe_borderpen);

// Labels
label(pic,"$\eclass_{\lang,0}$",(0.175wth,0.85hgt));
label(pic,"$\eclass_{\lang,1}$",(0.25wth,0.35hgt));
label(pic,"$\eclass_{\lang,2}$",(0.75wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............. resulting machine .........................
picture pic;
int picnum = 65;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$"); 
node q1=ncircle("$\eclass_{\lang,1}$",ns_accepting); 
node q2=ncircle("$\eclass_{\lang,2}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 2.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
layout(-30.0, 0.5*(1/Cos(-30.0))*u, q0, q2);

// draw edges
draw(pic,
     (q0..bend(-15)..q1).l("\str{a}").style("leftside"),
     (q0..bend..q2).l("\str{b}"),
     (q1..bend(-15)..q2).l("\str{a}").style("leftside"),
     (q1..loop(E)).l("\str{b}"),
     (q2..loop(S)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1,
     q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===== Myhill-Nerode: machine with four classes ========
picture pic;
int picnum = 66;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$",ns_accepting); 
node q1=ncircle("$\eclass_{\lang,1}$"); 
node q2=ncircle("$\eclass_{\lang,2}$"); 
node q3=ncircle("$\eclass_{\lang,3}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);
vlayout(1*v, q0, q3);
hlayout(1*u, q3, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{0}"),
     (q0--q1).l("\str{1}").style("leftside"),
     (q1..loop(E)).l("\str{0}"),
     (q1--q2).l("\str{1}").style("leftside"),
     (q2..loop(E)).l("\str{0}"),
     (q2--q3).l("\str{1}"),
     (q3..loop(W)).l("\str{0}"),
     (q3--q0).l("\str{1}")
);

// draw nodes
draw(pic,
     q0, q1,
     q3, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ===== Myhill-Nerode exercise: machine for even length strings ========
picture pic;
int picnum = 67;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$",ns_accepting); 
node q1=ncircle("$\eclass_{\lang,1}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0..bend..q1).l("\str{a},\str{b}"),
     (q1..bend..q0).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ===== Myhill-Nerode exercise: machine for length three strings ========
picture pic;
int picnum = 68;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$"); 
node q1=ncircle("$\eclass_{\lang,1}$"); 
node q2=ncircle("$\eclass_{\lang,2}$"); 
node q3=ncircle("$\eclass_{\lang,3}$",ns_accepting); 
node q4=ncircle("$\eclass_{\lang,4}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2, q3, q4);

// draw edges
draw(pic,
     (q0--q1).l("\str{a},\str{b}"),
     (q1--q2).l("\str{a},\str{b}"),
     (q2--q3).l("\str{a},\str{b}"),
     (q3--q4).l("\str{a},\str{b}"),
     (q4..loop(E)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ===== Myhill-Nerode exercise: strings that end in a ========
picture pic;
int picnum = 69;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$"); 
node q1=ncircle("$\eclass_{\lang,1}$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{b}"),
     (q0..bend..q1).l("\str{a}"),
     (q1..loop(E)).l("\str{a}"),
     (q1..bend..q0).l("\str{b}")
);

// draw nodes
draw(pic,
     q0, q1
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ===== Myhill-Nerode exercise: strings that end in 01 ========
picture pic;
int picnum = 70;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{1}"),
     (q0..bend(-20)..q1).l("\str{0}").style("leftside"),
     (q1..loop(N)).l("\str{0}"),
     (q1..bend(-20)..q2).l("\str{1}").style("leftside"),
     (q2..bend(-20)..q1).l("\str{0}"),
     (q2..bend(-30)..q0).l("\str{1}").style("leftside")
);

// draw nodes
draw(pic,
     q0, q1, q2
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===== Myhill-Nerode exercise: strings of form a^{n}b ========
picture pic;
int picnum = 71;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0..loop(W)).l("\str{a}"),
     (q0..bend(-20)..q1).l("\str{b}").style("leftside"),
     (q1..bend(-20)..q2).l("\str{a},\str{b}").style("leftside"),
     (q2..loop(E)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ===== Myhill-Nerode exercise: strings of form aab^{n} ========
picture pic;
int picnum = 72;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$",ns_accepting); 
node q3=ncircle("$q_3$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2, q3);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{a}").style("leftside"),
     (q0..bend..q3).l("\str{b}"),
     (q1..bend(-20)..q2).l("\str{a}").style("leftside"),
     (q1..bend..q3).l("\str{b}").style("leftside"),
     (q2..loop(N)).l("\str{b}"),
     (q2..bend(-20)..q3).l("\str{a}").style("leftside"),
     (q3..loop(N)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ===== Myhill-Nerode exercise: strings where every 0 is followed by 11 =======
picture pic;
int picnum = 73;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$",ns_accepting); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);
vlayout(-1*v, q2, q3);

// draw edges
draw(pic,
     (q0..bend(-20)..q1).l("\str{0}").style("leftside"),
     (q0..loop(W)).l("\str{1}"),
     (q1--q3).l("\str{0}").style("leftside"),
     (q1..bend(-20)..q2).l("\str{1}").style("leftside"),
     (q2..bend(-20)..q0).l("\str{1}").style("leftside"),
     (q2--q3).l("\str{0}").style("leftside"),
     (q3..loop(E)).l("\str{0},\str{1}")
);

// draw nodes
draw(pic,
     q0, q1, q2,
     q3
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ===== Minimization Moore's algorithm proof example input =======
picture pic;
int picnum = 74;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

layout(15.0, (1/Cos(15.0))*u, q0, q1);
layout(-15.0, (1/Cos(-15.0))*u, q0, q2);
hlayout(1*u, q1, q3);
hlayout(1*u, q2, q4);

// draw edges
draw(pic,
     (q0--q1).l("\str{a} .. \str{z}\,").style("leftside"),
     (q0--q2).l("\str{A} .. \str{Z}\;"),
     (q1..loop(N)).l("\str{a} .. \str{z}"),
     (q1--q3).l("\str{A} .. \str{Z}").style("leftside"),
     (q2..loop(S)).l("\str{A} .. \str{Z}"),
     (q2--q4).l("\str{a} .. \str{z}"),
     (q3..loop(E)).l("any"),
     (q4..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q3,
     q2, q4
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............... minimized machine ...............
picture pic;
int picnum = 75;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$r_0$"); 
node q1=ncircle("$r_1$"); 
node q2=ncircle("$r_2$"); 
node q3=ncircle("$r_3$",ns_accepting); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

layout(15.0, (1/Cos(15.0))*u, q0, q1);
layout(-15.0, (1/Cos(-15.0))*u, q0, q2);
hlayout(2*u, q0, q3);

// draw edges
draw(pic,
     (q0--q1).l("\str{a} .. \str{z}\;").style("leftside"),
     (q0--q2).l("\str{A} .. \str{Z}\;"),
     (q1..loop(N)).l("\str{a} .. \str{z}"),
     (q1--q3).l("\;\str{A} .. \str{Z}").style("leftside"),
     (q2..loop(S)).l("\str{A} .. \str{Z}"),
     (q2--q3).l("\;\str{a} .. \str{z}"),
     (q3..loop(E)).l("any")
);

// draw nodes
draw(pic,
     q0, q1, q3,
     q2
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============ Myhill-Nerode: strings that end in b ==============
picture pic;
int picnum = 76;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$\eclass_{\lang,0}$",ns_accepting); 
node q1=ncircle("$\eclass_{\lang,1}$"); 

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 2.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1);

// draw edges
draw(pic,
     (q0..bend(-15)..q1).l("\str{a}").style("leftside"),
     (q1..bend(-15)..q0).l("\str{b}").style("leftside"),
     (q0..loop(N)).l("\str{b}"),
     (q1..loop(N)).l("\str{a}")
);

// draw nodes
draw(pic,
     q0, q1);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== partition for myhill-nerode, no highlight color ====
// See also picnum 61
picture pic;
int picnum = 77;
unitsize(pic,1cm);

real wth=4, hgt=2; 

pair ll=(0,0), lr=(wth,0), ur=(wth,hgt), ul=(0,hgt);

real Mborderpenwidth = 1pt, Lborderpenwidth = 0.5*Mborderpenwidth;
pen Lborderpen = squarecap+linejoin(0)+linewidth(Lborderpenwidth)+lightcolor;
pen Mborderpen = squarecap+linejoin(0)+linewidth(Mborderpenwidth)+lightcolor;
pen outsideborderpen = squarecap+linejoin(0)+linewidth(0.4)+black;

// declare the vert middle boundary (drawn later)
path mid_bound = interp(ul,ur,0.5)
  ..(interp(ul.x,ur.x,0.5)+0.1,interp(ul.y,ll.y,0.5))
  ..interp(ll,lr,0.5);

// draw the vert middle boundary
draw(pic,mid_bound,Lborderpen);

// Draw the outside border
path Mborder = ll--lr--ur--ul--cycle;
draw(pic,Mborder,outsideborderpen);

// Labels
label(pic,"$\eclass_{\lang,0}$",(0.25wth,0.5hgt));
label(pic,"$\eclass_{\lang,1}$",(0.75wth,0.5hgt));
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== Moore's algorithm exercise, show machine minimal ============
picture pic;
int picnum = 78;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$"); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$"); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$",ns_accepting);  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 2cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3, q4);
vlayout(0.8v, q3, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..bend(22.5)..q2).l("\str{b}"),
     (q1..bend(-20)..q3).l("\str{a}").style("leftside"),
     (q1..bend(-15)..q2).l(Label("\str{b}",Relative(0.65))),
     (q2..bend(-10)..q1).l(Label("\str{a}", Relative(0.65))).style("leftside"),
     (q2--q3).l("\str{b}"),
     (q3--q4).l("\str{a}"),
     (q3..bend(10)..q5).l("\str{b}"),
     (q4..bend(-12.5)..q5).l("\str{a}"),
     (q4..bend(25)..q1).l("\str{b}"),
     (q5..bend(10)..q3).l("\str{a}"),
     (q5..bend(-25)..q0).l("\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4,
     q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== Moore's algorithm exercise, minimize ============
picture pic;
int picnum = 79;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$",ns_accepting); 
node q2=ncircle("$q_2$"); 
node q3=ncircle("$q_3$",ns_accepting); 
node q4=ncircle("$q_4$"); 
node q5=ncircle("$q_5$");  

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 2cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);
real tail_angle = 20;  // degrees
q4.pos = new_node_pos_h(q3, tail_angle, u);
q5.pos = new_node_pos_h(q3, -1*tail_angle, u);
// layout(v, tail_angle, q3, q4, u);
// layout(v, -20, q3, q5, u);
// vlayout(0.8v, q3, q5);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q0..bend(-20)..q3).l(Label("\str{b}",Relative(0.4))).style("leftside"),
     (q1..bend(-15)..q2).l(Label("\str{a}",Relative(0.65))).style("leftside"),
     (q1..bend(20)..q5).l(Label("\str{b}")).style("leftside"),
     (q2..bend(-15)..q1).l(Label("\str{a}", Relative(0.65))),
     (q2--q3).l("\str{b}"),
     (q3--q5).l("\str{a}"),
     (q3..bend(10)..q4).l("\str{b}"),
     (q4..bend(15)..q1).l("\str{a}").style("leftside"),
     (q4..bend(25)..q3).l(Label("\str{b}",Relative(0.6))),
     (q5..loop(E)).l("\str{a},\str{b}")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3,
     q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

