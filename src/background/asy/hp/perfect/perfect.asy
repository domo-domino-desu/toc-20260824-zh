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
node read=nbox("Read $x$");
node initial=nbox("$i=0$");
node iterate=nbox("$i=i+1$");
node test=nrounddiamond("$2i+1$ perfect?");
node printout=nbox("Output 1");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(start,read);
vlayout(read,initial);
vlayout(1.35u,initial,test);
hlayout(-4.5u,test,printout);
hlayout(4.5u,test,iterate);
vlayout(1u,printout,ending);

// draw nodes
draw(start,
     read,
     initial,
     test,
     iterate,
     printout,
     // loop, 
     ending
     );

// draw edges
draw(
     (start--read),
     (read--initial),
     (initial--test),
     (iterate--VH--middle(initial,test)),
     (test--printout).l("Yes"),
     (test--iterate).l("No").style("leftside"),
     (printout--ending)
);
