// flowcharts.asy
//  flowcharts for complexity chapter

import settings; 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set LaTeX defaults
import settexpreamble;
settexpreamble();
// Asy defaults
import jhnode;
import flowchart;

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
node printyes=nbox("Accept");
node printno=nbox("Reject");
// node printyes=nbox("Print \str{1}");
// node printno=nbox("Print \str{0}");
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
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Check that~$\omega$ is a path in $\sigma$'s graph");
node test=nrounddiamond("All vertices visited once?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
// node printyes=nbox("Print \str{1}");
// node printno=nbox("Print \str{0}");
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
hlayout(-4.25*u,dummy,printyes);
hlayout(4.25*u,dummy,printno);

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





// ============ Exercise: Fin \leq_p Reg =======================
picture pic;
int picnum = 2;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $x$");
node testmatch=nrounddiamond("$\sigma$ matches $\str{a}^n\str{b}^n$?");
node testlen=nrounddiamond("$\TM_x$ accepts a $\tau$ of length~$n$?");
node printyes=nbox("Print \str{1}");
node printno=nbox("Print \str{0}");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.25*v,read,testmatch);
vlayout(1.85*v,testmatch,testlen);
printyes.pos = testlen.pos+(-5.0*u,-0.8*v);
printno.pos = testlen.pos+(5.0*u,-0.8*v);
vlayout(2*v,testlen,ending);

// draw edges
draw(pic,
     (start--read),
     (read--testmatch),
     (testmatch--testlen).l("Y").style("leftside"),
     (testmatch..HV..printno).l(Label("N",Relative(0.15))).style("leftside"),
     (testlen..HV..printyes).l(Label("Y",Relative(0.25))),
     (testlen..HV..printno).l(Label("N",Relative(0.35))).style("leftside"),
     (printyes..VHV..ending),
     (printno..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     testmatch,
     testlen,
     printyes,
     printno,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................... after s-m-n ................
picture pic;
int picnum = 3;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node testmatch=nrounddiamond("$\sigma$ matches $\str{a}^n\str{b}^n$?");
node testlen=nrounddiamond("$\TM_x$ accepts a $\tau$ of length~$n$?");
node printyes=nbox("Print \str{1}");
node printno=nbox("Print \str{0}");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.25*v,read,testmatch);
vlayout(1.85*v,testmatch,testlen);
printyes.pos = testlen.pos+(-5.0*u,-0.8*v);
printno.pos = testlen.pos+(5.0*u,-0.8*v);
vlayout(2*v,testlen,ending);

// draw edges
draw(pic,
     (start--read),
     (read--testmatch),
     (testmatch--testlen).l("Y").style("leftside"),
     (testmatch..HV..printno).l(Label("N",Relative(0.15))).style("leftside"),
     (testlen..HV..printyes).l(Label("Y",Relative(0.25))),
     (testlen..HV..printno).l(Label("N",Relative(0.35))).style("leftside"),
     (printyes..VHV..ending),
     (printno..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     testmatch,
     testlen,
     printyes,
     printno,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







