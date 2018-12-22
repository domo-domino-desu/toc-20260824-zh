// graphs.asy
//  Draw intro to graphs

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../../asy/");
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
defaultnodestyle=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(white,black));
defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor);

// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;


// ======================== house graph =============
int picnum = 0;
picture p;

// define nodes
node peak=ncircle("$v_0$"),
     lefttop=ncircle("$v_1$"),
     righttop=ncircle("$v_2$"),
     leftbot=ncircle("$v_3$"),
     rightbot=ncircle("$v_4$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
layout(-90-peakangle,peak,lefttop);
layout(-90+peakangle,peak,righttop);
vlayout(1*v,lefttop,leftbot);
vlayout(1*v,righttop,rightbot);

// draw edges
draw(p,
     (peak--lefttop),
     (peak--righttop),
     (lefttop--righttop),
     (lefttop--leftbot),
     (lefttop--rightbot),
     (righttop--leftbot),
     (righttop--rightbot),
     (leftbot--rightbot)
    );

// draw nodes
draw(p,
     peak,
     lefttop,righttop,
     leftbot,rightbot);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== house graph sideways =============
int picnum = 1;
picture p;

// define nodes
node v0=ncircle("$v_0$"),
     v1=ncircle("$v_1$"),
     v2=ncircle("$v_2$"),
     v3=ncircle("$v_3$"),
     v4=ncircle("$v_4$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
hlayout(1*u,v3,v1);
hlayout(1*u,v4,v2);
vlayout(1*v,v1,v2);
vlayout(1*v,v3,v4);
v0.pos = (v1.pos.x+1*u,(v1.pos.y+v2.pos.y)/2); 
// layout(-45.0,0.707*v,v1,v0);

// draw edges
draw(p,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v1--v4),
     (v2--v3),
     (v2--v4),
     (v3--v4)
    );

// draw nodes
draw(p,
     v0,
     v1,v2,
     v3,v4);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ======================== house graph no edge crossing =============
int picnum = 2;
picture p;

// define nodes
node peak=ncircle("$v_0$"),
     lefttop=ncircle("$v_1$"),
     righttop=ncircle("$v_2$"),
     leftbot=ncircle("$v_3$"),
     rightbot=ncircle("$v_4$");

node n0, n1, n2;

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
layout(-90-peakangle,peak,lefttop);
layout(-90+peakangle,peak,righttop);
vlayout(1*v,lefttop,leftbot);
vlayout(1*v,righttop,rightbot);
hlayout(-0.5u,lefttop,n0);
hlayout(-0.25u,leftbot,n1);
vlayout(0.5v,leftbot,n2);

// draw edges
draw(p,
     (peak--lefttop),
     (peak--righttop),
     (lefttop--righttop),
     (lefttop--leftbot),
     // (lefttop.. bend(95.0) ..rightbot),
     (righttop--leftbot),
     (righttop--rightbot),
     (leftbot--rightbot)
    );
draw(p,lefttop.pos{curl 0.25} .. n1.pos .. n2.pos .. {curl 0.5}rightbot.pos,backgroundcolor);

// draw nodes
draw(p,
     peak,
     lefttop,righttop,
     leftbot,rightbot);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== tetrahedron =============
int picnum = 3;
picture p;

// define nodes
node v0=ncircle("$u_0$"),
     v1=ncircle("$u_1$"),
     v2=ncircle("$u_2$"),
     v3=ncircle("$u_3$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.65*u;                 // vertical

vlayout(v,v0,v1);
v2.pos = (v1.pos.x-u,v1.pos.y-v); 
v3.pos = (v1.pos.x+u,v2.pos.y); 

// draw edges
draw(p,
     (v0--v1),
     (v0--v2),
     (v0--v3),
     (v1--v2),
     (v1--v3),
     (v2--v3)
    );
// draw(p,lefttop.pos{curl 0.25} .. n1.pos .. n2.pos .. {curl 0.5}rightbot.pos,backgroundcolor);

// draw nodes
draw(p,
     v0,
     v1,
     v2,v3);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ======================== tetrahedron with walk =============
int picnum = 4;
picture p;

// draw edges as above
draw(p,
     (v0--v1),
     (v0--v2),
     (v0--v3),
     (v1--v2),
     (v1--v3),
     (v2--v3)
    );

// edges in walk
draw(p,(v0.pos--v1.pos), walk_pen);
draw(p,(v1.pos--v3.pos), walk_pen);

// draw nodes
draw(p,
     v0,
     v1,
     v2,v3);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ======================== cube =============
int picnum = 5;
picture p;

// define nodes
node v0=ncircle("$v_0$"),
     v1=ncircle("$v_1$"),
     v2=ncircle("$v_2$"),
     v3=ncircle("$v_3$"),
     v4=ncircle("$v_4$"),
     v5=ncircle("$v_5$"),
     v6=ncircle("$v_6$"),
     v7=ncircle("$v_7$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.6cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.8*u;                 // vertical

hlayout(3*u,v0,v1);
vlayout(3*v,v0,v6);
v2.pos = (v0.pos.x+1*u,v0.pos.y-v);
hlayout(1*u,v2,v3);
vlayout(1*v,v2,v4);
hlayout(1*u,v4,v5);
hlayout(3*u,v6,v7);

// draw edges
draw(p,
     (v0--v1),
     (v0--v2),
     (v0--v6),
     (v1--v3),
     (v1--v7),
     (v2--v3),
     (v2--v4),
     (v3--v5),
     (v4--v5),
     (v4--v6),
     (v5--v7),
     (v6--v7)
    );
// draw(p,lefttop.pos{curl 0.25} .. n1.pos .. n2.pos .. {curl 0.5}rightbot.pos,backgroundcolor);

// draw nodes
draw(p,
     v0,v1,
     v2,v3,
     v4,v5,
     v6,v7);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== cube with circuit =============
int picnum = 6;
picture p;

// repeat edges from last time
draw(p,
     (v0--v1),
     (v0--v2),
     (v0--v6),
     (v1--v3),
     (v1--v7),
     (v2--v3),
     (v2--v4),
     (v3--v5),
     (v4--v5),
     (v4--v6),
     (v5--v7),
     (v6--v7)
    );

// edges in cycle
draw(p,(v0.pos--v2.pos), walk_pen);
draw(p,(v2.pos--v3.pos), walk_pen);
draw(p,(v3.pos--v5.pos), walk_pen);
draw(p,(v5.pos--v4.pos), walk_pen);
draw(p,(v4.pos--v6.pos), walk_pen);
draw(p,(v6.pos--v7.pos), walk_pen);
draw(p,(v7.pos--v1.pos), walk_pen);
draw(p,(v1.pos--v0.pos), walk_pen);

// draw nodes, as last time
draw(p,
     v0,v1,
     v2,v3,
     v4,v5,
     v6,v7);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== shortest path =============
int picnum = 7;
picture p;

// define nodes
node a=ncircle("\strut$A$"),
     b=ncircle("\strut$B$"),
     c=ncircle("\strut$C$"),
     d=ncircle("\strut$D$"),
     e=ncircle("\strut$E$"),
     f=ncircle("\strut$F$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(v, a, b);
layout(-22.5, a, c);
hlayout(2*u, a, d);
hlayout(2*u, b, e);
layout(-22.5, d, f);

// draw edges
draw(p,
     (a--b).l(Label("\scriptsize $7$",edge_text_pen)), 
     (a--c).l(Label("\scriptsize $9$",edge_text_pen)),
     (a--d).l(Label("\scriptsize $14$",edge_text_pen)).style("leftside"),
     (b--c).l(Label("\scriptsize $10$",position=Relative(0.7),edge_text_pen)),
     (b--e).l(Label("\scriptsize $15$",edge_text_pen)),
     (c--d).l(Label("\scriptsize $2$",edge_text_pen)),
     (c--e).l(Label("\scriptsize $11$",position=Relative(0.3),edge_text_pen)),
     (e--f).l(Label("\scriptsize $6$",edge_text_pen)),
     (f--d).l(Label("\scriptsize $9$",edge_text_pen))
    );

// draw nodes
draw(p, a, b, c, d, e, f);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ======================== shortest path, with path shown =============
int picnum = 8;
picture p;

// define nodes
// node a=ncircle("\strut$a$"),
//      b=ncircle("\strut$b$"),
//      c=ncircle("\strut$c$"),
//      d=ncircle("\strut$d$"),
//      e=ncircle("\strut$e$"),
//      f=ncircle("\strut$f$");

// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 1.5cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// vlayout(v, a, b);
// layout(-22.5, a, c);
// hlayout(2*u, a, d);
// hlayout(2*u, b, e);
// layout(-22.5, d, f);

// draw edges, again
draw(p,
     (a--b).l(Label("\scriptsize $7$",edge_text_pen)), 
     (a--c).l(Label("\scriptsize $9$",edge_text_pen)),
     (a--d).l(Label("\scriptsize $14$",edge_text_pen)).style("leftside"),
     (b--c).l(Label("\scriptsize $10$",position=Relative(0.7),edge_text_pen)),
     (b--e).l(Label("\scriptsize $15$",edge_text_pen)),
     (c--d).l(Label("\scriptsize $2$",edge_text_pen)),
     (c--e).l(Label("\scriptsize $11$",position=Relative(0.3),edge_text_pen)),
     (e--f).l(Label("\scriptsize $6$",edge_text_pen)),
     (f--d).l(Label("\scriptsize $9$",edge_text_pen))
    );

// draw highlighted edges
draw(p,(a.pos--c.pos), walk_pen);
draw(p,(c.pos--d.pos), walk_pen);
draw(p,(f.pos--d.pos), walk_pen);

// draw nodes
draw(p, a, b, c, d, e, f);

shipout(format("graphs%02d",picnum),p,format="pdf");


// http://web.math.princeton.edu/math_alive/5/Notes2.pdf
// ======================== schedule problem =============
int picnum = 9;
picture p;

// define nodes
node a=ncircle("\strut$A$"),
     b=ncircle("\strut$B$"),
     c=ncircle("\strut$C$"),
     d=ncircle("\strut$D$"),
     e=ncircle("\strut$E$"),
     f=ncircle("\strut$F$"),
     g=ncircle("\strut$G$"),
     h=ncircle("\strut$H$"),
     i=ncircle("\strut$I$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.40*u;

hlayout(2*u, a, b);
layout(20.0, a, d);
vlayout(-2*v, a, c);
hlayout(2*u, c, i);
hlayout(1*u, c, f);
// layout(-45.0, c, f);
vlayout(-2*v, c, g);
hlayout(2*u, g, h);
hlayout(1*u, g, e);
// layout(-20.0, g, e);

// draw edges
draw(p,
     (a--b), 
     (a--c), 
     (a--d), 
     (b--i), 
     (c--d), 
     (c--f), 
     (c--g), 
     (c--h), 
     (d--f), 
     (d--i), 
     (e--f), 
     (e--g), 
     (e--i), 
     (f--g), 
     (f--h), 
     (f--i) 
    );

// draw nodes
draw(p, a, b, c, d, e, f, g, h, i);

shipout(format("graphs%02d",picnum),p,format="pdf");


// nodestyle ns1=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(lightred,black));
// nodestyle ns2=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(lightgreen,black));
// nodestyle ns3=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(lightblue,black));
// nodestyle ns4=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(lightyellow,black));
// In HSL, highlight _color is
// Hex: #8A0917
// HSL: 353° 88% 29%
// RGB: 138 9 23
// HSL hsl=HSL(153.0,0.88,0.29);
// pen highlight_light=hsl.rgb();
// pen highlight_light = rgb(250, 183, 191); // from: http://hslpicker.com/#f67987
nodestyle ns1=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(backgroundcolor+white,black));
nodestyle ns2=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(backgroundcolor,black));
nodestyle ns3=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(bold_light,black));
nodestyle ns4=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(lightcolor,black));
// ======================== schedule problem, nodes colored =============
int picnum = 10;
picture p;

// define nodes
node a=ncircle("\strut$A$",ns4),
     b=ncircle("\strut$B$", ns3),
     c=ncircle("\strut$C$",ns3),
     d=ncircle("\strut$D$", ns2),
     e=ncircle("\strut$E$",ns3),
     f=ncircle("\strut$F$", ns4),
     g=ncircle("\strut$G$", ns2),
     h=ncircle("\strut$H$", ns2),
     i=ncircle("\strut$I$",ns1);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.40*u;

hlayout(2*u, a, b);
layout(20.0, a, d);
vlayout(-2*v, a, c);
hlayout(2*u, c, i);
hlayout(1*u, c, f);
// layout(-45.0, c, f);
vlayout(-2*v, c, g);
hlayout(2*u, g, h);
hlayout(1*u, g, e);
// layout(-20.0, g, e);

// draw edges
draw(p,
     (a--b), 
     (a--c), 
     (a--d), 
     (b--i), 
     (c--d), 
     (c--f), 
     (c--g), 
     (c--h), 
     (d--f), 
     (d--i), 
     (e--f), 
     (e--g), 
     (e--i), 
     (f--g), 
     (f--h), 
     (f--i) 
    );

// draw nodes
draw(p, a, b, c, d, e, f, g, h, i);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ======================== isomorphic graphs V =============
int picnum = 11;
picture p;

// define nodes
node v0=ncircle("\strut$v_0$"),
     v1=ncircle("\strut$v_1$"),
     v2=ncircle("\strut$v_2$"),
     v3=ncircle("\strut$v_3$"),
     v4=ncircle("\strut$v_4$"),
     v5=ncircle("\strut$v_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

hlayout(1*u, v0, v1);
hlayout(1*u, v1, v2);
vlayout(-1*v, v0, v3);
hlayout(1*u, v3, v4);
hlayout(1*u, v4, v5);

// draw edges
draw(p,
     (v0--v3), 
     (v0--v4), 
     (v0--v5), 
     (v1--v3), 
     (v1--v4), 
     (v1--v5), 
     (v2--v3), 
     (v2--v4), 
     (v2--v5) 
    );

// draw nodes
draw(p, v0, v1, v2, v3, v4, v5);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== isomorphic graphs W =============
int picnum = 12;
picture p;

// define nodes
node w0=ncircle("\strut$w_0$"),
     w1=ncircle("\strut$w_1$"),
     w2=ncircle("\strut$w_2$"),
     w3=ncircle("\strut$w_3$"),
     w4=ncircle("\strut$w_4$"),
     w5=ncircle("\strut$w_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

real horiz_offset = -0.5*u;
hlayout(1*u, w0, w1);
vlayout(1.5*v, w1, w3);
hlayout(-1*u, w3, w4);
w2.pos = (w1.pos.x-horiz_offset,(w0.pos.y+w4.pos.y)/2);
w5.pos = (w0.pos.x+horiz_offset,w2.pos.y);

// draw edges
draw(p,
     (w0--w1),
     (w0--w3),
     (w1--w2),
     (w1--w4),
     (w2--w3),
     (w2--w5),
     (w3--w4), 
     (w4--w5), 
     (w5--w0)
    );

// draw nodes
draw(p, w0, w1, w2, w3, w4, w5);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ============== Exercise: unreachable nodes ======
int picnum = 13;
picture p;

unitsize(p,1pt);
// setdefaultstatediagramstyles() ;
  defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor,
			     arrow=Arrow(6,filltype=FillDraw(white,backgroundcolor)));

// define nodes
node w0=ncircle("\strut$w_0$"),
     w1=ncircle("\strut$w_1$"),
     w2=ncircle("\strut$w_2$"),
     w3=ncircle("\strut$w_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

real horiz_offset = -0.5*u;
hlayout(1*u, w0, w1, w2);
vlayout(-1*v, w1, w3);

// draw edges
draw(p,
     (w0..bend(20)..w1),
     (w1..bend(20)..w0),
     (w1..bend(20)..w2),
     (w2..bend(20)..w1),
     (w3--w1),
     (w3..loop(E))
     );

// draw nodes
draw(p, w0, w1, w2, w3);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ============== Exercise: unreachable nodes ======
int picnum = 14;
picture p;

unitsize(p,1pt);
// setdefaultstatediagramstyles() ;

// define nodes
node w0=ncircle("\strut$w_0$"),
     w1=ncircle("\strut$w_1$"),
     w2=ncircle("\strut$w_2$"),
     w3=ncircle("\strut$w_3$"),
     w4=ncircle("\strut$w_4$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

real horiz_offset = -0.5*u;
hlayout(w0, w4);
vlayout(1*v, w0, w2);
hlayout(1*u, w2, w1, w3);

// draw edges
draw(p,
     (w0--w1),
     (w1..bend(20)..w3),
     (w1..loop(S)),
     (w2--w4),
     (w2..loop(S)),
     (w3..loop(S)),
     (w4..loop(E))
     );

// draw nodes
draw(p, w0, w1, w2, w3, w4);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ============== Illustration of vertex cover ======
int picnum = 15;
picture p;

unitsize(p,1pt);
setdefaultgraphstyles() ;

// define nodes
node w0=ncircle("$w_0$"),
     w1=ncircle("$w_1$"),
     w2=ncircle("$w_2$"),
     w3=ncircle("$w_3$"),
     w4=ncircle("$w_4$"),
     w5=ncircle("$w_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

hlayout(w0, w1, w2);
vlayout(1*v, w0, w3);
hlayout(1*u, w3, w4, w5);

// draw edges
draw(p,
     (w0--w1),
     (w0--w3),
     (w1--w2),
     (w1--w4),
     (w2--w4),
     (w2--w5),
     (w3--w4),
     (w4--w5)
     );

// draw nodes
draw(p, w0, w1, w2, w3, w4, w5);

shipout(format("graphs%02d",picnum),p,format="pdf");





// ======================== illustration of coloring problem =============
int picnum = 16;
picture p;

// define nodes
node va=ncircle("$A$",ns_bleachedbg),
     vb=ncircle("$B$",ns_light),
     vc=ncircle("$C$",ns_bleachedbg),
     vd=ncircle("$D$",ns_light),
     ve=ncircle("$E$",ns_bleachedbold);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

vb.pos = new_node_pos_h(va, 20.0, 1.0*u);
hlayout(2*u, va, vc);
ve.pos = new_node_pos_h(va, -45.0, 0.60*u);
hlayout(0.9*u, ve, vd);
// vd.pos = new_node_pos_h(vc, -130.0, -0.67*u);

// draw edges
draw(p,
     (va--vd),
     (va--ve),
     (vb--ve),
     (vc--ve)
    );

// draw nodes
draw(p, va, vb, vc, vd, ve);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ======================== illustration of coloring problem =============
int picnum = 16;
picture p;

// define nodes
node va=ncircle("$A$",ns_bleachedbg),
     vb=ncircle("$B$",ns_light),
     vc=ncircle("$C$",ns_bleachedbg),
     vd=ncircle("$D$",ns_light),
     ve=ncircle("$E$",ns_bleachedbold);

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.80*u;

vb.pos = new_node_pos_h(va, 20.0, 1.0*u);
hlayout(2*u, va, vc);
ve.pos = new_node_pos_h(va, -45.0, 0.60*u);
hlayout(0.9*u, ve, vd);
// vd.pos = new_node_pos_h(vc, -130.0, -0.67*u);

// draw edges
draw(p,
     (va--vd),
     (va--ve),
     (vb--ve),
     (vc--ve)
    );

// draw nodes
draw(p, va, vb, vc, vd, ve);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== color cell towers =============
int picnum = 17;
picture p;

// define nodes
node v0=ncircle("$v_0$"),
     v1=ncircle("$v_1$"),
     v2=ncircle("$v_2$"),
     v3=ncircle("$v_3$"),
     v4=ncircle("$v_4$"),
     v5=ncircle("$v_5$"),
     v6=ncircle("$v_6$"),
     v7=ncircle("$v_7$"),
     v8=ncircle("$v_8$"),
     v9=ncircle("$v_9$"),
     v10=ncircle("$v_{10}$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u = defaultlayoutskip;
real v = 0.80*u;

hlayout(1*u, v0, v1, v2);
vlayout(1*v, v0, v3, v7);
hlayout(1*u, v3, v4, v5, v6);
hlayout(1*u, v7, v8, v9, v10);

// draw edges
draw(p,
     (v0--v1),
     (v0--v3),
     (v1--v2),
     (v1--v4),
     (v2--v5),
     (v3--v7),
     (v5--v6),
     (v6--v9),
     (v7--v8),
     (v0--v3),
     (v8--v9),
     (v9--v10)
    );

// draw nodes
draw(p, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ======================== isomorphism exercise =============
int picnum = 18;
picture p;

// define nodes
node va=ncircle("$A$"),
     vb=ncircle("$B$"),
     vc=ncircle("$C$"),
     vx=ncircle("$X$"),
     vy=ncircle("$Y$"),
     vz=ncircle("$Z$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u = defaultlayoutskip;
real v = 0.80*u;

hlayout(1*u, va, vb, vc);
vlayout(1*v, va, vx);
hlayout(1*u, vx, vy, vz);

// draw edges
draw(p,
     (va--vx),
     (va--vy),
     (va--vz),
     (vb--vx),
     (vb--vy),
     (vb--vz),
     (vc--vx),
     (vc--vy),
     (vc--vz)
    );

// draw nodes
draw(p, va, vb, vc, vx, vy, vz);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ======================== isomorphism problem  =============
int picnum = 19;
picture p;

// define nodes
// define nodes
node[] n = ncircles( "$a$",
		     "$x$",
		     "$b$",
		     "$y$",
		     "$c$",
		     "$z$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u = defaultlayoutskip;
real v = 0.80*u;

circularlayout(0.8*u, startangle=90, n);

// draw edges
draw(p,
     (n[0]--n[1]),
     (n[0]--n[3]),
     (n[0]--n[5]),
     (n[2]--n[1]),
     (n[2]--n[3]),
     (n[2]--n[5]),
     (n[4]--n[1]),
     (n[4]--n[3]),
     (n[4]--n[5])
    );

// draw nodes
draw(p, n);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== color US =============
int picnum = 20;
picture p;

// define nodes
// vAl.pos=(32.806671u,-86.791130v);
// vAk.pos=(61.370716u,-152.404419v);
// vAz.pos=(33.729759u,-111.431221v);
// vAr.pos=(34.969704u,-92.373123v);
// vCa.pos=(36.116203u,-119.681564v);
// vCo.pos=(39.059811u,-105.311104v);
// vCt.pos=(41.597782u,-72.755371v);
// vDe.pos=(39.318523u,-75.507141v);
// // District of Columbia	38.897438	-77.026817
// vFl.pos=(27.766279u,-81.686783v);
// vGa.pos=(33.040619u,-83.643074v);
// vHi.pos=(21.094318u,-157.498337v);
// vId.pos=(44.240459u,-114.478828v);
// vIl.pos=(40.349457u,-88.986137v);
// vIn.pos=(39.849426u,-86.258278v);
// vIa.pos=(42.011539u,-93.210526v);
// vKs.pos=(38.526600u,-96.726486v);
// vKy.pos=(37.668140u,-84.670067v);
// vLa.pos=(31.169546u,-91.867805v);
// vMe.pos=(44.693947u,-69.381927v);
// vMd.pos=(39.063946u,-76.802101v);
// vMa.pos=(42.230171u,-71.530106v);
// vMi.pos=(43.326618u,-84.536095v);
// vMn.pos=(45.694454u,-93.900192v);
// vMs.pos=(32.741646u,-89.678696v);
// vMo.pos=(38.456085u,-92.288368v);
// vMt.pos=(46.921925u,-110.454353v);
// vNe.pos=(41.125370u,-98.268082v);
// vNv.pos=(38.313515u,-117.055374v);
// vNh.pos=(43.452492u,-71.563896v);
// vNj.pos=(40.298904u,-74.521011v);
// vNm.pos=(34.840515u,-106.248482v);
// vNy.pos=(42.165726u,-74.948051v);
// vNc.pos=(35.630066u,-79.806419v);
// vNd.pos=(47.528912u,-99.784012v);
// vOh.pos=(40.388783u,-82.764915v);
// vOk.pos=(35.565342u,-96.928917v);
// vOr.pos=(44.572021u,-122.070938v);
// vPa.pos=(40.590752u,-77.209755v);
// vRi.pos=(41.680893u,-71.511780v);
// vSc.pos=(33.856892u,-80.945007v);
// vSd.pos=(44.299782u,-99.438828v);
// vTn.pos=(35.747845u,-86.692345v);
// vTx.pos=(31.054487u,-97.563461v);
// vUt.pos=(40.150032u,-111.862434v);
// uVt.pos=(44.045876u,-72.710686v);
// uVa.pos=(37.769337u,-78.169968v);
// vWa.pos=(47.400902u,-121.490494v);
// vWv.pos=(38.491226u,-80.954453v);
// vWi.pos=(44.268543u,-89.616508v);
// vWy.pos=(42.755966u,-107.302490v);

node v0=ncircle("$v_0$"),
     v1=ncircle("$v_1$"),
     v2=ncircle("$v_2$"),
     v3=ncircle("$v_3$"),
     v4=ncircle("$v_4$"),
     v5=ncircle("$v_5$"),
     v6=ncircle("$v_6$"),
     v7=ncircle("$v_7$"),
     v8=ncircle("$v_8$"),
     v9=ncircle("$v_9$"),
     v10=ncircle("$v_{10}$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u = defaultlayoutskip;
real v = 0.80*u;

hlayout(1*u, v0, v1, v2);
vlayout(1*v, v0, v3, v7);
hlayout(1*u, v3, v4, v5, v6);
hlayout(1*u, v7, v8, v9, v10);

// draw edges
draw(p,
     (v0--v1),
     (v0--v3),
     (v1--v2),
     (v1--v4),
     (v2--v5),
     (v3--v7),
     (v5--v6),
     (v6--v9),
     (v7--v8),
     (v0--v3),
     (v8--v9),
     (v9--v10)
    );

// draw nodes
draw(p, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format("graphs%02d",picnum),p,format="pdf");

