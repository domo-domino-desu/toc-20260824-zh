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
node read=nbox("Read $e,x_0,\ldots,x_n$");
node erase=nbox("Back up, erase $e$");
node pos=nbox("Move I/O head to start of $x_0$");
node run=nbox("Begin simulation of $\TM_e$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,erase);
vlayout(0.85u,erase,pos);
vlayout(0.85u,pos,run);
vlayout(0.85u,run,ending);

// draw edges
draw(pic,
     (start--read),
     (read--erase),
     (erase--pos),
     (pos--run),
     (run--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     erase,
     pos,
     run,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
