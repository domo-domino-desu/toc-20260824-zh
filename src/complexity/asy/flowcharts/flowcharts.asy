// flowcharts.asy
//  flowcharts for complexity chapter

import settings; 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jhnode;
cd("");
cd("../../../asy/");
import flowchart;
cd("");
// cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
// import node;
// cd("");


// define style
defaultnodestyle=nodestyle(xmargin=1pt,
			   textpen=fontsize(7pt),
			   drawfn=FillDrawer(verylightcolor,boldcolor));

defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+black,
			   arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));
// Pen for edges when Labelled
pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
// color edges in walk
pen walk_pen = linewidth(0.75bp) + highlight_color;


import graph;

string OUTPUT_FN = "flowcharts%03d";



// ============ verifier for SAT =======================
picture pic;
int picnum = 0;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Compute line~$\omega$ of $\sigma$'s truth table");
node test=nrounddiamond("It gives $T\,$?");
node printyes=nbox("Print \str{1}");
node printno=nbox("Print \str{0}");
node dummy=nbox("");  

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.15*v,read,compute);
vlayout(1.40*v,compute,test);
vlayout(1.15*v,test,dummy);
hlayout(-2.5*u,dummy,printyes);
hlayout(2.5*u,dummy,printno);

// draw edges
draw(pic,
     (start--read),
     (read--compute),
     (compute--test),
     (test..HV..printyes).l("Y"),
     (test..HV..printno).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     compute,
     test,
     printyes,
     printno
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============ verifier for HamPath =======================
picture pic;
int picnum = 1;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma=\sequence{\mathcal{G},v,\hat{v}}$, $\omega$");
node compute=nbox("Check that~$\omega$ is a path in $\sigma$'s graph");
node test=nrounddiamond("All vertices visited?");
node printyes=nbox("Print \str{1}");
node printno=nbox("Print \str{0}");
node dummy=nbox("");  

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.15*v,read,compute);
vlayout(1.40*v,compute,test);
vlayout(1.15*v,test,dummy);
hlayout(-3.25*u,dummy,printyes);
hlayout(3.25*u,dummy,printno);

// draw edges
draw(pic,
     (start--read),
     (read--compute),
     (compute--test),
     (test..HV..printyes).l("Y"),
     (test..HV..printno).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     compute,
     test,
     printyes,
     printno
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







