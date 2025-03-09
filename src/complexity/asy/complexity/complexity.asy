// complexity.asy
//  For chapter on complexity

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

node v00=ncircle("$v_{0,0}$"),
  v01=ncircle("$v_{0,1}$"),
  v10=ncircle("$v_{1,0}$"),
  v11=ncircle("$v_{1,1}$"),
  v20=ncircle("$v_{2,0}$"),
  v21=ncircle("$v_{2,1}$");
// node v00=ncircle("\nodebox{$v_{0,0}$}", ns_bleachedbg),
//   v01=ncircle("\nodebox{$v_{0,1}$}", ns_bleachedbg),
//   v10=ncircle("\nodebox{$v_{1,0}$}", ns_bleachedbold),
//   v11=ncircle("\nodebox{$v_{1,1}$}", ns_bleachedbold),
//   v20=ncircle("\nodebox{$v_{2,0}$}", ns_light),
//   v21=ncircle("\nodebox{$v_{2,1}$}", ns_light);

// calculate nodes position
real u=1.5cm;
real v=0.7*u;
hlayout(0.7*u, v00, v01);
v10.pos = new_node_pos(v00,  -135, -0.7*v);
v11.pos = new_node_pos(v10,  -55, -0.7*v);
v20.pos = new_node_pos(v01,  -45, -0.7*v);
v21.pos = new_node_pos(v20,  -120, -0.7*v);

// draw edges
draw(pic,
     (v00--v20),
     (v00--v11),
     (v00--v21),
     (v01--v10),
     (v01--v20),
     // (v10--v20),
     (v10--v21),
     (v11--v20),
     (v11--v21)
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





// ============ Graph look for max clique =============
int picnum = 13;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{$v_0$}",
  "\nodebox{$v_1$}",
  "\nodebox{$v_2$}",
  "\nodebox{$v_3$}",
  "\nodebox{$v_4$}",
  "\nodebox{$v_5$}");

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(1.0*u, startangle=-360/6, nodes);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[4]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[2]--nodes[5]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[4]--nodes[5])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




int picnum = 14;
picture pic;
// setdefaultgraphstyles();
// defaultlayoutrel = false;

// node[] nodes=ncircles("\nodebox{$v_0$}",
//   "\nodebox{$v_1$}",
//   "\nodebox{$v_2$}",
//   "\nodebox{$v_3$}",
//   "\nodebox{$v_4$}",
//   "\nodebox{$v_5$}");

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(1.0*u, startangle=-360/6, nodes);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[4]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4])
);
draw(pic, nodes[2]--nodes[3], WALK_PEN);
draw(pic, nodes[2]--nodes[4], WALK_PEN);
draw(pic, nodes[2]--nodes[5], WALK_PEN);
draw(pic, nodes[3]--nodes[4], WALK_PEN);
draw(pic, nodes[3]--nodes[5], WALK_PEN);
draw(pic, nodes[4]--nodes[5], WALK_PEN);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ========== 4-clique exercise ==========
int picnum = 15;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{$v_0$}",
		      "\nodebox{$v_1$}",
		      "\nodebox{$v_2$}",
		      "\nodebox{$v_3$}",
		      "\nodebox{$v_4$}",
		      "\nodebox{$v_5$}",
		      "\nodebox{$v_6$}",
		      "\nodebox{$v_7$}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

hlayout(3*u, nodes[0], nodes[1]);
vlayout(3*v, nodes[0], nodes[5]);
hlayout(3*u, nodes[5], nodes[6]);
nodes[2].pos = new_node_pos_h(nodes[0], -15.0, 1.5*u);
nodes[3].pos = new_node_pos_h(nodes[2], -120.0, -0.5*u);
hlayout(1*u, nodes[3], nodes[4]);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[6]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[3]--nodes[6]),
     (nodes[4]--nodes[5]),
     (nodes[4]--nodes[6]),
     (nodes[5]--nodes[6])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5], nodes[6]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 16;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

// node[] nodes=ncircles("\nodebox{$v_0$}",
// 		      "\nodebox{$v_1$}",
// 		      "\nodebox{$v_2$}",
// 		      "\nodebox{$v_3$}",
// 		      "\nodebox{$v_4$}",
// 		      "\nodebox{$v_5$}",
// 		      "\nodebox{$v_6$}",
// 		      "\nodebox{$v_7$}"
// 		      );

// calculate nodes position
// real u=1cm;
// real v=0.7*u;

// hlayout(3*u, nodes[0], nodes[1]);
// vlayout(3*v, nodes[0], nodes[5]);
// hlayout(3*u, nodes[5], nodes[6]);
// nodes[2].pos = new_node_pos_h(nodes[0], -20.0, 1.5*u);
// nodes[3].pos = new_node_pos_h(nodes[2], -120.0, -0.5*u);
// hlayout(1*u, nodes[3], nodes[4]);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[6]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4])
);
draw(pic,nodes[3]--nodes[4],WALK_PEN);
draw(pic,nodes[3]--nodes[5],WALK_PEN);
draw(pic,nodes[3]--nodes[6],WALK_PEN);
draw(pic,nodes[4]--nodes[5],WALK_PEN);
draw(pic,nodes[4]--nodes[6],WALK_PEN);
draw(pic,nodes[5]--nodes[6],WALK_PEN);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5], nodes[6]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ========== Clique exercise ==========
int picnum = 17;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{$v_0$}",
		      "\nodebox{$v_1$}",
		      "\nodebox{$v_2$}",
		      "\nodebox{$v_3$}",
		      "\nodebox{$v_4$}",
		      "\nodebox{$v_5$}",
		      "\nodebox{$v_6$}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

hlayout(2*u, nodes[6], nodes[5]);
vlayout(2*v, nodes[6], nodes[0]);
nodes[1].pos = new_node_pos_h(nodes[6], -35.0, 1*u);
hlayout(2*u, nodes[0], nodes[2]);
nodes[4].pos = new_node_pos_h(nodes[5], -35.0, 1*u);
hlayout(1*u, nodes[4], nodes[3]);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[6]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[6]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[2]--nodes[5]),
     (nodes[2]--nodes[4]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[4]--nodes[5])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5], nodes[6]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ========= icosohedron ===========
// Could not get this to go:
// http://www.piprime.fr/files/asymptote/modules/polyhedron_js/index.html
//Author Jens Schwaiger.
int picnum = 18;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] outer=ncircles("\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}"
		      );
node[] middle_points=ncircles("\nodebox{}",
			      "\nodebox{}",
			      "\nodebox{}",
			      "\nodebox{}",
			      "\nodebox{}"
			      );
node[] middle_midpoints=ncircles("\nodebox{}",
				 "\nodebox{}",
				 "\nodebox{}",
				 "\nodebox{}",
				 "\nodebox{}"
				 );
node[] inner=ncircles("\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}",
		      "\nodebox{}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

circularlayout(1.5*u, startangle=90, outer);
circularlayout(1.0*u, startangle=90, middle_points);
circularlayout(0.4*u, startangle=-90, inner);
middle_midpoints[0].pos=0.5*(middle_points[0].pos+middle_points[1].pos);
middle_midpoints[1].pos=0.5*(middle_points[1].pos+middle_points[2].pos);
middle_midpoints[2].pos=0.5*(middle_points[2].pos+middle_points[3].pos);
middle_midpoints[3].pos=0.5*(middle_points[3].pos+middle_points[4].pos);
middle_midpoints[4].pos=0.5*(middle_points[4].pos+middle_points[0].pos);

// draw edges
draw(pic,
     (outer[0]--outer[1]),
     (outer[1]--outer[2]),
     (outer[2]--outer[3]),
     (outer[3]--outer[4]),
     (outer[4]--outer[0]),
     (middle_points[0]--middle_points[1]),
     (middle_points[1]--middle_points[2]),
     (middle_points[2]--middle_points[3]),
     (middle_points[3]--middle_points[4]),
     (middle_points[4]--middle_points[0]),
     (inner[0]--inner[1]),
     (inner[1]--inner[2]),
     (inner[2]--inner[3]),
     (inner[3]--inner[4]),
     (inner[4]--inner[0]),
     (middle_points[0]--outer[0]),
     (middle_points[1]--outer[1]),
     (middle_points[2]--outer[2]),
     (middle_points[3]--outer[3]),
     (middle_points[4]--outer[4]),
     (inner[0]--middle_midpoints[2]),
     (inner[1]--middle_midpoints[3]),
     (inner[2]--middle_midpoints[4]),
     (inner[3]--middle_midpoints[0]),
     (inner[4]--middle_midpoints[1])
);

// draw nodes
draw(pic,
     outer[0], outer[1], outer[2], outer[3], outer[4],
     middle_points[0], middle_points[1], middle_points[2], middle_points[3], middle_points[4],
     middle_midpoints[0], middle_midpoints[1], middle_midpoints[2], middle_midpoints[3], middle_midpoints[4],
     inner[0], inner[1], inner[2], inner[3], inner[4]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



int picnum = 19;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

// draw edges
draw(pic,
     (outer[2]--outer[3]),
     (middle_points[2]--middle_midpoints[2]),
     (middle_points[3]--middle_midpoints[3]),
     (inner[0]--inner[1]),
     (middle_points[0]--outer[0]),
     (middle_points[1]--outer[1]),
     (middle_points[4]--outer[4]),
     (inner[2]--middle_midpoints[4]),
     (inner[3]--middle_midpoints[0]),
     (inner[4]--middle_midpoints[1])
);

draw(pic,outer[0]--outer[1],WALK_PEN);
draw(pic,outer[1]--outer[2],WALK_PEN);
draw(pic,outer[2]--middle_points[2],WALK_PEN);
draw(pic,middle_points[2]--middle_points[1],WALK_PEN);
draw(pic,middle_points[1]--middle_points[0],WALK_PEN);
draw(pic,middle_points[0]--middle_points[4],WALK_PEN);
draw(pic,middle_points[4]--middle_midpoints[3],WALK_PEN);
draw(pic,middle_midpoints[3]--inner[1],WALK_PEN);
draw(pic,inner[1]--inner[2],WALK_PEN);
draw(pic,inner[2]--inner[3],WALK_PEN);
draw(pic,inner[3]--inner[4],WALK_PEN);
draw(pic,inner[4]--inner[0],WALK_PEN);
draw(pic,inner[0]--middle_midpoints[2],WALK_PEN);
draw(pic,middle_midpoints[2]--middle_points[3],WALK_PEN);
draw(pic,middle_points[3]--outer[3],WALK_PEN);
draw(pic,outer[3]--outer[4],WALK_PEN);
draw(pic,outer[4]--outer[0],WALK_PEN);

// draw nodes
draw(pic,
     outer[0], outer[1], outer[2], outer[3], outer[4],
     middle_points[0], middle_points[1], middle_points[2], middle_points[3], middle_points[4],
     middle_midpoints[0], middle_midpoints[1], middle_midpoints[2], middle_midpoints[3], middle_midpoints[4],
     inner[0], inner[1], inner[2], inner[3], inner[4]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======================== K_5 =============
int picnum = 20;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{A}",
  "\nodebox{B}",
  "\nodebox{C}",
  "\nodebox{D}");

// calculate nodes position
real u=1cm;
real v=0.7*u;
vlayout(1*v, nodes[0], nodes[1]);
vlayout(-1*v, nodes[0], nodes[2]);
hlayout(1*u, nodes[0], nodes[3]);

// draw edges
draw(pic,
     (nodes[0]..bend(20)..nodes[1]),
     (nodes[0]..bend(-20)..nodes[1]),
     (nodes[0]..bend(20)..nodes[2]),
     (nodes[0]..bend(-20)..nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[1]--nodes[3]),
     (nodes[2]--nodes[3])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







// ======================== Minimum spanning tree =============
int picnum = 21;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

// node[] nodes=ncircles("\nodebox{0}",
//   "\nodebox{1}",
//   "\nodebox{2}",
//   "\nodebox{3}",
//   "\nodebox{4}",
//   "\nodebox{5}",
//   "\nodebox{6}",
//   "\nodebox{7}",
//   "\nodebox{8}",
//   "\nodebox{9}");
node[] nodes=ncircles("\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}",
  "\nodebox{}");

// calculate nodes position
real u=1.1cm;
real v=0.7*u;
hlayout(2*u, nodes[0],nodes[2],nodes[6],nodes[7]);
hlayout(1.5*u, nodes[7],nodes[8],nodes[9]);
layout(-45.0, nodes[0],nodes[1]);
hlayout(2.0*u, nodes[1], nodes[5]);
layout(-40.0, nodes[1],nodes[4]);
layout(45.0, nodes[2],nodes[3]);

// draw edges
draw(pic,
     (nodes[0]..bend(10)..nodes[1]).l("4"),
     (nodes[0]--nodes[2]).l("1").style("leftside"),
     (nodes[0]..bend(-20)..nodes[3]).l(Label("4",Relative(0.3))).style("leftside"),
     (nodes[1]--nodes[2]).l(Label("5",Relative(0.3))).style("leftside"),
     (nodes[1]..bend(10)..nodes[4]).l("9"),
     (nodes[1]--nodes[5]).l("9"),
     // (nodes[1]--nodes[6]).l("7").style("leftside"),
     (nodes[2]--nodes[3]).l("3").style("leftside"),
     (nodes[2]--nodes[6]).l("7").style("leftside"),
     (nodes[3]--nodes[6]).l("10").style("leftside"),
     (nodes[3]..bend(-20)..nodes[9]).l("18").style("leftside"),
     (nodes[4]--nodes[5]).l(Label("2",Relative(0.7))),
     (nodes[4]..bend(20)..nodes[7]).l(Label("4",Relative(0.7))),
     (nodes[4]..bend(20)..nodes[8]).l(Label("6",Relative(0.7))),
     (nodes[5]--nodes[6]).l(Label("8",Relative(0.7))),
     (nodes[5]..bend(10)..nodes[7]).l(Label("4",Relative(0.25))),
     (nodes[6]--nodes[7]).l("9").style("leftside"),
     (nodes[6]..bend(-25)..nodes[9]).l("8").style("leftside"),
     (nodes[7]--nodes[8]).l("3"),
     (nodes[7]..bend(-25)..nodes[9]).l(Label("9",Relative(0.2))).style("leftside"),
     (nodes[8]--nodes[9]).l("9")
     );
// highlighted edges
draw(pic,(nodes[0]..bend(10)..nodes[1]).l("4"),highlightcolor);
draw(pic,(nodes[0]--nodes[2]).l("1").style("leftside"),highlightcolor);
     // (nodes[0]..bend(-20)..nodes[3]).l(Label("4",Relative(0.3))).style("leftside"),
     // (nodes[1]--nodes[2]).l(Label("5",Relative(0.3))).style("leftside"),
     // (nodes[1]..bend(10)..nodes[4]).l("9"),
     // (nodes[1]--nodes[5]).l("9"),
draw(pic,(nodes[1]--nodes[6]).l("7").style("leftside"),highlightcolor);
draw(pic,(nodes[2]--nodes[3]).l("3").style("leftside"),highlightcolor);
     // (nodes[2]--nodes[6]).l("7").style("leftside"),
     // (nodes[3]--nodes[6]).l("10").style("leftside"),
     //(nodes[3]..bend(-20)..nodes[9]).l("18").style("leftside"),
draw(pic,(nodes[4]--nodes[5]).l(Label("2",Relative(0.7))),highlightcolor);
     // (nodes[4]..bend(20)..nodes[7]).l(Label("4",Relative(0.7))),
     // (nodes[4]..bend(20)..nodes[8]).l(Label("6",Relative(0.7))),
draw(pic,(nodes[5]--nodes[6]).label(Label("8",Relative(0.7))),highlightcolor);
draw(pic,(nodes[5]..bend(10)..nodes[7]).l(Label("4",Relative(0.25))),highlightcolor);
     // (nodes[6]--nodes[7]).l("9").style("leftside"),
draw(pic,(nodes[6]..bend(-25)..nodes[9]).l("8").style("leftside"),highlightcolor);
draw(pic,(nodes[7]--nodes[8]).l("3"),highlightcolor);
     // (nodes[7]..bend(-25)..nodes[9]).l(Label("9",Relative(0.2))).style("leftside"),
     // (nodes[8]--nodes[9]).l("9"),
     // highlightcolor);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4],
     nodes[5], nodes[6], nodes[7], nodes[8], nodes[9]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ...............vertex cover, ind sets.......................
picture pic;
int picnum = 22;
setdefaultgraphstyles();

// define nodes
node q0=ncircle("$v_0$");
node q1=ncircle("$v_1$");
node q2=ncircle("$v_2$");
node q3=ncircle("$v_3$");
node q4=ncircle("$v_4$");
node q5=ncircle("$v_5$");
node q6=ncircle("$v_6$");
node q7=ncircle("$v_7$");
node q8=ncircle("$v_8$");
node q9=ncircle("$v_9$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.0cm;
real u = defaultlayoutskip;
real v = 0.9*u;

hlayout(1*u, q0, q1, q2, q3, q4);
vlayout(1*v, q0, q5);
hlayout(1*u, q5, q6, q7, q8, q9);

// draw edges
draw(pic,
     (q0--q5),
     (q0--q8),
     (q1--q5),
     (q1--q8),
     (q2--q3),
     (q2--q6),
     (q2--q7),
     (q3--q8),
     (q4--q8),
     (q4--q9),
     (q5--q6),
     (q7--q8),
     (q8--q9)
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, q9);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== assignment, travelling salesman =================
picture pic;
int picnum = 23;
setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

// define nodes
node w0=ncircle("$w_0$");
node w1=ncircle("$w_1$");
node w2=ncircle("$w_2$");
node w3=ncircle("$w_3$");
node t0=ncircle("$t_0$");
node t1=ncircle("$t_1$");
node t2=ncircle("$t_2$");
node t3=ncircle("$t_3$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.15cm;
real u = defaultlayoutskip;
real v = 1*u;

hlayout(1.15*u, w0, w1, w2, w3);
vlayout(1.25*v, w0, t0);
hlayout(1.15*u, t0, t1, t2, t3);

// draw edges
real bend_angle = 10; // degrees
draw(pic,
     (w0..bend(bend_angle)..t0),
     (t0..bend(bend_angle)..w0),
     (w0..bend(bend_angle-2)..t1),
     (t1..bend(bend_angle-2)..w0),
     (w0..bend(bend_angle-4)..t2),
     (t2..bend(bend_angle-4)..w0),
     (w0..bend(bend_angle-6)..t3),
     (t3..bend(bend_angle-6)..w0)
     // (w1--t0),
     // (w1--t1),
     // (w1--t2),
     // (w1--t3),
     // (w2--t0),
     // (w2--t1),
     // (w2--t2),
     // (w2--t3),
     // (w3--t0),
     // (w3--t1),
     // (w3--t2),
     // (w3--t3)
);

// draw nodes
draw(pic,
     w0, w1, w2, w3,
     t0, t1, t2, t3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== max-flow =================
picture pic;
int picnum = 25;
setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");
node q6=ncircle("$q_6$");
node q7=ncircle("$q_7$");

// layout
real spread_angle = 35;
hlayout(2*u, q0, q3, q6);
q1.pos = new_node_pos_h(q0, spread_angle, 1*u);
q2.pos = new_node_pos_h(q0, -1*spread_angle, 1*u);
hlayout(2*u, q1, q4);
hlayout(2*u, q2, q5);

// draw edges
draw(pic,
     (q0--q1).l("$3$").style("leftside"),
     (q0--q2).l("$2$"),
     (q0--q3).l("$1$").style("leftside"),
     (q1--q3).l("$2$").style("leftside"),
     (q1--q4).l("$2$").style("leftside"),
     (q2--q3).l("$2$"),
     (q2--q5).l("$1$"),
     (q3--q4).l("$4$").style("leftside"),
     (q3--q5).l("$2$"),
     (q3--q6).l("$2$").style("leftside"),
     (q4--q6).l("$1$").style("leftside"),
     (q5--q6).l("$2$")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ........... answers added .................
picture pic;
int picnum = 26;
setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");
node q6=ncircle("$q_6$");
node q7=ncircle("$q_7$");

// layout
real spread_angle = 35;
hlayout(2*u, q0, q3, q6);
q1.pos = new_node_pos_h(q0, spread_angle, 1*u);
q2.pos = new_node_pos_h(q0, -1*spread_angle, 1*u);
hlayout(2*u, q1, q4);
hlayout(2*u, q2, q5);

// draw edges
draw(pic,
     (q0--q1).l("$3 (2)$").style("leftside"),
     (q0--q2).l("$2 (2)$"),
     (q0--q3).l("$1 (1)$").style("leftside"),
     (q1--q3).l("$2 (1)$").style("leftside"),
     (q1--q4).l("$2 (1)$").style("leftside"),
     (q2--q3).l("$2 (1)$"),
     (q2--q5).l("$1 (1)$"),
     (q3--q4).l("$4 (0)$").style("leftside"),
     (q3--q5).l("$2 (1)$"),
     (q3--q6).l("$2 (2)$").style("leftside"),
     (q4--q6).l("$1 (1)$").style("leftside"),
     (q5--q6).l("$2 (2)$")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== vertex cover leq set cover =================
picture pic;
int picnum = 27;
setdefaultgraphstyles();
defaultdrawstyle=undirectededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");
node q6=ncircle("$q_6$");
node q7=ncircle("$q_7$");
node q8=ncircle("$q_8$");
node q9=ncircle("$q_9$");

// layout
real spread_angle = 30;
hlayout(4*u, q0, q5);
q1.pos = new_node_pos_h(q0, spread_angle, 1*u);
q2.pos = new_node_pos_h(q0, -1*spread_angle, 1*u);
hlayout(2*u, q1, q3);
hlayout(2*u, q2, q4);
hlayout(2*u, q3, q6, q8);
hlayout(2*u, q4, q7, q9);

// draw edges
draw(pic,
     (q0--q1).l("$a$").style("leftside"),
     (q0--q2).l("$b$"),
     (q1--q3).l("$c$").style("leftside"),
     (q2--q3).l("$d$").style("leftside"),
     (q2--q4).l("$e$"),
     (q3--q5).l("$g$"),
     (q3--q6).l("$f$").style("leftside"),
     (q4--q5).l("$h$").style("leftside"),
     (q4--q7).l("$i$"),
     (q5--q6).l("$j$"),
     (q5--q7).l("$k$").style("leftside"),
     (q6--q8).l("$l$").style("leftside"),
     (q7--q8).l("$m$"),
     (q8--q9).l("$n$").style("leftside")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, q9
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............. vertex cover shown ...................
picture pic;
int picnum = 28;
setdefaultgraphstyles();
defaultdrawstyle=undirectededgestyle;

// define nodes
node q0=ncircle("$q_0$", ns_light);
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$", ns_light);
node q4=ncircle("$q_4$", ns_light);
node q5=ncircle("$q_5$");
node q6=ncircle("$q_6$", ns_light);
node q7=ncircle("$q_7$", ns_light);
node q8=ncircle("$q_8$");
node q9=ncircle("$q_9$", ns_light);

// layout
real spread_angle = 30;
hlayout(4*u, q0, q5);
q1.pos = new_node_pos_h(q0, spread_angle, 1*u);
q2.pos = new_node_pos_h(q0, -1*spread_angle, 1*u);
hlayout(2*u, q1, q3);
hlayout(2*u, q2, q4);
hlayout(2*u, q3, q6, q8);
hlayout(2*u, q4, q7, q9);

// draw edges
draw(pic,
     (q0--q1).l("$a$").style("leftside"),
     (q0--q2).l("$b$"),
     (q1--q3).l("$c$").style("leftside"),
     (q2--q3).l("$d$").style("leftside"),
     (q2--q4).l("$e$"),
     (q3--q5).l("$g$"),
     (q3--q6).l("$f$").style("leftside"),
     (q4--q5).l("$h$").style("leftside"),
     (q4--q7).l("$i$"),
     (q5--q6).l("$j$"),
     (q5--q7).l("$k$").style("leftside"),
     (q6--q8).l("$l$").style("leftside"),
     (q7--q8).l("$m$"),
     (q8--q9).l("$n$").style("leftside")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, q9
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== drummer leq max-flow =================
picture pic;
int picnum = 29;
setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$b_0$");
node q2=ncircle("$b_1$");
node q3=ncircle("$b_2$");
node q4=ncircle("$b_3$");
node q5=ncircle("$d_0$");
node q6=ncircle("$d_1$");
node q7=ncircle("$d_2$");
node q8=ncircle("$d_3$");
node q9=ncircle("$q_9$");

// layout
real u=1.35cm;
real v=0.7*u;
real spread_angle = 25;
hlayout(3*u, q0, q9);
q1.pos = new_node_pos_h(q0,  1.5*spread_angle, 1*u);
q2.pos = new_node_pos_h(q0,  0.5*spread_angle, 1*u);
q3.pos = new_node_pos_h(q0, -0.5*spread_angle, 1*u);
q4.pos = new_node_pos_h(q0, -1.5*spread_angle, 1*u);
hlayout(1*u, q1, q5);
hlayout(1*u, q2, q6);
hlayout(1*u, q3, q7);
hlayout(1*u, q4, q8);

// draw edges
draw(pic,
     (q0--q1).l("$1$").style("leftside"),
     (q0--q2).l("$1$").style("leftside"),
     (q0--q3).l("$1$").style("leftside"),
     (q0--q4).l("$1$").style("leftside"),
     (q1--q5).l("$1$").style("leftside"),
     (q1..bend(10)..q7).l(Label("$1$",Relative(0.3))).style("leftside"),
     (q2--q6).l(Label("$1$",Relative(0.2))),
     (q3--q6).l(Label("$1$",Relative(0.3))),
     (q4--q7).l("$1$").style("leftside"),
     (q4--q8).l("$1$"),
     (q5--q9).l("$1$").style("leftside"),
     (q6--q9).l("$1$").style("leftside"),
     (q7--q9).l("$1$").style("leftside"),
     (q8--q9).l("$1$").style("leftside")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8, q9
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== 3-SAT leq Ind Set =================
picture pic;
int picnum = 30;
setdefaultgraphstyles();
defaultdrawstyle=undirectededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");

// layout
real u=1cm;
real v=0.7*u;
hlayout(1*u, q0, q1, q2);
vlayout(1*v, q0, q3);
hlayout(1*u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1),
     (q0--q3),
     (q1--q2),
     (q1--q3),
     (q1--q5),
     (q2--q5),
     (q3--q4),
     (q4--q5)
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ................ include answer .................
picture pic;
int picnum = 31;
setdefaultgraphstyles();
defaultdrawstyle=undirectededgestyle;

// define nodes
node q0=ncircle("$q_0$", ns_light);
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$", ns_light);
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$", ns_light);
node q5=ncircle("$q_5$");

// layout
real u=1cm;
real v=0.7*u;
hlayout(1*u, q0, q1, q2);
vlayout(1*v, q0, q3);
hlayout(1*u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1),
     (q0--q3),
     (q1--q2),
     (q1--q3),
     (q1--q5),
     (q2--q5),
     (q3--q4),
     (q4--q5)
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== Hamiltonian Path leq Longest Path =================
picture pic;
int picnum = 32;
setdefaultgraphstyles();
defaultdrawstyle=directededgestyle;

// define nodes
node q0=ncircle("$q_0$");
node q1=ncircle("$q_1$");
node q2=ncircle("$q_2$");
node q3=ncircle("$q_3$");
node q4=ncircle("$q_4$");
node q5=ncircle("$q_5$");
node q6=ncircle("$q_6$");
node q7=ncircle("$q_7$");
node q8=ncircle("$q_8$");

// layout
real u=1.25cm;
real v=0.75*u;
hlayout(1*u, q0, q1, q2);
vlayout(1*v, q0, q3, q6);
hlayout(1*u, q3, q4, q5);
hlayout(1*u, q6, q7, q8);

// draw edges
draw(pic,
     (q0--q1),
     (q0..bend(-25)..q2),
     (q0--q3),
     (q0--q4),
     (q1--q2),
     (q3--q6),
     (q4--q7),
     (q5--q0),
     (q5--q2),
     (q5..bend(-30)..q3),
     (q5--q0),
     (q6--q4),
     (q7--q6),
     (q7--q8),
     (q8..bend(30)..q2),
     (q8--q4),
     (q8--q5)
);

// draw nodes
draw(pic,
     q0, q1, q2,
     q3, q4, q5,
     q6, q7, q8
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========== Ham circuit leq Ham path ==========
int picnum = 33;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{$v_0$}",
		      "\nodebox{$v_1$}",
		      "\nodebox{$v_2$}",
		      "\nodebox{$v_3$}",
		      "\nodebox{$v_4$}",
		      "\nodebox{$v_5$}",
		      "\nodebox{$v_6$}",
		      "\nodebox{$v_7$}",
		      "\nodebox{$v_8$}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

hlayout(1*u, nodes[0], nodes[7]);
hlayout(2*u, nodes[7], nodes[6]);
vlayout(2*v, nodes[7], nodes[1]);
nodes[2].pos = new_node_pos_h(nodes[7], -35.0, 1*u);
hlayout(2*u, nodes[1], nodes[3]);
nodes[5].pos = new_node_pos_h(nodes[6], -35.0, 1*u);
hlayout(1*u, nodes[5], nodes[4]);
vlayout(-1*v, nodes[4], nodes[8]);

// draw edges
draw(pic,
     (nodes[0]--nodes[7]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[3]),
     (nodes[1]--nodes[7]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[7]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[3]--nodes[6]),
     (nodes[4]--nodes[5]),
     (nodes[4]--nodes[6]),
     (nodes[4]--nodes[8]), 
     (nodes[5]--nodes[6])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4],
     nodes[5], nodes[6], nodes[7], nodes[8]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========== 3-Sat leq Ind set ==========
int picnum = 34;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0 = ncircle("$v_{0,0}$");
node v1 = ncircle("$\overline{v}_{0,1}$");
node v2 = ncircle("$\overline{v}_{0,2}$");
node w1 = ncircle("$v_{1,1}$");
node w2 = ncircle("$v_{1,2}$");
node w3 = ncircle("$\overline{v}_{1,3}$");

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = 20;
v1.pos = new_node_pos_h(v0, layout_angle, 1*u);
v2.pos = new_node_pos_h(v0, -1*layout_angle, 1*u);
hlayout(2*u, v1, w1);
hlayout(2*u, v2, w2);
w3.pos = new_node_pos_h(w2, layout_angle, 1*u);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--w1),
     (v2--w2),
     (v0--v1),
     (w1--w2),
     (w1--w3),
     (w2--w3)
);

// draw nodes
draw(pic,
     v0, v1, v2,
     w1, w2, w3
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========== 3-Sat leq 3-coloring ==========

// Edge dashed
pen dashedgepen=linetype(new real[] {2,1})+squarecap;
drawstyle dashedstyle=drawstyle(edgelabel, p=dashedgepen+EDGEPEN_TT, arrow=None);
drawstyle highlightstyle=drawstyle(edgelabel, p=WALK_PEN, arrow=None);

int picnum = 35;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node Tnode = ncircle("$T$",ns_bleachedbg);
node Fnode = ncircle("$F$",ns_light);
node Gnode = ncircle("$G$",ns_gray);
node anode = ncircle("$a$");
node bnode = ncircle("$b$");
node cnode = ncircle("$c$");
node xnode = ncircle("$w$\strut");
node negxnode = ncircle("$\neg w$");

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = -30;
hlayout(2*u, Tnode, Fnode);
Gnode.pos = new_node_pos_h(Tnode, layout_angle, 1*u);
xnode.pos = new_node_pos(Gnode, -110, -1.65*v);
negxnode.pos = new_node_pos(Gnode, -70, -1.65*v);

// draw edges
draw(pic,
     (Tnode--Fnode),
     (Tnode--Gnode),
     (Fnode--Gnode),
     (Gnode--xnode).style(dashedstyle),
     (Gnode--negxnode).style(dashedstyle),
     (xnode--negxnode)
);

// draw nodes
draw(pic,
     Tnode, Fnode, Gnode,
     xnode, negxnode
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// -------------- show a full gadget --------------
void drawgnd(picture p, pair cnx, real u, real v){
  draw(p, cnx-(0.15*u,0)--cnx+(0.15*u,0),EDGEPEN_TT+squarecap);
  draw(p, cnx-(0.10*u,0.125*v)--cnx+(0.10*u,-0.125*v),EDGEPEN_TT+squarecap);
  draw(p, cnx-(0.05*u,0.25*v)--cnx+(0.05*u,-0.25*v),EDGEPEN_TT+squarecap);
};

int picnum = 36;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node Tnode = ncircle("$T$",ns_bleachedbg);
node Fnode = ncircle("$F$",ns_light);
node Gnode = ncircle("$G$",ns_gray);
node anode = ncircle("$a$\strut");
node bnode = ncircle("$b$\strut");
node cnode = ncircle("$c$\strut");
node n0 = ncircle("$n_0$");
node n1 = ncircle("$n_1$");
node n2 = ncircle("$n_2$");
node n3 = ncircle("$n_3$");
node n4 = ncircle("$n_4$");
node n5 = ncircle("$n_5$");
// nodes for lines from a, b, c to G
node anode_below = nbox("",ns_noborder); 
node bnode_below = nbox("",ns_noborder); 
node cnode_below = nbox("",ns_noborder); 
node anode_below_left = nbox("",ns_noborder); 
node bnode_below_left = nbox("",ns_noborder); 
node cnode_below_left = nbox("",ns_noborder); 
node anode_above_left = nbox("",ns_noborder); 
node bnode_above_left = nbox("",ns_noborder); 
node cnode_above_left = nbox("",ns_noborder); 

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = -30;
hlayout(2*u, Tnode, Fnode);
Gnode.pos = new_node_pos_h(Tnode, layout_angle, 1*u);

n0.pos = new_node_pos(Gnode, -135, -1.5*v);
n3.pos = new_node_pos_h(n0, -135, -0.5*u);
hlayout(1*u, n3, n4);
hlayout(1.5*u, n0, n1);
// n1.pos = new_node_pos(Gnode, -45, -1.5*v);
hlayout(1*u, n1, n2);
n5.pos = new_node_pos_h(n1, -45, 0.5*u);
vlayout(1*v, n3, anode);
vlayout(1*v, n4, bnode);
vlayout(1*v, n5, cnode);
// Nodes for lines from a, b, c
// real dist_below =0.75*v;
// real dist_epsilon = 0.10*v;
// anode_below_left.pos=anode.pos-(1*u,dist_below);
// bnode_below_left.pos=anode_below_left.pos-(dist_epsilon,dist_epsilon);
// cnode_below_left.pos=anode_below_left.pos-(2*dist_epsilon,2*dist_epsilon);
// anode_above_left.pos=(anode_below_left.pos.x,Gnode.pos.y+dist_epsilon);
// bnode_above_left.pos=anode_above_left.pos-(dist_epsilon,0);
// cnode_above_left.pos=anode_above_left.pos-(2*dist_epsilon,dist_epsilon);

// draw edges
draw(pic,
     (Tnode--Fnode),
     (Tnode--Gnode),
     (Fnode--Gnode),
     (Fnode--n2),
     (Gnode--n0), // .style(dashedstyle),
     (Gnode--n2), // .style(dashedstyle),
     (n0--n1),
     (n0--n3),
     (n0--n4),
     (n1--n2),
     (n1--n5),
     (n2--n5),
     (n3--n4),
     (n3--anode),
     (n4--bnode),
     (n5--cnode)
);

// draw extra paths
pair gnd_offset = (0*u,0.75*v);
drawgnd(pic, anode.pos-gnd_offset, u, v);
  draw(pic,anode.pos--(anode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
drawgnd(pic, bnode.pos-gnd_offset, u, v);
  draw(pic,bnode.pos--(bnode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
drawgnd(pic, cnode.pos-gnd_offset, u, v);
  draw(pic,cnode.pos--(cnode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);

// draw nodes
draw(pic,
     Tnode, Fnode, Gnode,
     n0, n1, n2, n3, n4, n5,
     anode, bnode, cnode
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// -------------- two gadgets --------------
int picnum = 37;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node Tnode = ncircle("$T$");
node Fnode = ncircle("$F$");
node Gnode = ncircle("$G$");
node cnode = ncircle("$z$");
node n0 = ncircle("\rule{0pt}{5pt} ");
node n1 = ncircle("\rule{0pt}{5pt} ");
node n2 = ncircle("\rule{0pt}{5pt} ");
node n3 = ncircle("\rule{0pt}{5pt} ");
node n4 = ncircle("\rule{0pt}{5pt} ");
node n5 = ncircle("\rule{0pt}{5pt} ");
node m0 = ncircle("\rule{0pt}{5pt} ");
node m1 = ncircle("\rule{0pt}{5pt} ");
node m2 = ncircle("\rule{0pt}{5pt} ");
node m3 = ncircle("\rule{0pt}{5pt} ");
node m4 = ncircle("\rule{0pt}{5pt} ");
node m5 = ncircle("\rule{0pt}{5pt} ");
node xnode = ncircle("$P$\strut");
node negxnode = ncircle("$\neg P$");
node ynode = ncircle("$Q$\strut");
node negynode = ncircle("$\neg Q$");
node znode = ncircle("$R$\strut");
node negznode = ncircle("$\neg R$");
node bottomcenternode =ncircle("o");  // locate the center of the bottom line

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = -30;
hlayout(2*u, Tnode, Fnode);
Gnode.pos = new_node_pos_h(Tnode, layout_angle, 1*u);

n2.pos = new_node_pos(Gnode, -120, -1.5*v);
hlayout(-1*u, n2, n1);
hlayout(-1.5*u, n1, n0);
n3.pos = new_node_pos_h(n0, -135, -0.5*u);
hlayout(1*u, n3, n4);
hlayout(1.25*u, n0, n1);
n5.pos = new_node_pos_h(n1, -45, 0.5*u);

m0.pos = new_node_pos(Gnode, -60, -1.5*v);
m3.pos = new_node_pos_h(m0, -135, -0.5*u);
hlayout(1*u, m3, m4);
hlayout(1.25*u, m0, m1);
hlayout(1*u, m1, m2);
m5.pos = new_node_pos_h(m1, -45, 0.5*u);

vlayout(3.75*v, Gnode, bottomcenternode);
hlayout(-0.5*u, bottomcenternode, ynode);
hlayout(0.5*u, bottomcenternode, negynode);
hlayout(-1.25*u, ynode, negxnode);
hlayout(-1*u, negxnode, xnode);
hlayout(1.25*u, negynode, znode);
hlayout(1*u, znode, negznode);

// draw edges
draw(pic,
     (Tnode--Fnode),
     (Tnode--Gnode),
     (Fnode--Gnode),
     (Fnode..bend(-20)..n2),
     (Gnode--n0), // .style(dashedstyle),
     (Gnode--n2), //.style(dashedstyle),
     (n0--n1),
     (n0--n3),
     (n0--n4),
     (n1--n2),
     (n1--n5),
     (n2--n5),
     (n3--n4),
     (Fnode..bend(-20)..m2),  // matches the bend in the first gadget
     (Gnode--m0), // .style(dashedstyle),
     (Gnode--m2), // .style(dashedstyle),
     (m0--m1),
     (m0--m3),
     (m0--m4),
     (m1--m2),
     (m1--m5),
     (m2--m5),
     (m3--m4),
     (xnode--negxnode),
     (ynode--negynode),
     (znode--negznode)
);

// draw connections to gadgets
draw(pic,
     (n3--xnode).style(highlightstyle),
     (n4--ynode).style(highlightstyle),
     (n5--znode).style(highlightstyle),
     (m3--negxnode).style(highlightstyle),
     (m4--negynode).style(highlightstyle),
     (m5--znode).style(highlightstyle)
);

// Draw connections to G
real offset = 0.1*u;
real y_loc_G_path =  xnode.pos.y-0.5*v;
real x_loc_G_path = n3.pos.x-0.3*u;
real x_gather_loc = Gnode.pos.x-2*u;
path xnode_to_G = xnode.pos--(xnode.pos.x,y_loc_G_path)
  --(x_loc_G_path,y_loc_G_path)--(x_loc_G_path,Gnode.pos.y-2*offset)
  --(x_gather_loc,Gnode.pos.y-2*offset)--Gnode.pos;
path negxnode_to_G = negxnode.pos--(negxnode.pos.x,y_loc_G_path-1*offset)
  --(x_loc_G_path-1*offset,y_loc_G_path-1*offset)
  --(x_loc_G_path-1*offset,Gnode.pos.y-1*offset)
  --(x_gather_loc,Gnode.pos.y-1*offset)--Gnode.pos;
path ynode_to_G = ynode.pos--(ynode.pos.x,y_loc_G_path-2*offset)
  --(x_loc_G_path-2*offset,y_loc_G_path-2*offset)
  --(x_loc_G_path-2*offset,Gnode.pos.y-0*offset)
  --(x_gather_loc,Gnode.pos.y-0*offset)--Gnode.pos;
path negynode_to_G = negynode.pos--(negynode.pos.x,y_loc_G_path-3*offset)
  --(x_loc_G_path-3*offset,y_loc_G_path-3*offset)
  --(x_loc_G_path-3*offset,Gnode.pos.y+1*offset)
  --(x_gather_loc,Gnode.pos.y+1*offset)--Gnode.pos;
path znode_to_G = znode.pos--(znode.pos.x,y_loc_G_path-4*offset)
  --(x_loc_G_path-4*offset,y_loc_G_path-4*offset)
  --(x_loc_G_path-4*offset,Gnode.pos.y+2*offset)
  --(x_gather_loc,Gnode.pos.y+2*offset)--Gnode.pos;
path negznode_to_G = negznode.pos--(negznode.pos.x,y_loc_G_path-5*offset)
  --(x_loc_G_path-5*offset,y_loc_G_path-5*offset)
  --(x_loc_G_path-5*offset,Gnode.pos.y+3*offset)
  --(x_gather_loc,Gnode.pos.y+3*offset)--Gnode.pos;
 
draw(pic,xnode_to_G,EDGEPEN_TT+squarecap);
draw(pic,negxnode_to_G,EDGEPEN_TT+squarecap);
draw(pic,ynode_to_G,EDGEPEN_TT+squarecap);
draw(pic,negynode_to_G,EDGEPEN_TT+squarecap);
draw(pic,znode_to_G,EDGEPEN_TT+squarecap);
draw(pic,negznode_to_G,EDGEPEN_TT+squarecap);

// draw extra paths
// pair gnd_offset = (0*u,1*v);
// drawgnd(pic, xnode.pos-gnd_offset, u, v);
//   draw(pic,xnode.pos--(xnode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// drawgnd(pic, negxnode.pos-gnd_offset, u, v);
//   draw(pic,negxnode.pos--(negxnode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// drawgnd(pic, ynode.pos-gnd_offset, u, v);
//   draw(pic,ynode.pos--(ynode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// drawgnd(pic, negynode.pos-gnd_offset, u, v);
//   draw(pic,negynode.pos--(negynode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// drawgnd(pic, znode.pos-gnd_offset, u, v);
//   draw(pic,znode.pos--(znode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// drawgnd(pic, negznode.pos-gnd_offset, u, v);
//   draw(pic,negznode.pos--(negznode.pos-gnd_offset),dashedgepen+EDGEPEN_TT+squarecap);
// // Draw ground connection to G
// picture G_gnd_pic;
// drawgnd(G_gnd_pic, (0,0), u, v);
// add(pic, G_gnd_pic, Gnode.pos-(2*u,0.5*v));
// draw(pic, Gnode.pos--(Gnode.pos.x-2*u,Gnode.pos.y)--(Gnode.pos.x-2*u,Gnode.pos.y-0.5v), dashedgepen+EDGEPEN_TT+squarecap);

// draw nodes
draw(pic,
     Tnode, Fnode, Gnode,
     n0, n1, n2, n3, n4, n5,
     m0, m1, m2, m3, m4, m5,
     // bottomcenternode, // for debugging
     xnode, negxnode, ynode, negynode, znode, negznode
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ SAT \leq_p clique =============

int picnum = 38;
picture pic;
setdefaultgraphstyles();

node v00=ncircle("$0,x_0$"),
  v01=ncircle("$0,\neg x_1$"),
  v02=ncircle("$0,x_2$"),
  v10=ncircle("$1,\neg x_0$"),
  v11=ncircle("$1,x_2$"),
  v12=ncircle("$1,\neg x_3$"),
  v20=ncircle("$2,\neg x_1$"),
  v21=ncircle("$2,\neg x_2$");

// calculate nodes position
real u=1.5cm;
real v=0.8*u;
v00.pos = (-2*u,0*v);
v01.pos = new_node_pos(v00, 35, 0.55*v);
v02.pos = new_node_pos(v01, 35, 0.55*v);
hlayout(4*u, v00, v10);
v11.pos = new_node_pos(v10, 145, 0.55*v);
v12.pos = new_node_pos(v11, 145, 0.55*v);
v20.pos = (-0.7*u,-0.5*v);
hlayout(1.4*u, v20, v21);

// draw edges
draw(pic,
     (v00--v11), // clause 0 to clause 1
     (v00..bend(10)..v12),
     (v01--v10),
     (v01--v11),
     (v01--v12),
     (v02..bend(10)..v10),
     (v02..bend(10)..v11),
     (v02--v12),
     (v00--v20), // clause 0 to clause 2
     (v00..bend(-10)..v21),
     (v01--v20),
     (v01--v21),
     (v02--v20),
     (v10..bend(10)..v20), // clause 1 to clause 2
     (v10--v21),
     (v11--v20),
     (v12--v20),
     (v12--v21)
);
// draw(pic, v00--v11, WALK_PEN);  // show 3-clique
// draw(pic, v11--v20, WALK_PEN);
// draw(pic, v20--v00, WALK_PEN);

// draw nodes
draw(pic,
     v00, v01, v02,
     v10, v11, v12,
     v20, v21);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...............................
int picnum = 39;
picture pic;
setdefaultgraphstyles();

node v00=ncircle("$0,x_0$"),
  v01=ncircle("$0,\neg x_1$"),
  v02=ncircle("$0,x_2$"),
  v10=ncircle("$1,\neg x_0$"),
  v11=ncircle("$1,x_2$"),
  v12=ncircle("$1,\neg x_3$"),
  v20=ncircle("$2,\neg x_1$"),
  v21=ncircle("$2,\neg x_2$");

// calculate nodes position
real u=1.5cm;
real v=0.8*u;
v00.pos = (-2*u,0*v);
v01.pos = new_node_pos(v00, 35, 0.55*v);
v02.pos = new_node_pos(v01, 35, 0.55*v);
hlayout(4*u, v00, v10);
v11.pos = new_node_pos(v10, 145, 0.55*v);
v12.pos = new_node_pos(v11, 145, 0.55*v);
v20.pos = (-0.7*u,-0.5*v);
hlayout(1.4*u, v20, v21);

// draw edges
draw(pic,
     (v00--v11), // clause 0 to clause 1
     (v00..bend(10)..v12),
     (v01--v10),
     (v01--v11),
     (v01--v12),
     (v02..bend(10)..v10),
     (v02..bend(10)..v11),
     (v02--v12),
     (v00--v20), // clause 0 to clause 2
     (v00..bend(-10)..v21),
     (v01--v20),
     (v01--v21),
     (v02--v20),
     (v10..bend(10)..v20), // clause 1 to clause 2
     (v10--v21),
     (v11--v20),
     (v12--v20),
     (v12--v21)
);
draw(pic, v00--v11, WALK_PEN);  // show 3-clique
draw(pic, v11--v20, WALK_PEN);
draw(pic, v20--v00, WALK_PEN);

// draw nodes
draw(pic,
     v00, v01, v02,
     v10, v11, v12,
     v20, v21);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ========= Another try at gadget for 3SAT <= 3COLORING ==
int picnum = 40;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node Tnode = ncircle("$T$",ns_bleachedbg);
node Fnode = ncircle("$F$",ns_light);
node Gnode = ncircle("$G$",ns_gray);
node anode = ncircle("$a$");
node bnode = ncircle("$b$");
node cnode = ncircle("$c$");
node xnode = ncircle("$p$");
node negxnode = ncircle("$q$");

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = -30;
hlayout(2*u, Tnode, Fnode);
Gnode.pos = new_node_pos_h(Tnode, layout_angle, 1*u);
xnode.pos = new_node_pos(Gnode, -110, -1.65*v);
negxnode.pos = new_node_pos(Gnode, -70, -1.65*v);

// draw edges
draw(pic,
     (Tnode--Fnode),
     (Tnode--Gnode),
     (Fnode--Gnode),
     (xnode..bend(-30)..Gnode).style(dashedstyle),
     (negxnode..bend(-110)..Gnode).style(dashedstyle),
     (xnode--negxnode)
);

// draw nodes
draw(pic,
     Tnode, Fnode, Gnode,
     xnode, negxnode
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...............................
int picnum = 41;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node Tnode = ncircle("$T$");
node Fnode = ncircle("$F$");
node Gnode = ncircle("$G$");
node anode = ncircle("$a$\strut");
node bnode = ncircle("$b$\strut");
node cnode = ncircle("$c$\strut");
node n0 = ncircle("$n_0$");
node n1 = ncircle("$n_1$");
node n2 = ncircle("$n_2$");
node n3 = ncircle("$n_3$");
node n4 = ncircle("$n_4$");
node n5 = ncircle("$n_5$");
// nodes for lines from a, b, c to G
node anode_below = nbox("",ns_noborder); 
node bnode_below = nbox("",ns_noborder); 
node cnode_below = nbox("",ns_noborder); 
node anode_below_left = nbox("",ns_noborder); 
node bnode_below_left = nbox("",ns_noborder); 
node cnode_below_left = nbox("",ns_noborder); 
node anode_above_left = nbox("",ns_noborder); 
node bnode_above_left = nbox("",ns_noborder); 
node cnode_above_left = nbox("",ns_noborder); 

// calculate nodes position
real u=1cm;
real v=0.7*u;

real layout_angle = -30;
hlayout(2*u, Tnode, Fnode);
Gnode.pos = new_node_pos_h(Tnode, layout_angle, 1*u);

n0.pos = new_node_pos(Gnode, -135, -1.5*v);
n3.pos = new_node_pos_h(n0, -135, -0.5*u);
hlayout(1*u, n3, n4);
hlayout(1.5*u, n0, n1);
// n1.pos = new_node_pos(Gnode, -45, -1.5*v);
hlayout(1*u, n1, n2);
n5.pos = new_node_pos_h(n1, -45, 0.5*u);
vlayout(1*v, n3, anode);
vlayout(1*v, n4, bnode);
vlayout(1*v, n5, cnode);

// draw edges
draw(pic,
     (Tnode--Fnode),
     (Tnode--Gnode),
     (Fnode--Gnode),
     (Fnode--n2),
     (Gnode--n0), // .style(dashedstyle),
     (Gnode--n2), // .style(dashedstyle),
     (n0--n1),
     (n0--n3),
     (n0--n4),
     (n1--n2),
     (n1--n5),
     (n2--n5),
     (n3--n4),
     (n3--anode),
     (n4--bnode),
     (n5--cnode)
);

real offset = 0.1*u;
real y_loc_G_path =  anode.pos.y-0.5*v;
real x_loc_G_path = n3.pos.x-0.5*u;
real x_gather_loc = Gnode.pos.x-1*u;
path anode_to_G = anode.pos--(anode.pos.x,y_loc_G_path)
  --(x_loc_G_path,y_loc_G_path)--(x_loc_G_path,Gnode.pos.y-1*offset)
  --(x_gather_loc,Gnode.pos.y-1*offset)--Gnode.pos;
path bnode_to_G = bnode.pos--(bnode.pos.x,y_loc_G_path-1*offset)
  --(x_loc_G_path-1*offset,y_loc_G_path-1*offset)
  --(x_loc_G_path-1*offset,Gnode.pos.y-0*offset)
  --(x_gather_loc,Gnode.pos.y-0*offset)--Gnode.pos;
path cnode_to_G = cnode.pos--(cnode.pos.x,y_loc_G_path-2*offset)
  --(x_loc_G_path-2*offset,y_loc_G_path-2*offset)
  --(x_loc_G_path-2*offset,Gnode.pos.y+1*offset)
  --(x_gather_loc,Gnode.pos.y+1*offset)--Gnode.pos;

draw(pic,anode_to_G,EDGEPEN_TT+squarecap);
draw(pic,bnode_to_G,EDGEPEN_TT+squarecap);
draw(pic,cnode_to_G,EDGEPEN_TT+squarecap);

// draw nodes
draw(pic,
     Tnode, Fnode, Gnode,
     n0, n1, n2, n3, n4, n5,
     anode, bnode, cnode
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ========= 3SAT leq Independent set exercise =============

int picnum = 42;
picture pic;
setdefaultgraphstyles();

node c00=ncircle("\nodebox{\strut$c_{0,0}$}"),
  c01=ncircle("\nodebox{\strut$\bar{c}_{0,1}$}"),
  c02=ncircle("\nodebox{$\bar{c}_{0,2}$}"),
  c11=ncircle("\nodebox{$c_{1,1}$}"),
  c12=ncircle("\nodebox{$c_{1,2}$}"),
  c13=ncircle("\nodebox{$\bar{c}_{1,3}$}");

// calculate nodes position
real u=1.2cm;
real v=0.8*u;
c01.pos = new_node_pos_h(c00, 30, 1*u);
c02.pos = new_node_pos_h(c00, -30, 1*u);
hlayout(2.0*u, c01, c11);
hlayout(2.0*u, c02, c12);
c13.pos = new_node_pos_h(c11, -30, 1*u);

// draw edges
draw(pic,
     (c00--c01),
     (c00--c02),
     (c01--c02),
     (c01--c11),
     (c02--c12),
     (c11--c12),
     (c11--c13),
     (c12--c13)
);

// draw nodes, after edges
draw(pic,
     c00, c01, c02,
     c11, c12, c13);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= Travelling Salesman equiv Asymmetric TS =============

int picnum = 43;
picture pic;
setdefaultgraphstyles();
defaultdrawstyle=directededgesstyle;

node h0=ncircle("\nodebox{$h_0$}"),
  h1=ncircle("\nodebox{$h_1$}"),
  h2=ncircle("\nodebox{$h_2$}"),
  h0hat=ncircle("\nodebox{$\hat{h}_0$}"),
  h1hat=ncircle("\nodebox{$\hat{h}_1$}"),
  h2hat=ncircle("\nodebox{$\hat{h}_2$}");

// calculate nodes position
real u=1.2cm;
real v=0.8*u;
hlayout(2.0*u, h0, h1, h2);
vlayout(1.5*v, h0, h0hat);
hlayout(2.0*u, h0hat, h1hat, h2hat);

// draw edges
draw(pic,
     (h0--h1hat).l(Label("$3$",Relative(0.25))),
     // (h1hat--h0).l("$3$"),
     (h0--h2hat).l(Label("$5$",Relative(0.15))).style("leftside"),
     // (h2hat--h0).l("$5$"),
     (h1--h0hat).l(Label("$1$",Relative(0.2))),
     // (h0hat--h1).l("$1$"),
     (h1--h2hat).l(Label("$6$",Relative(0.225))).style("leftside"),
     // (h2hat--h1).l("$6$"),
     (h2--h0hat).l(Label("$2$",Relative(0.15))),
     // (h0hat--h2).l("$2$"),
     (h2--h1hat).l(Label("$4$",Relative(0.25))).style("leftside")
     // (h1hat--h2).l("$4$")
);

// draw nodes, after edges
draw(pic,
     h0, h1, h2,
     h0hat, h1hat, h2hat);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ................... adjusted graph .................
int picnum = 44;
picture pic;
setdefaultgraphstyles();
defaultdrawstyle=directededgesstyle;

node h0=ncircle("\nodebox{$h_0$}"),
  h1=ncircle("\nodebox{$h_1$}"),
  h2=ncircle("\nodebox{$h_2$}"),
  h0hat=ncircle("\nodebox{$\hat{h}_0$}"),
  h1hat=ncircle("\nodebox{$\hat{h}_1$}"),
  h2hat=ncircle("\nodebox{$\hat{h}_2$}");

// calculate nodes position
real u=1.2cm;
real v=0.8*u;
hlayout(2.0*u, h0, h1, h2);
vlayout(1.5*v, h0, h0hat);
hlayout(2.0*u, h0hat, h1hat, h2hat);

// draw edges
draw(pic,
     (h0--h1hat).l(Label("$3$",Relative(0.25))),
     // (h1hat--h0).l("$3$"),
     (h0--h2hat).l(Label("$5$",Relative(0.15))).style("leftside"),
     // (h2hat--h0).l("$5$"),
     (h1--h0hat).l(Label("$1$",Relative(0.2))),
     // (h0hat--h1).l("$1$"),
     (h1--h2hat).l(Label("$6$",Relative(0.225))).style("leftside"),
     // (h2hat--h1).l("$6$"),
     (h2--h0hat).l(Label("$2$",Relative(0.15))),
     // (h0hat--h2).l("$2$"),
     (h2--h1hat).l(Label("$4$",Relative(0.25))).style("leftside"),
     // (h1hat--h2).l("$4$")
     (h0--h0hat).l(Label("$-37$",Relative(0.6))),
     (h1--h1hat).l(Label("$-37$",Relative(0.8))).style("leftside"),
     (h2--h2hat).l(Label("$-37$",Relative(0.6))).style("leftside")
);

// draw nodes, after edges
draw(pic,
     h0, h1, h2,
     h0hat, h1hat, h2hat);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============= jigsaw puzzle ====================== 
int picnum = 45;
picture pic;
unitsize(pic,5cm);

int secs = seconds();
write(format("Seed for srand is %d",secs));
srand(secs);
//srand(5);

// Return a puzzle piece edge of length 1.
path make_edge(pair s) {
  real up_or_down = 1;  // does the cut go up or down?
  if ( unitrand()<0.5 ){
    up_or_down = -1;
  }
  pair bump_start = (0.40-0.1*(unitrand()-0.5),0.05*(unitrand()-0.5));
  pair bump_end = (0.60-0.1*(unitrand()-0.5),0.05*(unitrand()-0.5));
  pair bump_top = (0.5*(bump_start.x+bump_end.x)+0.05*(unitrand()-0.5),up_or_down*(0.20+0.02*(unitrand()-0.5)));
  pair bump_start_mid = (bump_start.x-0.05*(unitrand()-0.5), up_or_down*(0.8*abs(bump_top.y)+0.05*(unitrand()-0.5)));
  pair bump_end_mid = (bump_end.x+0.05*(unitrand()-0.5), up_or_down*(0.8*abs(bump_top.y)+0.05*(unitrand()-0.5)));
  dotfactor = 4;
  dot(pic,shift(s)*bump_start,green);
  dot(pic,shift(s)*bump_start_mid,blue);
  dot(pic,shift(s)*bump_top,black);
  dot(pic,shift(s)*bump_end_mid,blue);
  dot(pic,shift(s)*bump_end,green);
  
  path e = (0,0) .. // bump_start
    bump_start // .. bump_start_mid
    .. {E} bump_top // ..
	     // bump_end_mid
	     // .. bump_end 
    .. bump_end .. (1,0);
  return e;
  // draw(pic, shift*e, red);
}

// path p = make_edge((0,0))
//   .. shift((1,0))*make_edge((1,0))
//   .. shift((2,0))*make_edge((2,0))
//   .. shift((3,0))*make_edge((3,0));

path p = (0,0) .. (3,0.1) {up} .. (2.9,1) .. (4,1.1){right} .. (4.9,1) .. (5,0.1){down} .. (8,0); 
draw(pic, p, red);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

