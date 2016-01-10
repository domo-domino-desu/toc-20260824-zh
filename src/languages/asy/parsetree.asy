// parsetree.asy
//  Draw parse trees

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../asy/");
import settexpreamble;
cd("");
settexpreamble();
cd("../../asy/share/");
import jh;
cd("");

import node;

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);


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
draw(the,
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
draw(
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
int picnum = 0;
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
draw(natural0,
     digit0,
     natural1,
     three,
     natural2,
     digit1,
     two,
     digit2,
     one);

// draw edges
draw(
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
