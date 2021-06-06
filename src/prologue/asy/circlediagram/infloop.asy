// infloop.asy
//  circle diagram of the inf loop TM

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
setdefaultstatediagramstyles();
defaultdrawstyle=directededgestyle;

// define nodes
// node[] n = ncircles("$q_0$", "$b$", "$c$", "$d$", "$e$", "$f$");
node q0=ncircle("$q_0$");

// layout
defaultlayoutrel = false;
defaultlayoutskip = 1.5cm;
real u = defaultlayoutskip;
real v = 0.85*u;

// hlayout(u, q0);

// draw edges
draw(
     (q0..loop(W)).l("\scriptsize $\blank,\blank$"),
     (q0..loop(E)).l("\scriptsize $\str{1},\str{1}$")
    );

// draw nodes
draw(q0);
