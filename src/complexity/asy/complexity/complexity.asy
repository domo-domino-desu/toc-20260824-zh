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


string OUTPUT_FN = "complexity%02d";


nodestyle ns_bleachedbg=nodestyle(xmargin=1pt,textpen=NODEPEN,
				  drawfn=FillDrawer(backgroundcolor+white,black));
nodestyle ns_bg=nodestyle(xmargin=1pt,textpen=NODEPEN,
			  drawfn=FillDrawer(backgroundcolor,black));
nodestyle ns_bleachedbold=nodestyle(xmargin=1pt,textpen=NODEPEN,
				    drawfn=FillDrawer(bold_light,black));
nodestyle ns_light=nodestyle(xmargin=1pt,textpen=NODEPEN,
			     drawfn=FillDrawer(lightcolor,black));

// 
defaultlayoutrel = false;


// ======================== petersen graph =============
int picnum = 0;
picture pic;
setdefaultgraphstyles();

node[] outer=ncircles("\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}");
node[] inner=ncircles("\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}");

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(1.35*u, startangle=90, outer);
circularlayout(0.7*u, startangle=90, inner);

// draw edges
draw(pic,
     (outer[0]--outer[1]),
     (outer[1]--outer[2]),
     (outer[2]--outer[3]),
     (outer[3]--outer[4]),
     (outer[4]--outer[0]),
     (outer[0]--inner[0]),
     (outer[1]--inner[1]),
     (outer[2]--inner[2]),
     (outer[3]--inner[3]),
     (outer[4]--inner[4]),
     (inner[0]--inner[2]),
     (inner[0]--inner[3]),
     (inner[1]--inner[3]),
     (inner[1]--inner[4]),
     (inner[2]--inner[4])
);

// draw nodes
draw(pic,outer[0],outer[1],outer[2],outer[3],outer[4],
     inner[0],inner[1],inner[2],inner[3],inner[4]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======================== petersen graph, three colored =============

int picnum = 1;
picture pic;
setdefaultgraphstyles();

node outer0=ncircle("\nodebox{}",ns_bleachedbg),
  outer1=ncircle("\nodebox{}",ns_bleachedbold),
  outer2=ncircle("\nodebox{}",ns_light),
  outer3=ncircle("\nodebox{}",ns_bleachedbg),
  outer4=ncircle("\nodebox{}",ns_light);
node inner0=ncircle("\nodebox{}",ns_light),
  inner1=ncircle("\nodebox{}",ns_bleachedbg),
  inner2=ncircle("\nodebox{}",ns_bleachedbg),
  inner3=ncircle("\nodebox{}",ns_bleachedbold),
  inner4=ncircle("\nodebox{}",ns_bleachedbold);
node[] outer={outer0, outer1, outer2, outer3, outer4};
node[] inner={inner0, inner1, inner2, inner3, inner4};

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(1.25*u, startangle=90, outer);
circularlayout(0.6*u, startangle=90, inner);

// draw edges
draw(pic,
     (outer[0]--outer[1]),
     (outer[1]--outer[2]),
     (outer[2]--outer[3]),
     (outer[3]--outer[4]),
     (outer[4]--outer[0]),
     (outer[0]--inner[0]),
     (outer[1]--inner[1]),
     (outer[2]--inner[2]),
     (outer[3]--inner[3]),
     (outer[4]--inner[4]),
     (inner[0]--inner[2]),
     (inner[0]--inner[3]),
     (inner[1]--inner[3]),
     (inner[1]--inner[4]),
     (inner[2]--inner[4])
);

// draw nodes
draw(pic,outer[0],outer[1],outer[2],outer[3],outer[4],
     inner[0],inner[1],inner[2],inner[3],inner[4]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======================== K_4 =============

int picnum = 2;
picture pic;
setdefaultgraphstyles();

node n0=ncircle("\nodebox{}"),
  n1=ncircle("\nodebox{}"),
  n2=ncircle("\nodebox{}"),
  n3=ncircle("\nodebox{}");
node[] n={n0, n1, n2, n3};

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(0.8*u, startangle=90, n);

// draw edges
draw(pic,
     (n[0]--n[1]),
     (n[0]--n[2]),
     (n[0]--n[3]),
     (n[1]--n[2]),
     (n[1]--n[3]),
     (n[2]--n[3])
);

// draw nodes
draw(pic,
     n[0], n[1], n[2], n[3]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======================== clique =============

int picnum = 3;
picture pic;
setdefaultgraphstyles();

node v00=ncircle("\nodebox{$v_{0,0}$}", ns_bleachedbg),
  v01=ncircle("\nodebox{$v_{0,1}$}", ns_bleachedbg),
  v10=ncircle("\nodebox{$v_{1,0}$}", ns_bleachedbold),
  v11=ncircle("\nodebox{$v_{1,1}$}", ns_bleachedbold),
  v20=ncircle("\nodebox{$v_{2,0}$}", ns_light),
  v21=ncircle("\nodebox{$v_{2,1}$}", ns_light);

// calculate nodes position
real u=1.5cm;
real v=0.7*u;
hlayout(0.7*u, v00, v01);
v10.pos = new_node_pos(v00,  -135, -1*v);
v11.pos = new_node_pos(v10,  -45, -0.7*v);
v20.pos = new_node_pos(v01,  -45, -1*v);
v21.pos = new_node_pos(v20,  -135, -0.7*v);

// draw edges
draw(pic,
     (v00--v20),
     (v00--v11),
     (v00--v21),
     (v01--v10),
     (v01--v20),
     (v10--v20),
     (v10--v21),
     (v11--v20)
);

// draw nodes
draw(pic,
     v00, v01, v10, v11, v20, v21);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======================== vertex cover =============

int picnum = 4;
picture pic;
setdefaultgraphstyles();

node v0t=ncircle("\nodebox{\strut$v_{0,T}$}", ns_bleachedbg),
  v0f=ncircle("\nodebox{\strut$v_{0,F}$}"),
  v1t=ncircle("\nodebox{$v_{1,T}$}", ns_bleachedbg),
  v1f=ncircle("\nodebox{$v_{1,F}$}"),
  v2t=ncircle("\nodebox{$v_{2,T}$}", ns_bleachedbg),
  v2f=ncircle("\nodebox{$v_{2,F}$}"),
  v3t=ncircle("\nodebox{$v_{3,T}$}", ns_bleachedbg),
  v3f=ncircle("\nodebox{$v_{3,F}$}"),
  w00=ncircle("\nodebox{$w_{0,0}$}"),
  w01=ncircle("\nodebox{$w_{0,1}$}", ns_bleachedbg),
  w02=ncircle("\nodebox{$w_{0,2}$}", ns_bleachedbg),
  w10=ncircle("\nodebox{$w_{1,0}$}", ns_bleachedbg),
  w12=ncircle("\nodebox{$w_{1,2}$}"),
  w13=ncircle("\nodebox{$w_{1,3}$}", ns_bleachedbg),
  w21=ncircle("\nodebox{$w_{2,1}$}", ns_bleachedbg),
  w23=ncircle("\nodebox{$w_{2,3}$}");

// calculate nodes position
real u=1.35cm;
real v=0.7*u;
hlayout(1.0*u, v0t, v0f);
hlayout(1.35*u, v0f, v1t);
hlayout(1.0*u, v1t, v1f);
hlayout(1.35*u, v1f, v2t);
hlayout(1.0*u, v2t, v2f);
hlayout(1.35*u, v2f, v3t);
hlayout(1.0*u, v3t, v3f);

vlayout(1.5*v, v0t, w00);
hlayout(1.0*u, w00, w01);
// w02.pos = new_node_pos_h(w00, -45, 0.5*(w00.pos.x+w01.pos.x)-w00.pos.x);
w02.pos = new_node_pos_h(w00, -50, 0.5*u);

hlayout(2.5*u, w01, w10);
hlayout(1.0*u, w10, w12);
w13.pos = new_node_pos_h(w10, -50, 0.5*u);

hlayout(2.0*u, w12, w21);
hlayout(1.0*u, w21, w23);


// draw edges
draw(pic,
     (v0t--v0f),
     (v1t--v1f),
     (v2t--v2f),
     (v3t--v3f),
     (w00--w01),
     (w00--w02),
     (w01--w02),
     (w10--w12),
     (w10--w13),
     (w12--w13),
     (w21--w23),
     (v0t--w00),
     (v0f--w10),
     (v1t--w01),
     (v1f--w21),
     (v2f--w02),
     (v2t--w12),
     (v3f--w13),
     (v3f--w23)
);

// draw nodes, after edges
draw(pic,
     v0t, v0f, v1t, v1f, v2t, v2f, v3t, v3f,
     w00, w01, w02, w10, w12, w13, w21, w23);

// dot(pic,w00.pos,red);
// dot(pic,w00.pos+(1*u,0),red);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======================== crossword puzzle =============

int picnum = 5;
picture pic;

// height of boxes
real u=12pt;
real v=u;

int grid_entries = 3;  // number of grid entries
for(int i=0; i <= grid_entries; ++i) {
  draw(pic,
       (i*v,0)--(i*v,grid_entries*u), MAINPEN+boldcolor);
}
for(int j=0; j <= grid_entries; ++j) {
  draw(pic,
       (0,j*u)--(grid_entries*v,j*u), MAINPEN+boldcolor);
}

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 6;
picture pic;

// height of boxes
real u=12pt;
real v=u;

label(pic, "\str{C}", (0.5*u,2.5*v), fontsize(9pt));
label(pic, "\str{A}", (1.5*u,2.5*v), fontsize(9pt));
label(pic, "\str{B}", (2.5*u,2.5*v), fontsize(9pt));
label(pic, "\str{A}", (0.5*u,1.5*v), fontsize(9pt));
label(pic, "\str{G}", (1.5*u,1.5*v), fontsize(9pt));
label(pic, "\str{E}", (2.5*u,1.5*v), fontsize(9pt));
label(pic, "\str{D}", (0.5*u,0.5*v), fontsize(9pt));
label(pic, "\str{O}", (1.5*u,0.5*v), fontsize(9pt));
label(pic, "\str{G}", (2.5*u,0.5*v), fontsize(9pt));

int grid_entries = 3;  // number of grid entries
for(int i=0; i <= grid_entries; ++i) {
  draw(pic,
       (i*v,0)--(i*v,grid_entries*u), MAINPEN+boldcolor);
}
for(int j=0; j <= grid_entries; ++j) {
  draw(pic,
       (0,j*u)--(grid_entries*v,j*u), MAINPEN+boldcolor);
}

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======================== broadcast =============

int picnum = 7;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}", ns_bleachedbg),
  v1=ncircle("\nodebox{\strut$v_1$}"),
  v2=ncircle("\nodebox{\strut$v_2$}"),
  v3=ncircle("\nodebox{\strut$v_3$}"),
  v4=ncircle("\nodebox{\strut$v_4$}"),
  v5=ncircle("\nodebox{\strut$v_5$}"),
  v6=ncircle("\nodebox{\strut$v_6$}"),
  v7=ncircle("\nodebox{\strut$v_7$}"),
  v8=ncircle("\nodebox{\strut$v_8$}"),
  v9=ncircle("\nodebox{\strut$v_9$}"),
  v10=ncircle("\nodebox{\strut$v_{10}$}");

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(135.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
layout(-135.0, v0, v2);
hlayout(-1.0*u, v2, v3);
layout(45.0, v0, v4);
layout(-45.0, v0, v5);
layout(-60.0, v5, v6);
v7.pos = new_node_pos_h(v4, 30, 1*u);
v8.pos = new_node_pos_h(v4, -30, 1*u);
hlayout(1.0*u, v5, v9);
hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v0--v4),
     (v0--v5),
     (v1--v2),
     (v2--v3),
     (v2--v5),
     (v4--v7),
     (v4--v8),
     (v5--v6),
     (v5--v9),
     (v8--v9),
     (v8--v10)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 8;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v5=ncircle("\nodebox{\strut$v_5$}", ns_bleachedbg);

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(135.0, v0, v1); 
layout(-135.0, v0, v2);
hlayout(-1.0*u, v2, v3);
layout(45.0, v0, v4);
layout(-45.0, v0, v5);
layout(-60.0, v5, v6);
v7.pos = new_node_pos_h(v4, 30, 1*u);
v8.pos = new_node_pos_h(v4, -30, 1*u);
hlayout(1.0*u, v5, v9);
hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v0--v4),
     (v0--v5),
     (v1--v2),
     (v2--v3),
     (v2--v5),
     (v4--v7),
     (v4--v8),
     (v5--v6),
     (v5--v9),
     (v8--v9),
     (v8--v10)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 9;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v4=ncircle("\nodebox{\strut$v_4$}", ns_bleachedbg);
node v9=ncircle("\nodebox{\strut$v_9$}", ns_bleachedbg);

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(135.0, v0, v1); 
layout(-135.0, v0, v2);
hlayout(-1.0*u, v2, v3);
layout(45.0, v0, v4);
layout(-45.0, v0, v5);
layout(-60.0, v5, v6);
v7.pos = new_node_pos_h(v4, 30, 1*u);
v8.pos = new_node_pos_h(v4, -30, 1*u);
hlayout(1.0*u, v5, v9);
hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v0--v4),
     (v0--v5),
     (v1--v2),
     (v2--v3),
     (v2--v5),
     (v4--v7),
     (v4--v8),
     (v5--v6),
     (v5--v9),
     (v8--v9),
     (v8--v10)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 10;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v1=ncircle("\nodebox{\strut$v_1$}", ns_bleachedbg);
node v2=ncircle("\nodebox{\strut$v_2$}", ns_bleachedbg);
node v5=ncircle("\nodebox{\strut$v_5$}", ns_bleachedbg);
node v8=ncircle("\nodebox{\strut$v_8$}", ns_bleachedbg);

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(135.0, v0, v1); 
layout(-135.0, v0, v2);
hlayout(-1.0*u, v2, v3);
layout(45.0, v0, v4);
layout(-45.0, v0, v5);
layout(-60.0, v5, v6);
v7.pos = new_node_pos_h(v4, 30, 1*u);
v8.pos = new_node_pos_h(v4, -30, 1*u);
hlayout(1.0*u, v5, v9);
hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v0--v4),
     (v0--v5),
     (v1--v2),
     (v2--v3),
     (v2--v5),
     (v4--v7),
     (v4--v8),
     (v5--v6),
     (v5--v9),
     (v8--v9),
     (v8--v10)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 11;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v3=ncircle("\nodebox{\strut$v_3$}", ns_bleachedbg);
node v6=ncircle("\nodebox{\strut$v_6$}", ns_bleachedbg);
node v7=ncircle("\nodebox{\strut$v_7$}", ns_bleachedbg);
node v10=ncircle("\nodebox{\strut$v_{10}$}", ns_bleachedbg);

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(135.0, v0, v1); 
layout(-135.0, v0, v2);
hlayout(-1.0*u, v2, v3);
layout(45.0, v0, v4);
layout(-45.0, v0, v5);
layout(-60.0, v5, v6);
v7.pos = new_node_pos_h(v4, 30, 1*u);
v8.pos = new_node_pos_h(v4, -30, 1*u);
hlayout(1.0*u, v5, v9);
hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v0--v4),
     (v0--v5),
     (v1--v2),
     (v2--v3),
     (v2--v5),
     (v4--v7),
     (v4--v8),
     (v5--v6),
     (v5--v9),
     (v8--v9),
     (v8--v10)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======================== K_5 =============
int picnum = 12;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}");

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(1.0*u, startangle=90, nodes);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[4]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[3]),
     (nodes[1]--nodes[4]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[3]--nodes[4])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



