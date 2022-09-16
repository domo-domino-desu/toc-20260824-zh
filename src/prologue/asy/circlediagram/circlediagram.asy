// circlediagram.asy
//  circle diagram of a TM

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

// import node;

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(xmargin=1pt,
			   black,  // label
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+boldcolor,
			   arrow=Arrow(6,filltype=FillDraw(lightcolor,black))
			   );

// ............................ P_pred
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
// node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.40cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

draw(pic,
     (q0--q1).l("\scriptsize $\blank,\str{L}$"), 
     (q0..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
     // (q1--q2).l("\scriptsize $\blank,\str{L}$").style("leftside"),
     // (q1--q1).l(Label("\scriptsize $10$",position=Relative(0.7))),
     (q1--q2).l("\scriptsize $\blank,\str{L}$"),
     (q1..loop(S)).l("\scriptsize $\str{1},\str{B}$"),
     (q2--q3).l("\scriptsize $\blank,\str{R}$"),
     (q2..loop(S)).l("\scriptsize $\str{1},\str{L}$")
    );

// draw nodes
draw(pic, q0, q1, q2, q3);

shipout(format("circlediagram%02d",picnum),pic,format="pdf");



// ............................ P_add
picture pic;
int picnum = 1;
unitsize(pic,1pt);
setdefaultstatediagramstyles();

// define nodes
// node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$"),
     q4=ncircle("$q_4$"),
     q5=ncircle("$q_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.40cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1).l("\scriptsize $\blank,\blank$"), 
     (q0..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
     // (q1--q2).l("\scriptsize $\blank,\str{L}$").style("leftside"),
     // (q1--q1).l(Label("\scriptsize $10$",position=Relative(0.7))),
     (q1..loop(S)).l("\scriptsize $\blank,\str{1}$"),
     (q1--q2).l("\scriptsize $\str{1},\str{1}$"),
     (q2--q3).l("\scriptsize $\blank,\str{B}$"),
     (q2..loop(S)).l("\scriptsize $\str{1},\str{L}$"),
     (q3..loop(S)).l("\scriptsize $\blank,\str{R}$"),
     (q3--q4).l("\scriptsize $\str{1},\blank$"),
     (q4..bend..q5).l("\scriptsize $\blank,\str{R}$"),
     (q4..bend(-20)..q5).l("\scriptsize $\str{1},\str{1}$").style("leftside")
    );

// draw nodes
draw(pic, q0, q1, q2, q3, q4, q5);

shipout(format("circlediagram%02d",picnum),pic,format="pdf");

