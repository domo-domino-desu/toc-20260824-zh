// flowcharts.asy
//  Flow charts illustrating routines

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jhnode;
// Import flowchart commands
import flowchart;

import settings;
settings.outformat="pdf";

// cd("../../../asy/asy-graphtheory-master/modules");
// import node;
// cd("");

string OUTPUT_FN = "flowcharts%02d";



// ---- s-m-n theorem
picture pic;
int picnum = 0;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,a_0,\ldots,a_{m-1}$");
node create=nbox("Create instructions for $\hat{P}$");
node ret=nbox(minipage_snug("Return the index of\\ that instruction set"));
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node shiftleft=nbox("Move left $a_0+\cdots+a_{m-1}+m$ cells");
node inputprefix=nbox(minipage_snug("Put $a_0$, \ldots, $a_{m-1}$ on the tape\\ separated by blanks"));
node pointer=nbox("Move I/O head to the start of $a_0$");
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
setdefaultflowchartstyles();


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
setdefaultflowchartstyles();


// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node test=nrounddiamond("$\TMfcn^K_{e_0}(x)=0\,$?");
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
loop.pos = test.pos + (2.75*u,-0.75*v);
printout.pos = test.pos + (-2.75*u,-0.75*v);
// hlayout(-3.25*u,test,printout);
// hlayout(3.75*u,test,loop);
vlayout(1.1*v,printout,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printout).l(Label("Y",Relative(0.25))),
     (test..HV..loop).l(Label("N",Relative(0.25))).style("leftside"),
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node test=nrounddiamond("$x\in \text{oracle}$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.25*v,read,test);
printzero.pos = test.pos + (-2.25*u,-0.75*v);
loop.pos = test.pos + (2.25*u,-0.75*v);
vlayout(1.0*v,printzero,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l(Label("Y",Relative(0.25))),
     (test..HV..loop).l(Label("N",Relative(0.25))).style("leftside"),
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$x\in \text{oracle}$?");
node printzero=nbox("Print $42$");
node loop=nbox("Loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.25*v,read,test);
printzero.pos = test.pos + (-2.25*u,-0.75*v);
loop.pos = test.pos + (2.25*u,-0.75*v);
vlayout(1.0*v,printzero,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printzero).l(Label("Y",Relative(0.25))),
     (test..HV..loop).l(Label("N",Relative(0.25))).style("leftside"),
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $n,x$");
node getindex=nbox("Run $\TM_n$ on $n$");
node simulate=nbox(minipage_snug("With the result $w$,\\run $\TM_w$ on $x$"));
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node getindex=nbox("Run $\TM_n$ on $n$");
node simulate=nbox(minipage_snug("With the result $w$,\\run $\TM_w$ on $x$"));
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node getindex=nbox("Run $\TM_n$ on $n$");
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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $y$");
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
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
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



// ............. regularize it ...........
picture pic;
int picnum = 15;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node erase=nbox("Erase $\sigma$");
node print=nbox("Output $\composed{\strng}{\mach}\,(s(e_0,\sigma))$");
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



// ............. TM B ...........
picture pic;
int picnum = 16;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\beta$");
node compute=nbox("Compute $\alpha=q(\beta)$");
node print=nbox("Print $\smash{\alpha\concat\beta}$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,compute);
vlayout(1.00*v,compute,print);
vlayout(1.00*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--compute),
     (compute--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     compute,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======= Fixed Point phi_m(y)=m ==============
picture pic;
int picnum = 17;
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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


// ............. Q for machine that knows its source ...........
picture pic;
int picnum = 19;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node movepast=nbox("Move to end of $\sigma$");
node moveonemore=nbox("Move right, past one blank");
node print=nbox("Print $\composed{\strng}{\mach}\,(s(e_0,\sigma))$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,movepast,moveonemore,print);
vlayout(1.0*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--movepast),
     (movepast--moveonemore),
     (moveonemore--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     movepast,
     moveonemore,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............. B for machine that knows its source ...........
picture pic;
int picnum = 20;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\omega$, $\tau$");
node compute=nbox("Compute $\alpha=q(\tau)$");
// node compose=nbox("$\rho=\alpha\concat\tau$");
node print=nbox("Print $\smash{\alpha\concat\tau\concat\str{B}\concat\omega}$");
node run=nbox("Run $\TM[C]$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read,compute);
vlayout(1.00*v,compute,print);
vlayout(1.0*v,print,run);
vlayout(1.0*v,run,ending);

// draw edges
draw(pic,
     (start--read),
     (read--compute),
     (compute--print),
     (print--run),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     compute,
     print,
     run,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============== Oracle machines ================

// ========= just the oracle query box ============
picture pic;
int picnum = 21;
setdefaultflowchartstyles();

// define nodes
node nullboxtop=nbox("\raisebox{.5ex}{$\vdots$}", ns_noborder);  // into oracle? test
node nullboxleft=nbox("\raisebox{1.75ex}{$\vdots$}", ns_noborder); // out on left
node nullboxright=nbox("\raisebox{1.75ex}{$\vdots$}", ns_noborder);  // out on right
node test=nrounddiamond("$x\in\text{oracle}$?");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.5*v,nullboxtop,test);
nullboxleft.pos = test.pos + (-2.75*u,-1.25*v);
nullboxright.pos = test.pos + (2.75*u,-1.25*v);

// draw edges
draw(pic,
     (nullboxtop--test),
     (test..HV..nullboxleft).l(Label("Y",Relative(0.25))),
     (test..HV..nullboxright).l(Label("N",Relative(0.25))).style("leftside")
);

// draw nodes
draw(pic,
     nullboxtop,
     test,
     nullboxleft,
     nullboxright
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ========= oracle TM for P_e(3)\converges ============
picture pic;
int picnum = 22;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $k$");
node test=nrounddiamond("$s(e_0,k)\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= K\leq_T K_0 ============
picture pic;
int picnum = 23;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node test=nrounddiamond("$\sequence{x,x}\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ......... K_0\leq_T K ............
picture pic;
int picnum = 24;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$, $x$");
node test=nrounddiamond("$s(e_0,e,x)\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-3.25*u,-0.75*v);
no.pos = test.pos + (3.25*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= oracle TM for S\leq_T K^S ============
picture pic;
int picnum = 25;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node test=nrounddiamond("$s(e_0,x)\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-3*u,-0.75*v);
no.pos = test.pos + (3*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");







// =============== Exercises ===============
// s-m-n them
string OUTPUT_FN = "flowcharts1%03d";


// .......... flowchart of a simple machine to be parametrized ..
picture pic;
int picnum = 0;
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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
setdefaultflowchartstyles();

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




// ========= Exercise: Use K oracle to compute whether P_e(3) converges ======
picture pic;
int picnum = 33;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 34;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= Exercise: Use K oracle to compute whether P_e ever outputs 7 =====
picture pic;
int picnum = 35;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox(minipage_snug("Dovetail search for $j$\\where $\TM_x$ outputs $7$ on $j$"));
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,run);
vlayout(1.25*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 36;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox(minipage_snug("Dovetail search for $j$\\where $\TM_x$ outputs $7$ on $j$"));
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,run);
vlayout(1.25*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............ Dovetail search for i where P_e outputs 7 on i ...............
picture pic;
int picnum = 37;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node initialize=nbox("$i=0$, $\text{Flag}=F$");
node whilebox=nbox("While $\text{Flag}$ is $F$");
node increment=nbox("Increment $i$");
node forbox=nbox("For $j=0$ to $i$");
node run=nbox(minipage_snug("Run $\TM_x$ on input $j$\\ for $i$-many steps"));
node test=nrounddiamond("Halts and outputs $7$?");
node setflag=nbox("Set $\text{Flag}=T$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,initialize);
vlayout(1.15*v,initialize,whilebox);
hlayout(5.25*u,whilebox,ending);
increment.pos = whilebox.pos + (1*u, -1.15*v);
vlayout(1.15*v,increment,forbox);
run.pos = forbox.pos + (1*u,-1.5*v);
vlayout(1.65*v,run,test);
vlayout(1.5*v,test,setflag);

// draw edges
draw(pic,
     (start--initialize),
     (initialize--whilebox),
     (whilebox--ending).l(Label("Else",Relative(0.25))).style("leftside"),
     (whilebox..VHV..increment),
     (increment--forbox),
     (forbox..VHV..run),
     (forbox..HVHd(-1*u)..increment).l(Label("Done",Relative(0.15))).style("leftside"),
     (run--test),
     (test--setflag).l("Y"),
     (test..HVHd(-6.5*u)..forbox).l(Label("N",Relative(0.1))).style("leftside"),
     // (increment..HVHd(2.25*u)..forbox),
     //     (nullnode--forbox),
     (setflag..HVHd(3*u)..whilebox)
);

// draw nodes
draw(pic,
     start,
     initialize,
     whilebox,
     increment,
     forbox,
     run,
     test,
     setflag,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ P_e(3)=P_{2e}(3) ======================
picture pic;
int picnum = 38;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node runx=nbox("Run $\TM_x$ on input $3$");
node run2x=nbox("Run $\TM_{2x}$ on input $3$");
node test=nrounddiamond("Equal?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,runx);
vlayout(1*v,runx,run2x);
vlayout(1.35*v,run2x,test);
print.pos = test.pos + (-2*u,-1*v);
loop.pos = test.pos + (2*u,-1*v);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--runx),
     (runx--run2x),
     (run2x--test),
     (test..HV..print).l(Label("Y",Relative(0.25))),
     (test..HV..loop).l(Label("N",Relative(0.25))).style("leftside"),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     runx,
     run2x,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .................. after applying s-m-n ..................
picture pic;
int picnum = 39;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node runx=nbox("Run $\TM_x$ on input $3$");
node run2x=nbox("Run $\TM_{2x}$ on input $3$");
node test=nrounddiamond("Equal?");
node print=nbox("Print $42$");
node loop=nbox("Infinite loop");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,runx);
vlayout(1*v,runx,run2x);
vlayout(1.35*v,run2x,test);
print.pos = test.pos + (-2*u,-1*v);
loop.pos = test.pos + (2*u,-1*v);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--runx),
     (runx--run2x),
     (run2x--test),
     (test..HV..print).l(Label("Y",Relative(0.25))),
     (test..HV..loop).l(Label("N",Relative(0.25))).style("leftside"),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     runx,
     run2x,
     test,
     print,
     loop,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============ K\leq_T Tot ======================
picture pic;
int picnum = 40;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .................. after applying s-m-n ..................
picture pic;
int picnum = 41;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ K\leq_T Tot ======================
picture pic;
int picnum = 40;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .................. after applying s-m-n ..................
picture pic;
int picnum = 41;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ K\leq_T Ext ======================
picture pic;
int picnum = 42;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node run2=nbox("Run $\operatorname{steps}(y)$");
node print=nbox("Print that");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,run2);
vlayout(1*v,run2,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--run2),
     (run2--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     run2,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .................. after applying s-m-n ..................
picture pic;
int picnum = 43;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node run2=nbox("Run $\operatorname{steps}(y)$");
node print=nbox("Print that");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,run2);
vlayout(1*v,run2,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--run2),
     (run2--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     run2,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= oracle TM for 2B\leq_T B ============
picture pic;
int picnum = 44;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node oddtest=nrounddiamond("$x$ is odd?");
node test=nrounddiamond("$x/2\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.25*v,read,oddtest);
vlayout(1.65*v,oddtest,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--oddtest),
     (oddtest..HV..no).l(Label("Y",Relative(0.10))).style("leftside"),
     (oddtest--test).l(Label("N",Relative(0.5))).style("leftside"),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     oddtest,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ========= oracle TM for B\leq_T 2B ============
picture pic;
int picnum = 45;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node oddtest=nrounddiamond("$x$ is odd?");
node test=nrounddiamond("$2x\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= oracle TM computing primes dividing n from Primes oracle ========
picture pic;
int picnum = 46;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $n$");
node forbox=nbox("For i in $\leftclosed{2}{n}$");
node oracletest=nrounddiamond("$i\in\text{oracle}$?");
node divtest=nrounddiamond("$i$ divides $n$?");
node print=nbox("Print $i$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,forbox);
hlayout(2.5*u,forbox,ending);
oracletest.pos = forbox.pos + (1*u,-1.5*v);
vlayout(1.75*v,oracletest,divtest);
vlayout(1.5*v,divtest,print);

// draw edges
draw(pic,
     (start--read),
     (read--forbox),
     (forbox--ending),
     (forbox..VHV..oracletest),
     (oracletest..HVHd(1.375*u)..forbox).l(Label("N",Relative(0.08))),
     (oracletest--divtest).l(Label("Y",Relative(0.5))).style("leftside"),
     (divtest..HVHd(1.29*u)..forbox).l(Label("N",Relative(0.05))),
     (divtest--print).l(Label("Y",Relative(0.5))).style("leftside"),
     (print..HVHd(2.5*u)..forbox)
);

// draw nodes
draw(pic,
     start,
     read,
     forbox,
     oracletest,
     divtest,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// == Exercise: Use K oracle to compute whether P_e(3) and P_e(4) converges ==
picture pic;
int picnum = 47;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on $3$ and $4$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 48;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on $3$ and $4$");
node print=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= oracle TM for Ext ============
picture pic;
int picnum = 49;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $k$");
node test=nrounddiamond("$s(e_0,k)\in\text{oracle}$?");  // \notin doesnt work
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("N",Relative(0.25))),
     (test..HV..no).l(Label("Y",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========= oracle A \leq_T A^\comp ============
picture pic;
int picnum = 50;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$y\notin\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ K\leq_T {x| \phi_x(y)=2y} ======================
picture pic;
int picnum = 51;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $2\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .................. after applying s-m-n ..................
picture pic;
int picnum = 52;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $2\cdot y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ============ A\leq_T B implies ... ======================
picture pic;
int picnum = 53;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
// node run=nbox(minipage_snug("\centering \raisebox{1ex}{$\vdots$}\\Compute some $f(x)$\\\raisebox{1.5ex}{$\vdots$}"));
node run=nbox("Compute some $f(x)$");
node test=nrounddiamond("$f(x)\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1.35*v,run,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ................... A^comp \leq_T B .................
picture pic;
int picnum = 54;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
// node run=nbox(minipage_snug("\centering Determine $A(x)$ using oracle \raisebox{1ex}{$\vdots$}\\Compute some $f(x)$\\\raisebox{1.5ex}{$\vdots$}"));
node run=nbox("Determine $A(x)$ using oracle");
node print=nbox("Print $1-\text{result}$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.1*v,read,run);
vlayout(1.1*v,run,print);
vlayout(1*v,print,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--print),
     (print--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     print,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .............. A\leq_T B^comp ............
picture pic;
int picnum = 55;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
// node run=nbox(minipage_snug("\centering \raisebox{1ex}{$\vdots$}\\Compute some $f(x)$\\\raisebox{1.5ex}{$\vdots$}"));
node run=nbox("Compute some $f(x)$");
node test=nrounddiamond("$f(x)\notin\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1.35*v,run,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ========= Exercise: P_e(3)\leq_T K converges ======
picture pic;
int picnum = 56;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node run=nbox("Run $\TM_x$ on $3$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ............ After s-m-n ..................
picture pic;
int picnum = 57;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node run=nbox("Run $\TM_x$ on $3$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ........ oracle TM for P_e(3) \leq_T K ..........
picture pic;
int picnum = 58;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node test=nrounddiamond("$s(e_0,x)\in\text{oracle}$?");
node yes=nbox("Print $1$");
node no=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(0.8*v,start,read);
vlayout(1.25*v,read,test);
yes.pos = test.pos + (-2.75*u,-0.75*v);
no.pos = test.pos + (2.75*u,-0.75*v);
vlayout(2*v,test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yes).l(Label("Y",Relative(0.25))),
     (test..HV..no).l(Label("N",Relative(0.25))).style("leftside"),
     (yes..VHV..ending),
     (no..VHV..ending)
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yes,
     no,
     ending
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
