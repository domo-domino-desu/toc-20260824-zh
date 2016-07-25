// pad.asy
//  Flow chart showing how \TM_e(x) is coded as \TM_{f(e)}
cd("../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../asy");
import jh;
cd("");

import settings;
settings.outformat="pdf";

import node;
size(0,0);  // units are big points: 72 is 1inch


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node test=nrounddiamond("$\TM_e(e)$ halts?");
node printout=nbox("Output 0");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(start,read);
vlayout(1.35u,read,test);
hlayout(-5u,test,printout);
hlayout(5u,test,loop);
vlayout(1.25u,printout,ending);

// draw nodes
draw(start,
     read, 
     test,
     printout,
     loop, 
     ending
     );

// draw edges
draw(
     (start--read),
     (read--test),
     (test--printout).l("No"),
     (test--loop).l("Yes").style("leftside"),
     (printout--ending)
);
