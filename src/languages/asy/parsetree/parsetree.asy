// parsetree.asy
//  Draw parse trees

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jhnode;

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);



// =========================================
string OUTPUT_FN = "parsetree%03d";


// ======================== english grammar =============
int picnum = 0;
picture p;

// define nodes
node the=nbox("\strut\terminal{the}"),
     young=nbox("\strut\terminal{young}"),
     man=nbox("\strut\terminal{man}"),
     caught=nbox("\strut\terminal{caught}"),
     the2=nbox("\strut\terminal{the}"),
     ball=nbox("\strut\terminal{ball}"),
     sentence=nbox("\strut\nonterminal{sentence}"),
     nounphrase=nbox("\strut\nonterminal{noun phrase}"),
     nounphrase2=nbox("\strut\nonterminal{noun phrase}"),
     verbphrase=nbox("\strut\nonterminal{verb phrase}"),
     article=nbox("\strut\nonterminal{article}"),
     article2=nbox("\strut\nonterminal{article}"),
     adjective=nbox("\strut\nonterminal{adjective}"),
     verb=nbox("\strut\nonterminal{verb}"),
     noun=nbox("\strut\nonterminal{noun}"),
     noun2=nbox("\strut\nonterminal{noun}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
sentence.pos=(0*u,0*v);
// rank 1
nounphrase.pos=(-1*u,-1*v);
verbphrase.pos=(1*u,-1*v);
// rank 2
article.pos=(-2.5*u,-2*v);
adjective.pos=(-1.5*u,-2*v);
noun.pos=(-0.5*u,-2*v);
verb.pos=(0.5*u,-2*v);
nounphrase2.pos=(2.0*u,-2*v);
// rank 3
the.pos=(-2.5*u,-3*v);
young.pos=(-1.5*u,-3*v);
man.pos=(-0.5*u,-3*v);
caught.pos=(0.5*u,-3*v);
article2.pos=(1.5*u,-3*v);
noun2.pos=(2.5*u,-3*v);
// rank 4
the2.pos=(1.5*u,-4*v);
ball.pos=(2.5*u,-4*v);

// draw nodes
draw(pic=p,
     the,
     young,
     man,
     caught,
     the2,
     ball,
     sentence,
     nounphrase,
     nounphrase2,
     verbphrase,
     article,
     article2,
     adjective,
     verb,
     noun,
     noun2);

// draw edges
draw(pic=p,
     (sentence--nounphrase),
     (sentence--verbphrase),
     (nounphrase--article),
     (nounphrase--adjective),
     (nounphrase--noun),
     (verbphrase--verb),
     (verbphrase--nounphrase2),
     (article--the),
     (adjective--young),
     (noun--man),
     (verb--caught),
     (nounphrase2--article2),
     (nounphrase2--noun2),
     (article2--the2),
     (noun2--ball)
    );

shipout(format("parsetree%03d",picnum),p,format="pdf");



// ======================== naturals 321 =============
int picnum = 1;
picture p;

// define nodes
node natural0=nbox("\strut\nonterminal{natural}"),
     digit0=nbox("\strut\nonterminal{digit}"),
     natural1=nbox("\strut\nonterminal{natural}"),
     three=nbox("\strut\terminal{3}"),
     natural2=nbox("\strut\nonterminal{natural}"),
     digit1=nbox("\strut\nonterminal{digit}"),
     two=nbox("\strut\terminal{2}"),
     digit2=nbox("\strut\nonterminal{digit}"),
     one=nbox("\strut\terminal{1}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
natural0.pos=(0*u,0*v);
// rank 1
digit0.pos=(-0.5*u,-1*v);
natural1.pos=(0.5*u,-1*v);
// rank 2
three.pos=(-0.5*u,-2*v);
digit1.pos=(0*u,-2*v);
natural2.pos=(1*u,-2*v);
// rank 3
two.pos=(0*u,-3*v);
digit2.pos=(1*u,-3*v);
// rank 4
one.pos=(1*u,-4*v);

// draw nodes
draw(p,
     natural0,
     digit0,
     natural1,
     three,
     natural2,
     digit1,
     two,
     digit2,
     one);

// draw edges
draw(p,
     (natural0--digit0),
     (natural0--natural1),
     (digit0--three),
     (natural1--digit1),
     (natural1--natural2),
     (digit1--two),
     (natural2--digit2),
     (digit2--one)
    );

shipout(format("parsetree%03d",picnum),p,format="pdf");

// ======================== naturals 321 =============
int picnum = 2;
picture p;

// define nodes
node expr0=nbox("\strut\nonterminal{expr}"),
     expr1=nbox("\strut\nonterminal{expr}"),
     plussign=nbox("\strut\terminal{+}"),
     expr2=nbox("\strut\nonterminal{expr}"),
     a=nbox("\strut\terminal{a}"),
     expr3=nbox("\strut\nonterminal{expr}"),
     starsign=nbox("\strut\terminal{*}"),
     expr4=nbox("\strut\nonterminal{expr}"),
     b=nbox("\strut\terminal{b}"),
     c=nbox("\strut\terminal{c}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
expr0.pos=(0*u,0*v);
// rank 1
expr1.pos=(-0.5*u,-1*v);
plussign.pos=(0*u,-1*v);
expr2.pos=(0.75*u,-1*v);
// rank 2
a.pos=(-0.5*u,-2*v);
expr3.pos=(0.25*u,-2*v);
starsign.pos=(0.75*u,-2*v);
expr4.pos=(1.25*u,-2*v);
// rank 3
b.pos=(0.25*u,-3*v);
c.pos=(1.25*u,-3*v);

// draw nodes
draw(p,
     expr0,
     expr1,
     plussign,
     expr2,
     a,
     expr3,
     starsign,
     expr4,
     b,
     c);

// draw edges
draw(p,
     (expr0--expr1),
     (expr0--plussign),
     (expr0--expr2),
     (expr1--a),
     (expr2--expr3),
     (expr2--starsign),
     (expr2--expr4),
     (expr3--b),
     (expr4--c)
    );

shipout(format("parsetree%03d",picnum),p,format="pdf");



// ======================== parse a+b*c =============
int picnum = 3;
picture p;

// define nodes
node expr0=nbox("\strut\nonterminal{expr}"),
     expr1=nbox("\strut\nonterminal{expr}"),
     starsign=nbox("\strut\terminal{*}"),
     expr2=nbox("\strut\nonterminal{expr}"),
     expr3=nbox("\strut\nonterminal{expr}"),
     plussign=nbox("\strut\terminal{+}"),
     expr4=nbox("\strut\nonterminal{expr}"),
     c=nbox("\strut\terminal{c}"),
     a=nbox("\strut\terminal{a}"),
     b=nbox("\strut\terminal{b}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
expr0.pos=(0*u,0*v);
// rank 1
expr1.pos=(-0.75*u,-1*v);
starsign.pos=(0.0*u,-1*v);
expr2.pos=(0.5*u,-1*v);
// rank 2
expr3.pos=(-1.25*u,-2*v);
plussign.pos=(-0.75*u,-2*v);
expr4.pos=(-0.25*u,-2*v);
c.pos=(0.5*u,-2*v);
// rank 3
a.pos=(-1.25*u,-3*v);
b.pos=(-0.25*u,-3*v);

// draw nodes
draw(p,
     expr0,
     expr1,
     plussign,
     expr2,
     a,
     expr3,
     starsign,
     expr4,
     b,
     c);

// draw edges
draw(p,
     (expr0--expr1),
     (expr0--starsign),
     (expr0--expr2),
     (expr1--expr3),
     (expr1--plussign),
     (expr1--expr4),
     (expr2--c),
     (expr3--a),
     (expr4--b)
    );

shipout(format("parsetree%03d",picnum),p,format="pdf");


// ======================== algebra terms =============
picnum = picnum+1;  // 004
picture p;

// define nodes
node expr0=nbox("\strut\nonterminal{expr}"),
     term0=nbox("\strut\nonterminal{term}"),
     term1=nbox("\strut\nonterminal{term}"),
     times=nbox("\strut\terminal{*}"),
     factor0=nbox("\strut\nonterminal{factor}"),
     factor1=nbox("\strut\nonterminal{factor}"),
     openparen=nbox("\strut\terminal{(}"),
     expr1=nbox("\strut\nonterminal{expr}"),
     closedparen=nbox("\strut\terminal{)}"),
     x=nbox("\strut\terminal{x}"),
     term2=nbox("\strut\nonterminal{term}"),
     addition=nbox("\strut\terminal{+}"),
     expr2=nbox("\strut\nonterminal{expr}"),
     factor2=nbox("\strut\nonterminal{factor}"),
     term3=nbox("\strut\nonterminal{term}"),
     y=nbox("\strut\terminal{y}"),
     factor3=nbox("\strut\nonterminal{factor}"),
     z=nbox("\strut\terminal{z}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.4*u;                 // vertical

// rank 0
expr0.pos=(0*u,0*v);
// rank 1
term0.pos=(0*u,-1*v);
// rank 2
term1.pos=(-0.5*u,-2*v);
times.pos=(0*u,-2*v);
factor0.pos=(0.75*u,-2*v);
// rank 3
factor1.pos=(-0.5*u,-3*v);
openparen.pos=(0.25*u,-3*v);
expr1.pos=(0.75*u,-3*v);
closedparen.pos=(1.25*u,-3*v);
// rank 4
x.pos=(-0.5*u,-4*v);
term2.pos=(0.25*u,-4*v);
addition.pos=(0.75*u,-4*v);
expr2.pos=(1.25*u,-4*v);
// rank 5
factor2.pos=(0.25*u,-5*v);
term3.pos=(1.25*u,-5*v);
// rank 6
y.pos=(0.25*u,-6*v);
factor3.pos=(1.25*u,-6*v);
// rank 7
z.pos=(1.25*u,-7*v);

// draw edges
draw(p,
     (expr0--term0),
     (term0--term1), (term0--times), (term0--factor0),
     (term1--factor1), (factor0--openparen), (factor0--expr1), (factor0--closedparen),
     (factor1--x), (expr1--term2), (expr1--addition), (expr1--expr2),
     (term2--factor2), (expr2--term3),
     (factor2--y), (term3--factor3),
     (factor3--z)
    );

// draw nodes
draw(p,
     expr0,
     term0,
     term1,
     times,
     factor0,
     factor1,
     openparen,
     expr1,
     closedparen,
     x, term2, addition, expr2,
     factor2, term3,
     y, factor3,
     z);

shipout(format("parsetree%03d",picnum),p,format="pdf");




// ======================== ambiguous grammar =============
int picnum = 5;
picture p;

// define nodes
node if0=nbox("\strut\terminal{if}"),
     bool0=nbox("\strut\nonterminal{bool}"),
     stmt0=nbox("\strut\nonterminal{stmt}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.5*u,-1*v);
stmt0.pos=(0.5*u,-1*v);

// draw nodes
draw(p,
     if0,
     bool0,
     stmt0
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--stmt0)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ...................................
int picnum = 6;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if}"),
     bool0 = nbox("\strut\nonterminal{bool}"),
     if1 = nbox("\strut\terminal{if}"),
     bool1 = nbox("\strut\nonterminal{bool}"),
     stmt0 = nbox("\strut\nonterminal{stmt}"),
     else0 = nbox("\strut\terminal{else}"),
     stmt1 = nbox("\strut\nonterminal{stmt}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.5*u,-1*v);
if1.pos=(0.5*u,-1*v);
// rank 2
bool1.pos=(-0.25*u,-2*v);
stmt0.pos=(0.25*u,-2*v);
else0.pos=(0.75*u,-2*v);
stmt1.pos=(1.25*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     bool1,
     stmt0,
     else0,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     (if1--bool1),
     (if1--stmt0),
     (if1--else0),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// .......parse tree of full statement............................
int picnum = 7;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if}"),
     bool0 = nbox("\strut\terminal{enrolled(s)}"),
     if1 = nbox("\strut\terminal{if}"),
     bool1 = nbox("\strut\terminal{studied(s)}"),
     stmt0 = nbox("\strut\terminal{grade=\textquotesingle P\textquotesingle}"),
     else0 = nbox("\strut\terminal{else}"),
     stmt1 = nbox("\strut\terminal{grade=\textquotesingle F\textquotesingle}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.5*u,-1*v);
if1.pos=(0.5*u,-1*v);
// rank 2
bool1.pos=(-0.85*u,-2*v);
stmt0.pos=(0.125*u,-2*v);
else0.pos=(0.80*u,-2*v);
stmt1.pos=(1.5*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     bool1,
     stmt0,
     else0,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     (if1--bool1),
     (if1--stmt0),
     (if1--else0),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ...................................
int picnum = 8;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if}"),
     bool0 = nbox("\strut\nonterminal{bool}"),
     stmt0 = nbox("\strut\nonterminal{stmt}"),
     else0 = nbox("\strut\terminal{else}"),
     stmt1 = nbox("\strut\nonterminal{stmt}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.75*u,-1*v);
stmt0.pos=(-0.25*u,-1*v);
else0.pos=(0.25*u,-1*v);
stmt1.pos=(0.75*u,-1*v);

// draw nodes
draw(p,
     if0,
     bool0,
     stmt0,
     else0,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--stmt0),
     (if0--else0),
     (if0--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ...................................
int picnum = 9;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if}"),
     bool0 = nbox("\strut\nonterminal{bool}"),
     if1 = nbox("\strut\terminal{if}"),
     else0 = nbox("\strut\terminal{else}"),
     stmt0 = nbox("\strut\nonterminal{stmt}"),
     bool1 = nbox("\strut\nonterminal{bool}"),
     stmt1 = nbox("\strut\nonterminal{stmt}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.75*u,-1*v);
if1.pos=(-0.25*u,-1*v);
else0.pos=(0.25*u,-1*v);
stmt0.pos=(0.75*u,-1*v);
// rank 2
bool1.pos=(-0.5*u,-2*v);
stmt1.pos=(0.0*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     else0,
     stmt0,
     bool1,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     (if0--else0),
     (if0--stmt0),
     (if1--bool1),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ...................................
int picnum = 10;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if}"),
     bool0 = nbox("\strut\terminal{enrolled(s)}"),
     if1 = nbox("\strut\terminal{if}"),
     else0 = nbox("\strut\terminal{else}"),
     stmt0 = nbox("\strut\terminal{grade=\textquotesingle F\textquotesingle}"),
     bool1 = nbox("\strut\terminal{studied(s)}"),
     stmt1 = nbox("\strut\terminal{grade=\textquotesingle P\textquotesingle}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.9*u,-1*v);
if1.pos=(-0.2*u,-1*v);
else0.pos=(0.2*u,-1*v);
stmt0.pos=(0.90*u,-1*v);
// rank 2
bool1.pos=(-0.7*u,-2*v);
stmt1.pos=(0.3*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     else0,
     stmt0,
     bool1,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     (if0--else0),
     (if0--stmt0),
     (if1--bool1),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");




// ======================== a^nb^n =============
int picnum = 11;
picture p;

// define nodes
node start=nbox("\strut S"),
     a1=nbox("\strut \trm{a}"),
     s1=nbox("\strut S"),
     b1=nbox("\strut\trm{b}"),
     a2=nbox("\strut\trm{a}"),
     s2=nbox("\strut S"),
     b2=nbox("\strut\trm{b}"),
     empty=nbox("\strut\emptystring");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
start.pos=(0*u,0*v);
// rank 1
a1.pos=(-0.5*u,-1*v);
s1.pos=(0.0*u,-1*v);
b1.pos=(0.5*u,-1*v);
// rank 2
a2.pos=(-0.5*u,-2*v);
s2.pos=(0.0*u,-2*v);
b2.pos=(0.5*u,-2*v);
// rank 3
empty.pos=(0*u,-3*v);

// draw edges
draw(p,
     (start--a1),
     (start--s1),
     (start--b1),
     (s1--a2),
     (s1--s2),
     (s1--b2),
     (s2--empty)
    );

// draw nodes
draw(p,
     start,
     a1,
     s1,
     b1,
     a2,
     s2,
     b2,
     empty);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");




// .......parse tree of full statement, add if-the-else ................
int picnum = 12;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if-then-else}"),
     bool0 = nbox("\strut\terminal{enrolled(s)}"),
     if1 = nbox("\strut\terminal{if-then-else}"),
     bool1 = nbox("\strut\terminal{studied(s)}"),
     stmt0 = nbox("\strut\terminal{grade=\textquotesingle P\textquotesingle}"),
// else0 = nbox("\strut\terminal{else}"),
     stmt1 = nbox("\strut\terminal{grade=\textquotesingle F\textquotesingle}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-0.75*u,-1*v);
if1.pos=(0.5*u,-1*v);
// rank 2
bool1.pos=(-0.9*u,-2*v);
stmt0.pos=(0.1*u,-2*v);
else0.pos=(0.80*u,-2*v);
stmt1.pos=(1*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     bool1,
     stmt0,
     // else0,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     (if1--bool1),
     (if1--stmt0),
     // (if1--else0),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");



// ...................................
int picnum = 13;
picture p;

// define nodes
node if0 = nbox("\strut\terminal{if-then-else}"),
     bool0 = nbox("\strut\terminal{enrolled(s)}"),
     if1 = nbox("\strut\terminal{if-then-else}"),
// else0 = nbox("\strut\terminal{else}"),
     stmt0 = nbox("\strut\terminal{grade=\textquotesingle F\textquotesingle}"),
     bool1 = nbox("\strut\terminal{studied(s)}"),
     stmt1 = nbox("\strut\terminal{grade=\textquotesingle P\textquotesingle}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.5*u;                 // vertical

// rank 0
if0.pos=(0*u,0*v);
// rank 1
bool0.pos=(-1.2*u,-1*v);
if1.pos=(0*u,-1*v);
// else0.pos=(0.2*u,-1*v);
stmt0.pos=(1.1*u,-1*v);
// rank 2
bool1.pos=(-0.6*u,-2*v);
stmt1.pos=(0.4*u,-2*v);

// draw nodes
draw(p,
     if0,
     bool0,
     if1,
     // else0,
     stmt0,
     bool1,
     stmt1
     );

// draw edges
draw(p,
     (if0--bool0),
     (if0--if1),
     // (if0--else0),
     (if0--stmt0),
     (if1--bool1),
     (if1--stmt1)
    );

shipout(format(OUTPUT_FN,picnum),p,format="pdf");






// ======= Exercises =================
// =========================================
string OUTPUT_FN = "parsetree1%03d";


// ======================== C-like language =============
picnum = 0;  
picture p;

// define nodes
node program=nbox("\nonterminal{program}"),
     opencurly=nbox("\strut\terminal{\{}"),
     statementlist=nbox("\nonterminal{statement-list}"),
     closedcurly=nbox("\strut\terminal{\}}"),
     statement0=nbox("\nonterminal{statement}"),
     semicolon0=nbox("\strut\terminal{;}"),
     statement1=nbox("\nonterminal{statement}"),
     semicolon1=nbox("\strut\terminal{;}"),
     statement2=nbox("\nonterminal{statement}"),
     semicolon2=nbox("\strut\terminal{;}"),
     datatype=nbox("\nonterminal{datatype}"),
     identifier0=nbox("\nonterminal{identifier}"),
     identifier1=nbox("\nonterminal{identifier}"),
     equals=nbox("\strut\terminal{=}"),
     expression0=nbox("\nonterminal{expression}"),
     print=nbox("\strut\terminal{print}"),
     identifier2=nbox("\nonterminal{identifier}"),
     boolean=nbox("\strut\terminal{int}"),
     letter0=nbox("\nonterminal{letter}"),
     letter1=nbox("\nonterminal{letter}"),
     number=nbox("\nonterminal{number}"),
     letter2=nbox("\nonterminal{letter}"),
     A0=nbox("\strut\terminal{A}"),
     A1=nbox("\strut\terminal{A}"),
     digit=nbox("\nonterminal{digit}"),
     A2=nbox("\strut\terminal{A}"),
     one=nbox("\strut\terminal{1}");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 1inch;
real u = 0.7inch;  // horizontal
real v = 0.4*u;                 // vertical

// rank 0
program.pos=(0*u,0*v);
// rank 1
opencurly.pos=(-1*u,-1*v);
statementlist.pos=(0*u,-1*v);
closedcurly.pos=(1*u,-1*v);
// rank 2
statement0.pos=(-2*u,-2*v);
semicolon0.pos=(-1*u,-2*v);
statement1.pos=(-0.15*u,-2*v);
semicolon1.pos=(0.65*u,-2*v);
statement2.pos=(1.5*u,-2*v);
semicolon2.pos=(2.25*u,-2*v);
// rank 3
datatype.pos=(-3*u,-3*v);
identifier0.pos=(-2*u,-3*v);
identifier1.pos=(-0.9*u,-3*v);
equals.pos=(0*u,-3*v);
expression0.pos=(0.9*u,-3*v);
print.pos=(2*u,-3*v);
identifier2.pos=(3*u,-3*v);
// rank 4
boolean.pos=(-3*u,-4*v);
letter0.pos=(-2*u,-4*v);
letter1.pos=(-0.9*u,-4*v);
number.pos=(0.9*u,-4*v);
letter2.pos=(3*u,-4*v);
// rank 5
A0.pos=(-2*u,-5*v);
A1.pos=(-0.9*u,-5*v);
digit.pos=(0.9*u,-5*v);
A2.pos=(3*u,-5*v);
// rank 6
one.pos=(0.9*u,-6*v);

// draw edges
draw(p,
     (program--opencurly), (program--statementlist), (program--closedcurly),
     (statementlist--statement0), (statementlist--semicolon0),
     (statementlist--statement1), (statementlist--semicolon1),
     (statementlist--statement2), (statementlist--semicolon2),
     (statement0--datatype), (statement0--identifier0),
     (statement1--identifier1), (statement1--equals), (statement1--expression0),
     (statement2--print), (statement2--identifier2),     
     (datatype--boolean),
     (identifier0--letter0),
     (identifier1--letter1),
     (expression0--number),
     (identifier2--letter2),
     (letter0--A0),
     (letter1--A1),
     (number--digit),
     (letter2--A2),
     (digit--one)
    );

// draw nodes
draw(p,
     program,
     opencurly, statementlist, closedcurly,
     statement0, semicolon0, statement1, semicolon1, statement2, semicolon2, 
     datatype, identifier0, identifier1, equals, expression0, print, identifier2,
     boolean, letter0, letter1, number, letter2, 
     A0, A1, digit, A2, 
     one);

shipout(format(OUTPUT_FN,picnum),p,format="pdf");


// ======================== C-like language =============
picnum = 1;  
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
int picnum = 2;
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
digit1.pos=(0*u,-2*v);
natural2.pos=(2*u,-2*v);
// rank 3
nine1.pos=(0*u,-3*v);
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


