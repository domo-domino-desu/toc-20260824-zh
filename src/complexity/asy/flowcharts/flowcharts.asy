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
node compute=nbox("Interpret~$\sigma$ as $\sequence{\mathcal{G},v,\hat{v}}$ and $\omega$ as a path in $\mathcal{G}$ from $v$ to $\hat{v}$");
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
vlayout(0.80*v,test,dummy);
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



// ============ Nondeterministic Bounded Halting problem ===================
picture pic;
int picnum = 4;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$");
node guess=nbox("Guess $\omega$");
node test=nrounddiamond("$V(\sigma,\omega)$ accepts?");
node yesbox=nbox("Halt");
node nobox=nbox("Inf loop");
node dummy=nbox("");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.15*v,read,guess);
vlayout(1.5*v,guess,test);
vlayout(0.75*v,test,dummy);
hlayout(-3.1*u,dummy,yesbox);
hlayout(3.1*u,dummy,nobox);

// draw edges
draw(pic,
     (start--read),
     (read--guess),
     (guess--test),
     (test..HV..yesbox).l("Y"),
     (test..HV..nobox).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     guess,
     test,
     yesbox,
     nobox
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ......... parametrize sigma .................
picture pic;
int picnum = 5;
setdefaultflowchartstyles();

// define nodes
// node start=nroundbox("Start");
// node read=nbox("Read $\tau$");
// node guess=nbox("Guess $\omega$");
// node test=nrounddiamond("$V(\sigma,\omega)$ accepts?");
// node yesbox=nbox("Halt");
// node nobox=nbox("Inf loop");
// node dummy=nbox("");

// // layout
// defaultlayoutrel = false;
// defaultlayoutskip = 0.75cm;
// real u = defaultlayoutskip;
// real v = 0.85*u;

vlayout(1.15*v,start,guess);
// vlayout(1.15*v,read,guess);
vlayout(1.5*v,read,test);
vlayout(0.75*v,test,dummy);
hlayout(-3.1*u,dummy,yesbox);
hlayout(3.1*u,dummy,nobox);

// draw edges
draw(pic,
     (start--guess),
     (guess--test),
     (test..HV..yesbox).l("Y"),
     (test..HV..nobox).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     guess,
     test,
     yesbox,
     nobox
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ============ Bounded Halting problem =======================
picture pic;
int picnum = 6;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node test=nrounddiamond("$V(\sigma,\omega)$ accepts?");
node nobox=nbox("Halt");
node yesbox=nbox("Inf loop");
node dummy=nbox("");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.5*v,read,test);
vlayout(0.75*v,test,dummy);
hlayout(3.1*u,dummy,nobox);
hlayout(-3.1*u,dummy,yesbox);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yesbox).l("Y"),
     (test..HV..nobox).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yesbox,
     nobox
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ......... parametrize sigma .................
picture pic;
int picnum = 7;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\omega$");
node test=nrounddiamond("$V(\sigma,\omega)$ accepts?");
node nobox=nbox("Halt");
node yesbox=nbox("Inf loop");
node dummy=nbox("");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.5*v,read,test);
vlayout(0.75*v,test,dummy);
hlayout(3.1*u,dummy,nobox);
hlayout(-3.1*u,dummy,yesbox);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..yesbox).l("Y"),
     (test..HV..nobox).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     yesbox,
     nobox
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");






// ============ verifier for just do what the witness says =================
picture pic;
int picnum = 8;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node test=nrounddiamond("$\omega=1$?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
node dummy=nbox("");  

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.15*v,start,read);
vlayout(1.35*v,read,test);
vlayout(1.15*v,test,dummy);
hlayout(-2.25*u,dummy,printyes);
hlayout(2.25*u,dummy,printno);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printyes).l("Y"),
     (test..HV..printno).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     printyes,
     printno
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ============ verifier for 3DMatching exercise =======================
picture pic;
int picnum = 9;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $M$ and $\omega$ as $\hat{M}$");
node test=nrounddiamond("Any triples share an entry?");
node printyes=nbox("Reject");
node printno=nbox("Accept");
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



// ............... verifier for Partition exercise .....
picture pic;
int picnum = 10;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $A$ and $\omega$ as $\hat{A}$");
node test=nrounddiamond("$\textstyle \sum_{a\in\hat{A}}a=\sum_{a\in A-\hat{A}}a$?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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


//  =========== verifier for Graph colorability exercise ==========
picture pic;
int picnum = 11;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $\sequence{\mathcal{G},B}$ and $\omega$ as a $B$-coloring");
node test=nrounddiamond("Is the coloring valid?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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



//  =========== verifier for Countdown exercise ==========
picture pic;
int picnum = 12;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $\sequence{s_0,\ldots\,s_5,T}$ and $\omega$ as an arithmetic expression");
node test=nrounddiamond("The expression adds to $T$?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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



//  =========== verifier for Traveling Salesman exercise ==========
picture pic;
int picnum = 13;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as weighted graph $\mathcal{G}$ and $\omega$ as a circuit");
node test=nrounddiamond("Circuit weight no more than $B$?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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
hlayout(-5.25*u,dummy,printyes);
hlayout(5.25*u,dummy,printno);

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



//  =========== verifier for Independent Set exercise ==========
picture pic;
int picnum = 14;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as a pair $\mathcal{G},n$ and $\omega$ as $n$ vertices");
node test=nrounddiamond("Vertices are independent?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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
hlayout(-5.25*u,dummy,printyes);
hlayout(5.25*u,dummy,printno);

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



//  =========== verifier for Knapsack exercise ==========
picture pic;
int picnum = 15;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $\sequence{(w_0,v_0),\ldots{} (w_{n-1},v_{n-1}),B,T}$ and $\omega$ as $\set{i_0,\ldots{} i_k}\subseteq\set{0,\ldots{} n-1}$");
node test=nrounddiamond("Weights and values meet goals?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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
hlayout(-5.25*u,dummy,printyes);
hlayout(5.25*u,dummy,printno);

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



//  =========== verifier for Primality example ==========
picture pic;
int picnum = 16;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $n\in\N^+$ and $\omega$ as $d\in\open{1}{n}$");
node test=nrounddiamond("Does $d$ divide $n$?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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




//  =========== verifier for Longest Path exercise ==========
picture pic;
int picnum = 17;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $\sigma$, $\omega$");
node compute=nbox("Interpret $\sigma$ as $\sequence{\mathcal{G},B}$ and $\omega$ as a simple path");
node test=nrounddiamond("Is the path long enough?");
node printyes=nbox("Accept");
node printno=nbox("Reject");
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




//  =========== HP is NP hard, not NP ==========
picture pic;
int picnum = 18;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nrounddiamond("$\sigma$ is satisfiable?");
node printyes=nbox("Halt");
node printno=nbox("Inf loop");
node dummy=nbox("");  

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1.0*v,start,read);
vlayout(1.35*v,read,test);
vlayout(0.8*v,test,dummy);
hlayout(-2.75*u,dummy,printyes);
hlayout(2.75*u,dummy,printno);

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test..HV..printyes).l("Y"),
     (test..HV..printno).l("N").style("leftside")
);

// draw nodes
draw(pic,
     start,
     read,
     test,
     printyes,
     printno
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");









