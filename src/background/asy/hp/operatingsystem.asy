// operatingsystem.asy
//  Flow chart describing how an operating system is like a UTM
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy");
import jh;
cd("");

import settings;
settings.outformat="pdf";

import node;
size(0,0);  // units are big points: 72 is 1inch

// defaultnodestyle=nodestyle(xmargin=3pt, ymargin=0,
// 			   drawfn=None); // FillDrawer(lightgray,black));

// defaultnodestyle=nodestyle(xmargin=3pt, ymargin=0,
// 			   drawfn=FillDrawer(lightgray,black));
// nodestyle ns2=nodestyle(xmargin=0, ymargin=3pt,
// 			drawfn=FillDrawer(lightgray,black));
// defaultdrawstyle=drawstyle(p=fontsize(8pt)+fontcommand("\ttfamily"),
// 			   arrow=Arrow(6));

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x$");
node simulate=nbox(minipage("\centering Simulate $\TM_e$ on input~$x$",1.85cm));
node printout=nbox("Print result");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(start, read);
vlayout(1.25u,read,simulate);
vlayout(1.25u,simulate,printout);
vlayout(printout,ending);

// draw nodes
draw(start,
     read, 
     simulate,
     printout,
     ending
     );

// draw edges
draw(
     (start--read),
     (read--simulate),
     (simulate--printout),
     (printout--ending)
);
