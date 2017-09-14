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


nodestyle ns_bleachedbg=nodestyle(xmargin=1pt,
				  drawfn=FillDrawer(backgroundcolor+white,black));
nodestyle ns_bg=nodestyle(xmargin=1pt,
			  drawfn=FillDrawer(backgroundcolor,black));
nodestyle ns_bleachedbold=nodestyle(xmargin=1pt,
				    drawfn=FillDrawer(bold_light,black));
nodestyle ns_light=nodestyle(xmargin=1pt,
			     drawfn=FillDrawer(lightcolor,black));



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

// draw nodes
draw(pic,outer[0],outer[1],outer[2],outer[3],outer[4],
     inner[0],inner[1],inner[2],inner[3],inner[4]);

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

// draw nodes
draw(pic,outer[0],outer[1],outer[2],outer[3],outer[4],
     inner[0],inner[1],inner[2],inner[3],inner[4]);

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

// draw nodes
draw(pic,
     n[0], n[1], n[2], n[3]);

// draw edges
draw(pic,
     (n[0]--n[1]),
     (n[0]--n[2]),
     (n[0]--n[3]),
     (n[1]--n[2]),
     (n[1]--n[3]),
     (n[2]--n[3])
);
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
hlayout(0.5*u, v00, v01);
v10.pos = new_node_pos(v00,  -135, -1*v);
v11.pos = new_node_pos(v10,  -45, -0.75*v);
v20.pos = new_node_pos(v01,  -45, -1*v);
v21.pos = new_node_pos(v20,  -135, -0.75*v);


// draw nodes
draw(pic,
     v00, v01, v10, v11, v20, v21);


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

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======================== vertex cover =============

int picnum = 4;
picture pic;
setdefaultgraphstyles();

node v0t=ncircle("\nodebox{$v_{0,T}$}", ns_bleachedbg),
  v0f=ncircle("\nodebox{$v_{0,F}$}"),
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
real u=1.5cm;
real v=0.7*u;
hlayout(1.0*u, v0t, v0f);
hlayout(1.5*u, v0f, v1t);
hlayout(1.0*u, v1t, v1f);
hlayout(1.5*u, v1f, v2t);
hlayout(1.0*u, v2t, v2f);
hlayout(1.5*u, v2f, v3t);
hlayout(1.0*u, v3t, v3f);

vlayout(2.0*v, v0t, w00);
hlayout(1.5*u, w00, w01);
w02.pos = new_node_pos(w01,  -120, -1*v);

hlayout(2.0*u, w01, w10);
hlayout(1.5*u, w10, w12);
w13.pos = new_node_pos(w10,  -120, -1*v);

hlayout(2.0*u, w12, w21);
hlayout(1.5*u, w21, w23);


// draw nodes
draw(pic,
     v0t, v0f, v1t, v1f, v2t, v2f, v3t, v3f,
     w00, w01, w02, w10, w12, w13, w21, w23);


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

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
