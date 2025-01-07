// graphs.asy
//  Draw intro to graphs

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

string OUTPUT_FN = "problems%02d";


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





// ======================== crossword puzzle =============

int picnum = 0;
picture pic;
setdefaultgraphstyles();

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



int picnum = 1;
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

int picnum = 2;
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



int picnum = 3;
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



int picnum = 4;
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



int picnum = 5;
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



int picnum = 6;
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
int picnum = 7;
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
int picnum = 8;
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




int picnum = 9;
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
int picnum = 10;
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



int picnum = 11;
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
int picnum = 12;
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
int picnum = 13;
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



int picnum = 14;
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
int picnum = 15;
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



// =============== graph for counties =============
int picnum = 16;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

// label(pic,graphic("counties01.eps","height=1.25in"),(0,0));
// layer(pic);

// Grid to help locate nodes
// height of boxes
real u=2pt;
real v=u;

// int grid_entries = 20;  // number of grid entries
// for(int i=-1*grid_entries; i <= grid_entries; ++i) {
//   draw(pic,
//        (i*v,-1*grid_entries*u)--(i*v,grid_entries*u), linewidth(0.1pt)+red);
// }
// for(int j=-1*grid_entries; j <= grid_entries; ++j) {
//   draw(pic,
//        (-1*grid_entries*v,j*u)--(grid_entries*v,j*u), linewidth(0.1pt)+red);
// }
// // major lines
// for(int i=-1*4; i <= 4; ++i) {
//   draw(pic,
//        (i*v*5,-1*4*u*5)--(i*v*5,4*u*5), linewidth(0.2pt)+blue);
// }
// for(int j=-1*4; j <= 4; ++j) {
//   draw(pic,
//        (-1*4*v*5,j*u*5)--(4*v*5,j*u*5), linewidth(0.2pt)+blue);
// }
// // axes
//   draw(pic,
//        (0*v*5,-1*4*u*5)--(0*v*5,4*u*5), linewidth(0.2pt)+green);
//   draw(pic,
//        (-1*4*v*5,0*u*5)--(4*v*5,0*u*5), linewidth(0.2pt)+green);

node northumberland=ncircle("");   // Northumberland 0
northumberland.pos = (2*u, 18*v);
node cumbria=ncircle("");   // Cumbria 1
cumbria.pos = (-3*u, 12*v);
node tyne=ncircle("");  // Tyne & Wear 2
tyne.pos = (3*u, 15*v);
node durham=ncircle("");  // Durham 3
durham.pos = (2*u, 12*v);
node nyorkshire=ncircle("");  // North Yorkshire 4
nyorkshire.pos = (5*u, 10*v);
node lancashire=ncircle("");  // Lancashire 5
lancashire.pos = (-2*u, 7*v);
node wyorkshire=ncircle("");  // West Yorkshire 6
wyorkshire.pos = (3*u, 7*v);
node eyorkshire=ncircle("");  // East Riding of Yorkshire 7
eyorkshire.pos = (9*u, 8*v);
node merseyside=ncircle("");  // Merseyside 8
merseyside.pos = (-3*u, 4*v);
node manchester=ncircle("");  // Greater Manchester 9
manchester.pos = (0*u, 5*v);
node syorkshire=ncircle("");  // South Yorkshire 10
syorkshire.pos = (5*u, 5*v);
node cheshire=ncircle("");  // Cheshire 11
cheshire.pos = (-2*u, 2*v);
node derbyshire=ncircle("");  // Derbyshire 12
derbyshire.pos = (3*u, 3*v);
node nottinghamshire=ncircle("");  // Nottinghamshire 13
nottinghamshire.pos = (6*u, 2*v);
node lincolnshire=ncircle("");  // Lincolnshire 14
lincolnshire.pos = (10*u, 3*v);
node shropshire=ncircle("");  // Shropshire 15
shropshire.pos = (-2*u, -2*v);
node staffordshire=ncircle("");   // Staffordshire 16
staffordshire.pos = (1*u, 1*v);
node leicestershire=ncircle("");   // Leicestershire 17
leicestershire.pos = (5*u, -1*v);
node rutland=ncircle("");  // Rutland 18
rutland.pos = (8*u, -1*v);
node norfolk=ncircle("");  // Norfolk 19
norfolk.pos = (15*u, 0*v);
node herefordshire=ncircle("");  // Herefordshire 20
herefordshire.pos = (-3*u, -6*v);
node worcestershire=ncircle("");  // Worcestershire 21 
worcestershire.pos = (1*u, -5*v);
node wmidlands=ncircle("");  // West Midlands 22
wmidlands.pos = (1.5*u, -2.5*v);
node warwickshire=ncircle("");  // Warwickshire 23
warwickshire.pos = (4*u, -5*v);
node northamptonshire=ncircle("");  // Northamptonshire 24
northamptonshire.pos = (6*u, -3*v);
node cambridgeshire=ncircle("");  // Cambridgeshire 25
cambridgeshire.pos = (11*u, -4*v);
node suffolk=ncircle("");  // Suffolk 26
suffolk.pos = (15*u, -5*v);
node gloucestershire=ncircle("");  // Gloucestershire 27
gloucestershire.pos = (1*u, -8*v);
node oxfordshire=ncircle("");  // Oxfordshire 28
oxfordshire.pos = (4*u, -8*v);
node buckinghamshire=ncircle("");  // Buckinghamshire 29
buckinghamshire.pos = (6*u, -7*v);
node bedfordshire=ncircle("");  // Bedfordshire 30
bedfordshire.pos = (8*u, -5*v);
node hertfordshire=ncircle("");  // Hertfordshire 31
hertfordshire.pos = (9*u, -8*v);
node essex=ncircle("");  // Essex 32
essex.pos = (13*u, -8*v);
node bristol=ncircle("");   // Bristol 33
bristol.pos = (-1.5*u, -10*v);
node cornwall=ncircle("");   // Cornwall 34
cornwall.pos = (-12*u, -19*v);
node devon=ncircle("");  // Devon 35
devon.pos = (-7*u, -15*v);
node somerset=ncircle("");  // Somerset 36
somerset.pos = (-1.5*u, -13*v);
node dorset=ncircle("");  // Dorset 37
dorset.pos = (0*u, -15*v);
node wiltshire=ncircle("");  // Wiltshire 38
wiltshire.pos = (2*u, -11*v);
node hampshire=ncircle("");  // Hampshire 39
hampshire.pos = (4*u, -13*v);
node berkshire=ncircle("");  // Berkshire 40
berkshire.pos = (6*u, -10*v);
node surrey=ncircle("");  // Surrey 41
surrey.pos = (8*u, -12*v);
node wsussex=ncircle("");  // West Sussex 42
wsussex.pos = (8*u, -15*v);
node london=ncircle("");  // Greater London 43
london.pos = (10*u, -10*v);
node kent=ncircle("");  // Kent 44
kent.pos = (14*u, -11*v);
node esussex=ncircle("");  // East Sussex 45
esussex.pos = (13*u, -14*v);
node wight=ncircle("");  // Isle of Wight 46
wight.pos = (4*u, -16*v);

// calculate nodes position
// real u=1cm;
// real v=0.7*u;
// vlayout(1*v, nodes[0], nodes[1]);
// vlayout(-1*v, nodes[0], nodes[2]);
// hlayout(1*u, nodes[0], nodes[3]);

// draw edges
draw(pic,
     (northumberland--cumbria),
     (northumberland--tyne),
     (northumberland--durham),
     (cumbria--durham),
     (cumbria--nyorkshire),
     (cumbria--lancashire),
     (tyne--nyorkshire),
     (durham--nyorkshire),
     (nyorkshire--lancashire),
     (nyorkshire--wyorkshire),
     (nyorkshire--eyorkshire),
     (nyorkshire--syorkshire),
     (lancashire--wyorkshire),
     (lancashire--merseyside),
     (lancashire--manchester),
     (wyorkshire--manchester),
     (wyorkshire--syorkshire),
     (eyorkshire--lincolnshire),
     (merseyside--manchester),
     (merseyside--cheshire),
     (manchester--cheshire),
     (manchester--derbyshire),
     (syorkshire--derbyshire),
     (syorkshire--nottinghamshire),
     (syorkshire--lincolnshire),
     (cheshire--shropshire),
     (cheshire--staffordshire),
     (cheshire--derbyshire),
     (derbyshire--staffordshire),
     (derbyshire--leicestershire),
     (derbyshire--nottinghamshire),
     (nottinghamshire--leicestershire),
     (nottinghamshire--lincolnshire),
     (lincolnshire--leicestershire),
     (lincolnshire--rutland),
     (lincolnshire--cambridgeshire),
     (lincolnshire--norfolk),
     (shropshire--staffordshire),
     (shropshire--herefordshire),
     (shropshire--worcestershire),
     (shropshire--wmidlands),
     (staffordshire--wmidlands),
     (staffordshire--warwickshire),
     (staffordshire--leicestershire),
     (leicestershire--warwickshire),
     (leicestershire--northamptonshire),
     (leicestershire--rutland),
     (rutland--cambridgeshire),
     (norfolk--cambridgeshire),
     (norfolk--suffolk),
     (herefordshire--worcestershire),
     (herefordshire--gloucestershire),
     (worcestershire--gloucestershire),
     (worcestershire--warwickshire),
     (worcestershire--wmidlands),
     (wmidlands--warwickshire),
     (warwickshire--gloucestershire),
     (warwickshire--oxfordshire),
     (warwickshire--northamptonshire),
     (northamptonshire--oxfordshire),
     (northamptonshire--buckinghamshire),
     (northamptonshire--bedfordshire),
     (northamptonshire--cambridgeshire),
     (cambridgeshire--suffolk),
     (cambridgeshire--bedfordshire),
     (cambridgeshire--hertfordshire),
     (cambridgeshire--essex),
     (suffolk--essex),
     (gloucestershire--bristol),
     (gloucestershire--somerset),
     (gloucestershire--wiltshire),
     (gloucestershire--oxfordshire),
     (oxfordshire--wiltshire),
     (oxfordshire--berkshire),
     (oxfordshire--buckinghamshire),
     (buckinghamshire--berkshire),
     (buckinghamshire--london),
     (buckinghamshire--hertfordshire),
     (buckinghamshire--bedfordshire),
     (bedfordshire--hertfordshire),
     (hertfordshire--london),
     (hertfordshire--essex),
     (essex--london),
     (bristol--somerset),
     (cornwall--devon),
     (devon--somerset),
     (devon--dorset),
     (somerset--dorset),
     (somerset--wiltshire),
     (dorset--hampshire),
     (dorset--wiltshire),
     (wiltshire--hampshire),
     (wiltshire--berkshire),
     (hampshire--wsussex),
     (hampshire--surrey),
     (hampshire--wight),
     (hampshire--berkshire),
     (berkshire--surrey),
     (berkshire--london),
     (surrey--wsussex),
     (surrey--kent),
     (surrey--london),
     (wsussex--esussex),
     (london--kent),
     (kent--esussex)
     );

// draw nodes
draw(pic,
     northumberland,
     cumbria,
     tyne,
     durham,
     nyorkshire,
     lancashire,
     wyorkshire,
     eyorkshire,
     merseyside,
     manchester,
     syorkshire,
     cheshire,
     derbyshire,
     nottinghamshire,
     lincolnshire,
     shropshire,
     staffordshire,
     leicestershire,
     rutland,
     norfolk,
     herefordshire,
     worcestershire,
     wmidlands,
     warwickshire,
     northamptonshire,
     cambridgeshire,
     suffolk,
     gloucestershire,
     oxfordshire,
     buckinghamshire,
     bedfordshire,
     hertfordshire,
     essex,
     bristol,
     cornwall,
     devon,
     somerset,
     dorset,
     wiltshire,
     hampshire,
     berkshire,
     surrey,
     wsussex,
     london,
     kent,
     esussex,
     wight
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// =============== pyramid =============
int picnum = 17;
picture pic;
settings.render = 16; settings.prc = false;
import three;  // must set render, prc before importing three
unitsize(pic,1cm,0);

currentprojection=orthographic(10,5,2,up=Z);

// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple corner0 = (3/4)*(sqrt(8/9),0,-1/3);
triple corner1 = (3/4)*(-sqrt(2/9),sqrt(2/3),-1/3);
triple corner2 = (3/4)*(-sqrt(2/9),-sqrt(2/3),-1/3);
triple corner3 = (3/4)*(0,0,1);

// dot(pic,corner0,red);
// dot(pic,corner1,blue);
// dot(pic,corner2,green);
// dot(pic,corner3,black);
dotfactor=3; // default 6
dot(pic,corner0,boldcolor);
dot(pic,corner1,boldcolor);
dot(pic,corner2,boldcolor);
dot(pic,corner3,boldcolor);

path3 edge01 = corner0--corner1;
path3 edge02 = corner0--corner2;
path3 edge03 = corner0--corner3;
path3 edge12 = corner1--corner2;
path3 edge13 = corner1--corner3;
path3 edge23 = corner2--corner3;

// draw(pic,edge01,boldcolor);
draw(pic,edge02,boldcolor);
// draw(pic,edge03,boldcolor);
// draw(pic,edge12,boldcolor);
draw(pic,edge13,boldcolor);
// draw(pic,edge23,boldcolor);
draw(pic,corner2--corner3--corner0--corner1--corner2,DARKPEN+highlightcolor,nolight);

// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // X axis
// draw(pic,origin--2Z,black);  // X axis

real opacity_index=0.75;
draw(pic,surface(corner0--corner3--corner2--cycle),lightcolor+opacity(opacity_index),nolight);  // left front
draw(pic,surface(corner0--corner1--corner3--cycle),lightcolor+opacity(opacity_index),nolight);  // rt front
draw(pic,surface(corner1--corner2--corner3--cycle),lightcolor+opacity(opacity_index),nolight);  // back
draw(pic,surface(corner0--corner2--corner1--cycle),lightcolor+opacity(opacity_index),nolight);  // left front

shipout(format(OUTPUT_FN,picnum),pic,format="png");   // PNG! bugs in asy



// =============== cube =============
int picnum = 18;
picture pic;
settings.render = 16; settings.prc = false;
import three;  // must set render, prc before importing three
unitsize(pic,1cm,0);

currentprojection=orthographic(10,5,2,up=Z);

// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple cornertx = (1,0,1);
triple cornertf = (1,1,1);
triple cornerty = (0,1,1);
triple cornerto = (0,0,1);
triple cornerbx = (1,0,0);
triple cornerbf = (1,1,0);
triple cornerby = (0,1,0);
triple cornerbo = (0,0,0);

// dot(pic,cornertx,red);
// dot(pic,cornertf,blue);
// dot(pic,cornerty,green);
// dot(pic,cornerto,black);
// dot(pic,cornerbx,red);
// dot(pic,cornerbf,blue);
// dot(pic,cornerby,green);
// dot(pic,cornerbo,black);
dotfactor=3; // default 6
dot(pic,cornertx,boldcolor);
dot(pic,cornertf,boldcolor);
dot(pic,cornerty,boldcolor);
dot(pic,cornerto,boldcolor);
dot(pic,cornerbx,boldcolor);
dot(pic,cornerbf,boldcolor);
dot(pic,cornerby,boldcolor);
dot(pic,cornerbo,boldcolor);

path3 edgeboby = cornerbo--cornerby;
path3 edgebobx = cornerbo--cornerbx;
path3 edgebybf = cornerby--cornerbf;
path3 edgebxbf = cornerbx--cornerbf;
path3 edgeboto = cornerbo--cornerto;
path3 edgebyty = cornerby--cornerty;
path3 edgebxtx = cornerbx--cornertx;
path3 edgebftf = cornerbf--cornertf;
path3 edgetoty = cornerto--cornerty;
path3 edgetotx = cornerto--cornertx;
path3 edgetytf = cornerty--cornertf;
path3 edgetxtf = cornertx--cornertf;

draw(pic,edgeboby,boldcolor);
// draw(pic,edgebobx,boldcolor);
// draw(pic,edgebybf,boldcolor);
// draw(pic,edgebxbf,boldcolor);
// draw(pic,edgeboto,boldcolor);
// draw(pic,edgebyty,boldcolor);
draw(pic,edgebxtx,boldcolor);
draw(pic,edgebftf,boldcolor);
draw(pic,edgetoty,boldcolor);
// draw(pic,edgetotx,boldcolor);
// draw(pic,edgetytf,boldcolor);
// draw(pic,edgetxtf,boldcolor);
draw(pic,cornerbo--cornerbx--cornerbf--cornerby--cornerty--cornertf--cornertx--cornerto--cycle,DARKPEN+highlightcolor,nolight);

// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // X axis
// draw(pic,origin--2Z,black);  // X axis

real opacity_index=0.75;
draw(pic,surface(cornerto--cornertx--cornertf--cornerty--cycle),lightcolor+opacity(opacity_index),nolight);  // top
draw(pic,surface(cornerbo--cornerbx--cornertx--cornerto--cycle),lightcolor+opacity(opacity_index),nolight);  // xz plane
draw(pic,surface(cornerbo--cornerto--cornerty--cornerby--cycle),lightcolor+opacity(opacity_index),nolight);  // yz plane
draw(pic,surface(cornerby--cornerty--cornertf--cornerbf--cycle),lightcolor+opacity(opacity_index),nolight);  // right
draw(pic,surface(cornerbx--cornerbf--cornertf--cornertx--cycle),lightcolor+opacity(opacity_index),nolight);  // front/left
draw(pic,surface(cornerbo--cornerby--cornerbf--cornerbx--cycle),lightcolor+opacity(opacity_index),nolight);  // bot

shipout(format(OUTPUT_FN,picnum),pic,format="png");   // PNG! bugs in asy





// ========= octahedral graph ===========
// 
int picnum = 19;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{0}",
		      "\nodebox{1}",
		      "\nodebox{2}",
		      "\nodebox{3}",
		      "\nodebox{4}",
		      "\nodebox{5}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

vlayout(-3.0*v,nodes[0],nodes[1]);
nodes[2].pos = (0.5*u, (1/2)*(nodes[0].pos.y+nodes[1].pos.y));
nodes[3].pos = (1.0*u, 1.0*v);
vlayout(-1.0*v, nodes[3], nodes[4]);
hlayout(2.5*u, nodes[2], nodes[5]);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[5]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[4]--nodes[5])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ========= octahedral graph ===========
// 
int picnum = 20;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{0}",
		      "\nodebox{1}",
		      "\nodebox{2}",
		      "\nodebox{3}",
		      "\nodebox{4}",
		      "\nodebox{5}",
		      "\nodebox{6}",
		      "\nodebox{7}",
		      "\nodebox{8}",
		      "\nodebox{9}",
		      "\nodebox{10}",
		      "\nodebox{11}"
		      );

// calculate nodes position
real u=0.9cm;
real v=0.7*u;

real fan_angle = 45.0;
vlayout(1.0*v, nodes[0], nodes[1]);
vlayout(1.9*v, nodes[1], nodes[6]);
nodes[2].pos = new_node_pos(nodes[1], -140, -1.0*v);
nodes[3].pos = new_node_pos(nodes[1], -110, -1.0*v);
nodes[4].pos = new_node_pos(nodes[1], -70,  -1.0*v);
nodes[5].pos = new_node_pos(nodes[1], -40,  -1.0*v);
nodes[7].pos = new_node_pos(nodes[6], -140, -0.5*v);
nodes[8].pos = new_node_pos(nodes[6],  -40, -0.5*v);
nodes[9].pos = new_node_pos(nodes[6],  -90, -1.15*v);
nodes[10].pos = new_node_pos(nodes[0], -90+(-1*fan_angle), -4.75*v);
nodes[11].pos = new_node_pos(nodes[0], -90+fan_angle, -4.75*v);

// draw edges
draw(pic,
     (nodes[0]--nodes[10]),
     (nodes[0]--nodes[11]),
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[3]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[5]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[7]),
     (nodes[2]--nodes[10]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[6]),
     (nodes[3]--nodes[7]),
     (nodes[4]--nodes[5]),
     (nodes[4]--nodes[6]),
     (nodes[4]--nodes[8]),
     (nodes[5]--nodes[8]),
     (nodes[5]--nodes[11]),
     (nodes[6]--nodes[7]),
     (nodes[6]--nodes[8]),
     (nodes[6]--nodes[9]),
     (nodes[7]--nodes[9]),
     (nodes[7]--nodes[10]),
     (nodes[8]--nodes[9]),
     (nodes[8]--nodes[11]),
     (nodes[9]--nodes[10]),
     (nodes[9]--nodes[11]),
     (nodes[10]--nodes[11])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5],
     nodes[6], nodes[7], nodes[8], nodes[9], nodes[10], nodes[11]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ========= map that requires four colors ===========
// 
int picnum = 21;
picture pic;
unitsize(pic,0.5cm);

path insidecircle, outsidecircle;
insidecircle = circle((0,0),0.8);
outsidecircle = circle((0,0),2);

// Times on the circles
real t0=0;
real t1=4/3;
real t2=8/3;
// Points associated with those times
pair pti0=point(insidecircle,t0);
pair pto0=point(outsidecircle,t0);
pair pti1=point(insidecircle,t1);
pair pto1=point(outsidecircle,t1);
pair pti2=point(insidecircle,t2);
pair pto2=point(outsidecircle,t2);

draw(pic,pti0--pto0,MAINPEN);
draw(pic,pti1--pto1,MAINPEN);
draw(pic,pti2--pto2,MAINPEN);
draw(pic,insidecircle,MAINPEN);
draw(pic,outsidecircle,MAINPEN);

label(pic,"$B$",midpoint(point(insidecircle,(t0+t1)/2)--point(outsidecircle,(t0+t1)/2)));
label(pic,"$A$",midpoint(point(insidecircle,(t1+t2)/2)--point(outsidecircle,(t1+t2)/2)));
label(pic,"$C$",midpoint(point(insidecircle,t2+(t0+t1)/2)--point(outsidecircle,t2+(t0+t1)/2)));
label(pic,"$D$",(0,0));

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= map that would require five colors ===========
// 
int picnum = 22;
picture pic;
unitsize(pic,1.0cm);

real ht=1.5,
  wd=4;
real small_country_radius = 0.8*min(ht/4,wd/10);
path countryA0 = (0,0)--(wd,0)--(wd,ht)--(0,ht)--cycle;
path countryB0 = circle((wd/5,ht/2),small_country_radius);
path countryC0 = circle((2*wd/5,ht/2),small_country_radius);
path countryD0 = circle((3*wd/5,ht/2),small_country_radius);
path countryE0 = circle((4*wd/5,ht/2),small_country_radius);

draw(pic,countryA0,MAINPEN);
draw(pic,countryB0,MAINPEN);
draw(pic,countryC0,MAINPEN);
draw(pic,countryD0,MAINPEN);
draw(pic,countryE0,MAINPEN);
label(pic,"$A$",(0.05wd,0.9ht));
label(pic,"$B$",(wd/5,ht/2));
label(pic,"$C$",(2*wd/5,ht/2));
label(pic,"$D$",(3*wd/5,ht/2));
label(pic,"$E$",(4*wd/5,ht/2));

// Draw them again, with B and A interchanged, and shifted
path countryB1 = (0,0)--(wd,0)--(wd,ht)--(0,ht)--cycle;
path countryA1 = circle((wd/5,ht/2),small_country_radius);
path countryC1 = circle((2*wd/5,ht/2),small_country_radius);
path countryD1 = circle((3*wd/5,ht/2),small_country_radius);
path countryE1 = circle((4*wd/5,ht/2),small_country_radius);

draw(pic,shift(wd,0)*countryB1,MAINPEN);
draw(pic,shift(wd,0)*countryA1,MAINPEN);
draw(pic,shift(wd,0)*countryC1,MAINPEN);
draw(pic,shift(wd,0)*countryD1,MAINPEN);
draw(pic,shift(wd,0)*countryE1,MAINPEN);
label(pic,"$B$",shift(wd,0)*(0.05wd,0.9ht));
label(pic,"$A$",shift(wd,0)*(wd/5,ht/2));
label(pic,"$C$",shift(wd,0)*(2*wd/5,ht/2));
label(pic,"$D$",shift(wd,0)*(3*wd/5,ht/2));
label(pic,"$E$",shift(wd,0)*(4*wd/5,ht/2));

// Draw them again, with C and A interchanged, and shifted
path countryC2 = (0,0)--(wd,0)--(wd,ht)--(0,ht)--cycle;
path countryB2 = circle((wd/5,ht/2),small_country_radius);
path countryA2 = circle((2*wd/5,ht/2),small_country_radius);
path countryD2 = circle((3*wd/5,ht/2),small_country_radius);
path countryE2 = circle((4*wd/5,ht/2),small_country_radius);

draw(pic,shift(2*wd,0)*countryC2,MAINPEN);
draw(pic,shift(2*wd,0)*countryB2,MAINPEN);
draw(pic,shift(2*wd,0)*countryA2,MAINPEN);
draw(pic,shift(2*wd,0)*countryD2,MAINPEN);
draw(pic,shift(2*wd,0)*countryE2,MAINPEN);
label(pic,"$C$",shift(2*wd,0)*(0.05wd,0.9ht));
label(pic,"$B$",shift(2*wd,0)*(wd/5,ht/2));
label(pic,"$A$",shift(2*wd,0)*(2*wd/5,ht/2));
label(pic,"$D$",shift(2*wd,0)*(3*wd/5,ht/2));
label(pic,"$E$",shift(2*wd,0)*(4*wd/5,ht/2));

// Draw them again, with D and A interchanged, and shifted
path countryD3 = (0,0)--(wd,0)--(wd,ht)--(0,ht)--cycle;
path countryB3 = circle((wd/5,ht/2),small_country_radius);
path countryC3 = circle((2*wd/5,ht/2),small_country_radius);
path countryA3 = circle((3*wd/5,ht/2),small_country_radius);
path countryE3 = circle((4*wd/5,ht/2),small_country_radius);

draw(pic,shift(0.5*wd,-ht)*countryD3,MAINPEN);
draw(pic,shift(0.5*wd,-ht)*countryB3,MAINPEN);
draw(pic,shift(0.5*wd,-ht)*countryC3,MAINPEN);
draw(pic,shift(0.5*wd,-ht)*countryA3,MAINPEN);
draw(pic,shift(0.5*wd,-ht)*countryE3,MAINPEN);
label(pic,"$D$",shift(0.5*wd,-ht)*(0.05wd,0.9ht));
label(pic,"$B$",shift(0.5*wd,-ht)*(wd/5,ht/2));
label(pic,"$C$",shift(0.5*wd,-ht)*(2*wd/5,ht/2));
label(pic,"$A$",shift(0.5*wd,-ht)*(3*wd/5,ht/2));
label(pic,"$E$",shift(0.5*wd,-ht)*(4*wd/5,ht/2));

// Draw them again, with E and A interchanged, and shifted
path countryE4 = (0,0)--(wd,0)--(wd,ht)--(0,ht)--cycle;
path countryB4 = circle((wd/5,ht/2),small_country_radius);
path countryC4 = circle((2*wd/5,ht/2),small_country_radius);
path countryD4 = circle((3*wd/5,ht/2),small_country_radius);
path countryA4 = circle((4*wd/5,ht/2),small_country_radius);

draw(pic,shift(1.5*wd,-ht)*countryE4,MAINPEN);
draw(pic,shift(1.5*wd,-ht)*countryB4,MAINPEN);
draw(pic,shift(1.5*wd,-ht)*countryC4,MAINPEN);
draw(pic,shift(1.5*wd,-ht)*countryD4,MAINPEN);
draw(pic,shift(1.5*wd,-ht)*countryA4,MAINPEN);
label(pic,"$E$",shift(1.5*wd,-ht)*(0.05wd,0.9ht));
label(pic,"$B$",shift(1.5*wd,-ht)*(wd/5,ht/2));
label(pic,"$C$",shift(1.5*wd,-ht)*(2*wd/5,ht/2));
label(pic,"$D$",shift(1.5*wd,-ht)*(3*wd/5,ht/2));
label(pic,"$A$",shift(1.5*wd,-ht)*(4*wd/5,ht/2));


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============== 3 color <= SAT =============

int picnum = 23;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{$v_0$}"),
  v1=ncircle("\nodebox{$v_1$}"),
  v2=ncircle("\nodebox{$v_2$}"),
v3=ncircle("\nodebox{$v_3$}");

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

hlayout(1.0*u, v0, v1, v2);
// layout(135.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
// layout(-135.0, v0, v2);
// hlayout(-1.0*u, v2, v3);
// layout(45.0, v0, v4);
// layout(-45.0, v0, v5);
// layout(-60.0, v5, v6);
v3.pos = new_node_pos_h(v0, -40, 1*u);
// v8.pos = new_node_pos_h(v4, -30, 1*u);
// hlayout(1.0*u, v5, v9);
// hlayout(1*u, v8, v10);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v3),
     (v1--v2),
     (v1--v3)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Kevin Bacon =============

int picnum = 24;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node kevinbacon=nbox("\scriptsize Kevin Bacon",ns_noborder),
  edasner=nbox("\scriptsize Ed Asner",ns_noborder),
  elvispresley=nbox("\scriptsize Elvis Presley",ns_noborder),
  merylstreep=nbox("\scriptsize Meryl Streep",ns_noborder),
  alecbaldwin=nbox("\scriptsize Alec Baldwin",ns_noborder),
  johnkennedy=nbox("\scriptsize John Kennedy",ns_noborder),
  andiemacdowell=nbox("\scriptsize Andie MacDowell",ns_noborder),
  jayosanders=nbox("\scriptsize Jay O Sanders",ns_noborder),
taraoreilley=nbox("\scriptsize Tara O'Reilley",ns_noborder), // Tara Ariella O'Reilley
  jimhefferon=nbox("\scriptsize Jim Hef{}feron",ns_noborder);

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

hlayout(4.0*u, kevinbacon, alecbaldwin);
layout(280.0, 1.5*v, alecbaldwin, johnkennedy);
layout(165.0, 2.0*u, kevinbacon, edasner, elvispresley);
layout(35.0, 2.0*v, kevinbacon, merylstreep);
layout(310.0, 1.5*u, kevinbacon, andiemacdowell);
layout(190.0, 2.0*u, kevinbacon, jayosanders);
layout(190.0, 2.5*u, jayosanders, taraoreilley);
vlayout(0.85*v, taraoreilley, jimhefferon);

// draw edges
draw(pic,
     (kevinbacon--edasner).l("\tiny JFK"),
     (edasner--elvispresley).l(Label("\tiny \hspace*{2em} Change of Habit",Relative(0.15))),
     (kevinbacon--merylstreep).l(Label("\tiny \hspace*{1em}The River Wild",Relative(0.75))),
     (kevinbacon--alecbaldwin).l("\tiny She's Having a Baby"),
     (alecbaldwin--johnkennedy).l("\tiny Cats \& Dogs"),
     (kevinbacon--andiemacdowell).l("\tiny Beauty Shop"),
     (kevinbacon--jayosanders).l("\tiny JFK"),
     (jayosanders--taraoreilley).l(Label("\tiny \hspace*{3.5em}Northern Borders",Relative(0.15))).style("leftside"),
     (taraoreilley--jimhefferon).l("\tiny Shout It Out!").style("leftside")
);

// draw nodes, after edges
draw(pic,
     kevinbacon,
     edasner, elvispresley,
     merylstreep,
     alecbaldwin,johnkennedy,
     andiemacdowell,
     jayosanders, taraoreilley, jimhefferon);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============== Constellations =============

int picnum = 25;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

// calculate nodes position
real u=28.0cm;
real v=u;
defaultlayoutskip=u;

// declination_to_radius  convert star location to polar coord radius
real declination_to_radius(real dec, real decmins, real decsecs) {
  real d = dec + (decmins/60) + (decsecs/(60*60));
  return (90-d)/180; }

real PI = 3.14159265359;
// ra_to_theta  convert star right ascension to polar coord angle
real ra_to_theta(real hrs, real ramins, real rasecs) {
  return ( (hrs/24)+(ramins/(24*60))+(rasecs/(24*60*60)) )*2*PI; }

real ROTATION_ANGLE = 30;
pair star_to_rectangular(real hrs, real ramins, real rasecs, real dec, real decmins, real decsecs) {
  real theta = ra_to_theta(hrs, ramins, rasecs);
  real r = declination_to_radius(dec, decmins, decsecs);
  real x = r*cos(theta);
  real y = r*sin(theta);
  return rotate(ROTATION_ANGLE)*(x*u, y*v);
}

node ursaminoralpha=ncircle("\tiny $\alpha$");
node ursaminorbeta=ncircle("\tiny $\beta$");
node ursaminorgamma=ncircle("\tiny $\gamma$");
node ursaminordelta=ncircle("\tiny $\delta$");
node ursaminorepsilon=ncircle("\tiny $\epsilon$");
node ursaminoreta=ncircle("\tiny $\eta$");
node ursaminorzeta=ncircle("\tiny $\zeta$");
node dracoalpha=ncircle("\tiny $\alpha$",ns_light);
node dracobeta=ncircle("\tiny $\beta$",ns_light);
node dracodelta=ncircle("\tiny $\delta$",ns_light);
node dracogamma=ncircle("\tiny $\gamma$",ns_light);
node dracoepsilon=ncircle("\tiny $\epsilon$",ns_light);
node dracozeta=ncircle("\tiny $\zeta$",ns_light);
node dracoeta=ncircle("\tiny $\eta$",ns_light);
// node dracotheta=ncircle("\tiny $\theta$",ns_light);
node dracoiota=ncircle("\tiny $\iota$",ns_light);
node dracokappa=ncircle("\tiny $\kappa$",ns_light);
node dracolambda=ncircle("\tiny $\lambda$",ns_light);
node dracoxi=ncircle("\tiny $\xi$",ns_light);
node dracochi=ncircle("\tiny $\chi$",ns_light);


ursaminoralpha.pos = star_to_rectangular(2, 31, 48.7, 89, 15, 51);
ursaminorbeta.pos = star_to_rectangular(14, 50, 42.3, 74, 9, 20);
ursaminorgamma.pos = star_to_rectangular(15, 20, 43.3, 71, 50, 2);
ursaminordelta.pos = star_to_rectangular(17, 32, 12.9, 86, 35, 11);
ursaminorepsilon.pos = star_to_rectangular(16, 45, 58.2, 82, 2, 14);
ursaminoreta.pos = star_to_rectangular(16, 17, 30.3, 75, 45, 19.1);
ursaminorzeta.pos = star_to_rectangular(15, 44, 3.5, 77, 47, 40.1);
dracoalpha.pos = star_to_rectangular(14, 4, 23, 64, 22, 33);
dracobeta.pos = star_to_rectangular(17, 30, 26, 52, 18, 5);
dracodelta.pos = star_to_rectangular(19, 12, 33, 67, 39, 41);
dracogamma.pos = star_to_rectangular(17, 56, 36, 51, 29, 20);
dracoepsilon.pos = star_to_rectangular(19, 48, 10, 70, 16, 4);
dracozeta.pos = star_to_rectangular(17, 8, 47, 65, 42, 53);
dracoeta.pos = star_to_rectangular(16, 23, 59, 61, 30, 50);
// dracotheta.pos = star_to_rectangular(, , , , , );
dracoiota.pos = star_to_rectangular(15, 24, 56, 58, 57, 58);
dracokappa.pos = star_to_rectangular(12, 33, 29, 69, 47, 17);
dracolambda.pos = star_to_rectangular(11, 31, 24, 69, 19, 52);
dracoxi.pos = star_to_rectangular(17, 53, 32, 56, 52, 21);
dracochi.pos = star_to_rectangular(18, 21, 3, 72, 43, 58);

// draw edges
draw(pic,
     (ursaminoralpha--ursaminordelta),
     (ursaminordelta--ursaminorepsilon),
     (ursaminorepsilon--ursaminorzeta),
     (ursaminorzeta--ursaminorbeta),
     (ursaminorzeta--ursaminoreta), 
     (ursaminoreta--ursaminorgamma),
     (ursaminorgamma--ursaminorbeta),
     (dracobeta--dracogamma),
     (dracobeta--dracoxi),
     (dracogamma--dracoxi),
     (dracoxi--dracodelta),
     (dracodelta--dracoepsilon),
     (dracoepsilon--dracochi),
     (dracochi--dracozeta),
     (dracozeta--dracoeta),
     (dracoeta--dracoiota),
     (dracoiota--dracoalpha),
     (dracoalpha--dracokappa),
     (dracokappa--dracolambda)
);

// draw nodes, after edges
draw(pic,
     ursaminoralpha,
     ursaminorbeta,
     ursaminorgamma,
     ursaminordelta,
     ursaminorepsilon,
     ursaminoreta,
     ursaminorzeta,
     dracoalpha,
     dracobeta,
     dracodelta,
     dracogamma,
     dracoepsilon,
     dracozeta,
     dracoeta,
     dracoiota,
     dracokappa,
     dracolambda,
     dracoxi,
     dracochi
  );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............. constellations smaller ..........
int picnum = 26;
picture pic;
size(pic,1.5inch,0);
// setdefaultgraphstyles();
// defaultlayoutrel = false;

// calculate nodes position
real u=0.5cm;
real v=u;
// defaultlayoutskip=u;

// declination_to_radius  convert star location to polar coord radius
// real declination_to_radius(real dec, real decmins, real decsecs) {
//   real d = dec + (decmins/60) + (decsecs/(60*60));
//   return (90-d)/180; }

// real PI = 3.14159265359;
// // ra_to_theta  convert star right ascension to polar coord angle
// real ra_to_theta(real hrs, real ramins, real rasecs) {
//   return ( (hrs/24)+(ramins/(24*60))+(rasecs/(24*60*60)) )*2*PI; }

// real ROTATION_ANGLE = 30;
// pair star_to_rectangular(real hrs, real ramins, real rasecs, real dec, real decmins, real decsecs) {
//   real theta = ra_to_theta(hrs, ramins, rasecs);
//   real r = declination_to_radius(dec, decmins, decsecs);
//   real x = r*cos(theta);
//   real y = r*sin(theta);
//   return rotate(ROTATION_ANGLE)*(x*u, y*v);
// }

// node ursaminoralpha=ncircle("\tiny $\alpha$");
// node ursaminorbeta=ncircle("\tiny $\beta$");
// node ursaminorgamma=ncircle("\tiny $\gamma$");
// node ursaminordelta=ncircle("\tiny $\delta$");
// node ursaminorepsilon=ncircle("\tiny $\epsilon$");
// node ursaminoreta=ncircle("\tiny $\eta$");
// node ursaminorzeta=ncircle("\tiny $\zeta$");
// node dracoalpha=ncircle("\tiny $\alpha$",ns_light);
// node dracobeta=ncircle("\tiny $\beta$",ns_light);
// node dracodelta=ncircle("\tiny $\delta$",ns_light);
// node dracogamma=ncircle("\tiny $\gamma$",ns_light);
// node dracoepsilon=ncircle("\tiny $\epsilon$",ns_light);
// node dracozeta=ncircle("\tiny $\zeta$",ns_light);
// node dracoeta=ncircle("\tiny $\eta$",ns_light);
// // node dracotheta=ncircle("\tiny $\theta$",ns_light);
// node dracoiota=ncircle("\tiny $\iota$",ns_light);
// node dracokappa=ncircle("\tiny $\kappa$",ns_light);
// node dracolambda=ncircle("\tiny $\lambda$",ns_light);
// node dracoxi=ncircle("\tiny $\xi$",ns_light);
// node dracochi=ncircle("\tiny $\chi$",ns_light);


pair ursaminoralpha = star_to_rectangular(2, 31, 48.7, 89, 15, 51);
pair ursaminorbeta = star_to_rectangular(14, 50, 42.3, 74, 9, 20);
pair ursaminorgamma = star_to_rectangular(15, 20, 43.3, 71, 50, 2);
pair ursaminordelta = star_to_rectangular(17, 32, 12.9, 86, 35, 11);
pair ursaminorepsilon = star_to_rectangular(16, 45, 58.2, 82, 2, 14);
pair ursaminoreta = star_to_rectangular(16, 17, 30.3, 75, 45, 19.1);
pair ursaminorzeta = star_to_rectangular(15, 44, 3.5, 77, 47, 40.1);
pair dracoalpha = star_to_rectangular(14, 4, 23, 64, 22, 33);
pair dracobeta = star_to_rectangular(17, 30, 26, 52, 18, 5);
pair dracodelta = star_to_rectangular(19, 12, 33, 67, 39, 41);
pair dracogamma = star_to_rectangular(17, 56, 36, 51, 29, 20);
pair dracoepsilon = star_to_rectangular(19, 48, 10, 70, 16, 4);
pair dracozeta = star_to_rectangular(17, 8, 47, 65, 42, 53);
pair dracoeta = star_to_rectangular(16, 23, 59, 61, 30, 50);
// dracotheta.pos = star_to_rectangular(, , , , , );
pair dracoiota = star_to_rectangular(15, 24, 56, 58, 57, 58);
pair dracokappa = star_to_rectangular(12, 33, 29, 69, 47, 17);
pair dracolambda = star_to_rectangular(11, 31, 24, 69, 19, 52);
pair dracoxi = star_to_rectangular(17, 53, 32, 56, 52, 21);
pair dracochi = star_to_rectangular(18, 21, 3, 72, 43, 58);

// draw edges
pen constpen=LIGHTPEN+backgroundcolor;
draw(pic,ursaminoralpha--ursaminordelta,constpen);
draw(pic,ursaminordelta--ursaminorepsilon,constpen);
draw(pic,ursaminorepsilon--ursaminorzeta,constpen);
draw(pic,ursaminorzeta--ursaminorbeta,constpen);
draw(pic,ursaminorzeta--ursaminoreta,constpen); 
draw(pic,ursaminoreta--ursaminorgamma,constpen);
draw(pic,ursaminorgamma--ursaminorbeta,constpen);
pen constpen=LIGHTPEN+lightcolor;
draw(pic,dracobeta--dracogamma,constpen);
draw(pic,dracobeta--dracoxi,constpen);
draw(pic,dracogamma--dracoxi,constpen);
draw(pic,dracoxi--dracodelta,constpen);
draw(pic,dracodelta--dracoepsilon,constpen);
draw(pic,dracoepsilon--dracochi,constpen);
draw(pic,dracochi--dracozeta,constpen);
draw(pic,dracozeta--dracoeta,constpen);
draw(pic,dracoeta--dracoiota,constpen);
draw(pic,dracoiota--dracoalpha,constpen);
draw(pic,dracoalpha--dracokappa,constpen);
draw(pic,dracokappa--dracolambda,constpen);

// draw nodes, after edges
dot(pic,ursaminoralpha);
dot(pic,ursaminorbeta);
dot(pic,ursaminorgamma);
dot(pic,ursaminordelta);
dot(pic,ursaminorepsilon);
dot(pic,ursaminoreta);
dot(pic,ursaminorzeta);
dot(pic,dracoalpha);
dot(pic,dracobeta);
dot(pic,dracodelta);
dot(pic,dracogamma);
dot(pic,dracoepsilon);
dot(pic,dracozeta);
dot(pic,dracoeta);
dot(pic,dracoiota);
dot(pic,dracokappa);
dot(pic,dracolambda);
dot(pic,dracoxi);
dot(pic,dracochi);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============== Interlocking directorships =============

int picnum = 27;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node fordmotor=nbox("\scriptsize Ford Motor",ns_noborder),
  jpmorgan=nbox("\scriptsize JP Morgan",ns_noborder),
  caterpillar=nbox("\scriptsize Caterpillar",ns_noborder),
  att=nbox("\scriptsize AT\&T",ns_noborder),
  texasinstruments=nbox("\scriptsize Texas Instruments",ns_noborder),
  citigroup=nbox("\scriptsize Citigroup",ns_noborder),
  haliburton=nbox("\scriptsize Haliburton",ns_noborder),
  georgiapacific=nbox("\scriptsize Georgia Pacific",ns_noborder),
  aig=nbox("\scriptsize AIG",ns_noborder);

// calculate nodes position
real u=2cm;
real v=0.8*u;
defaultlayoutskip=u;

layout(30.0, 1*v, fordmotor, jpmorgan);
hlayout(1*u, jpmorgan, caterpillar, att, texasinstruments);
hlayout(4.5*u, fordmotor, citigroup);
layout(-30.0, 1*v, fordmotor, aig);
hlayout(1*u, aig, georgiapacific, haliburton);

// draw edges
draw(pic,
     (fordmotor--citigroup),
     (jpmorgan--aig),
     (caterpillar..bend(20)..texasinstruments),
     (caterpillar--georgiapacific),
     (att--citigroup),
     (att--haliburton),
     (citigroup--haliburton)
);

// draw nodes, after edges
draw(pic,
     fordmotor,
     jpmorgan, caterpillar, att, texasinstruments, 
     citigroup,
     haliburton, georgiapacific, aig);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======================== Shortest path =============
//  From http://www.cs.princeton.edu/courses/archive/spring10/cos226/exercises/sp.html
int picnum = 28;
picture pic;
setdefaultgraphstyles();
  defaultdrawstyle=directededgestyle;

defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{A}",
  "\nodebox{B}",
  "\nodebox{C}",
  "\nodebox{D}");
node q0 = ncircle("$q_0$");  // a
node q1 = ncircle("$q_1$");  // b
node q2 = ncircle("$q_2$");  // c
node q3 = ncircle("$q_3$");  // d
node q4 = ncircle("$q_4$");  // e
node q5 = ncircle("$q_5$");  // f
node q6 = ncircle("$q_6$");  // g
node q7 = ncircle("$q_7$");  // h
node q8 = ncircle("$q_8$");  // i


// calculate nodes position
real u=1.25cm;
real v=0.7*u;
q1.pos = new_node_pos_h(q0, 45, 1*u);
hlayout(1*u, q0, q2);
q3.pos = new_node_pos_h(q0, -45, 1*u);
q4.pos = new_node_pos_h(q2, -20, 1*u);
hlayout(1.5*u, q4, q5);
q6.pos = new_node_pos_h(q4, 45, 0.75*u);
hlayout(3.5*u, q1, q7);
hlayout(3.5*u, q3, q8);

// draw edges
draw(pic,
     (q0--q1).l("$15$").style("leftside"),
     (q0--q2).l("$13$"),
     (q0--q3).l("$5$"),
     (q1--q7).l("$12$").style("leftside"),
     (q2--q1).l("$2$").style("leftside"),
     (q2--q3).l("$18$").style("leftside"),
     (q2--q6).l("$6$").style("leftside"),
     (q3--q4).l("$4$"),
     (q3--q8).l("$24$"),
     (q4--q2).l("$3$").style("leftside"),
     (q4--q5).l(Label("$9$",Relative(0.35))).style("leftside"),
     (q4--q6).l(Label("$1$",Relative(0.25))).style("leftside"),
     (q4--q8).l("$14$"),
     (q5--q6).l("$16$").style("leftside"),
     (q5--q7).l("$7$").style("leftside"),
     (q5--q8).l("$10$").style("leftside"),
     (q6--q1).l("$8$"),
     (q6--q7).l("$17$").style("leftside"),
     (q8--q7).l("$11$")
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5, q6, q7, q8);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========== Vertex cover, ind path ================
picture pic;
int picnum = 29;
setdefaultgraphstyles();

// define nodes
node q0=ncircle("$v_0$");
node q1=ncircle("$v_1$");
node q2=ncircle("$v_2$");
node q3=ncircle("$v_3$");
node q4=ncircle("$v_4$");
node q5=ncircle("$v_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.0cm;
real u = defaultlayoutskip;
real v = 0.8*u;

hlayout(1*u, q0, q1, q2);
vlayout(1*v, q0, q3);
hlayout(1*u, q3, q4, q5);

// draw edges
draw(pic,
     (q0--q1),
     (q0--q3),
     (q1--q2),
     (q1--q3),
     (q1--q4),
     (q1--q5)
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ....................................
picture pic;
int picnum = 30;
setdefaultgraphstyles();

// define nodes
node q0=ncircle("$v_0$");
node q1=ncircle("$v_1$");
node q2=ncircle("$v_2$");
node q3=ncircle("$v_3$");
node q4=ncircle("$v_4$");
node q5=ncircle("$v_5$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.0cm;
real u = defaultlayoutskip;
real v = 0.8*u;

hlayout(1*u, q0, q1, q2, q3);
vlayout(1*v, q0, q4);
hlayout(1*u, q4, q5);

// draw edges
draw(pic,
     (q0--q1),
     (q0--q4),
     (q1--q2),
     (q1--q4),
     (q2--q3),
     (q2--q5),
     (q4--q5)
);

// draw nodes
draw(pic,
     q0, q1, q2, q3, q4, q5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


real platonichgt = 1.5cm;  // make them all the same height
// =============== pyramid =============
int picnum = 31;
picture pic;
settings.render = 0; settings.prc = false;
import three;  // must set render, prc before importing three
size(pic,0,platonichgt);

currentprojection=orthographic(10,5,2,up=Z);

// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple corner0 = (3/4)*(sqrt(8/9),0,-1/3);
triple corner1 = (3/4)*(-sqrt(2/9),sqrt(2/3),-1/3);
triple corner2 = (3/4)*(-sqrt(2/9),-sqrt(2/3),-1/3);
triple corner3 = (3/4)*(0,0,1);

// For composing picture
// label(pic,"\tiny $0$",corner0,E);
// label(pic,"\tiny $1$",corner1,E);
// label(pic,"\tiny $2$",corner2,E);
// label(pic,"\tiny $3$",corner3,E);

// dot(pic,corner0,red);
// dot(pic,corner1,blue);
// dot(pic,corner2,green);
// dot(pic,corner3,black);
dotfactor=3; // default 6
dot(pic,corner0,boldcolor);
dot(pic,corner1,boldcolor);
dot(pic,corner2,boldcolor);
dot(pic,corner3,boldcolor);

path3 edge01 = corner0--corner1;
path3 edge02 = corner0--corner2;
path3 edge03 = corner0--corner3;
path3 edge12 = corner1--corner2;
path3 edge13 = corner1--corner3;
path3 edge23 = corner2--corner3;

// Draw edges
draw(pic,edge01,boldcolor);
draw(pic,edge02,boldcolor);
draw(pic,edge03,boldcolor);
draw(pic,edge12,boldcolor);
draw(pic,edge13,boldcolor);
draw(pic,edge23,boldcolor);

// Entire Hamiltonian path
draw(pic,corner2--corner3--corner0--corner1--corner2,DARKPEN+highlightcolor,nolight);

// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // X axis
// draw(pic,origin--2Z,black);  // X axis

real opacity_index=0.5;
draw(pic,surface(corner0--corner3--corner2--cycle),lightcolor+opacity(opacity_index),nolight);  // left front
draw(pic,surface(corner0--corner1--corner3--cycle),lightcolor+opacity(opacity_index),nolight);  // rt front
draw(pic,surface(corner1--corner2--corner3--cycle),lightcolor+opacity(opacity_index),nolight);  // back
draw(pic,surface(corner0--corner2--corner1--cycle),lightcolor+opacity(opacity_index),nolight);  // left front

// Edges in front
draw(pic,edge02,boldcolor);
draw(pic,edge13,boldcolor);

// Ham path in front
draw(pic,corner2--corner3--corner0--corner1,DARKPEN+highlightcolor,nolight);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");   



// =============== cube =============
int picnum = 32;
picture pic;
settings.render = 0;
settings.prc = false;
import three;  // must set render, prc before importing three
size(pic,0,platonichgt);

currentprojection=orthographic(10,5,2,up=Z);

// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple cornertx = (1,0,1);
triple cornertf = (1,1,1);
triple cornerty = (0,1,1);
triple cornerto = (0,0,1);
triple cornerbx = (1,0,0);
triple cornerbf = (1,1,0);
triple cornerby = (0,1,0);
triple cornerbo = (0,0,0);

// For composing the picture
// label(pic,"\tiny tx",cornertx);
// label(pic,"\tiny tf",cornertf);
// label(pic,"\tiny ty",cornerty);
// label(pic,"\tiny to",cornerto);
// label(pic,"\tiny bx",cornerbx);
// label(pic,"\tiny bf",cornerbf);
// label(pic,"\tiny by",cornerby);
// label(pic,"\tiny bo",cornerbo);
// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // X axis
// draw(pic,origin--2Z,black);  // X axis

// dot(pic,cornertx,red);
// dot(pic,cornertf,blue);
// dot(pic,cornerty,green);
// dot(pic,cornerto,black);
// dot(pic,cornerbx,red);
// dot(pic,cornerbf,blue);
// dot(pic,cornerby,green);
// dot(pic,cornerbo,black);
dotfactor=3; // default 6
dot(pic,cornertx,boldcolor);
dot(pic,cornertf,boldcolor);
dot(pic,cornerty,boldcolor);
dot(pic,cornerto,boldcolor);
dot(pic,cornerbx,boldcolor);
dot(pic,cornerbf,boldcolor);
dot(pic,cornerby,boldcolor);
dot(pic,cornerbo,boldcolor);

path3 edgeboby = cornerbo--cornerby;
path3 edgebobx = cornerbo--cornerbx;
path3 edgebybf = cornerby--cornerbf;
path3 edgebxbf = cornerbx--cornerbf;
path3 edgeboto = cornerbo--cornerto;
path3 edgebyty = cornerby--cornerty;
path3 edgebxtx = cornerbx--cornertx;
path3 edgebftf = cornerbf--cornertf;
path3 edgetoty = cornerto--cornerty;
path3 edgetotx = cornerto--cornertx;
path3 edgetytf = cornerty--cornertf;
path3 edgetxtf = cornertx--cornertf;

// Edges in back
draw(pic,edgeboby,boldcolor);
// draw(pic,edgebobx,boldcolor);
// draw(pic,edgebybf,boldcolor);
// draw(pic,edgebxbf,boldcolor);
// draw(pic,edgeboto,boldcolor);
// draw(pic,edgebyty,boldcolor);
draw(pic,edgebxtx,boldcolor);
draw(pic,edgebftf,boldcolor);
draw(pic,edgetoty,boldcolor);
// draw(pic,edgetotx,boldcolor);
// draw(pic,edgetytf,boldcolor);
// draw(pic,edgetxtf,boldcolor);
draw(pic,cornerbo--cornerbx--cornerbf--cornerby--cornerty--cornertf--cornertx--cornerto--cycle,DARKPEN+highlightcolor,nolight);

real opacity_index=0.5;
draw(pic,surface(cornerbo--cornerby--cornerbf--cornerbx--cycle),lightcolor+opacity(opacity_index),nolight);  // bot
draw(pic,surface(cornerbo--cornerbx--cornertx--cornerto--cycle),lightcolor+opacity(opacity_index),nolight);  // xz plane
draw(pic,surface(cornerbo--cornerto--cornerty--cornerby--cycle),lightcolor+opacity(opacity_index),nolight);  // yz plane
draw(pic,surface(cornerby--cornerty--cornertf--cornerbf--cycle),lightcolor+opacity(opacity_index),nolight);  // right
draw(pic,surface(cornerbx--cornerbf--cornertf--cornertx--cycle),lightcolor+opacity(opacity_index),nolight);  // front/left
draw(pic,surface(cornerto--cornertx--cornertf--cornerty--cycle),lightcolor+opacity(opacity_index),nolight);  // top

// Edges in front
// draw(pic,edgeboby,boldcolor);
// draw(pic,edgebobx,boldcolor);
// draw(pic,edgebybf,boldcolor);
// draw(pic,edgebxbf,boldcolor);
// draw(pic,edgeboto,boldcolor);
draw(pic,edgebyty,boldcolor);
draw(pic,edgebxtx,boldcolor);
draw(pic,edgebftf,boldcolor);
draw(pic,edgetoty,boldcolor);
draw(pic,edgetotx,boldcolor);
draw(pic,edgetytf,boldcolor);
draw(pic,edgetxtf,boldcolor);

dot(pic,cornertf,boldcolor);

draw(pic,cornerbx--cornerbf--cornerby--cornerty--cornertf--cornertx--cornerto,DARKPEN+highlightcolor,nolight);



shipout(format(OUTPUT_FN,picnum),pic,format="pdf");   // PDF need Acrobat Reader





// =============== octahedron =============
int picnum = 33;
picture pic;
settings.render = 0;
settings.prc = false;
import three;  // must set render, prc before importing three
size(pic,0,platonichgt);

currentprojection=orthographic(10,5,2,up=Z);

// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple corner0 = (1,0,0);
triple corner1 = (-1,0,0);
triple corner2 = (0,1,0);
triple corner3 = (0,-1,0);
triple corner4 = (0,0,1);
triple corner5 = (0,0,-1);

// dot(pic,corner0,red);
// dot(pic,corner1,blue);
// dot(pic,corner2,green);
// dot(pic,corner3,black);
dotfactor=3; // default 6
dot(pic,corner0,boldcolor);
dot(pic,corner1,boldcolor);
dot(pic,corner2,boldcolor);
dot(pic,corner3,boldcolor);
dot(pic,corner4,boldcolor);
dot(pic,corner5,boldcolor);

// For composing the picture
// label(pic,"\tiny $0$",corner0,E);
// label(pic,"\tiny $1$",corner1,E);
// label(pic,"\tiny $2$",corner2,E);
// label(pic,"\tiny $3$",corner3,E);
// label(pic,"\tiny $4$",corner4,E);
// label(pic,"\tiny $5$",corner5,E);
// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // Y axis
// draw(pic,origin--2Z,black);  // Z axis

path3 edge02 = corner0--corner2;
path3 edge03 = corner0--corner3;
path3 edge04 = corner0--corner4;
path3 edge05 = corner0--corner5;
path3 edge12 = corner1--corner2;
path3 edge13 = corner1--corner3;
path3 edge14 = corner1--corner4;
path3 edge15 = corner1--corner5;
path3 edge24 = corner2--corner4;
path3 edge25 = corner2--corner5;
path3 edge34 = corner3--corner4;
path3 edge35 = corner3--corner5;

// edges in back
draw(pic,edge12,boldcolor);
draw(pic,edge13,boldcolor);
draw(pic,edge14,boldcolor);
draw(pic,edge15,boldcolor);

// back of Ham path
draw(pic,corner2--corner1--corner4,DARKPEN+highlightcolor,nolight);

real opacity_index=0.5;
draw(pic,surface(corner1--corner3--corner4--cycle),lightcolor+opacity(opacity_index),nolight);  // top rear
draw(pic,surface(corner1--corner2--corner4--cycle),lightcolor+opacity(opacity_index),nolight);  // top rt rear
draw(pic,surface(corner0--corner2--corner4--cycle),lightcolor+opacity(opacity_index),nolight);  // top front
draw(pic,surface(corner0--corner3--corner4--cycle),lightcolor+opacity(opacity_index),nolight);  // top left front
draw(pic,surface(corner1--corner2--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // bot rt rear
draw(pic,surface(corner1--corner3--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // bot left rear
draw(pic,surface(corner0--corner2--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // bot front
draw(pic,surface(corner0--corner3--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // bot left front

// edges in front
draw(pic,edge02,boldcolor);
draw(pic,edge03,boldcolor);
draw(pic,edge04,boldcolor);
draw(pic,edge05,boldcolor);
draw(pic,edge24,boldcolor);
draw(pic,edge25,boldcolor);
draw(pic,edge34,boldcolor);
draw(pic,edge35,boldcolor);

// front of Ham path
draw(pic,corner0--corner2,DARKPEN+highlightcolor,nolight);
draw(pic,corner4--corner3--corner5--corner0,DARKPEN+highlightcolor,nolight);

// entire Ham path
// draw(pic,corner0--corner2--corner1--corner4--corner3--corner5--corner0,DARKPEN+highlightcolor,nolight);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");   // PNG! bugs in asy





// ========= octahedral graph ===========
// 
int picnum = 34;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{0}",
		      "\nodebox{1}",
		      "\nodebox{2}",
		      "\nodebox{3}",
		      "\nodebox{4}",
		      "\nodebox{5}"
		      );

// calculate nodes position
real u=1cm;
real v=0.7*u;

vlayout(-3.0*v,nodes[0],nodes[1]);
nodes[2].pos = (0.5*u, (1/2)*(nodes[0].pos.y+nodes[1].pos.y));
nodes[3].pos = (1.0*u, 1.0*v);
vlayout(-1.0*v, nodes[3], nodes[4]);
hlayout(2.5*u, nodes[2], nodes[5]);

// draw edges
draw(pic,
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[3]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[5]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[4]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[5]),
     (nodes[4]--nodes[5])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// =============== icosahedron =============
int picnum = 36;
picture pic;
settings.render = 0;
settings.prc = false;
import three;  // must set render, prc before importing three
size(pic,0,platonichgt);

currentprojection=orthographic(10,5,2,up=Z);

real phi = (1+sqrt(5))/2;
// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple corner0 = (0,1,phi);
triple corner1 = (0,-1,phi);
triple corner2 = (0,1,-phi);
triple corner3 = (0,-1,-phi);
triple corner4 = (1,phi,0);
triple corner5 = (-1,phi,0);
triple corner6 = (1,-phi,0);
triple corner7 = (-1,-phi,0);
triple corner8 = (phi,0,1);
triple corner9 = (-phi,0,1);
triple corner10 = (phi,0,-1);
triple corner11 = (-phi,0,-1);

dotfactor=3; // default 6
dot(pic,corner0,boldcolor);
dot(pic,corner1,boldcolor);
dot(pic,corner2,boldcolor);
dot(pic,corner3,boldcolor);
dot(pic,corner4,boldcolor);
dot(pic,corner5,boldcolor);
dot(pic,corner6,boldcolor);
dot(pic,corner7,boldcolor);
dot(pic,corner8,boldcolor);
dot(pic,corner9,boldcolor);
dot(pic,corner10,boldcolor);
dot(pic,corner11,boldcolor);

// For composing the picture
// label(pic,"\tiny $0$",corner0,E);
// label(pic,"\tiny $1$",corner1,E);
// label(pic,"\tiny $2$",corner2,E);
// label(pic,"\tiny $3$",corner3,E);
// label(pic,"\tiny $4$",corner4,E);
// label(pic,"\tiny $5$",corner5,E);
// label(pic,"\tiny $6$",corner6,E);
// label(pic,"\tiny $7$",corner7,E);
// label(pic,"\tiny $8$",corner8,E);
// label(pic,"\tiny $9$",corner9,E);
// label(pic,"\tiny $10$",corner10,E);
// label(pic,"\tiny $11$",corner11,E);
// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // Y axis
// draw(pic,origin--2Z,black);  // Z axis

path3 edge01 = corner0--corner1;
path3 edge04 = corner0--corner4;
path3 edge05 = corner0--corner5;
path3 edge08 = corner0--corner8;
path3 edge09 = corner0--corner9;
path3 edge16 = corner1--corner6;
path3 edge17 = corner1--corner7;
path3 edge18 = corner1--corner8;
path3 edge19 = corner1--corner9;
path3 edge23 = corner2--corner3;
path3 edge24 = corner2--corner4;
path3 edge25 = corner2--corner5;
path3 edge210 = corner2--corner10;
path3 edge211 = corner2--corner11;
path3 edge36 = corner3--corner6;
path3 edge37 = corner3--corner7;
path3 edge310 = corner3--corner10;
path3 edge311 = corner3--corner11;
path3 edge45 = corner4--corner5;
path3 edge48 = corner4--corner8;
path3 edge410 = corner4--corner10;
path3 edge59 = corner5--corner9;
path3 edge511 = corner5--corner11;
path3 edge67 = corner6--corner7;
path3 edge68 = corner6--corner8;
path3 edge610 = corner6--corner10;
path3 edge79 = corner7--corner9;
path3 edge711 = corner7--corner11;
path3 edge810 = corner8--corner10;
path3 edge911 = corner9--corner11;

// edges in back
// draw(pic,edge12,boldcolor);
// draw(pic,edge13,boldcolor);
// draw(pic,edge14,boldcolor);
// draw(pic,edge15,boldcolor);

// back of Ham path
// draw(pic,corner2--corner1--corner4,DARKPEN+highlightcolor,nolight);

real opacity_index=0.75;
// triangles in back
draw(pic,surface(corner0--corner1--corner9--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner0--corner5--corner9--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner1--corner6--corner7--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner1--corner7--corner9--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner5--corner9--corner11--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner2--corner5--corner11--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner2--corner3--corner11--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner3--corner6--corner7--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner3--corner7--corner11--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner7--corner9--corner11--cycle),lightcolor+opacity(opacity_index),nolight);  // rear

// edges in back
draw(pic,edge09,boldcolor);
draw(pic,edge17,boldcolor);
draw(pic,edge19,boldcolor);
draw(pic,edge211,boldcolor);
draw(pic,edge37,boldcolor);
draw(pic,edge311,boldcolor);
draw(pic,edge59,boldcolor);
draw(pic,edge511,boldcolor);
draw(pic,edge67,boldcolor);
draw(pic,edge79,boldcolor);
draw(pic,edge711,boldcolor);
draw(pic,edge911,boldcolor);

// back of Ham path
draw(pic,corner3
     --corner7--corner9--corner11--corner2,
     DARKPEN+highlightcolor,nolight);


// triangles in front
draw(pic,surface(corner0--corner1--corner8--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner0--corner4--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner0--corner4--corner8--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner1--corner6--corner8--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner2--corner3--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner2--corner4--corner5--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner2--corner4--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner3--corner6--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner4--corner8--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner6--corner8--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // front

// edges in front
draw(pic,edge04,boldcolor);
draw(pic,edge08,boldcolor);
draw(pic,edge01,boldcolor);
draw(pic,edge05,boldcolor);
draw(pic,edge16,boldcolor);
draw(pic,edge18,boldcolor);
draw(pic,edge23,boldcolor);
draw(pic,edge24,boldcolor);
draw(pic,edge25,boldcolor);
draw(pic,edge210,boldcolor);
draw(pic,edge36,boldcolor);
draw(pic,edge310,boldcolor);
draw(pic,edge45,boldcolor);
draw(pic,edge48,boldcolor);
draw(pic,edge410,boldcolor);
draw(pic,edge68,boldcolor);
draw(pic,edge610,boldcolor);
draw(pic,edge810,boldcolor);

// front of Ham path
draw(pic,corner0--corner1--corner8--corner6--corner3,
     DARKPEN+highlightcolor,nolight);
draw(pic,corner2--corner10--corner4--corner5--corner0,
     DARKPEN+highlightcolor,nolight);

// entire Ham path
// draw(pic,corner0--corner1--corner8--corner6--corner3
//      --corner7--corner9--corner11
//      --corner2--corner10--corner4--corner5--corner0,
//      DARKPEN+highlightcolor,nolight);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");   // PNG! bugs in asy
// The vertices are easy, but which vertex is connected to which?
// Find the nearest vertices.
// PHI = (1+sqrt(5))/2
// c0=vector(RR, [0, 1, PHI])
// c1=vector(RR, [0, -1, PHI])
// c2=vector(RR, [0, 1, -PHI])
// c3=vector(RR, [0, -1, -PHI])
// c4=vector(RR, [1, PHI, 0])
// c5=vector(RR, [-1, PHI, 0])
// c6=vector(RR, [1, -PHI, 0])
// c7=vector(RR, [-1, -PHI, 0])
// c8=vector(RR, [PHI, 0, 1])
// c9=vector(RR, [-PHI, 0, 1])
// c10=vector(RR, [PHI, 0, -1])
// c11=vector(RR, [-PHI, 0, -1])
// v = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11]
// sage: def f(c):
// ....:     for d in v:
// ....:         print("d=",d," dist=",(c-d).norm())
// Which are in front?
// sage: CAMERA = vector(RR, [10, 5, 2])
// sage: for vertex in v:
// ....:     print("vertex=",vertex,"dist to camera is ",(CAMERA-vertex).norm())
// ....:     
// vertex  dist to camera  on rim?  closer than rim?
// =================================================
//   0      10.78           y
//   1      11.67           y
//   2      11.36           y
//   3      12.21           y
//   4       9.82                     y
//   5      11.68           y
//   6      11.34           y
//   7      12.99
//   8       9.81                     y
//   9      12.69
//   10     10.21                     y
//   11     13.00


// ========= icosahedral graph ===========
// 
int picnum = 37;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("\nodebox{0}",
		      "\nodebox{1}",
		      "\nodebox{2}",
		      "\nodebox{3}",
		      "\nodebox{4}",
		      "\nodebox{5}",
		      "\nodebox{6}",
		      "\nodebox{7}",
		      "\nodebox{8}",
		      "\nodebox{9}",
		      "\nodebox{10}",
		      "\nodebox{11}"
		      );

// calculate nodes position
real u=0.9cm;
real v=0.7*u;

real fan_angle = 45.0;
vlayout(1.0*v, nodes[0], nodes[1]);
vlayout(1.9*v, nodes[1], nodes[6]);
nodes[2].pos = new_node_pos(nodes[1], -140, -1.0*v);
nodes[3].pos = new_node_pos(nodes[1], -110, -1.0*v);
nodes[4].pos = new_node_pos(nodes[1], -70,  -1.0*v);
nodes[5].pos = new_node_pos(nodes[1], -40,  -1.0*v);
nodes[7].pos = new_node_pos(nodes[6], -140, -0.5*v);
nodes[8].pos = new_node_pos(nodes[6],  -40, -0.5*v);
nodes[9].pos = new_node_pos(nodes[6],  -90, -1.15*v);
nodes[10].pos = new_node_pos(nodes[0], -90+(-1*fan_angle), -4.75*v);
nodes[11].pos = new_node_pos(nodes[0], -90+fan_angle, -4.75*v);

// draw edges
draw(pic,
     (nodes[0]--nodes[10]),
     (nodes[0]--nodes[11]),
     (nodes[0]--nodes[1]),
     (nodes[0]--nodes[2]),
     (nodes[0]--nodes[5]),
     (nodes[1]--nodes[2]),
     (nodes[1]--nodes[3]),
     (nodes[1]--nodes[4]),
     (nodes[1]--nodes[5]),
     (nodes[2]--nodes[3]),
     (nodes[2]--nodes[7]),
     (nodes[2]--nodes[10]),
     (nodes[3]--nodes[4]),
     (nodes[3]--nodes[6]),
     (nodes[3]--nodes[7]),
     (nodes[4]--nodes[5]),
     (nodes[4]--nodes[6]),
     (nodes[4]--nodes[8]),
     (nodes[5]--nodes[8]),
     (nodes[5]--nodes[11]),
     (nodes[6]--nodes[7]),
     (nodes[6]--nodes[8]),
     (nodes[6]--nodes[9]),
     (nodes[7]--nodes[9]),
     (nodes[7]--nodes[10]),
     (nodes[8]--nodes[9]),
     (nodes[8]--nodes[11]),
     (nodes[9]--nodes[10]),
     (nodes[9]--nodes[11]),
     (nodes[10]--nodes[11])
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2], nodes[3], nodes[4], nodes[5],
     nodes[6], nodes[7], nodes[8], nodes[9], nodes[10], nodes[11]
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// =============== dodecahedron =============
int picnum = 38;
picture pic;
settings.render = 0;
settings.prc = false;
import three;  // must set render, prc before importing three
size(pic,0,platonichgt);

currentprojection=orthographic(10,5,2,up=Z);

real phi = (1+sqrt(5))/2;
// https://en.wikipedia.org/wiki/Tetrahedron#Formulas_for_a_regular_tetrahedron
triple origin=(0,0,0);
triple corner0 = (1,1,1);
triple corner1 = (1,1,-1);
triple corner2 = (1,-1,1);
triple corner3 = (1,-1,-1);
triple corner4 = (-1,1,1);
triple corner5 = (-1,1,-1);
triple corner6 = (-1,-1,1);
triple corner7 = (-1,-1,-1);
triple corner8 = (0,phi,1/phi);
triple corner9 = (0,phi,-1/phi);
triple corner10 = (0,-phi,1/phi);
triple corner11 = (0,-phi,-1/phi);
triple corner12 = (1/phi,0,phi);
triple corner13 = (1/phi,0,-phi);
triple corner14 = (-1/phi,0,phi);
triple corner15 = (-1/phi,0,-phi);
triple corner16 = (phi,1/phi,0);
triple corner17 = (phi,-1/phi,0);
triple corner18 = (-phi,1/phi,0);
triple corner19 = (-phi,-1/phi,0);

dotfactor=3; // default 6
dot(pic,corner0,boldcolor);
dot(pic,corner1,boldcolor);
dot(pic,corner2,boldcolor);
dot(pic,corner3,boldcolor);
dot(pic,corner4,boldcolor);
dot(pic,corner5,boldcolor);
dot(pic,corner6,boldcolor);
dot(pic,corner7,boldcolor);
dot(pic,corner8,boldcolor);
dot(pic,corner9,boldcolor);
dot(pic,corner10,boldcolor);
dot(pic,corner11,boldcolor);
dot(pic,corner12,boldcolor);
dot(pic,corner13,boldcolor);
dot(pic,corner14,boldcolor);
dot(pic,corner15,boldcolor);
dot(pic,corner16,boldcolor);
dot(pic,corner17,boldcolor);
dot(pic,corner18,boldcolor);
dot(pic,corner19,boldcolor);

// For composing the picture
// label(pic,"\tiny $0$",corner0,E);
// label(pic,"\tiny $1$",corner1,E);
// label(pic,"\tiny $2$",corner2,E);
// label(pic,"\tiny $3$",corner3,E);
// label(pic,"\tiny $4$",corner4,E);
// label(pic,"\tiny $5$",corner5,E);
// label(pic,"\tiny $6$",corner6,E);
// label(pic,"\tiny $7$",corner7,E);
// label(pic,"\tiny $8$",corner8,E);
// label(pic,"\tiny $9$",corner9,E);
// label(pic,"\tiny $10$",corner10,E);
// label(pic,"\tiny $11$",corner11,E);
// label(pic,"\tiny $12$",corner12,E);
// label(pic,"\tiny $13$",corner13,E);
// label(pic,"\tiny $14$",corner14,E);
// label(pic,"\tiny $15$",corner15,E);
// label(pic,"\tiny $16$",corner16,E);
// label(pic,"\tiny $17$",corner17,E);
// label(pic,"\tiny $18$",corner18,E);
// label(pic,"\tiny $19$",corner19,E);
// draw(pic,origin--2X,black);  // X axis
// draw(pic,origin--2Y,black);  // Y axis
// draw(pic,origin--2Z,black);  // Z axis

// edges
path3 edge08 = corner0--corner8;
path3 edge012 = corner0--corner12;
path3 edge016 = corner0--corner16;
path3 edge19 = corner1--corner9;
path3 edge113 = corner1--corner13;
path3 edge116 = corner1--corner16;
path3 edge210 = corner2--corner10;
path3 edge212 = corner2--corner12;
path3 edge217 = corner2--corner17;
path3 edge311 = corner3--corner11;
path3 edge313 = corner3--corner13;
path3 edge317 = corner3--corner17;
path3 edge48 = corner4--corner8;
path3 edge414 = corner4--corner14;
path3 edge418 = corner4--corner18;
path3 edge59 = corner5--corner9;
path3 edge515 = corner5--corner15;
path3 edge518 = corner5--corner18;
path3 edge610 = corner6--corner10;
path3 edge614 = corner6--corner14;
path3 edge619 = corner6--corner19;
path3 edge711 = corner7--corner11;
path3 edge715 = corner7--corner15;
path3 edge719 = corner7--corner19;
path3 edge89 = corner8--corner9;
path3 edge1011 = corner10--corner11;
path3 edge1214 = corner12--corner14;
path3 edge1315 = corner13--corner15;
path3 edge1617 = corner16--corner17;
path3 edge1819 = corner18--corner19;

// back of Ham path
// draw(pic,corner2--corner1--corner4,DARKPEN+highlightcolor,nolight);

real opacity_index=0.75;
// pentgons in back
draw(pic,surface(corner4--corner18--corner19--corner6--corner14--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner5--corner15--corner7--corner19--corner18--cycle),lightcolor+opacity(opacity_index),nolight);  // rear
draw(pic,surface(corner6--corner19--corner7--corner11--corner10--cycle),lightcolor+opacity(opacity_index),nolight);  // rear

// // edges in back
draw(pic,edge418,boldcolor);
draw(pic,edge518,boldcolor);
draw(pic,edge610,boldcolor);
draw(pic,edge614,boldcolor);
draw(pic,edge619,boldcolor);
draw(pic,edge711,boldcolor);
draw(pic,edge715,boldcolor);
draw(pic,edge719,boldcolor);
draw(pic,edge1819,boldcolor);

// Ham path in back
draw(pic,
     corner10
     --corner6--corner19--corner18--corner5,
     DARKPEN+highlightcolor,nolight);
draw(pic,
     corner15
     --corner7--corner11--corner3,
     DARKPEN+highlightcolor,nolight);

// pentagons in front
draw(pic,surface(corner0--corner8--corner4--corner14--corner12--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner0--corner8--corner9--corner1--corner16--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner0--corner12--corner2--corner17--corner16--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner1--corner9--corner5--corner15--corner13--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner1--corner13--corner3--corner17--corner16--cycle),lightcolor+opacity(opacity_index),nolight);  // front
draw(pic,surface(corner2--corner10--corner11--corner3--corner17--cycle),lightcolor+opacity(opacity_index),nolight);  // front

// edges in front
draw(pic,edge08,boldcolor);
draw(pic,edge012,boldcolor);
draw(pic,edge016,boldcolor);
draw(pic,edge19,boldcolor);
draw(pic,edge113,boldcolor);
draw(pic,edge116,boldcolor);
draw(pic,edge210,boldcolor);
draw(pic,edge212,boldcolor);
draw(pic,edge217,boldcolor);
draw(pic,edge311,boldcolor);
draw(pic,edge313,boldcolor);
draw(pic,edge317,boldcolor);
draw(pic,edge48,boldcolor);
draw(pic,edge414,boldcolor);
draw(pic,edge59,boldcolor);
draw(pic,edge515,boldcolor);
draw(pic,edge89,boldcolor);
draw(pic,edge1011,boldcolor);
draw(pic,edge1214,boldcolor);
draw(pic,edge1315,boldcolor);
draw(pic,edge1617,boldcolor);

// Ham path in front
draw(pic,corner0--corner8--corner4--corner14
     --corner12--corner2--corner10,
     DARKPEN+highlightcolor,nolight);
draw(pic,corner5
     --corner9--corner1--corner13--corner15,
     DARKPEN+highlightcolor,nolight);
draw(pic,corner11--corner3
     --corner17--corner16--corner0,
     DARKPEN+highlightcolor,nolight);

// entire Ham path
// draw(pic,corner0--corner8--corner4--corner14
//      --corner12--corner2--corner10
//      --corner6--corner19--corner18--corner5
//      --corner9--corner1--corner13--corner15
//      --corner7--corner11--corner3
//      --corner17--corner16--corner0,
//      DARKPEN+highlightcolor,nolight);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");   // 
// sage: PHI = (1+sqrt(5))/2
// sage: PHI
// 1/2*sqrt(5) + 1/2
// sage: c0 = vector(RR, [1, 1, 1])
// sage: c1 = vector(RR, [1, 1, -1])
// sage: c2 = vector(RR, [1, -1, 1])
// sage: c3 = vector(RR, [1, -1, -1])
// sage: c4 = vector(RR, [-1, 1, 1])
// sage: c5 = vector(RR, [-1, 1, -1])
// sage: c6 = vector(RR, [-1, -1, 1])
// sage: c7 = vector(RR, [-1, -1, -1])
// sage: c8 = vector(RR, [0, PHI, 1/PHI])
// sage: c9 = vector(RR, [0, PHI, -1/PHI])
// sage: c10 = vector(RR, [0, -PHI, 1/PHI])
// sage: c11 = vector(RR, [0, -PHI, -1/PHI])
// sage: c12 = vector(RR, [1/PHI, 0, PHI])
// sage: c13 = vector(RR, [1/PHI, 0, -PHI])
// sage: c14 = vector(RR, [-1/PHI, 0, PHI])
// sage: c15 = vector(RR, [-1/PHI, 0, -PHI])
// sage: c16 = vector(RR, [PHI, 1/PHI, 0])
// sage: c17 = vector(RR, [PHI, -1/PHI, 0])
// sage: c18 = vector(RR, [-PHI, 1/PHI, 0])
// sage: c19 = vector(RR, [-PHI, -1/PHI, 0])
// sage: lst = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19]
// # for each corner, find nearest three corners
// sage: def dist(c):
// ....:     dex = 0
// ....:     for v in lst:
// ....:         print("c",dex," dist=",(c-v).norm())
// ....:         dex = dex+1
// # Find the vertices behind, and those in front
// sage: CAMERA = vector(RR, [10, 5, 2])
// sage: for v in lst:
// ....:     print("c",dex," dist to camera=",(CAMERA-v).norm())
// ....:     dex = dex+1
// ....:     
// ('c', 0, ' dist to camera=', 9.89949493661167)
// ('c', 1, ' dist to camera=', 10.2956301409870)
// ('c', 2, ' dist to camera=', 10.8627804912002)
// ('c', 3, ' dist to camera=', 11.2249721603218)
// ('c', 4, ' dist to camera=', 11.7473401244707)
// ('c', 5, ' dist to camera=', 12.0830459735946)
// ('c', 6, ' dist to camera=', 12.5698050899765)
// ('c', 7, ' dist to camera=', 12.8840987267251)
// ('c', 8, ' dist to camera=', 10.6464794254956)
// ('c', 9, ' dist to camera=', 10.8762032009107)
// ('c', 10, ' dist to camera=', 12.0709653272843)
// ('c', 11, ' dist to camera=', 12.2740570245742)
// ('c', 12, ' dist to camera=', 10.6380065928727)
// ('c', 13, ' dist to camera=', 11.2299357157555)
// ('c', 14, ' dist to camera=', 11.7425952761729)
// ('c', 15, ' dist to camera=', 12.2814012119952)
// ('c', 16, ' dist to camera=', 9.66741849396741)
// ('c', 17, ' dist to camera=', 10.2868683335844)
// ('c', 18, ' dist to camera=', 12.5769765797468)
// ('c', 19, ' dist to camera=', 13.0591354867961)





// ======================== 3-D Matching =============
// Credit: Jan Verschelde
int picnum = 39;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node InstA=ncircle("\nodebox{\strut$A$}"),
  InstB=ncircle("\nodebox{\strut$B$}"),
  InstC=ncircle("\nodebox{\strut$C$}"),
  InstD=ncircle("\nodebox{\strut$D$}"),
  InstE=ncircle("\nodebox{\strut$E$}"),
  Course0=ncircle("\nodebox{\strut$0$}"),
  Course1=ncircle("\nodebox{\strut$1$}"),
  Course2=ncircle("\nodebox{\strut$2$}"),
  Course3=ncircle("\nodebox{\strut$3$}"),
  Course4=ncircle("\nodebox{\strut$4$}"),
  TimeAlpha=ncircle("\nodebox{\strut$\alpha$}"),
  TimeBeta=ncircle("\nodebox{\strut$\beta$}"),
  TimeGamma=ncircle("\nodebox{\strut$\gamma$}"),
  TimeDelta=ncircle("\nodebox{\strut$\delta$}"),
TimeEpsilon=ncircle("\nodebox{\strut$\varepsilon$}");

// calculate nodes position
real u=1.0cm;
real v=u;
defaultlayoutskip=u;

vlayout(1*v, InstA, Course0, TimeAlpha);
hlayout(1*u, InstA, InstB, InstC, InstD, InstE);
hlayout(1*u, Course0, Course1, Course2, Course3, Course4);
hlayout(1*u, TimeAlpha, TimeBeta, TimeGamma, TimeDelta, TimeEpsilon);

// draw edges
draw(pic,
     (InstA--Course1),
     (InstA--Course2),
     (InstA--Course3),
     (InstB--Course0),
     (InstB--Course1),
     (InstB--Course2),
     (InstC--Course3),
     (InstD--Course1),
     (InstE--Course2),
     (InstE--Course4),
     (Course0--TimeAlpha),
     (Course0--TimeDelta),
     (Course1--TimeBeta),
     (Course1--TimeEpsilon),
     (Course2--TimeGamma),
     (Course2--TimeEpsilon),
     (Course3--TimeGamma),
     (Course4--TimeDelta)
);

// draw nodes, after edges
draw(pic,
     InstA, InstB, InstC, InstD, InstE,
     Course0, Course1, Course2, Course3, Course4,
     TimeAlpha, TimeBeta, TimeGamma, TimeDelta, TimeEpsilon);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======================== Linear programming =============
int picnum = 40;
picture pic;

import graph;
unitsize(pic, 0.35cm,0);

real xmin = -0.75;
real xmax = 8.75;
real ymin = -0.75;
real ymax = 5.75;

real f1(real x) {return (8-(4/3)*x);}
real f2(real x) {return (4);}
real F2(real x) {return ((2-x)/2);}
real F4(real x) {return ((4-x)/2);}
real F6(real x) {return ((6-x)/2);}
real F8(real x) {return ((8-x)/2);}
real F10(real x) {return ((10-x)/2);}

path feasible_region = (0,0)--(0,4)--(3,4)--(6,0)--cycle;
fill(pic,feasible_region,backgroundcolor);

xaxis(pic, Label("$x_0$",align=1*SE), YZero,
      xmin=xmin, xmax=xmax,
      RightTicks("%", Step=5, step=1),Arrow(TeXHead));
yaxis(pic, Label("$x_1$",align=NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks("%", Step=5, step=1),Arrow(TeXHead));

draw(pic, graph(f1, 2.5, 6.5));
draw(pic, graph(f2, 0, 4));

draw(pic, graph(F2, xmin, 3), highlightcolor);
label(pic, "{\scriptsize $F = 2$}", (xmin, F2(xmin)), align=W, highlightcolor);
// draw(pic, graph(F4, xmin, 5), highlightcolor);
// label(pic, "{\scriptsize $F = 4$}", (xmin, F4(xmin)), align=W, highlightcolor);
// draw(pic, graph(F6, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 6$}", (xmin, F6(xmin)), align=W, highlightcolor);
// draw(pic, graph(F8, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 8$}", (xmin, F8(xmin)), align=W, highlightcolor);
// draw(pic, graph(F10, xmin, 6), highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............ F4 .................
int picnum = 41;
picture pic;

import graph;
unitsize(pic, 0.35cm,0);

real xmin = -0.75;
real xmax = 8.75;
real ymin = -0.75;
real ymax = 5.75;

real f1(real x) {return (8-(4/3)*x);}
real f2(real x) {return (4);}
real F2(real x) {return ((2-x)/2);}
real F4(real x) {return ((4-x)/2);}
real F6(real x) {return ((6-x)/2);}
real F8(real x) {return ((8-x)/2);}
real F10(real x) {return ((10-x)/2);}

path feasible_region = (0,0)--(0,4)--(3,4)--(6,0)--cycle;
fill(pic,feasible_region,backgroundcolor);

xaxis(pic, Label("$x_0$",align=1*SE), YZero,
      xmin=xmin, xmax=xmax,
      RightTicks("%", Step=5, step=1),Arrow(TeXHead));
yaxis(pic, Label("$x_1$",align=NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks("%", Step=5, step=1),Arrow(TeXHead));

draw(pic, graph(f1, 2.5, 6.5));
draw(pic, graph(f2, 0, 4));

// draw(pic, graph(F2, xmin, 3), highlightcolor);
// label(pic, "{\scriptsize $F = 2$}", (xmin, F2(xmin)), align=W, highlightcolor);
draw(pic, graph(F4, xmin, 5), highlightcolor);
label(pic, "{\scriptsize $F = 4$}", (xmin, F4(xmin)), align=W, highlightcolor);
// draw(pic, graph(F6, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 6$}", (xmin, F6(xmin)), align=W, highlightcolor);
// draw(pic, graph(F8, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 8$}", (xmin, F8(xmin)), align=W, highlightcolor);
// draw(pic, graph(F10, xmin, 6), highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............ F6 .................
int picnum = 42;
picture pic;

import graph;
unitsize(pic, 0.35cm,0);

real xmin = -0.75;
real xmax = 8.75;
real ymin = -0.75;
real ymax = 5.75;

real f1(real x) {return (8-(4/3)*x);}
real f2(real x) {return (4);}
real F2(real x) {return ((2-x)/2);}
real F4(real x) {return ((4-x)/2);}
real F6(real x) {return ((6-x)/2);}
real F8(real x) {return ((8-x)/2);}
real F10(real x) {return ((10-x)/2);}

path feasible_region = (0,0)--(0,4)--(3,4)--(6,0)--cycle;
fill(pic,feasible_region,backgroundcolor);

xaxis(pic, Label("$x_0$",align=1*SE), YZero,
      xmin=xmin, xmax=xmax,
      RightTicks("%", Step=5, step=1),Arrow(TeXHead));
yaxis(pic, Label("$x_1$",align=NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks("%", Step=5, step=1),Arrow(TeXHead));

draw(pic, graph(f1, 2.5, 6.5));
draw(pic, graph(f2, 0, 4));

// draw(pic, graph(F2, xmin, 3), highlightcolor);
// label(pic, "{\scriptsize $F = 2$}", (xmin, F2(xmin)), align=W, highlightcolor);
// draw(pic, graph(F4, xmin, 5), highlightcolor);
// label(pic, "{\scriptsize $F = 4$}", (xmin, F4(xmin)), align=W, highlightcolor);
draw(pic, graph(F6, xmin, 7), highlightcolor);
label(pic, "{\scriptsize $F = 6$}", (xmin, F6(xmin)), align=W, highlightcolor);
// draw(pic, graph(F8, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 8$}", (xmin, F8(xmin)), align=W, highlightcolor);
// draw(pic, graph(F10, xmin, 6), highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ F8 .................
int picnum = 43;
picture pic;

import graph;
unitsize(pic, 0.35cm,0);

real xmin = -0.75;
real xmax = 8.75;
real ymin = -0.75;
real ymax = 5.75;

real f1(real x) {return (8-(4/3)*x);}
real f2(real x) {return (4);}
real F2(real x) {return ((2-x)/2);}
real F4(real x) {return ((4-x)/2);}
real F6(real x) {return ((6-x)/2);}
real F8(real x) {return ((8-x)/2);}
real F10(real x) {return ((10-x)/2);}

path feasible_region = (0,0)--(0,4)--(3,4)--(6,0)--cycle;
fill(pic,feasible_region,backgroundcolor);

xaxis(pic, Label("$x_0$",align=1*SE), YZero,
      xmin=xmin, xmax=xmax,
      RightTicks("%", Step=5, step=1),Arrow(TeXHead));
yaxis(pic, Label("$x_1$",align=NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks("%", Step=5, step=1),Arrow(TeXHead));

draw(pic, graph(f1, 2.5, 6.5));
draw(pic, graph(f2, 0, 4));

// draw(pic, graph(F2, xmin, 3), highlightcolor);
// label(pic, "{\scriptsize $F = 2$}", (xmin, F2(xmin)), align=W, highlightcolor);
// draw(pic, graph(F4, xmin, 5), highlightcolor);
// label(pic, "{\scriptsize $F = 4$}", (xmin, F4(xmin)), align=W, highlightcolor);
// draw(pic, graph(F6, xmin, 7), highlightcolor);
// label(pic, "{\scriptsize $F = 6$}", (xmin, F6(xmin)), align=W, highlightcolor);
draw(pic, graph(F8, xmin, 7), highlightcolor);
label(pic, "{\scriptsize $F = 8$}", (xmin, F8(xmin)), align=W, highlightcolor);
// draw(pic, graph(F10, xmin, 6), highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ F2--F8 .................
int picnum = 44;
picture pic;

import graph;
unitsize(pic, 0.35cm,0);

real xmin = -0.75;
real xmax = 8.75;
real ymin = -0.75;
real ymax = 5.75;

real[] xticks_at = {5};
real[] yticks_at = {5};

real f1(real x) {return (8-(4/3)*x);}
real f2(real x) {return (4);}
real F2(real x) {return ((2-x)/2);}
real F4(real x) {return ((4-x)/2);}
real F6(real x) {return ((6-x)/2);}
real F8(real x) {return ((8-x)/2);}
real F10(real x) {return ((10-x)/2);}

path feasible_region = (0,0)--(0,4)--(3,4)--(6,0)--cycle;
fill(pic,feasible_region,backgroundcolor);

xaxis(pic, Label("$x_0$",align=1*SE), YZero,
      xmin=xmin, xmax=xmax,
      RightTicks("%", Step=5, step=1),Arrow(TeXHead));
yaxis(pic, Label("$x_1$",align=2*NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks("%", Step=5, step=1),Arrow(TeXHead));

draw(pic, graph(f1, 2.5, 6.5));
draw(pic, graph(f2, 0, 4));

// check that the intersection is (3,4)
// dot(pic,(3,4),red);
// draw(pic, (3,-1)--(3,5),red);

draw(pic, graph(F2, xmin, 3), highlightcolor);
label(pic, "{\scriptsize $F = 2$}", (xmin, F2(xmin)), align=W, highlightcolor);
draw(pic, graph(F4, xmin, 5), highlightcolor);
label(pic, "{\scriptsize $F = 4$}", (xmin, F4(xmin)), align=W, highlightcolor);
draw(pic, graph(F6, xmin, 7), highlightcolor);
label(pic, "{\scriptsize $F = 6$}", (xmin, F6(xmin)), align=W, highlightcolor);
draw(pic, graph(F8, xmin, 7), highlightcolor);
label(pic, "{\scriptsize $F = 8$}", (xmin, F8(xmin)), align=W, highlightcolor);
// draw(pic, graph(F10, xmin, 6), highlightcolor);
xaxis(pic, Label("",align=1*SE),
      YZero,
      xmin=xmin, xmax=xmax,
      RightTicks(OmitFormat("\raisebox{1ex}{\tiny $ %.4g$}", 0,4), Step=5, step=1),
        Arrow(TeXHead),
      above=true);
yaxis(pic, Label("$x_1$",align=2*NE), XZero,
      ymin=ymin,ymax=ymax,
      LeftTicks(OmitFormat("\raisebox{0.5ex}{\tiny $ %.4g$}", 0,4), Step=5, step=1),
         Arrow(TeXHead),
      above=true);


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======================== TSP =============

int picnum = 45;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{$v_0$}"),
  v1=ncircle("\nodebox{$v_1$}"),
  v2=ncircle("\nodebox{$v_2$}"),
  v3=ncircle("\nodebox{$v_3$}");

// calculate nodes position
real u=1.0cm;
real v=0.8*u;
defaultlayoutskip=u;

hlayout(1*u, v0, v1);
vlayout(1*v, v0, v2);
hlayout(1*u, v2, v3);

// draw edges
draw(pic,
     (v0--v1).l("3").style("leftside"),
     (v0--v2).l("2"),
     (v0--v3).l(Label("7",Relative(0.2))),
     (v1--v2).l(Label("1",Relative(0.2))).style("leftside"),
     (v1--v3).l("5").style("leftside"),
     (v2--v3).l("4")
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======================== max cut =============

int picnum = 46;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}"),
  v1=ncircle("\nodebox{\strut$v_1$}"),
  v2=ncircle("\nodebox{\strut$v_2$}"),
  v3=ncircle("\nodebox{\strut$v_3$}"),
  v4=ncircle("\nodebox{\strut$v_4$}"),
  v5=ncircle("\nodebox{\strut$v_5$}");

// calculate nodes position
real u=1.25cm;
real v=0.60*u;  // results in 0.75
defaultlayoutskip=u;

layout(30.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
layout(-30.0, v0, v2);
hlayout(1.0*u, v1, v3);
hlayout(1.0*u, v2, v4);
layout(-30.0, v3, v5);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v2--v4),
     (v3--v4),
     (v3--v5),
     (v4--v5)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ..........................................
int picnum = 47;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}"),
  v1=ncircle("\nodebox{\strut$v_1$}"),
  v2=ncircle("\nodebox{\strut$v_2$}"),
  v3=ncircle("\nodebox{\strut$v_3$}"),
  v4=ncircle("\nodebox{\strut$v_4$}"),
  v5=ncircle("\nodebox{\strut$v_5$}");

// calculate nodes position
real u=1.25cm;
real v=0.60*u;
defaultlayoutskip=u;

layout(30.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
layout(-30.0, v0, v2);
hlayout(1.0*u, v1, v3);
hlayout(1.0*u, v2, v4);
layout(-30.0, v3, v5);

path cut;
cut = v0.pos-(0,1*v)
  ..interp(v0.pos,v2.pos,0.5)
  ..interp(v1.pos,v3.pos,0.5)
  ..{E}v3.pos+(0,0.75*v)
  ..interp(v3.pos,v5.pos,0.5)
  ..interp(v3.pos,v4.pos,0.5)
  ..interp(v2.pos,v4.pos,0.5)
  ..(interp(v2.pos,v4.pos,0.5)-(0.10*u,0.30*v));

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v2--v4),
     (v3--v4),
     (v3--v5),
     (v4--v5)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

draw(pic, cut, highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ..........................................
int picnum = 48;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}", ns_bleachedbg),
  v1=ncircle("\nodebox{\strut$v_1$}", ns_bleachedbg),
  v2=ncircle("\nodebox{\strut$v_2$}", ns_bleachedbold),
  v3=ncircle("\nodebox{\strut$v_3$}", ns_bleachedbold),
  v4=ncircle("\nodebox{\strut$v_4$}", ns_bleachedbg),
  v5=ncircle("\nodebox{\strut$v_5$}", ns_bleachedbg);

// calculate nodes position
real u=1.25cm;
real v=0.60*u;
defaultlayoutskip=u;

layout(30.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
layout(-30.0, v0, v2);
hlayout(1.0*u, v1, v3);
hlayout(1.0*u, v2, v4);
layout(-30.0, v3, v5);

// draw edges
// draw edges
draw(pic,
     (v0--v1).l("$e_0$").style("leftside"),
     (v0--v2).l("$e_1$"),
     (v1--v2).l("$e_2$"),
     (v1--v3).l("$e_3$").style("leftside"),
     (v2--v4).l("$e_4$"),
     (v3--v4).l("$e_5$").style("leftside"),
     (v3--v5).l("$e_6$").style("leftside"),
     (v4--v5).l("$e_7$")
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// .......... misleading cut for exercise ..................
int picnum = 49;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}"),
  v1=ncircle("\nodebox{\strut$v_1$}"),
  v2=ncircle("\nodebox{\strut$v_2$}"),
  v3=ncircle("\nodebox{\strut$v_3$}"),
  v4=ncircle("\nodebox{\strut$v_4$}"),
  v5=ncircle("\nodebox{\strut$v_5$}");

// calculate nodes position
real u=1.0cm;
real v=0.75*u;
defaultlayoutskip=u;

layout(30.0, v0, v1); // layout(real angle or pair dir, real skip=defaultlayoutskip, bool rel=defaultlayoutrel, node[] nds)
layout(-30.0, v0, v2);
hlayout(1.0*u, v1, v3);
hlayout(1.0*u, v2, v4);
layout(-30.0, v3, v5);

path cut;
cut = v0.pos+(0.5*u,0)
  ..interp(v0.pos,v1.pos,0.5)
  ..v0.pos-(0.5*u,0.0*v){S}
  ..interp(v0.pos,v2.pos,0.5)
  ..interp(v1.pos,v3.pos,0.5)
  ..{E}v3.pos+(0,0.50*v)
  ..interp(v3.pos,v5.pos,0.5)
  ..interp(v3.pos,v4.pos,0.5)
  ..interp(v2.pos,v4.pos,0.5)
  ..v4.pos-(0.0*u,0.5*v){E}
  ..interp(v4.pos,v5.pos,0.5)
  ..interp(v4.pos,v5.pos,0.5)-(0.05*u,-0.10*v);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v2--v4),
     (v3--v4),
     (v3--v5),
     (v4--v5)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

draw(pic, cut, highlightcolor);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= Max cut exercise =============
int picnum = 50;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}"),
  v1=ncircle("\nodebox{\strut$v_1$}"),
  v2=ncircle("\nodebox{\strut$v_2$}"),
  v3=ncircle("\nodebox{\strut$v_3$}"),
  v4=ncircle("\nodebox{\strut$v_4$}"),
  v5=ncircle("\nodebox{\strut$v_5$}");

// calculate nodes position
real u=1.0cm;
real v=0.75*u;
defaultlayoutskip=u;

hlayout(1*u, v0, v2, v4);
vlayout(1*v, v0, v1);
hlayout(1*u, v1, v3, v5);

// draw edges
draw(pic,
     (v0--v2),
     (v0--v3),
     (v1--v2),
     (v1--v3),
     (v2--v4),
     (v2--v5),
     (v3--v4),
     (v3--v5)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............ answer .............
int picnum = 51;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{\strut$v_0$}", ns_bleachedbg),
  v1=ncircle("\nodebox{\strut$v_1$}", ns_bleachedbg),
  v2=ncircle("\nodebox{\strut$v_2$}", ns_bleachedbold),
  v3=ncircle("\nodebox{\strut$v_3$}", ns_bleachedbold),
  v4=ncircle("\nodebox{\strut$v_4$}", ns_bleachedbg),
  v5=ncircle("\nodebox{\strut$v_5$}", ns_bleachedbg);

// calculate nodes position
real u=1.0cm;
real v=0.75*u;
defaultlayoutskip=u;

hlayout(1*u, v0, v2, v4);
vlayout(1*v, v0, v1);
hlayout(1*u, v1, v3, v5);

// draw edges
draw(pic,
     (v0--v2),
     (v0--v3),
     (v1--v2),
     (v1--v3),
     (v2--v4),
     (v2--v5),
     (v3--v4),
     (v3--v5)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3, v4, v5);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ======= asymmetric travelling salesman ====
int picnum = 52;
picture pic;
setdefaultdirectedgraphstyles();
defaultlayoutrel = false;

node[] nodes=ncircles("$v_0$",
  "$v_1$",
  "$v_2$");

// calculate nodes position
real u=1cm;
real v=0.7*u;
circularlayout(0.8*u, startangle=90, nodes);

// draw edges
draw(pic,
     (nodes[0]..bend(10)..nodes[1]).l("1"),
     (nodes[0]..bend(10)..nodes[2]).l("2"),
     (nodes[1]..bend(10)..nodes[0]).l("3"),
     (nodes[1]..bend(10)..nodes[2]).l("4"),
     (nodes[2]..bend(10)..nodes[0]).l("5"),
     (nodes[2]..bend(10)..nodes[1]).l("6")
);

// draw nodes
draw(pic,
     nodes[0], nodes[1], nodes[2]);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ======= TSP with edge that cannot be part of any solution =======
int picnum = 53;
picture pic;
setdefaultgraphstyles();
defaultlayoutrel = false;

node v0=ncircle("\nodebox{$v_0$}"),
  v1=ncircle("\nodebox{$v_1$}"),
  v2=ncircle("\nodebox{$v_2$}"),
  v3=ncircle("\nodebox{$v_3$}");

// calculate node positions
real u=0.9cm;
real v=0.75*u;
defaultlayoutskip=u;

hlayout(1*u, v0, v1);
vlayout(1*v, v0, v2);
hlayout(1*u, v2, v3);

// draw edges
draw(pic,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v2--v3)
);

// draw nodes, after edges
draw(pic,
     v0, v1, v2, v3);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






