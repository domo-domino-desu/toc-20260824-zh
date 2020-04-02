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
import jhnode;
cd("");
cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
import node;
cd("");

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(white,black));
drawstyle standarddrawstyle = drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor);
defaultdrawstyle = standarddrawstyle;

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
node
vAl=ncircle("\tiny AL"),
// vAk=ncircle("\tiny AK"),
vAz=ncircle("\tiny AZ"),
vAr=ncircle("\tiny AR"),
vCa=ncircle("\tiny CA"),
vCo=ncircle("\tiny CO"),
vCt=ncircle("\tiny CT"),
vDe=ncircle("\tiny DE"),
vFl=ncircle("\tiny FL"),
vGa=ncircle("\tiny GA"),
// vHi=ncircle("\tiny HI"),
vId=ncircle("\tiny ID"),
vIl=ncircle("\tiny IL"),
vIn=ncircle("\tiny IN"),
vIa=ncircle("\tiny IA"),
vKs=ncircle("\tiny KS"),
vKy=ncircle("\tiny KY"),
vLa=ncircle("\tiny LA"),
vMe=ncircle("\tiny ME"),
vMd=ncircle("\tiny MD"),
vMa=ncircle("\tiny MA"),
vMi=ncircle("\tiny MI"),
vMn=ncircle("\tiny MN"),
vMs=ncircle("\tiny MS"),
vMo=ncircle("\tiny MO"),
vMt=ncircle("\tiny MT"),
vNe=ncircle("\tiny NE"),
vNv=ncircle("\tiny NV"),
vNh=ncircle("\tiny NH"),
vNj=ncircle("\tiny NJ"),
vNm=ncircle("\tiny NM"),
vNy=ncircle("\tiny NY"),
vNc=ncircle("\tiny NC"),
vNd=ncircle("\tiny ND"),
vOh=ncircle("\tiny OH"),
vOk=ncircle("\tiny OK"),
vOr=ncircle("\tiny OR"),
vPa=ncircle("\tiny PA"),
vRi=ncircle("\tiny RI"),
vSc=ncircle("\tiny SC"),
vSd=ncircle("\tiny SD"),
vTn=ncircle("\tiny TN"),
vTx=ncircle("\tiny TX"),
vUt=ncircle("\tiny UT"),
vVt=ncircle("\tiny VT"),
vVa=ncircle("\tiny VA"),
vWa=ncircle("\tiny WA"),
vWv=ncircle("\tiny WV"),
vWi=ncircle("\tiny WI"),
vWy=ncircle("\tiny WY");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u=0.5*defaultlayoutskip;
real v=1*u;
       
vAl.pos=( -86.791130u,32.806671v);
vAz.pos=(-111.431221u,33.729759v);
vAr.pos=( -92.373123u,34.969704v);
vCa.pos=(-119.681564u,36.116203v);
vCo.pos=(-105.311104u,39.059811v);
vCt.pos=( -72.755371u,41.597782v);
vDe.pos=( -75.507141u,39.318523v);
vFl.pos=( -81.686783u,27.766279v);
vGa.pos=( -83.643074u,33.040619v);
vId.pos=(-114.478828u,44.240459v);
vIl.pos=( -88.986137u,40.349457v);
vIn.pos=( -86.258278u,39.849426v);
vIa.pos=( -93.210526u,42.011539v);
vKs.pos=( -96.726486u,38.526600v);
vKy.pos=( -84.670067u,37.668140v);
vLa.pos=( -91.867805u,31.169546v);
vMe.pos=( -69.381927u,44.693947v);
vMd.pos=( -76.802101u,39.063946v);
// was: vMa.pos=( -71.530106u,42.230171v);  Moved to show lines
vMa.pos=( -73.530106u,42.530171v);
vMi.pos=( -84.536095u,43.326618v);
vMn.pos=( -93.900192u,45.694454v);
vMs.pos=( -89.678696u,32.741646v);
vMo.pos=( -92.288368u,38.456085v);
vMt.pos=(-110.454353u,46.921925v);
vNe.pos=( -98.268082u,41.125370v);
vNv.pos=(-117.055374u,38.313515v);
vNh.pos=( -71.563896u,43.452492v);
vNj.pos=( -74.521011u,40.298904v);
vNm.pos=(-106.248482u,34.840515v);
vNy.pos=( -74.948051u,42.165726v);
vNc.pos=( -79.806419u,35.630066v);
vNd.pos=( -99.784012u,47.528912v);
vOh.pos=( -82.764915u,40.388783v);
vOk.pos=( -96.928917u,35.565342v);
vOr.pos=(-122.070938u,44.572021v);
vPa.pos=( -77.209755u,40.590752v);
vRi.pos=( -71.511780u,41.680893v);
vSc.pos=( -80.945007u,33.856892v);
vSd.pos=( -99.438828u,44.299782v);
vTn.pos=( -86.692345u,35.747845v);
vTx.pos=( -97.563461u,31.054487v);
vUt.pos=(-111.862434u,40.150032v);
vVt.pos=( -72.710686u,44.045876v);
vVa.pos=( -78.169968u,37.769337v);
vWa.pos=(-121.490494u,47.400902v);
vWv.pos=( -80.954453u,38.491226v);
vWi.pos=( -89.616508u,44.268543v);
vWy.pos=(-107.302490u,42.755966v);
// vAk.pos=(-152.404419u,61.370716v);
// vHi.pos=(-157.498337u,21.094318v);
// District of Columbia	38.897438	-77.026817
	
	
// draw edges
draw(p,
     // New England
     (vMe--vNh),
     (vNh--vVt),
     (vNh--vMa),
     (vVt--vNy),
     (vVt--vMa),
     (vMa--vCt),
     (vMa--vRi),
     (vMa--vNy),
     (vCt--vNy),
     (vCt--vRi),
     // Midwest
     (vNy--vPa),
     (vNy--vNj),
     (vNj--vDe),
     (vPa--vNj),
     (vPa--vMd),
     (vPa--vWv),
     (vPa--vDe),
     (vPa--vOh),
     (vOh--vMi),
     (vOh--vIn),
     (vOh--vKy),
     (vOh--vWv),
     (vWv--vKy),
     (vWv--vVa),
     (vMd--vVa),
     (vMd--vDe),
     (vMd--vWv),
     (vVa--vKy),
     (vVa--vTn),
     (vVa--vNc),
     (vKy--vIn),
     (vKy--vIl),
     (vKy--vMo),
     (vKy--vTn),
     (vMi--vWi),
     (vMi--vIn),
     (vWi--vMn),
     (vWi--vIa),
     (vIl--vWi),
     (vIl--vIa),
     (vIl--vMo),
     (vIl--vIn),
     // South
     (vNc--vTn),
     (vNc--vGa),
     (vNc--vSc),
     (vTn--vMo),
     (vTn--vAr),
     (vTn--vMs),
     (vTn--vAl),
     (vTn--vGa),
     (vSc--vGa),
     (vTx--vAr),
     (vMs--vAr),
     (vMs--vLa),
     (vMs--vAl),
     (vLa--vAr),
     (vAl--vFl),
     (vAl--vGa),
     (vGa--vFl),
     // west of Mississippi river
     (vMn--vNd),
     (vMn--vSd),
     (vMn--vIa),
     (vNd--vMt),
     (vNd--vMn),
     (vNd--vSd),
     (vSd--vMn),
     (vSd--vWy),
     (vSd--vNe),
     (vNe--vWy),
     (vNe--vCo),
     (vNe--vKs),
     (vNe--vMo),
     (vIa--vSd),
     (vIa--vNe),
     (vIa--vMo),
     (vMo--vKs),
     (vMo--vOk),
     (vMo--vAr),
     (vKs--vCo),
     (vKs--vOk),
     (vOk--vCo),
     (vOk--vNm),
     (vOk--vTx),
     (vOk--vAr),
     (vTx--vNm),
     (vTx--vLa),
     (vMt--vId),
     (vMt--vWy),
     (vMt--vSd),
     (vId--vWa),
     (vId--vOr),
     (vId--vNv),
     (vId--vUt),
     (vId--vWy),
     (vWy--vUt),
     (vWy--vCo),
     (vUt--vNv),
     (vUt--vCo),
     (vUt--vAz),
     (vCo--vNm),
     (vAz--vNv),
     (vAz--vCa),
     (vAz--vNm),
     // West coast
     (vWa--vOr),
     (vOr--vCa),
     (vOr--vNv),
     (vCa--vNv)
    );	
	
// draw nodes
draw(p,
     vAl,
     //     vAk,
     vAz,
     vAr,
     vCa,
     vCo,
     vCt,
     vDe,
     vFl,
     vGa,
     //  vHi,
     vId,
     vIl,
     vIn,
     vIa,
     vKs,
     vKy,
     vLa,
     vMe,
     vMd,
     vMa,
     vMi,
     vMn,
     vMs,
     vMo,
     vMt,
     vNe,
     vNv,
     vNh,
     vNj,
     vNm,
     vNy,
     vNc,
     vNd,
     vOh,
     vOk,
     vOr,
     vPa,
     vRi,
     vSc,
     vSd,
     vTn,
     vTx,
     vUt,
     vVt,
     vVa,
     vWa,
     vWv,
     vWi,
     vWy
);

shipout(format("graphs%02d",picnum),p,format="pdf");






// ======================== same degree sequence, nonisomorphic =============
int picnum = 21;
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
real v = 0.85*u;

hlayout(1*u, v0, v1);
layout(22.5, v1, v2);
hlayout(1*u, v2, v3);
layout(-22.5, v1, v4);
hlayout(1*u, v4, v5);

// draw edges
draw(p,
     (v0--v1), 
     (v1--v2), 
     (v2--v3), 
     (v1--v4), 
     (v4--v5)
    );

// draw nodes
draw(p, v0, v1, v2, v3, v4, v5);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ...................
int picnum = 22;
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
real v = 0.85*u;

vlayout(1*v, v0, v1);
layout(-20.0, v0, v2);
layout(20.0, v1, v2);
hlayout(1*u, v2, v3, v4, v5);

// draw edges
draw(p,
     (v0--v2), 
     (v1--v2), 
     (v2--v3), 
     (v3--v4), 
     (v4--v5)
    );

// draw nodes
draw(p, v0, v1, v2, v3, v4, v5);

shipout(format("graphs%02d",picnum),p,format="pdf");




// ================== Homework =======================
string OUTPUT_FN = "graphs1%03d";

// ======= New England states ==========
int picnum = 0;
picture p;

// define nodes
node ME=ncircle("\strut ME"),
     NH=ncircle("\strut NH"),
     VT=ncircle("\strut VT"),
     MA=ncircle("\strut MA"),
     CT=ncircle("\strut CT"),
     RI=ncircle("\strut RI");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, VT, NH, ME);
layout(-40.0, VT, MA);
layout(-120.0, MA, CT);
hlayout(1*u, CT, RI);

// draw edges
draw(p,
     (VT--NH), 
     (VT--MA), 
     (NH--ME), 
     (NH--MA), 
     (MA--ME),
     (MA--CT),
     (MA--RI),
     (CT--RI)
    );

// draw nodes
draw(p, VT, NH, ME, MA, CT, RI);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ======= Divisibility up to 12 ==========
int picnum = 1;
picture p;

// define nodes
node v12=ncircle("\strut $12$"),
     v11=ncircle("\strut $11$"),
     v10=ncircle("\strut $10$"),
     v9=ncircle("\strut $9$"),
     v8=ncircle("\strut $8$"),
     v7=ncircle("\strut $7$"),
     v6=ncircle("\strut $6$"),
     v5=ncircle("\strut $5$"),
     v4=ncircle("\strut $4$"),
     v3=ncircle("\strut $3$"),
     v2=ncircle("\strut $2$"),
     v1=ncircle("\strut $1$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.75*u;

v1.pos = (4*u,0*v);
v2.pos = (3*u,1*v);
hlayout(1*u, v2, v3, v5, v7, v11);
v4.pos = (3*u,2*v);
hlayout(1*u, v4, v6, v9, v10);
v8.pos = (3*u,3*v);
hlayout(1*u,v8,v12);
// layout(-40.0, VT, MA);
// layout(-120.0, MA, CT);
// hlayout(1*u, CT, RI);

// draw edges
draw(p,
     (v2--v1), 
     (v3--v1), 
     (v5--v1), 
     (v7--v1), 
     (v11--v1), 
     (v4--v2), 
     (v6--v2), 
     (v6--v3), 
     (v8--v4), 
     (v9--v3), 
     (v10--v2), 
     (v10--v5), 
     (v12--v6), 
     (v12--v4)
    );

// draw nodes
draw(p, v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======= Rock Paper Scissors ==========
int picnum = 2;
picture p;
defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor,
			     arrow=Arrow(6,filltype=FillDraw(white,backgroundcolor)));

// define nodes
node rock=ncircle("\strut R"),
     paper=ncircle("\strut P"),
     scissors=ncircle("\strut S");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 1.0*u;

hlayout(1.0*u, rock, paper);
scissors.pos = (0.5*u, 0.707*v);

// draw edges
draw(p,
     (rock..bend(-20)..scissors), 
     (scissors..bend(-20)..paper), 
     (paper..bend(-20)..rock)
    );

// draw nodes
draw(p, rock, paper, scissors);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");
defaultdrawstyle = standarddrawstyle;



// ======= Konigsberg bridges ==========
int picnum = 3;
picture p;

// define nodes
node m0=ncircle("\strut $m_0$"),
     m1=ncircle("\strut $m_1$"),
     m2=ncircle("\strut $m_2$"),
     m3=ncircle("\strut $m_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1.0*u, m0, m1);
vlayout(1.0*v, m0, m2);
hlayout(1.0*u, m2, m3);

// draw edges
draw(p,
     (m0..bend(20)..m1), 
     (m0..bend(-20)..m1), 
     (m0--m2), 
     (m1--m2),
     (m1..bend(20)..m3), 
     (m1..bend(-20)..m3), 
     (m2--m3)
    );

// draw nodes
draw(p, m0, m1, m2, m3);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======= Course prerequisites ==========
int picnum = 4;
picture p;
defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor,
			     arrow=Arrow(6,filltype=FillDraw(white,backgroundcolor)));

// define nodes
node calc1=ncircle("\strut I"),
     calc2=ncircle("\strut II"),
     calc3=ncircle("\strut III"),
     linear=ncircle("\strut LA"),
     reals=ncircle("\strut RA");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1*u, calc1, calc2);
layout(-20.0, calc2, linear);
layout(20.0, calc2, calc3);
layout(-20.0, calc3, reals);

// draw edges
draw(p,
     (calc1--calc2), 
     (calc2--calc3), 
     (calc2--linear), 
     (calc3--reals), 
     (linear--reals) 
    );

// draw nodes
draw(p, calc1, calc2, calc3, linear, reals);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");
defaultdrawstyle = standarddrawstyle;



// ======= Graph with random nodes ==========
int picnum = 5;
picture p;

// define nodes
node[] v = ncircles("$v_0$",
		    "$v_1$",
		    "$v_2$",
		    "$v_3$",
		    "$v_4$",
		    "$v_5$");

// layout
circularlayout(1cm, startangle=90, v);

// draw edges
draw(p,
     (v[0]--v[1]), 
     (v[0]--v[3]), 
     (v[0]--v[5]), 
     (v[1]--v[4]), 
     (v[3]--v[4]),
     (v[4]--v[5])
    );

// draw nodes
draw(p, v);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======= Morse code tree ==========
int picnum = 6;
picture p;

// define nodes
node empty = ncircle("$\emptystring$"),
     a = ncircle("A"),
     b = ncircle("B"),
     c = ncircle("C"),
     d = ncircle("D"),
     e = ncircle("E"),
     f = ncircle("F"),
     g = ncircle("G"),
     h = ncircle("H"),
     i = ncircle("I"),
     j = ncircle("J"),
     k = ncircle("K"),
     l = ncircle("L"),
     m = ncircle("M"),
     n = ncircle("N"),
     o = ncircle("O"),
     P = ncircle("P"),
     q = ncircle("Q"),
     r = ncircle("R"),
     s = ncircle("S"),
     t = ncircle("T"),
     U = ncircle("U"),
     V = ncircle("V"),
     w = ncircle("W"),
     x = ncircle("X"),
     y = ncircle("Y"),
     z = ncircle("Z");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.65*u;

real total_width = 9.0*u;
real nhd(real rank) { return 2^(rank+1); } // number of horizontal divisions
real rank;    // depth in the tree; used for horizontal layout
rank = 0;
empty.pos = (1*(total_width/nhd(rank)), rank*-1*v);
rank = 1;
e.pos = (1*(total_width/nhd(rank)), rank*-1*v);
t.pos = (3*(total_width/nhd(rank)), rank*-1*v);
rank = 2;
i.pos = (1*(total_width/nhd(rank)), rank*-1*v);
a.pos = (3*(total_width/nhd(rank)), rank*-1*v);
n.pos = (5*(total_width/nhd(rank)), rank*-1*v);
m.pos = (7*(total_width/nhd(rank)), rank*-1*v);
rank = 3;
s.pos = (1*(total_width/nhd(rank)), rank*-1*v);
U.pos = (3*(total_width/nhd(rank)), rank*-1*v);
r.pos = (5*(total_width/nhd(rank)), rank*-1*v);
w.pos = (7*(total_width/nhd(rank)), rank*-1*v);
d.pos = (9*(total_width/nhd(rank)), rank*-1*v);
k.pos = (11*(total_width/nhd(rank)), rank*-1*v);
g.pos = (13*(total_width/nhd(rank)), rank*-1*v);
o.pos = (15*(total_width/nhd(rank)), rank*-1*v);
rank = 4;
h.pos = (1*(total_width/nhd(rank)), rank*-1*v);
V.pos = (3*(total_width/nhd(rank)), rank*-1*v);
f.pos = (5*(total_width/nhd(rank)), rank*-1*v);
// u UMLAUT .pos = (7*(total_width/nhd(rank)), rank*-1*v);
l.pos = (9*(total_width/nhd(rank)), rank*-1*v);
// A UMLAUT.pos = (11*(total_width/nhd(rank)), rank*-1*v);
P.pos = (13*(total_width/nhd(rank)), rank*-1*v);
j.pos = (15*(total_width/nhd(rank)), rank*-1*v);
b.pos = (17*(total_width/nhd(rank)), rank*-1*v);
x.pos = (19*(total_width/nhd(rank)), rank*-1*v);
c.pos = (21*(total_width/nhd(rank)), rank*-1*v);
y.pos = (23*(total_width/nhd(rank)), rank*-1*v);
z.pos = (25*(total_width/nhd(rank)), rank*-1*v);
q.pos = (27*(total_width/nhd(rank)), rank*-1*v);
// O UMLAUT .pos = (29*(total_width/nhd(rank)), rank*-1*v);
// CH .pos = (31*(total_width/nhd(rank)), rank*-1*v);
// hlayout(1*u, calc1, calc2);
// layout(-20.0, calc2, linear);
// layout(20.0, calc2, calc3);
// layout(-20.0, calc3, reals);

// draw edges
draw(p,
     (empty--e).l("{\color{black} \dit}"), 
     (empty--t).l("{\color{black} \dah}").style("leftside"),
     // rank 2
     (e--i).l("{\color{black} \dit}"), 
     (e--a).l("{\color{black} \dah}").style("leftside"), 
     (t--n).l("{\color{black} \dit}"), 
     (t--m).l("{\color{black} \dah}").style("leftside"),
     // rank 3
     (i--s).l("{\color{black} \dit}"),
     (i--U).l("{\color{black} \dah}").style("leftside"),
     (a--r).l("{\color{black} \dit}"),
     (a--w).l("{\color{black} \dah}").style("leftside"),
     (n--d).l("{\color{black} \dit}"),
     (n--k).l("{\color{black} \dah}").style("leftside"),
     (m--g).l("{\color{black} \dit}"),
     (m--o).l("{\color{black} \dah}").style("leftside"),
     // rank 4
     (s--h).l("{\color{black} \dit}"),
     (s--V).l("{\color{black} \dah}").style("leftside"),
     (U--f).l("{\color{black} \dit}"),
     // (U--),
     (r--l).l("{\color{black} \dit}"),
     // (R--),
     (w--P).l("{\color{black} \dit}"),
     (w--j).l("{\color{black} \dah}").style("leftside"),
     (d--b).l("{\color{black} \dit}"),
     (d--x).l("{\color{black} \dah}").style("leftside"),
     (k--c).l("{\color{black} \dit}"),
     (k--y).l("{\color{black} \dah}").style("leftside"),
     (g--z).l("{\color{black} \dit}"),
     (g--q).l("{\color{black} \dah}").style("leftside")
     // (O--),
     // (O--)
    );

// draw nodes
draw(p, empty, e,t, i,a,n,m, s,U,r,w,d,k,g,o, h,V,f,l,P,j,b,x,c,y,z,q);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======================== color cell towers =============
int picnum = 7;
picture p;

// define nodes
node v0=ncircle("$v_0$",ns_bleachedbg),
     v1=ncircle("$v_1$",ns_light),
     v2=ncircle("$v_2$",ns_bleachedbg),
     v3=ncircle("$v_3$",ns_light),
     v4=ncircle("$v_4$",ns_bleachedbg),
     v5=ncircle("$v_5$",ns_light),
     v6=ncircle("$v_6$",ns_bleachedbg),
     v7=ncircle("$v_7$",ns_bleachedbg),
     v8=ncircle("$v_8$",ns_light),
     v9=ncircle("$v_9$",ns_bleachedbold),
     v10=ncircle("$v_{10}$",ns_light);

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

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======================== blood types =============
int picnum = 8;
picture p;
// make it a directed graph; see also line after shipout(..)
defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor,
			     arrow=Arrow(6,filltype=FillDraw(white,backgroundcolor)));

// define nodes
node ominus=ncircle("$\text{O}^-$"),
     oplus=ncircle("$\text{O}^+$"),
     aminus=ncircle("$\text{A}^-$"),
     aplus=ncircle("$\text{A}^+$"),
     bminus=ncircle("$\text{B}^-$"),
     bplus=ncircle("$\text{B}^+$"),
     abminus=ncircle("$\text{AB}^-$"),
     abplus=ncircle("$\text{AB}^+$");

// layout
// see bloodtype.dot
defaultlayoutrel = false;
defaultlayoutskip = 1cm;
real u = 3*defaultlayoutskip;
real v = 0.65*u;

// aminus.pos = new_node_pos(ominus, -80.0, -1*v);
vlayout(1*v, ominus, aminus);
vlayout(2*v, aminus, abplus);
hlayout(-0.90*u, aminus, oplus);
hlayout(0.90*u, aminus, bminus);
// layout(-60.0, oplus, aplus);
aplus.pos = new_node_pos(oplus, -70.0, -1*v);
hlayout(1*u, aplus, bplus, abminus);

// draw edges
draw(p,
     (ominus..loop(N)),
     (oplus..loop(E)),
     (aminus..loop(W)),
     (bminus..loop(E)),
     (aplus..loop(W)),
     (bplus..loop(E)),
     (abminus..loop(E)),
     (abplus..loop(S)),
     (ominus..bend(20)..oplus),
     (ominus--aminus),
     (ominus--aplus),
     (ominus--bminus),
     (ominus--bplus),
     (ominus--abminus),
     (ominus..bend(90)..abplus),
     (oplus--aplus),
     (oplus--bplus),
     (oplus--abplus),
     (aminus--aplus),
     (aminus--abminus),
     (aminus--abplus),
     (aplus--abplus),
     (bminus..bend(20)..bplus),
     (bminus--abminus),
     (bminus..bend(-20)..abplus),
     (bplus--abplus),
     (abminus--abplus)
    );

// draw nodes
draw(p, ominus, oplus, aminus, aplus, bminus, bplus, abminus, abplus);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");
defaultdrawstyle = standarddrawstyle;


