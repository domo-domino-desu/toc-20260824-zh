// perfect.asy
//  Flow charts showing Halting Problem args
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../asy");
import jhnode;
cd("");
cd("../../../asy");
import flowchart;
cd("");

import settings;
settings.outformat="pdf";

// cd("../../../asy/asy-graphtheory-master/modules");
// import node;
// cd("");
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

// ==========================================
// Format of the names of the files produced (another format is below)
string OUTPUT_FILE = "hp%02d";  

// =================== Unbounded search for perfect numbers =========
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

shipout(format("hp%02d",picnum),pic,format="pdf");



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

shipout(format("hp%02d",picnum),pic,format="pdf");




// ---- Diagonalization to get a contradiction
picture pic;
int picnum = 2;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e$");
node simulate=nbox(minipage_snug("Compute table entry\\for index~$e$, input~$e$")); // was minipage3
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

shipout(format("hp%02d",picnum),pic,format="pdf");




// ---- K0 reduces to K, before s-m-n thm
picture pic;
int picnum = 3;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x,y$");
node simulate=nbox(minipage2("Simulate $\TM_{e}$\\ on input~$x$"));
node printout=nbox("Print 42");
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

shipout(format("hp%02d",picnum),pic,format="pdf");


// ---- K0 reduces to K, after s-m-n thm
picture pic;
int picnum = 4;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox(minipage2("Simulate $\TM_{e}$\\ on input~$x$"));
node printout=nbox("Print 42");
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

shipout(format("hp%02d",picnum),pic,format="pdf");



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

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- halts on three is unsolvable, before s-m-n
picture pic;
picnum = 6;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print 42");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- halts on three is unsolvable, after s-m-n
picture pic;
picnum = 7;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print 42");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");


// ---- outputs seven is unsolvable, before s-m-n
picture pic;
picnum = 8;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print 7");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- outputs seven is unsolvable, after s-m-n
picture pic;
picnum = picnum+1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print 7");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- doubler is unsolvable, before s-m-n
picture pic;
picnum = picnum+1;  // 10

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $2y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- doubler is unsolvable, after s-m-n
picture pic;
picnum = picnum+1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $2y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- Rice's Thm, before s-m-n
picture pic;
picnum = picnum+1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node sim1=nbox("Run $\TM_x$ on~$x$");
node sim2=nbox("Run $\TM_{e_1}$ on~$y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,sim1);
vlayout(0.85u,sim1,sim2);
vlayout(0.85u,sim2,ending);

// draw nodes
draw(pic,
     start,
     read, 
     sim1,
     sim2,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--sim1),
     (sim1--sim2),
     (sim2--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- Rice's Thm, after s-m-n
picture pic;
picnum = picnum+1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node sim1=nbox("Run $\TM_x$ on~$x$");
node sim2=nbox("Run $\TM_{e_1}$ on~$y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,sim1);
vlayout(0.85u,sim1,sim2);
vlayout(0.85u,sim2,ending);

// draw nodes
draw(pic,
     start,
     read, 
     sim1,
     sim2,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--sim1),
     (sim1--sim2),
     (sim2--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- operating systems
picture pic;
picnum = picnum+1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $e,x$");
node sim=nbox(minipage("\centering Simulate $\TM_e$ on input~$x$",1.85cm));
node print=nbox("Print result");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(1.15u,read,sim);
vlayout(1.15u,sim,print);
vlayout(0.85u,print,ending);

// draw nodes
draw(pic,
     start,
     read, 
     sim,
     print,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--sim),
     (sim--print),
     (print--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ---- halts on three is unsolvable, family of functions
picture pic;
picnum = 15;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_0$ on~$0$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");


// ...................................
picture pic;
picnum = 16;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_1$ on~$1$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format("hp%02d",picnum),pic,format="pdf");



// ================ For exercises =====================

// Format of the names of the files produced 
string OUTPUT_FILE = "hp10%02d";  

// -------- unsolvable: determine if squaring function unsolvable ----
picture pic;
picnum = 0;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $y^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 1;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $y^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// -------- unsolvable: determine if same output on consecutive inputs ----
picture pic;
picnum = 2;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 3;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");



// -------- unsolvable: determine if fcn total ----
picture pic;
picnum = 4;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 5;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// -------- unsolvable: determine if diverge on five ----
picture pic;
picnum = 6;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 7;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");




// -------- give family of computable fncs and machines 3x+y ----
picture pic;
picnum = 8;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node printout=nbox("Print $3x+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=0 ...........................
picture pic;
picnum = 9;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=1 ...........................
picture pic;
picnum = 10;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $3+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=2 ...........................
picture pic;
picnum = 11;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $6+y$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");





// -------- give family of computable fncs and machines xy^2 ----
picture pic;
picnum = 12;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node printout=nbox("Print $x\cdot y^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=0 ...........................
picture pic;
picnum = 13;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=1 ...........................
picture pic;
picnum = 14;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $y^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=2 ...........................
picture pic;
picnum = 15;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $2y^2$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");



// -------- give family of computable fncs and machines with choice ----
picture pic;
picnum = 16;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nrounddiamond("$x$ odd?");
node yesbox=nbox("Print $x$");
node nobox=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(1.15u,read,test);
hlayout(-2.5u,test,yesbox);
hlayout(2.5u,test,nobox);
vlayout(1.4u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     yesbox,
     nobox, 
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--yesbox).l("Y"),
     (test--nobox).l("N").style("leftside"),
     (yesbox--VH--ending),
     (nobox--VH--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=0 ...........................
picture pic;
picnum = 17;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=1 ...........................
picture pic;
picnum = 18;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............Freeze x=2 ...........................
picture pic;
picnum = 19;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node printout=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");






// -------- unsolvable: determine if fcn is successor ----
picture pic;
picnum = 20;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $y+1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 21;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $y+1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");



// -------- unsolvable: determine if fcn converges on x and 2x ----
picture pic;
picnum = 22;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$, $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// .............................................
picture pic;
picnum = 23;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node test=nbox("Run $\TM_x$ on~$x$");
node printout=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;

vlayout(0.85u,start,read);
vlayout(0.85u,read,test);
vlayout(0.85u,test,printout);
vlayout(0.85u,printout,ending);

// draw nodes
draw(pic,
     start,
     read, 
     test,
     printout,
     ending
     );

// draw edges
draw(pic,
     (start--read),
     (read--test),
     (test--printout),
     (printout--ending)
);

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");





// ============ union of decidable langs is decidable =======
picture pic;
int picnum = 24;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node e0test=nrounddiamond("$\TMfcn_{e_0}(x)=1$?");
node e0ybranch=nbox("Print $1$");
node e1test=nrounddiamond("$\TMfcn_{e_1}(x)=1$?");
node e1ybranch=nbox("Print $1$");
node e1nbranch=nbox("Print $0$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,e0test);
e0ybranch.pos = e0test.pos + (-2.5*u,-1.5*v);
e1test.pos = e0test.pos + (3*u,-1.25*v);
e1ybranch.pos = e1test.pos + (-2*u,-1.0*v);
e1nbranch.pos = e1test.pos + (2*u,-1.0*v);
vlayout(3.25*v,e0test,ending);

// draw edges
draw(pic,
     (start--read),
     (read--e0test),
     (e0test..HV..e0ybranch).l("Y"),
     (e0test..HV..e1test).l("N").style("leftside"),
     (e1test..HV..e1ybranch).l("Y"),
     (e1test..HV..e1nbranch).l("N").style("leftside"),
     (e0ybranch..VH..ending),
     (e1ybranch..VH..ending),
     (e1nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     e0test,
     e0ybranch,
     e1test,
     e1ybranch,
     e1nbranch, 
     ending
     );

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............ intersection ...............
picture pic;
int picnum = 25;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node e0test=nrounddiamond("$\TMfcn_{e_0}(x)=1$?");
node e0nbranch=nbox("Print $0$");
node e1test=nrounddiamond("$\TMfcn_{e_1}(x)=1$?");
node e1ybranch=nbox("Print $1$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.35*v,read,e0test);
e0nbranch.pos = e0test.pos + (2.5*u,-3.25*v);
vlayout(1.9*v,e0test,e1test);
vlayout(1.5*v,e1test,e1ybranch);
// e1nbranch.pos = e1test.pos + (2*u,-1.0*v);
vlayout(1*v,e1ybranch,ending);

// draw edges
draw(pic,
     (start--read),
     (read--e0test),
     (e0test..HV..e0nbranch).label(Label("N",Relative(0.08))).style("leftside"),
     (e0test--e1test).l("Y").style("leftside"),
     (e1test--e1ybranch).l("Y").style("leftside"),
     (e1test..HV..e0nbranch).label(Label("N",Relative(0.15))).style("leftside"),
     (e1ybranch--ending),
     (e0nbranch..VH..ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     e0test,
     e0nbranch,
     e1test,
     e1ybranch, 
     ending
     );

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


// ............ complement ...............
picture pic;
int picnum = 26;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node output=nbox("Print $1-\TMfcn_e(x)$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,output);
vlayout(1*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     (read--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     read, 
     output, 
     ending
     );

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");




// ============= Does not cut across all TM's ===========
picture pic;
int picnum = 27;

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node run=nbox("Run $\TM_x$ on $x$");
node output=nbox("Print $42$");
node ending=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,run);
vlayout(1*v,run,output);
vlayout(1*v,output,ending);

// draw edges
draw(pic,
     (start--read),
     (read--run),
     (run--output),
     (output--ending)
);

// draw nodes
draw(pic,
     start,
     read,
     run,
     output, 
     ending
     );

shipout(format(OUTPUT_FILE,picnum),pic,format="pdf");


