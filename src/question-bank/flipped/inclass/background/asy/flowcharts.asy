// flowcharts.asy
//  Flow charts illustrating routines
cd("../../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../../asy");
import jhnode;
cd("");

cd("../../../../../asy");
import flowchart;
cd("");

import settings;
settings.outformat="pdf";


string OUTPUT_FN = "flowcharts%03d";



// ================== Two.V 1a ==================
picture pic;
int picnum = 0;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node simulate=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $42$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............... after s-m-n P_{s(e,0)} .......................
picture pic;
int picnum = 1;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_0$ on input $0$");
node print=nbox("Print $42$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,1)} .......................
picture pic;
int picnum = 2;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_1$ on input $1$");
node print=nbox("Print $42$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,2)} .......................
picture pic;
int picnum = 3;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_2$ on input $2$");
node print=nbox("Print $42$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ================== Two.V 1b ==================
picture pic;
int picnum = 4;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node simulate=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $7$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............... after s-m-n P_{s(e,0)} .......................
picture pic;
int picnum = 5;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_0$ on input $0$");
node print=nbox("Print $7$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,1)} .......................
picture pic;
int picnum = 6;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_1$ on input $1$");
node print=nbox("Print $7$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,2)} .......................
picture pic;
int picnum = 7;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_2$ on input $2$");
node print=nbox("Print $7$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




// ================== Two.V 1c ==================
picture pic;
int picnum = 8;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x,y$");
node simulate=nbox("Run $\TM_x$ on input $x$");
node print=nbox("Print $y^2$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ............... after s-m-n P_{s(e,0)} .......................
picture pic;
int picnum = 9;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_0$ on input $0$");
node print=nbox("Print $y^2$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,1)} .......................
picture pic;
int picnum = 10;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_1$ on input $1$");
node print=nbox("Print $y^2$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// ............... after s-m-n  P_{s(e,2)} .......................
picture pic;
int picnum = 11;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $y$");
node simulate=nbox("Run $\TM_2$ on input $2$");
node print=nbox("Print $y^2$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1.2*v,read,simulate);
vlayout(1.2*v,simulate,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--simulate),
     (simulate--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     simulate,
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// =============Rice's thm worksheet; halts on 5 ===============
picture pic;
int picnum = 12;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node print=nbox("Print $42$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................... not in I .................
picture pic;
int picnum = 13;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node loop=nbox("Infinite loop");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,loop);

// draw edges
draw(pic,
     (start--read),
     (read--loop)
     );

// draw nodes
draw(pic,
     start,
     read, 
     loop
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// =============Rice's thm worksheet; f(4)=7 ===============
picture pic;
int picnum = 14;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node print=nbox("Print $7$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................... not in I .................
picture pic;
int picnum = 15;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node print=nbox("Print $6$");
node start=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// =============Rice's thm worksheet; squaring function ===============
picture pic;
int picnum = 16;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node print=nbox("Print $x^2$");
node end=nroundbox("End");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,print);
vlayout(1*v,print,end);

// draw edges
draw(pic,
     (start--read),
     (read--print),
     (print--end)
     );

// draw nodes
draw(pic,
     start,
     read, 
     print,
     end
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ...................... not in I .................
picture pic;
int picnum = 17;
setdefaultflowchartstyles();

// define nodes
node start=nroundbox("Start");
node read=nbox("Read $x$");
node loop=nbox("Infinite loop");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(1*v,start,read);
vlayout(1*v,read,loop);

// draw edges
draw(pic,
     (start--read),
     (read--loop)
     );

// draw nodes
draw(pic,
     start,
     read, 
     loop
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
