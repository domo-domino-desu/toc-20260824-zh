// flowcharts.asy
//  Flow charts illustrating routines
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy");
import jhnode;
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
node read=nbox("Read $e,a_0,\ldots,a_{m-1}$");
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
node shiftleft=nbox("Move left $a_0+\cdots+a_{m-1}+m$ cells");
node inputprefix=nbox(minipage_snug("Put $a_0$, \ldots, $a_{m-1}$ on tape\\ separated by blanks"));
node pointer=nbox("Move I/O head to start of $a_0$");
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
node test=nrounddiamond("$K(e)=0$?");
node printout=nbox("Print 42");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-3*u,test,printout);
hlayout(3.35*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("Y"),
     (test--loop).l("N").style("leftside"),
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
node read=nbox("Read $x$");
node test=nrounddiamond("$\TMfcn^K_e(x)=1$?");
node printout=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-3.25*u,test,printout);
hlayout(3.75*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("N"),
     (test--loop).l("Y").style("leftside"),
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
node test=nrounddiamond("$x\in X$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
printzero.pos = test.pos + (-2*u,-1.0*v);
loop.pos = test.pos + (2*u,-1.0*v);
vlayout(1.0*v,printzero,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (printzero--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     loop, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ........ apply s-m-n thm ........
picture pic;
int picnum = 5;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$x\in X$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
printzero.pos = test.pos + (-2*u,-1.0*v);
loop.pos = test.pos + (2*u,-1.0*v);
vlayout(1.0*v,printzero,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (printzero--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     loop, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// // ---- relativization to K -------------
// picture pic;
// int picnum = 5;

// // define nodes
// node start=nroundbox("Start");
// node read=nbox("Read $y$");
// node test=nrounddiamond("oracle(x)?");
// node printzero=nbox("Print 0");
// node printone=nbox("Print 1");
// node ending=nroundbox("End");

// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 0.75cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

// vlayout(1*v,start,read);
// vlayout(1.35*v,read,test);
// vlayout(1.3*v,test,ending);
// hlayout(-2.0*u,ending,printzero);
// hlayout(2.0*u,ending,printone);

// // draw edges
// draw(pic,
//      (start--read),
//      (read--test),
//      (test..HV..printzero).l("N"),
//      (test..HV..printone).l("Y").style("leftside"),
//      (printzero--ending),
//      (printone--ending)
// );

// // draw nodes
// draw(pic,
//      start,
//      read, 
//      test,
//      printzero,
//      printone, 
//      ending
//      );

// shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ---- recursion theorem -------------
picture pic;
int picnum = 6;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x$");
node getindex=nbox("Run $\TM_e$ on $e$");
node simulate=nbox(minipage_snug("With the result $w$,\\run $\TM_w$ on input $x$"));
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,getindex);
vlayout(1.4*v,getindex,simulate);
vlayout(1.3*v,simulate,end);

// draw edges
draw(pic,
     (start--read),
     (read--getindex),
     (getindex--simulate),
     (simulate--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     getindex,
     simulate, 
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................
picture pic;
int picnum = 7;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node getindex=nbox("Run $\TM_e$ on $e$");
node simulate=nbox(minipage_snug("With the result $w$,\\run $\TM_w$ on input $x$"));
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,getindex);
vlayout(1.4*v,getindex,simulate);
vlayout(1.3*v,simulate,end);

// draw edges
draw(pic,
     (start--read),
     (read--getindex),
     (getindex--simulate),
     (simulate--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     getindex,
     simulate, 
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................
picture pic;
int picnum = 8;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node getindex=nbox("Run $\TM_e$ on $e$");
node simulate=nbox("With the result $w$, run $\TM_{f(w)}$ on $x$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,getindex);
vlayout(1.2*v,getindex,simulate);
vlayout(1.2*v,simulate,end);

// draw edges
draw(pic,
     (start--read),
     (read--getindex),
     (getindex--simulate),
     (simulate--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     getindex,
     simulate, 
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======== application of recursion theorem W_m={m} ==============
picture pic;
int picnum = 9;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,m$");
node test=nrounddiamond("$x=m$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node dummy=nbox("");  
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
vlayout(0.9*v,test,dummy);
hlayout(-1.5*u,dummy,printzero);
vlayout(1.0*v,printzero,end);
hlayout(1.5*u,dummy,loop);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (printzero--end)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     loop, 
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..........................
picture pic;
int picnum = 10;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node test=nrounddiamond("$x=m$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node dummy=nbox("");  
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
vlayout(0.9*v,test,dummy);
hlayout(-1.5*u,dummy,printzero);
vlayout(1.0*v,printzero,end);
hlayout(1.5*u,dummy,loop);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (printzero--end)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printzero,
     loop, 
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ---- Exercise on Fixed Point Theorem
picture pic;
int picnum = 11;

// define nodes
node start=nroundbox("Start");
node pstart=nbox("Print ``Start''");
node pprinte=nbox("Print ``Print ''+ $e$");
node pend=nbox("Print ``End''");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,pstart);
vlayout(1.0*v,pstart,pprinte);
vlayout(1.0*v,pprinte,pend);
vlayout(1.0*v,pend,ending);

// draw edges
draw(pic,
     (start--pstart),
     (pstart--pprinte),
     (pprinte--pend),
     (pend--ending)
);

// draw nodes
draw(pic,
     start,
     pstart,
     pprinte,
     pend,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ........... second part of that exercise
picture pic;
int picnum = 12;

// define nodes
node start=nroundbox("Start");
node ppofe=nbox("Print machine number $P(e)$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,ppofe);
vlayout(1.0*v,ppofe,ending);

// draw edges
draw(pic,
     (start--ppofe),
     (ppofe--ending)
);

// draw nodes
draw(pic,
     start,
     ppofe,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =========== Programs that know their own source ==========
picture pic;
int picnum = 13;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node print=nbox("Print $\sigma$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............. apply smn to prior ...........
picture pic;
int picnum = 14;

// define nodes
node start=nroundbox("Start");
node print=nbox("Print $\sigma$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............. regularize it ...........
picture pic;
int picnum = 15;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node erase=nbox("Erase $\sigma$");
node print=nbox("Print $m(\,s(e_0,\sigma)\,)$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,erase,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--erase),
     (erase--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     erase,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............. TM B ...........
picture pic;
int picnum = 16;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\tau$");
node print=nbox("Print $q(\tau)\concat\tau$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ======= Fixed Point phi_m(y)=m ==============
picture pic;
int picnum = 17;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node print=nbox("Print $x$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...... after smn .............
picture pic;
int picnum = 18;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $x$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// =============== Exercises ===============
// s-m-n them
string OUTPUT_FN = "flowcharts1%03d";


// .......... flowchart of a simple machine to be parametrized ..
picture pic;
int picnum = 0;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_0$, $x_1$");
node print=nbox("Print $x_0+x_1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .......... answer: freeze it at x0=1 ..
picture pic;
int picnum = 1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $1+x_1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .......... answer: freeze it at x0=0 ..
picture pic;
int picnum = 2;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$");
node print=nbox("Print $0+x_1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ==== flowchart of a simple machine to be parametrized x0+x1*x2 
picture pic;
int picnum = 3;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_0$, $x_1$, $x_2$");
node print=nbox("Print $x_0+x_1\cdot x_2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ... answer: freeze x_0=1
picture pic;
int picnum = 4;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_1$, $x_2$");
node print=nbox("Print $1+x_1\cdot x_2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ... answer: freeze x_0=1, x1=2
picture pic;
int picnum = 5;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_2$");
node print=nbox("Print $1+2\cdot x_2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ==== flowchart of a simple machine to be parametrized with decision box 
picture pic;
int picnum = 6;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_0$, $x_1$");
node test=nrounddiamond("$x_0>1$?");
node printout=nbox("Print $x_1$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
hlayout(-3*u,test,printout);
hlayout(3.35*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout).l("N"),
     (test--loop).l("Y").style("leftside"),
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



// .......... flowchart of a machine that will parametrize to a family ..
picture pic;
int picnum = 7;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node print=nbox("Print $x\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... fix x=0 ..
picture pic;
int picnum = 8;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $0\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... fix x=1 ..
picture pic;
int picnum = 9;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $1\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... fix x=2 ..
picture pic;
int picnum = 10;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $2\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... leave x=x ..
picture pic;
int picnum = 11;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $x\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.0*v,read,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... flowchart of a machine that will parametrize to a family ..
picture pic;
int picnum = 12;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x_0$, $x_1$, $y$");
node test=nrounddiamond("$x_0$ even?");
node ybranch=nbox("Print $x_1\cdot y$");
node nbranch=nbox("Print $x_1+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
ybranch.pos = test.pos + (-2*u,-1.0*v);
nbranch.pos = test.pos + (2*u,-1.0*v);
vlayout(1.85*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..ybranch).l("Y"),
     (test..HV..nbranch).l("N").style("leftside"),
     (ybranch..VH..ending),
     (nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     ybranch,
     nbranch, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... parametrize x_0=0, x_1=3 ..
picture pic;
int picnum = 13;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$0$ even?");
node ybranch=nbox("Print $3\cdot y$");
node nbranch=nbox("Print $3+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
ybranch.pos = test.pos + (-2*u,-1.0*v);
nbranch.pos = test.pos + (2*u,-1.0*v);
vlayout(1.85*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..ybranch).l("Y"),
     (test..HV..nbranch).l("N").style("leftside"),
     (ybranch..VH..ending),
     (nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     ybranch,
     nbranch, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... parametrize x_0=1, x_1=3 ..
picture pic;
int picnum = 14;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$1$ even?");
node ybranch=nbox("Print $3\cdot y$");
node nbranch=nbox("Print $3+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
ybranch.pos = test.pos + (-2*u,-1.0*v);
nbranch.pos = test.pos + (2*u,-1.0*v);
vlayout(1.85*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..ybranch).l("Y"),
     (test..HV..nbranch).l("N").style("leftside"),
     (ybranch..VH..ending),
     (nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     ybranch,
     nbranch, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... parametrize x_0=a, x_1=b ..
picture pic;
int picnum = 15;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$a$ even?");
node ybranch=nbox("Print $b\cdot y$");
node nbranch=nbox("Print $b+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
ybranch.pos = test.pos + (-2*u,-1.0*v);
nbranch.pos = test.pos + (2*u,-1.0*v);
vlayout(1.85*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..ybranch).l("Y"),
     (test..HV..nbranch).l("N").style("leftside"),
     (ybranch..VH..ending),
     (nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     ybranch,
     nbranch, 
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .......... family computing y |--> y+n^2 ....
picture pic;
int picnum = 16;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node print=nbox("Print $y+x^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... family computing x |--> mx+b ....
picture pic;
int picnum = 17;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $u$, $v$, $x$");
node print=nbox("Print $u\cdot x+v$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// .......... family computing y |--> 3n+y ....
picture pic;
int picnum = 18;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node print=nbox("Print $3\cdot x + y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========== Compute y |--> 7 =========
picture pic;
int picnum = 19;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node simulate=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $7$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,simulate);
vlayout(1*v,simulate,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     simulate,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .... Compute y |--> 7 after s-m-n ........
picture pic;
int picnum = 20;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $7$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,simulate);
vlayout(1*v,simulate,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     simulate,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========== Compute y |--> 2y =========
picture pic;
int picnum = 21;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node simulate=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $2y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,simulate);
vlayout(1*v,simulate,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     simulate,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// .... Compute y |--> 2y after s-m-n ........
picture pic;
int picnum = 22;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $2y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,simulate);
vlayout(1*v,simulate,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     simulate,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= W_e = {0,1,2,.. e} =========
picture pic;
int picnum = 23;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nrounddiamond("$y\leq x$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ......... after smn ..........
picture pic;
int picnum = 24;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$y\leq x$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= W_e = {e-th prime number} =========
picture pic;
int picnum = 25;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nrounddiamond("$y=p(x)$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ....... after smn .................
picture pic;
int picnum = 26;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$y=p(x)$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= W_m = {m^2} =========
picture pic;
int picnum = 27;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nrounddiamond("$y=x^2$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 28;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$y=x^2$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= W_m = N-{m} =========
picture pic;
int picnum = 29;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nrounddiamond("$y\neq x$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 30;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$y\neq x$?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,test);
print.pos = test.pos +(-2.0*u,-1.0*v);
loop.pos = test.pos +(2.0*u,-1.0*v);
vlayout(1.65*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..print).l("Y"),
     (test..HV..loop).l("N").style("leftside"),
     (print..VH..ending),
     (loop..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ========= range of \phi_m={m} =========
picture pic;
int picnum = 31;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node print=nbox("Print $x$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 32;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node print=nbox("Print $x$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
