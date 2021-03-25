// flowcharts.asy
//  Flow charts illustrating routines
cd("../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../asy");
import jhnode;
cd("");

cd("../../../../asy");
import flowchart;
cd("");

import settings;
settings.outformat="pdf";


string OUTPUT_FN = "flowcharts%03d";



// ================== Handin-3 ==================
picture pic;
int picnum = 0;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $2x_1$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............................................
picture pic;
int picnum = 1;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $x_1^2+1$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..........................................
picture pic;
int picnum = 2;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $2x_1$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............................................
picture pic;
int picnum = 3;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $x_1^2+3$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========== NDFSM ==================
picture pic;
int picnum = 4;
setdefaultstatediagramstyles();

// define nodes
node q0=ncircle("$q_0$"); 
node q1=ncircle("$q_1$");  
node q2=ncircle("$q_2$",ns_accepting);  

// calculate nodes position
real u=1.75cm;  // horizontal  
real v=1.0*u;  // vertical

hlayout(1*u, q0, q1);
vlayout(1*v, q0, q2);


// draw edges
draw(pic,
     (q0..loop(N)).l("\str{a}"),
     (q0..bend(15)..q1).l("\str{a},\str{b}"),
     (q1..bend(15)..q0).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q2--q0).l("\str{b}"),
     (q2..loop(S)).l("\str{b}")
     );

// draw nodes
draw(pic,
     q0, q1,
     q2
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

