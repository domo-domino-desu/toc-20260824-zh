// pad.asy
//  Flow chart showing how \TM_e(x) is coded as \TM_{f(e)}
cd("../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../asy");
import jh;
import flowchart;
cd("");

import settings;
settings.outformat="pdf";

import node;
// size(0.5cm);  // units are big points: 72 is 1inch

// pen NODEPEN=fontsize(8pt);
// pen EDGEPEN=fontsize(6pt); // +fontcommand("\ttfamily");
// // // define edge style
// defaultdrawstyle=drawstyle(p=EDGEPEN+fontcommand("\sffamily"), arrow=Arrow(DefaultHead,size=3));
// // // Standard node is single-circle border
// defaultnodestyle=nodestyle(textpen=NODEPEN+fontcommand("\sffamily"), xmargin=1pt, drawfn=FillDrawer(backgroundcolor,black));
// // // Double circle nodes
// nodestyle ns_accepting=nodestyle(textpen=NODEPEN+fontcommand("\sffamily"), drawfn=Filler(FILLCOLOR)+DoubleDrawer(black));
// // // nodes without any boxing
// nodestyle ns_noborder=nodestyle(textpen=NODEPEN+fontcommand("\sffamily"), xmargin=1pt, drawfn=None);

// ---- Unbounded search for perfect numbers
picture pic;
int picnum = 0;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node initial=nbox("$i=0$");
node iterate=nbox("$i=i+1$");
node test=nrounddiamond("$2i+1$ perfect?");
node printout=nbox("Print 1");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,initial);
vlayout(1.5u,initial,test);
// hlayout(-3.75u,test,printout);
vlayout(1.5u,test,printout);
hlayout(-3.75u,test,iterate);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read,
     initial,
     test,
     iterate,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--initial),
     (initial--test),
     (iterate--VH--middle(initial,test)),
     (test--printout).l("Yes").style("leftside"),
     (test--iterate).l("No").style("leftside"),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");



// ---- With halt_checker all fcns total
picture pic;
int picnum = 1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x$");
node test=nrounddiamond("$\phi_e(x)\!\converges$\,?");
node printout=nbox("Print $\phi_e(x)$");
node ow=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(1.25u,read,test);
// hlayout(-3.75u,test,printout);
vlayout(1.5u,test,printout);
hlayout(-2.5u,printout,ow);
vlayout(1.25u,printout,ending);

// draw nodes
draw(pic,
     start,
     read,
     test,
     printout,
     ow,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--HV--ow).label(Label("No",position=Relative(0.25))).style("rightside"),
     (test--printout).l("Yes").style("leftside"),
     (ow--VH--middle(printout,ending)),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");




// ---- Diagonalization to get a contradiction
picture pic;
int picnum = 2;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node simulate=nbox(minipage3("Compute table entry\\for index~$e$, input~$e$"));
node printout=nbox("Print $\text{result}+1$");
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
draw(pic,
     start,
     read, 
     simulate,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--printout),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");




// ---- K0 reduces to K, before s-m-n thm
picture pic;
int picnum = 3;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x,y$");
node simulate=nbox(minipage2("Simulate $\TM_{e}$\\ on input~$x$"));
node printout=nbox("Output 0");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(start,read);
vlayout(1.25u,read,simulate);
vlayout(1.25u,simulate,printout);
vlayout(printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--printout),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");


// ---- K0 reduces to K, after s-m-n thm
picture pic;
int picnum = 4;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox(minipage2("Simulate $\TM_{e}$\\ on input~$x$"));
node printout=nbox("Output 0");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(start,read);
vlayout(1.25u,read,simulate);
vlayout(1.25u,simulate,printout);
vlayout(printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--printout),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");



// ---- the Halting Problem is unsolvable
picture pic;
int picnum = 5;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node test=nrounddiamond("$\TM_e(e)$ halts?");
node printout=nbox("Print 0");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(1.2u,read,test);
hlayout(-3.5u,test,printout);
hlayout(3.85u,test,loop);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     loop, 
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("No"),
     (test--loop).l("Yes").style("leftside"),
     (printout--ending)
);

shipout(format("perfect%02d",picnum),pic,format="pdf");

