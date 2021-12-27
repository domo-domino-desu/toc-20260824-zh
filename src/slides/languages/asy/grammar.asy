// fsa.asy
//  circle diagrams of a FSA

import settings;
// settings.dir="..";  // make it able to see jh.asy 
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

// defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
ns_noborder=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);

string OUTPUT_FN = "grammar%03d";


// ======================== ambiguous grammar =============
int picnum = 0;
picture p;

// define nodes
node plussign=nbox("\strut\terminal{+}",ns_noborder),
     five=nbox("\strut\terminal{5}",ns_noborder),
     star=nbox("\strut\terminal{*}",ns_noborder),
     two=nbox("\strut\terminal{2}",ns_noborder),
     three=nbox("\strut\terminal{3}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
plussign.pos=(0*u,0*v);
// rank 1
five.pos=(-0.5*u,-1*v);
star.pos=(1*u,-1*v);
// rank 2
two.pos=(0.5*u,-2*v);
three.pos=(1.5*u,-2*v);

// draw edges
draw(pic=p,
     (plussign--five),
     (plussign--star),
     (star--two),
     (star--three)
    );

// draw nodes
draw(pic=p,
     plussign,
     five, star,
     two, three);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// .................................................
int picnum = 1;
picture p;

// define nodes
node plussign=nbox("\strut\terminal{+}",ns_noborder),
     five=nbox("\strut\terminal{5}",ns_noborder),
     star=nbox("\strut\terminal{*}",ns_noborder),
     two=nbox("\strut\terminal{2}",ns_noborder),
     three=nbox("\strut\terminal{3}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
star.pos=(0*u,0*v);
// rank 1
plussign.pos=(-1*u,-1*v);
three.pos=(0.5*u,-1*v);
// rank 2
five.pos=(-1.5*u,-2*v);
two.pos=(-0.5*u,-2*v);

// draw edges
draw(pic=p,
     (star--plussign),
     (star--three),
     (plussign--five),
     (plussign--two)
    );

// draw nodes
draw(pic=p,
     star,
     plussign, three,
     five, two
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ======= classes, for graph coloring ============
int picnum = 2;
picture p;

// define nodes
node n1007=ncircle("1007",ns_white),
     n3137=ncircle("3137",ns_white),
     n3157=ncircle("3157",ns_white),
     n3261=ncircle("3261",ns_white),
     n3203=ncircle("3203",ns_white),
     n4115=ncircle("4115",ns_white),
     n4118=ncircle("4118",ns_white),
     n4156=ncircle("4156",ns_white);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 2cm;
real u = 0.7*defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

// 
n1007.pos=(0*u,0*v);
// above
n3203.pos=(0*u,2*v);
n4115.pos=(-1*u,1*v);
n3261.pos=(1*u,1*v);
// below
n4118.pos=(-1.0*u,-1.5*v);
n3137.pos=(0.0*u,-1.5*v);
n4156.pos=(1.0*u,-1.5*v);
n3157.pos=(0.75*u,-3*v);

// draw edges
draw(pic=p,
     (n1007--n3137),
     (n1007 -- n3157),
     (n3137 -- n3157),
     (n1007 -- n3203),
     (n1007 -- n3261),
     (n3137 -- n3261),
     (n3203 -- n3261),
     (n1007 -- n4115),
     (n3137 -- n4115),
     (n3203 -- n4115),
     (n3261 -- n4115),
     (n1007 -- n4118),
     (n3137 -- n4118),
     (n1007 -- n4156),
     (n3137 -- n4156),
     (n3157 -- n4156)
     );

// draw nodes
draw(pic=p,
     n1007,
     n4115, n3261, n3203,
     n4118, n3137, n4156, n3157
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ......... coloring added ..................
int picnum = 3;
picture p;

// define nodes
node n1007=ncircle("1007",ns_bg),
     n3137=ncircle("3137",ns_bleachedbold),
     n3157=ncircle("3157",ns_light),
     n3261=ncircle("3261",ns_gray),
     n3203=ncircle("3203",ns_light),
     n4115=ncircle("4115",ns_bleachedbold),
     n4118=ncircle("4118",ns_light),
     n4156=ncircle("4156",ns_gray);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 2cm;
real u = 0.7*defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

// 
n1007.pos=(0*u,0*v);
// above
n3203.pos=(0*u,2*v);
n4115.pos=(-1*u,1*v);
n3261.pos=(1*u,1*v);
// below
n4118.pos=(-1.0*u,-1.5*v);
n3137.pos=(0.0*u,-1.5*v);
n4156.pos=(1.0*u,-1.5*v);
n3157.pos=(0.75*u,-3*v);

// draw edges
draw(pic=p,
     (n1007--n3137),
     (n1007 -- n3157),
     (n3137 -- n3157),
     (n1007 -- n3203),
     (n1007 -- n3261),
     (n3137 -- n3261),
     (n3203 -- n3261),
     (n1007 -- n4115),
     (n3137 -- n4115),
     (n3203 -- n4115),
     (n3261 -- n4115),
     (n1007 -- n4118),
     (n3137 -- n4118),
     (n1007 -- n4156),
     (n3137 -- n4156),
     (n3157 -- n4156)
     );

// draw nodes
draw(pic=p,
     n1007,
     n4115, n3261, n3203,
     n4118, n3137, n4156, n3157
     );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");







