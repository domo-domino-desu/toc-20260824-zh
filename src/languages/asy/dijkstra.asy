// dijkstra.asy
//  draw tape for before and after, to give defn of fcn

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../asy/share/");
import tape;
cd("");

import node;

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(drawfn=FillDrawer(white,highlight_color));
defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily"));

// define nodes
// node[] n = ncircles("$a$", "$b$", "$c$", "$d$", "$e$", "$f$");
node a=ncircle("$a$"),
     b=ncircle("$b$"),
     c=ncircle("$c$"),
     d=ncircle("$d$"),
     e=ncircle("$e$"),
     f=ncircle("$f$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.7cm;
real u = defaultlayoutskip;
real v = 0.85*u;

vlayout(v, a, b);
layout(-22.5, a, c);
hlayout(2*u, a, d);
hlayout(2*u, b, e);
layout(-22.5, d, f);

// draw nodes
draw(a, b, c, d, e, f);

// draw edges
draw(
     (a--b).l("\scriptsize $7$"), 
     (a--c).l("\scriptsize $9$"),
     (a--d).l("\scriptsize $14$").style("leftside"),
     (b--c).l(Label("\scriptsize $10$",position=Relative(0.7))),
     (b--e).l("\scriptsize $15$"),
     (c--d).l("\scriptsize $2$"),
     (c--e).l(Label("\scriptsize $11$",position=Relative(0.3))),
     (e--f).l("\scriptsize $6$"),
     (f--d).l("\scriptsize $9$")
    );

