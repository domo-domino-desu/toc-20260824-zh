// circlediagram.asy
//  circle diagram of a TM

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

import node;

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

// define nodes
// node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3);

// draw nodes
draw(pic, q0, q1, q2, q3);

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
shipout(format("circlediagram%02d",picnum),pic,format="pdf");


// ............................ P_add
picture pic;
int picnum = 1;
unitsize(pic,1pt);

// define nodes
// node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
node q0=ncircle("$q_0$"),
     q1=ncircle("$q_1$"),
     q2=ncircle("$q_2$"),
     q3=ncircle("$q_3$"),
     q4=ncircle("$q_4$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(u, q0, q1, q2, q3, q4);

// draw nodes
draw(pic, q0, q1, q2, q3, q4);

// draw edges
draw(pic,
     (q0--q1).l("\scriptsize $\blank,\str{1}$"), 
     (q0..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
     // (q1--q2).l("\scriptsize $\blank,\str{L}$").style("leftside"),
     // (q1--q1).l(Label("\scriptsize $10$",position=Relative(0.7))),
     (q1--q2).l("\scriptsize $\blank,\str{L}$"),
     (q1..loop(S)).l("\scriptsize $\str{1},\str{R}$"),
     (q2--q3).l("\scriptsize $\blank,\str{R}$"),
     (q2..loop(S)).l("\scriptsize $\str{1},\str{L}$"),
     (q3--q4).l("\scriptsize $\str{1},\blank$"),
     (q3..loop(S)).l("\scriptsize $\blank,\str{R}$")
    );
shipout(format("circlediagram%02d",picnum),pic,format="pdf");

