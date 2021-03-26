// regex.asy
//  Drawings for regular expressions

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
// cd("../../../asy/asy-graphtheory-master/modules");  // import patched version
// import node;
// cd("");

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);

string OUTPUT_FN = "regex%02d";

defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);

// Given the angle and the desired vert dist, return the horiz dist
real find_horiz(real theta, real vert) {
  return vert/Tan(theta);
}

// Given the angle and the desired horiz dist, return the vert dist
real find_vert(real theta, real horiz) {
  return horiz*Tan(theta);
}

// From starting point, angle, and desired vert dist, return new pos
pair new_node_pos(node starting_pos, real theta, real vert) {
  return (starting_pos.pos.x+find_horiz(theta,vert), starting_pos.pos.y+vert);
}


// ======================== parse tree for a(b|c)* =============
int picnum = 0;
picture pic;
// setdefaultstatediagramstyles();

// define nodes
node a=nbox("\strut\terminal{a}",ns_noborder),
     b=nbox("\strut\terminal{b}",ns_noborder),
     c=nbox("\strut\terminal{c}",ns_noborder),
     pipe=nbox("\strut\terminal{|}",ns_noborder), 
     star=nbox("\strut\terminal{*}",ns_noborder),
     openparen=nbox("\strut\terminal{(}",ns_noborder),
     closeparen=nbox("\strut\terminal{)}",ns_noborder),
     regex1=nbox("\strut\nonterminal{regex}",ns_noborder),
     concat1=nbox("\strut\nonterminal{concat}",ns_noborder),
     concat2=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple1=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple2=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple3=nbox("\strut\nonterminal{simple}",ns_noborder),
     char1=nbox("\strut\nonterminal{char}",ns_noborder),
     regex2=nbox("\strut\nonterminal{regex}",ns_noborder),
     regex3=nbox("\strut\nonterminal{regex}",ns_noborder),
     concat3=nbox("\strut\nonterminal{concat}",ns_noborder),
     concat4=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple4=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple5=nbox("\strut\nonterminal{simple}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 2cm;      // horizontal
real v = 0.45*u;    // vertical

// rank 0
regex1.pos=(0*u,0*v);
// rank 1
concat1.pos=(0*u,-1*v);
// rank 2
concat2.pos=(-1*u,-2*v);
// simple1.pos=(2*u,-2*v);
//  simple1.pos=(find_horiz(-45.0,-1*v) + concat1.pos.x,concat1.pos.y-1*v);
simple1.pos=new_node_pos(concat1, -30, -1*v);
// rank 3
// simple2.pos=(-1*u,-3*v);
simple2.pos=new_node_pos(concat2, -90, -1*v);
// simple3.pos=(1.5*u,-3*v);
simple3.pos=new_node_pos(simple1, -135.0, -1*v);
// star.pos=(2.5*u,-3*v);
star.pos=new_node_pos(simple1, -45.0, -1*v);
// rank 4
// vlayout(1*v, simple2, char1);
// char1.pos=(-1*u,-4*v);
char1.pos=new_node_pos(simple2, -90, -1*v);
// openparen.pos=(1*u,-4*v);
openparen.pos=new_node_pos(simple3, -135, -1*v);
// regex2.pos=(1.5*u,-4*v);
regex2.pos=new_node_pos(simple3, -90, -1*v);
// closeparen.pos=(2*u,-4*v);
closeparen.pos=new_node_pos(simple3, -45, -1*v);
// rank 5
// a.pos=(-1*u,-5*v);
a.pos=new_node_pos(char1, -90, -1*v);
// regex3.pos=(1*u,-5*v);
regex3.pos=new_node_pos(regex2, -135, -1*v);
// pipe.pos=(1.5*u,-5*v);
pipe.pos=new_node_pos(regex2, -90, -1*v);
// concat3.pos=(2*u,-5*v);
concat3.pos=new_node_pos(regex2, -45, -1*v);
// rank 6
// concat4.pos=(1*u,-6*v);
concat4.pos=new_node_pos(regex3, -90, -1*v);
// simple4.pos=(2*u,-6*v);
simple4.pos=new_node_pos(concat3, -90, -1*v);
// rank 7
// simple5.pos=(1*u,-7*v);
simple5.pos=new_node_pos(concat4, -90, -1*v);
// c.pos=(2*u,-7*v);
c.pos=new_node_pos(simple4, -90, -1*v);
// rank 8
// b.pos=(1*u,-8*v);
b.pos=new_node_pos(simple5, -90, -1*v);

// draw edges
draw(pic,
     (regex1--concat1),
     (concat1--concat2), (concat1--simple1),
     (concat2--simple2),
     (simple1--simple3), (simple1--star),
     (concat2--simple2),
     (simple2--char1),
     (simple3--openparen), (simple3--regex2), (simple3--closeparen),
     (regex2--regex3), (regex2--pipe), (regex2--concat3),
     (char1--a),
     (regex3--concat4),
     (concat3--simple4),
     (concat4--simple5),
     (simple4--c),
     (simple5--b)
    );


// draw nodes
draw(pic,
     a,
     b,
     c,
     pipe,
     star,
     openparen,
     closeparen,
     regex1,
     concat1,
     concat2,
     simple1,
     simple2,
     simple3,
     char1,
     regex2,
     regex3,
     concat3,
     concat4,
     simple4,
     simple5
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");





// ======================== parse tree for a(b*|c*) =============
int picnum = 1;
picture pic;
// setdefaultstatediagramstyles();

// define nodes
node
     regex1=nbox("\strut\nonterminal{regex}",ns_noborder),
     concat1=nbox("\strut\nonterminal{concat}",ns_noborder),
     concat2=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple1=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple2=nbox("\strut\nonterminal{simple}",ns_noborder),
     openparen=nbox("\strut\terminal{(}",ns_noborder),
     regex2=nbox("\strut\nonterminal{regex}",ns_noborder),
     closeparen=nbox("\strut\terminal{)}",ns_noborder),
     char1=nbox("\strut\nonterminal{char}",ns_noborder),
     regex3=nbox("\strut\nonterminal{regex}",ns_noborder),
     pipe=nbox("\strut\terminal{|}",ns_noborder), 
     concat3=nbox("\strut\nonterminal{concat}",ns_noborder),
     a=nbox("\strut\terminal{a}",ns_noborder),
     concat4=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple3=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple4=nbox("\strut\nonterminal{simple}",ns_noborder),
simple5=nbox("\strut\nonterminal{simple}",ns_noborder),
     star1=nbox("\strut\terminal{*}",ns_noborder),
simple6=nbox("\strut\nonterminal{simple}",ns_noborder),
     star2=nbox("\strut\terminal{*}",ns_noborder),
     char2=nbox("\strut\nonterminal{char}",ns_noborder),
     char3=nbox("\strut\nonterminal{char}",ns_noborder),
     c=nbox("\strut\terminal{c}",ns_noborder),
     b=nbox("\strut\terminal{b}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 2cm;      // horizontal
real v = 0.45*u;    // vertical

// rank 0
regex1.pos=(0*u,0*v);
// rank 1
concat1.pos=(0*u,-1*v);
// rank 2
concat2.pos=(-1*u,-2*v);
simple1.pos=new_node_pos(concat1, -30, -1*v);
// rank 3
simple2.pos=new_node_pos(concat2, -90, -1*v);
openparen.pos=new_node_pos(simple1, -135.0, -1*v);
regex2.pos=new_node_pos(simple1, -90.0, -1*v);
closeparen.pos=new_node_pos(simple1, -45.0, -1*v);
// rank 4
char1.pos=new_node_pos(simple2, -90, -1*v);
regex3.pos=new_node_pos(regex2, -150, -1*v);
pipe.pos=new_node_pos(regex2, -90, -1*v);
concat3.pos=new_node_pos(regex2, -30, -1*v);
// rank 5
a.pos=new_node_pos(char1, -90, -1*v);
concat4.pos=new_node_pos(regex3, -90, -1*v);
simple3.pos=new_node_pos(concat3, -90, -1*v);
// rank 6
simple4.pos=new_node_pos(concat4, -90, -1*v);
simple5.pos=new_node_pos(simple3, -135, -1*v);
star1.pos=new_node_pos(simple3, -45, -1*v);
// rank 7
simple6.pos=new_node_pos(simple4, -135, -1*v);
star2.pos=new_node_pos(simple4, -45, -1*v);
char2.pos=new_node_pos(simple5, -90, -1*v);
// rank 8
char3.pos=new_node_pos(simple6, -90, -1*v);
c.pos=new_node_pos(char2, -90, -1*v);
// rank 9
b.pos=new_node_pos(char3, -90, -1*v);

// draw edges
draw(pic,
     // rank 0-1
     (regex1--concat1),
     // rank 1-2
     (concat1--concat2), (concat1--simple1),
     // rank 2-3
     (concat2--simple2),
     (simple1--openparen), (simple1--regex2), (simple1--closeparen),
     // rank 3-4
     (simple2--char1),
     (regex2--regex3), (regex2--pipe), (regex2--concat3),
     // rank 4-5
     (char1--a),
     (regex3--concat4),
     (concat3--simple3),
     // rank 5-6
     (concat4--simple4),
     (simple3--simple5), (simple3--star1),
     // rank 6-7
     (simple4--simple6), (simple4--star2),
     (simple5--char2),
     // rank 7-8
     (simple6--char3),
     (char2--c),
     // rank 8-9
     (char3--b)
     );


// draw nodes
draw(pic,
     regex1,
     concat1,
     concat2,
     simple1,
     simple2,
     openparen,
     regex2,
     closeparen,
     char1,
     regex3,
     pipe, 
     concat3,
     a,
     concat4,
     simple3,
     simple4,
     simple5,
     star1,
     simple6,
     star2,
     char2,
     char3,
     c,
     b
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ======================== parse tree for ab*(a|c) =============
int picnum = 2;
picture pic;
setdefaultparsetreestyles();

// define nodes
node
     regex1=nbox("\strut\nonterminal{regex}",ns_noborder),
     concat0=nbox("\strut\nonterminal{concat}",ns_noborder),
     concat1=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple1=nbox("\strut\nonterminal{simple}",ns_noborder),
     concat2=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple2=nbox("\strut\nonterminal{simple}",ns_noborder),
     openparen=nbox("\strut\terminal{(}",ns_noborder),
     regex2=nbox("\strut\nonterminal{regex}",ns_noborder),
     closeparen=nbox("\strut\terminal{)}",ns_noborder),
     simple3=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple4=nbox("\strut\nonterminal{simple}",ns_noborder),
     star=nbox("\strut\terminal{*}",ns_noborder),
     regex3=nbox("\strut\nonterminal{regex}",ns_noborder),
     pipe=nbox("\strut\terminal{|}",ns_noborder), 
     concat3=nbox("\strut\nonterminal{concat}",ns_noborder),
     char1=nbox("\strut\nonterminal{char}",ns_noborder),
     char2=nbox("\strut\nonterminal{char}",ns_noborder),
     concat4=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple5=nbox("\strut\nonterminal{simple}",ns_noborder),
     a1=nbox("\strut\terminal{a}",ns_noborder),
     b=nbox("\strut\terminal{b}",ns_noborder),
     simple6=nbox("\strut\nonterminal{simple}",ns_noborder),
     char3=nbox("\strut\nonterminal{char}",ns_noborder),
     char4=nbox("\strut\nonterminal{char}",ns_noborder),
     c=nbox("\strut\terminal{c}",ns_noborder),
     a2=nbox("\strut\terminal{a}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 2cm;      // horizontal
real v = 0.45*u;    // vertical

// rank -1 and 0  (boo-boo)
regex1.pos=(0*u,1*v);
concat0.pos=(0*u,0*v);
// rank 1
concat1.pos=new_node_pos(concat0, -150, -1*v);
simple1.pos=new_node_pos(concat0, -30, -1*v);
// rank 2
concat2.pos=new_node_pos(concat1, -135, -1*v);
simple2.pos=new_node_pos(concat1, -45, -1*v);
openparen.pos=new_node_pos(simple1, -135.0, -1*v);
regex2.pos=new_node_pos(simple1, -90.0, -1*v);
closeparen.pos=new_node_pos(simple1, -45.0, -1*v);
// rank 3
simple3.pos=new_node_pos(concat2, -90, -1*v);
simple4.pos=new_node_pos(simple2, -120, -1*v);
star.pos=new_node_pos(simple2, -60, -1*v);
regex3.pos=new_node_pos(regex2, -130, -1*v);
pipe.pos=new_node_pos(regex2, -90, -1*v);
concat3.pos=new_node_pos(regex2, -50, -1*v);
// rank 4
char1.pos=new_node_pos(simple3, -90, -1*v);
char2.pos=new_node_pos(simple4, -90, -1*v);
concat4.pos=new_node_pos(regex3, -90, -1*v);
simple5.pos=new_node_pos(concat3, -90, -1*v);
// rank 5
a1.pos=new_node_pos(char1, -90, -1*v);
b.pos=new_node_pos(char2, -90, -1*v);
simple6.pos=new_node_pos(concat4, -90, -1*v);
char3.pos=new_node_pos(simple5, -90, -1*v);
// rank 6
char4.pos=new_node_pos(simple6, -90, -1*v);
c.pos=new_node_pos(char3, -90, -1*v);
// rank 7
a2.pos=new_node_pos(char4, -90, -1*v);

// draw edges
draw(pic,
     (regex1--concat0),
     // rank 0-1
     (concat0--concat1),
     (concat0--simple1),
     // rank 1-2
     (concat1--concat2), (concat1--simple2),
     (simple1--openparen), (simple1--regex2), (simple1--closeparen),     
     // rank 2-3
     (concat2--simple3),
     (simple2--simple4), (simple2--star),
     (regex2--regex3), (regex2--pipe), (regex2--concat3),     
     // rank 3-4
     (simple3--char1),
     (simple4--char2),
     (regex3--concat4),
     (concat3--simple5),
     // rank 4-5
     (char1--a1),
     (char2--b),
     (concat4--simple6),
     (simple5--char3),
     // rank 5-6
     (simple6--char4),
     (char3--c),
     // rank 6-7
     (char4--a2)
     );


// draw nodes
draw(pic,
     regex1,
     concat0,
// rank 1
     concat1,
     simple1,
// rank 2
     concat2,
     simple2,
     openparen,
     regex2,
     closeparen,
// rank 3
     simple3,
     simple4,
     star,
     regex3,
     pipe,
     concat3,
// rank 4
     char1,
     char2,
     concat4,
     simple5,
// rank 5
     a1,
     b,
     simple6,
     char3,
// rank 6
     char4,
     c,
// rank 7
a2
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ======================== parse tree for a(b|c) =============
int picnum = 3;
picture pic;
setdefaultparsetreestyles();

// define nodes
node
     regex1=nbox("\strut\nonterminal{regex}",ns_noborder),
     concat1=nbox("\strut\nonterminal{concat}",ns_noborder),
     concat2=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple1=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple2=nbox("\strut\nonterminal{simple}",ns_noborder),
     openparen=nbox("\strut\terminal{(}",ns_noborder),
     regex2=nbox("\strut\nonterminal{regex}",ns_noborder),
     closeparen=nbox("\strut\terminal{)}",ns_noborder),
     char1=nbox("\strut\nonterminal{char}",ns_noborder),
     regex3=nbox("\strut\nonterminal{regex}",ns_noborder),
     pipe=nbox("\strut\terminal{|}",ns_noborder), 
     concat3=nbox("\strut\nonterminal{concat}",ns_noborder),
     a=nbox("\strut\terminal{a}",ns_noborder),
     concat4=nbox("\strut\nonterminal{concat}",ns_noborder),
     simple3=nbox("\strut\nonterminal{simple}",ns_noborder),
     simple4=nbox("\strut\nonterminal{simple}",ns_noborder),
     char2=nbox("\strut\nonterminal{char}",ns_noborder),
     char3=nbox("\strut\nonterminal{char}",ns_noborder),
     c=nbox("\strut\terminal{c}",ns_noborder),
     b=nbox("\strut\terminal{b}",ns_noborder);

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 2cm;      // horizontal
real v = 0.45*u;    // vertical

// rank 0
regex1.pos=(0*u,1*v);
// rank 1
concat1.pos=(0*u,0*v);
// rank 2
concat2.pos=new_node_pos(concat1, -150, -1*v);
simple1.pos=new_node_pos(concat1, -30, -1*v);
// rank 3
simple2.pos=new_node_pos(concat2, -90, -1*v);
openparen.pos=new_node_pos(simple1, -135.0, -1*v);
regex2.pos=new_node_pos(simple1, -90.0, -1*v);
closeparen.pos=new_node_pos(simple1, -45.0, -1*v);
// rank 4
char1.pos=new_node_pos(simple2, -90, -1*v);
regex3.pos=new_node_pos(regex2, -130, -1*v);
pipe.pos=new_node_pos(regex2, -90, -1*v);
concat3.pos=new_node_pos(regex2, -50, -1*v);
// rank 5
a.pos=new_node_pos(char1, -90, -1*v);
concat4.pos=new_node_pos(regex3, -90, -1*v);
simple3.pos=new_node_pos(concat3, -90, -1*v);
// rank 6
simple4.pos=new_node_pos(concat4, -90, -1*v);
char2.pos=new_node_pos(simple3, -90, -1*v);
// rank 7
char3.pos=new_node_pos(simple4, -90, -1*v);
c.pos=new_node_pos(char2, -90, -1*v);
// rank 8
b.pos=new_node_pos(char3, -90, -1*v);

// draw edges
draw(pic,
     // rank 0-1
     (regex1--concat1),
     // rank 1-2
     (concat1--concat2),
     (concat1--simple1),
     // rank 2-3
     (concat2--simple2),
     (simple1--openparen), (simple1--regex2), (simple1--closeparen),
     // rank 3-4
     (simple2--char1),
     (regex2--regex3), (regex2--pipe), (regex2--concat3),     
     // rank 4-5
     (char1--a),
     (regex3--concat4),
     (concat3--simple3),
     // rank 5-6
     (concat4--simple4),
     (simple3--char2),
     // rank 6-7
     (simple4--char3),
     (char2--c),
     // rank 7-8
     (char3--b)
     );


// draw nodes
draw(pic,
     regex1,
     concat1,
     concat2,
     simple1,
     simple2,
     openparen,
     regex2,
     closeparen,
     char1,
     regex3,
     pipe, 
     concat3,
     a,
     concat4,
     simple3,
     simple4,
     char2,
     char3,
     c,
     b
     );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ==================== Machines for regex ============

// ========== a*ba =============================
picture pic;
int picnum = 4;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");        
node q2=ncircle("$q_2$",ns_accepting);    
// node e=ncircle("$e$");    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.75*u;

hlayout(1*u, q0, q1, q2);
// vlayout(1*v,q2, e);

// draw edges
draw(pic,
     (q0..loop(N)).l("\str{a}"),
     (q0--q1).l("\str{b}"),
     (q1--q2).l("\str{a}")
);

// draw nodes
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............................................
picture pic;
int picnum = 5;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");        
node q2=ncircle("$q_2$",ns_accepting);    
node e=ncircle("$e$");    

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;
real v = 0.85*u;

hlayout(1*u, q0, q1, q2);
vlayout(1*v,q1, e);

// draw edges
draw(pic,
     (q0..loop(N)).l("\str{a}"),
     (q0--q1).l("\str{b}"),
     (q1--q2).l("\str{a}"),
     (q1--e).l("\str{b}"),
     (q2--e).l("\str{a},\str{b}"),
     (e..loop(E)).l("\str{a},\str{b}")
  );

// draw nodes
     draw(pic, q0, q1, q2,
	  e
	  );

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ========== a*ba =============================
picture pic;
int picnum = 6;
unitsize(pic,1pt);
setdefaultstatediagramstyles() ;

// define nodes
node q0=ncircle("$q_0$");    
node q1=ncircle("$q_1$");        
node q2=ncircle("$q_2$",ns_accepting);       

// calculate nodes position
// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.25cm;
real u = defaultlayoutskip;

hlayout(1*u, q0, q1, q2);

// draw edges
draw(pic,
     (q0--q1).l("\str{a}"),
     (q1..loop(N)).l("\str{a},\str{b}"),
     (q1--q2).l("\str{a}")
);

// draw nodes
draw(pic, q0, q1, q2);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

