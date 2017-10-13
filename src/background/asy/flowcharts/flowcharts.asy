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





// ================= Proof of HP ==============
picture pic;
int picnum = 2;


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node test=nrounddiamond("$\TMfcn_e(e)\converges$?");
node printout=nbox("Print 0");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-2.8*u,test,printout);
hlayout(3.15*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("No"),
     (test--loop).l("Yes").style("leftside"),
     (printout--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     loop, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ---- relativization to K -------------
picture pic;
int picnum = 3;


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node test=nrounddiamond("$\TMfcn^K_e(e)\converges$?");
node printout=nbox("Print 0");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-2.8*u,test,printout);
hlayout(3.15*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("No"),
     (test--loop).l("Yes").style("leftside"),
     (printout--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     loop, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ================= K\leq K^K ==============
picture pic;
int picnum = 4;


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node test=nrounddiamond("oracle(x)?");
node printzero=nbox("Print 0");
node printone=nbox("Print 1");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-3*u,test,printzero);
hlayout(3.15*u,test,printone);
vlayout(1.3*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printzero).l("No"),
     (test--printone).l("Yes").style("leftside"),
     (printzero..VH..ending),
     (printone..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     printone, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ---- relativization to K -------------
picture pic;
int picnum = 5;


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("oracle(x)?");
node printzero=nbox("Print 0");
node printone=nbox("Print 1");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-3*u,test,printzero);
hlayout(3.15*u,test,printone);
vlayout(1.3*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printzero).l("No"),
     (test--printone).l("Yes").style("leftside"),
     (printzero..VH..ending),
     (printone..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     printone, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
