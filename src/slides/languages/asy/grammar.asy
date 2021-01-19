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

defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);

string OUTPUT_FN = "grammar%03d";


// ======================== ambiguous grammar =============
int picnum = 0;
picture p;

// define nodes
node plussign=nbox("\strut\terminal{+}"),
     five=nbox("\strut\terminal{5}"),
     star=nbox("\strut\terminal{*}"),
     two=nbox("\strut\terminal{2}"),
     three=nbox("\strut\terminal{3}");

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
node plussign=nbox("\strut\terminal{+}"),
     five=nbox("\strut\terminal{5}"),
     star=nbox("\strut\terminal{*}"),
     two=nbox("\strut\terminal{2}"),
     three=nbox("\strut\terminal{3}");

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







