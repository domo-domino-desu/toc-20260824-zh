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



// ======================== non-iso graphs with same degree sequence ======
int picnum = 2;
picture pic;

setdefaultgraphstyles();
defaultlayoutrel = false;

node n0=ncircle("\nodebox{\strut$v_0$}"),
  n1=ncircle("\nodebox{\strut$v_1$}"),
  n2=ncircle("\nodebox{\strut$v_2$}"),
  n3=ncircle("\nodebox{\strut$v_3$}"),
  n4=ncircle("\nodebox{\strut$v_4$}"),
  n5=ncircle("\nodebox{\strut$v_5$}"),
  n6=ncircle("\nodebox{\strut$v_6$}"),
  n7=ncircle("\nodebox{\strut$v_7$}");

// calculate nodes position
real u=1.0cm;
real v=u;
defaultlayoutskip=u;

hlayout(3*u, n0, n1);
n4.pos = new_node_pos_h(n0, -45, 1*u);
hlayout(1*u, n4, n5);
vlayout(1*v, n4, n6);
hlayout(1*u, n6, n7);
vlayout(3*v, n0, n2);
hlayout(3*u, n2, n3);

// draw edges
draw(pic,
     (n0--n1),
     (n0--n2),
     (n0--n4),
     (n1--n3),
     (n2--n3),
     (n2--n6),
     (n4--n5),
     (n4--n6),
     (n5--n7),
     (n6--n7)
);

// draw nodes, after edges
draw(pic,
     n0, n1, n2, n3, n4, n5, n6, n7
     );


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

// .......................................................
int picnum = 3;
picture pic;

setdefaultgraphstyles();
defaultlayoutrel = false;

node n0=ncircle("\nodebox{\strut$n_0$}"),
  n1=ncircle("\nodebox{\strut$n_1$}"),
  n2=ncircle("\nodebox{\strut$n_2$}"),
  n3=ncircle("\nodebox{\strut$n_3$}"),
  n4=ncircle("\nodebox{\strut$n_4$}"),
  n5=ncircle("\nodebox{\strut$n_5$}"),
  n6=ncircle("\nodebox{\strut$n_6$}"),
  n7=ncircle("\nodebox{\strut$n_7$}");

// calculate nodes position
real u=1.0cm;
real v=u;
defaultlayoutskip=u;

hlayout(3*u, n6, n2);
n5.pos = new_node_pos_h(n0, -45, 1*u);
hlayout(1*u, n5, n1);
vlayout(1*v, n5, n0);
hlayout(1*u, n0, n4);
vlayout(3*v, n6, n7);
hlayout(3*u, n7, n3);

// draw edges
draw(pic,
     (n0--n4),
     (n0--n5),
     (n1--n4),
     (n1--n5),
     (n2--n3),
     (n2--n6),
     (n3--n4),
     (n3--n7),
     (n5--n6),
     (n6--n7)
);

// draw nodes, after edges
draw(pic,
     n0, n1, n2, n3, n4, n5, n6, n7
     );


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


