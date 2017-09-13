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


nodestyle ns_bleachedbg=nodestyle(drawfn=FillDrawer(backgroundcolor+white,black));
nodestyle ns_bg=nodestyle(drawfn=FillDrawer(backgroundcolor,black));
nodestyle ns_bleachedbold=nodestyle(drawfn=FillDrawer(bold_light,black));
nodestyle ns_light=nodestyle(drawfn=FillDrawer(lightcolor,black));



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
