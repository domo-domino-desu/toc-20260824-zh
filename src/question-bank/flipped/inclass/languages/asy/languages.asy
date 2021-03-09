// parsetree.asy
//  Draw parse trees

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import
cd("../../../../../asy");
import settexpreamble;
cd("");
settexpreamble();

cd("../../../../../asy");
import jhnode;
cd("");

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);



// =========================================
string OUTPUT_FN = "languages%03d";


// ======================== derivation of 42 =============
int picnum = 0;
picture p;

// define nodes
node natural=nbox("\strut\nonterminal{natural}"),
     natural1=nbox("\strut\nonterminal{natural}"),
     digit=nbox("\strut\nonterminal{digit}"),
     digit1=nbox("\strut\nonterminal{digit}"),
     four=nbox("\strut\terminal{4}"),
     two=nbox("\strut\terminal{2}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
natural.pos=(0*u,0*v);
// rank 1
digit.pos=(-1*u,-1*v);
natural1.pos=(1*u,-1*v);
// rank 2
four.pos=(-1*u,-2*v);
digit1.pos=(1*u,-2*v);
// rank 3
two.pos=(1*u,-3*v);

// draw edges
draw(pic=p,
     (natural--digit),
     (natural--natural1),
     (natural1--digit1),
     (digit--four),
     (digit1--two)
    );

// draw nodes
draw(pic=p,
     natural,
     digit,
     natural1,
     digit1,
     four,
     two
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ======================== derivation of 993 =============
int picnum = 1;
picture p;

// define nodes
node natural=nbox("\strut\nonterminal{natural}"),
     natural1=nbox("\strut\nonterminal{natural}"),
     natural2=nbox("\strut\nonterminal{natural}"),
     digit=nbox("\strut\nonterminal{digit}"),
     digit1=nbox("\strut\nonterminal{digit}"),
     digit2=nbox("\strut\nonterminal{digit}"),
     nine=nbox("\strut\terminal{9}"),
     nine1=nbox("\strut\terminal{9}"),
     three=nbox("\strut\terminal{3}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
natural.pos=(0*u,0*v);
// rank 1
digit.pos=(-1*u,-1*v);
natural1.pos=(1*u,-1*v);
// rank 2
nine.pos=(-1*u,-2*v);
digit1.pos=(1*u,-2*v);
natural2.pos=(2*u,-2*v);
// rank 3
nine1.pos=(1*u,-3*v);
digit2.pos=(2*u,-3*v);
// rank 4
three.pos=(2*u,-4*v);

// draw edges
draw(pic=p,
     (natural--digit),
     (natural--natural1),
     (digit--nine),
     (natural1--digit1),
     (natural1--natural2),
     (digit1--nine1),
     (natural2--digit2),
     (digit2--three)
    );


// draw nodes
draw(pic=p,
     natural,
     digit,
     natural1,
     nine,
     digit1,
     natural2,
     nine1,
     digit2,
     three
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


