// busybeaver.asy
//  Diagrams for the Busy Beaver extra section

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);


// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
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

string OUTPUT_FN = "busybeaver%02d";



// ============== Four ones ================
picture pic;
int picnum = 0;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$"),
  q1=ncircle("$q_1$"),
  q2=ncircle("$q_2$"),
  q3=ncircle("$q_3$"),
  halt=ncircle("Halt");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;
hlayout(1.0*u, q0, q1, q2, q3, halt);

// edges
draw(pic,
(q0..bend(30)..q1).l("\str{1},R"),
     (q0..loop(N)).l("\str{B},\str{1}"),
     (q1..bend..q2).l("\str{1},R"),
     (q1..loop(N)).l("\str{B},\str{1}"),
     (q2..bend..q3).l("\str{1},R"),
     (q2..loop(N)).l("\str{B},\str{1}"),
     (q3..bend..halt).l("\str{1},R"),
     (q3..loop(N)).l("\str{B},\str{1}")
    );

// draw nodes after edges so arrows are OK
draw(pic, q0, q1, q2, q3, halt);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Compose machines ================

// ..... before .........
picture pic;
int picnum = 1;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node mi=ncircle("$m_i$"),
  mj=ncircle("$m_j$"),
  mi_etc=ncircle("$\ldots$",ns_noborder),
  mj_etc=ncircle("$\ldots$",ns_noborder),
  halt=ncircle("Halt"),
  n0=ncircle("$n_0$"),
  n1=ncircle("$n_1$"),
  n1_etc=ncircle("$\ldots$",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;
hlayout(0.5*u, mi_etc, mi);
hlayout(1.0*u, mi, halt);
hlayout(1.0u, halt, n0);
hlayout(1.0*u, n0, n1);
hlayout(0.5*u, n1, n1_etc);
mj.pos = new_node_pos(halt, -135.0, -0.75*v);
hlayout(-0.5*u, mj, mj_etc);


// edges
draw(pic,
     (mi--halt),
     (mj--halt),
     (n0--n1)
    );

// draw nodes after edges so arrows are OK
draw(pic, mi_etc, mi, halt, mj_etc, mj, n0, n1, n1_etc);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ..... after .........
picture pic;
int picnum = 2;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node mi=ncircle("$m_i$"),
  mj=ncircle("$m_j$"),
  mi_etc=ncircle("$\ldots$",ns_noborder),
  mj_etc=ncircle("$\ldots$",ns_noborder),
  n0=ncircle("$n_0$"),
  n1=ncircle("$n_1$"),
  n1_etc=ncircle("$\ldots$",ns_noborder);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;
hlayout(0.5*u, mi_etc, mi);
hlayout(1.0*u, mi, n0, n1);
hlayout(0.5*u, n1, n1_etc);
mj.pos = new_node_pos(n0, -135.0, -0.75*v);
hlayout(-0.5*u, mj, mj_etc);


// edges
draw(pic,
     (mi--n0),
     (mj--n0),
     (n0--n1)
    );

// draw nodes after edges so arrows are OK
draw(pic, mi_etc, mi, mj_etc, mj, n0, n1, n1_etc);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
