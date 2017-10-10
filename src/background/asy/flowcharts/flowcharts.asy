// flowcharts.asy
//  Flow charts illustrating routines
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy");
import jh;
import flowchart;
cd("");

import settings;
settings.outformat="pdf";

cd("../../../asy/asy-graphtheory-master/modules");
import node;
cd("");

string OUTPUT_FN = "flowcharts%02d";



// ---- s-m-n theorem
picture pic;
int picnum = 0;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x_0,\ldots,x_{m-1}$");
node create=nbox("Create instructions for $\hat{P}$");
node ret=nbox(minipage_snug("Return index of\\ that instruction set"));
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,create);
vlayout(1.275*v,create,ret);
vlayout(1.25*v,ret,ending);

// draw edges
draw(pic,
     (start--read),
     (read--create),
     (create--ret),
     (ret--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     create,
     ret,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ---------------------------
picture pic;
int picnum = 1;

// define nodes
node start=nroundbox("Start");
node shiftleft=nbox("Move left $x_0+\cdots+x_{m-1}+m$ cells");
node inputprefix=nbox(minipage_snug("Put $x_0$, \ldots, $x_{m-1}$ on tape\\ separated by blanks"));
node pointer=nbox("Move I/O head to start of $x_0$");
node run=nbox("Simulate $P_e$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,shiftleft);
vlayout(1.25*v,shiftleft,inputprefix);
vlayout(1.275*v,inputprefix,pointer);
vlayout(1.0*v,pointer,run);
vlayout(1.0*v,run,ending);

// draw edges
draw(pic,
     (start--shiftleft),
     (shiftleft--inputprefix),
     (inputprefix--pointer),
     (pointer--run),
     (run--ending)
);

// draw nodes
draw(pic,
     start,
     shiftleft,
     inputprefix,
     pointer,
     run,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
