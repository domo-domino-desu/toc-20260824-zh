// graphs.asy
//  Draw intro to graphs

import settings;
// settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import tape --> jh
cd("../../../asy/");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/share/");
import jh;
cd("");

import node;

// define style
// defaultnodestyle=nodestyle(drawfn=FillDrawer(lightgray,black));
defaultnodestyle=nodestyle(textpen=fontsize(7pt),drawfn=FillDrawer(white,highlight_color));
defaultdrawstyle=drawstyle(p=fontsize(7pt)+fontcommand("\ttfamily")+backgroundcolor);


// ======================== house graph =============
int picnum = 0;
picture p;

// define nodes
node peak=ncircle("$v_0$"),
     lefttop=ncircle("$v_1$"),
     righttop=ncircle("$v_2$"),
     leftbot=ncircle("$v_3$"),
     rightbot=ncircle("$v_4$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
layout(-90-peakangle,peak,lefttop);
layout(-90+peakangle,peak,righttop);
vlayout(1*v,lefttop,leftbot);
vlayout(1*v,righttop,rightbot);

// draw edges
draw(p,
     (peak--lefttop),
     (peak--righttop),
     (lefttop--righttop),
     (lefttop--leftbot),
     (lefttop--rightbot),
     (righttop--leftbot),
     (righttop--rightbot),
     (leftbot--rightbot)
    );

// draw nodes
draw(p,
     peak,
     lefttop,righttop,
     leftbot,rightbot);

shipout(format("graphs%02d",picnum),p,format="pdf");



// ======================== house graph sideways =============
int picnum = 1;
picture p;

// define nodes
node v0=ncircle("$v_0$"),
     v1=ncircle("$v_1$"),
     v2=ncircle("$v_2$"),
     v3=ncircle("$v_3$"),
     v4=ncircle("$v_4$");

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
hlayout(1*u,v3,v1);
hlayout(1*u,v4,v2);
vlayout(1*v,v1,v2);
vlayout(1*v,v3,v4);
v0.pos = (v1.pos.x+1*u,(v1.pos.y+v2.pos.y)/2); 
// layout(-45.0,0.707*v,v1,v0);

// draw edges
draw(p,
     (v0--v1),
     (v0--v2),
     (v1--v2),
     (v1--v3),
     (v1--v4),
     (v2--v3),
     (v2--v4),
     (v3--v4)
    );

// draw nodes
draw(p,
     v0,
     v1,v2,
     v3,v4);

shipout(format("graphs%02d",picnum),p,format="pdf");


// ======================== house graph no edge crossing =============
int picnum = 2;
picture p;

// define nodes
node peak=ncircle("$v_0$"),
     lefttop=ncircle("$v_1$"),
     righttop=ncircle("$v_2$"),
     leftbot=ncircle("$v_3$"),
     rightbot=ncircle("$v_4$");

node n0, n1, n2;

// layout
defaultlayoutrel = true;
defaultlayoutskip = 0.75cm;
real u = defaultlayoutskip;  // horizontal
real v = 0.5*u;                 // vertical

real peakangle = 65;  // half angle formed at peak
layout(-90-peakangle,peak,lefttop);
layout(-90+peakangle,peak,righttop);
vlayout(1*v,lefttop,leftbot);
vlayout(1*v,righttop,rightbot);
hlayout(-0.5u,lefttop,n0);
hlayout(-0.25u,leftbot,n1);
vlayout(0.5v,leftbot,n2);

// draw edges
draw(p,
     (peak--lefttop),
     (peak--righttop),
     (lefttop--righttop),
     (lefttop--leftbot),
     // (lefttop.. bend(95.0) ..rightbot),
     (righttop--leftbot),
     (righttop--rightbot),
     (leftbot--rightbot)
    );
draw(p,lefttop.pos{curl 0.25} .. n1.pos .. n2.pos .. {curl 0.5}rightbot.pos,backgroundcolor);

// draw nodes
draw(p,
     peak,
     lefttop,righttop,
     leftbot,rightbot);

shipout(format("graphs%02d",picnum),p,format="pdf");



