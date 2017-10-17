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





