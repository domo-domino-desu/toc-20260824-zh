// jhnode.asy Asymptote common definitions
// for https://github.com/taoari/asy-graphtheory/blob/master/Usage.md

// node.asy seems to cause graph3 to give output with a truncated viewport
// So I need to import my settings for it separately 

// 2020-Jan-30 JH

// This is only ever imported after jh.asy so the fact that some
// colors are not defined is OK; they are defined there.

import jh;

// node.asy parameters
// import patched version
import node;

// define node style
pen GRAYPEN = gray(0.3);  // 0 is black, 1 is white
pen NODEPEN=fontsize(7pt)+linecap(0);
pen EDGEPEN=backgroundcolor+linewidth(1pt)+fontsize(7pt); // +fontcommand("\ttfamily");
pen  EDGEPEN_TT=EDGEPEN+fontcommand("\color{black}\ttfamily");

pen WALK_PEN = linewidth(0.75bp) + highlight_color;

// // define edge style
labelstyle edgelabel=labelstyle(fontsize(5pt)+fontcommand("\ttfamily")+GRAYPEN);
drawstyle directededgestyle=drawstyle(edgelabel, p=EDGEPEN_TT,
				      arrow=Arrow(6,filltype=FillDraw(backgroundcolor,GRAYPEN)));
defaultdrawstyle=directededgestyle;
// // Edge with no arrow
drawstyle undirectededgestyle=drawstyle(edgelabel, p=EDGEPEN_TT, arrow=None);



// Node styles
// Standard node is single-circle border
defaultnodestyle=nodestyle(textpen=NODEPEN, xmargin=1pt, drawfn=FillDrawer(backgroundcolor,black));
// Double circle nodes
nodestyle ns_accepting=nodestyle(textpen=NODEPEN+red, drawfn=Filler(backgroundcolor)+DoubleDrawer(black));
// Nodes without any boxing
nodestyle ns_noborder=nodestyle(xmargin=1pt, drawfn=None);

// For graph coloring
nodestyle ns_bleachedbg=nodestyle(xmargin=1pt,textpen=NODEPEN,
				  drawfn=FillDrawer(backgroundcolor+white,black));
nodestyle ns_bg=nodestyle(xmargin=1pt,textpen=NODEPEN,
			  drawfn=FillDrawer(backgroundcolor,black));
nodestyle ns_bleachedbold=nodestyle(xmargin=1pt,textpen=NODEPEN,
				    drawfn=FillDrawer(bold_light,black));
nodestyle ns_light=nodestyle(xmargin=1pt,textpen=NODEPEN,
			     drawfn=FillDrawer(lightcolor,black));
nodestyle ns_gray=nodestyle(xmargin=1pt,textpen=NODEPEN,
			    drawfn=FillDrawer(gray(0.85),black));
nodestyle ns_white=nodestyle(xmargin=1pt,textpen=NODEPEN,
			    drawfn=FillDrawer(white,black));



// nrounddiamond; shape like ndiamond, but with rounded corners
path rounddiamond(pair center=(0,0), real rx=1, real ry=rx)
{
  pair rightcorner = center+(rx,0);
  pair leftcorner = center-(rx,0);
  pair topcorner = center+(0,ry);
  pair botcorner = center-(0,ry);
  path diamondpath = rightcorner--topcorner--leftcorner--botcorner--cycle;
  // real d=roundratio*min(DD.x,DD.y);
  real roundratio = 0.15; // additional parameter
  path rightcircle = circle(rightcorner,roundratio*rx);
  path leftcircle = circle(leftcorner,roundratio*rx);
  path topcircle = circle(topcorner,roundratio*ry);
  path botcircle = circle(botcorner,roundratio*ry);

  // straight from rightcorner to topcorner
  path firststraight = subpath(diamondpath,0,1);
  firststraight = firstcut(firststraight,rightcircle).after;
  firststraight = firstcut(firststraight,topcircle).before;
  // straight from topcorner to leftcorner
  path secondstraight = subpath(diamondpath,1,2);
  secondstraight = firstcut(secondstraight,topcircle).after;
  secondstraight = firstcut(secondstraight,leftcircle).before;
  // straight from leftcorner to botcorner
  path thirdstraight = subpath(diamondpath,2,3);
  thirdstraight = firstcut(thirdstraight,leftcircle).after;
  thirdstraight = firstcut(thirdstraight,botcircle).before;
  // straight from botcorner to rightcorner
  path fourthstraight = subpath(diamondpath,3,4);
  fourthstraight = firstcut(fourthstraight,botcircle).after;
  fourthstraight = firstcut(fourthstraight,rightcircle).before;

  return firststraight::secondstraight::thirdstraight::fourthstraight::cycle;
}


node nrounddiamond(Label L, nodestyle ns=defaultnodestyle) {
    real xmargin = ns.xmargin;
    real ymargin = ns.ymargin;
    pen textpen = ns.textpen;
    draw_t drawfn = ns.drawfn;
    real mag = ns.mag;

    node nd;
    label(nd.stuff, L, textpen);
    pair M=max(nd.stuff),
         m=min(nd.stuff),
         D=M-m,
         c=0.5*(M+m);
    pair DD=mag*(D+2*(xmargin,ymargin));
    real ra, rb;
    ra=0.5*DD.x*2;rb=0.5*DD.y*2;
    nd.outline=rounddiamond(c, ra, rb);
    drawfn(nd.stuff, nd.outline);
    return nd;
}

node[] nrounddiamonds(nodestyle ns=defaultnodestyle ... Label[] Ls) {
    node[] nds;
    for (Label L : Ls) {
        nds.push(nrounddiamond(L, ns));
    }
    return nds;
}


// Set defaults for circle and arrow states diagrams
void setdefaultstatediagramstyles() {
  // If you declare structures then you won't see the changes outside the fcn
  NODEPEN=fontsize(7pt);
  EDGEPEN=linewidth(0.75bp)+fontsize(7pt)+black; 
  EDGEPEN_TT=EDGEPEN+fontcommand("\ttfamily");
  defaultnodestyle=nodestyle(xmargin=1pt,
			     textpen=NODEPEN,
			     drawfn=FillDrawer(backgroundcolor,boldcolor));
  // Nodes with double circle 
  ns_accepting=nodestyle(xmargin=1pt,
			 textpen=NODEPEN,
			 drawfn=Filler(backgroundcolor)+DoubleDrawer(black));
  // Nodes without any boxing
  ns_noborder=nodestyle(xmargin=1pt,
			textpen=NODEPEN,
			drawfn=None);
  // edge style
  // defaultdrawstyle=drawstyle(p=EDGEPEN,
  // 			     arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));
  defaultdrawstyle=directededgestyle;

  // Pen for edges when Labelled
  // pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
  // color edges in walk
  //  pen walk_pen = linewidth(0.75bp) + highlight_color;
}


// Set defaults for graphs
void setdefaultgraphstyles() {
  // If you declare structures then you won't see the changes outside the fcn
  // NODEPEN=fontsize(7pt);
  // EDGEPEN=linewidth(0.75bp)+fontsize(7pt); // +boldcolor; 
  // EDGEPEN_TT=EDGEPEN+fontcommand("\ttfamily");
  defaultnodestyle=nodestyle(xmargin=0.4pt,
			     textpen=NODEPEN,
			     drawfn=FillDrawer(white,boldcolor));
  // edge style
  // defaultdrawstyle=drawstyle(p=EDGEPEN_TT+backgroundcolor, arrow=None);
  defaultdrawstyle=undirectededgestyle;

  // for directed graphs 
  drawstyle directedstyle=directededgestyle;
    // drawstyle(p=EDGEPEN_TT,
    // 				    arrow=Arrow(6,filltype=FillDraw(white,boldcolor)));
}


// Set defaults for parsetrees
void setdefaultparsetreestyles() {
  currentpen=MAINPEN+fontsize(9.24994pt);
  defaultnodestyle=nodestyle(drawfn=FillDrawer(white,white));
  defaultdrawstyle=drawstyle(p=fontsize(9.24994pt)+fontcommand("\ttfamily")+backgroundcolor);
}

// When drawing parse trees you want to position according to the
// node above.  For example, 
//    simple1.pos=new_node_pos(concat1, -30, -1*v);
// puts the node simple1 at the position below concat1 of -30 degrees,
// so that it is 1v lower than concat1.

// Given the angle and the desired vert dist, return the horiz dist
real find_horiz(real theta, real vert) {
  return vert/Tan(theta);
}

// Given the angle and the desired horiz dist, return the vert dist
real find_vert(real theta, real horiz) {
  return horiz*Tan(theta);
}

// From starting point, angle, and desired vert dist, return new pos
// (If you want the returned position to be below, maybe you want both
// theta and vert to be negative?)
pair new_node_pos(node starting_pos, real theta, real vert) {
  return (starting_pos.pos.x+find_horiz(theta,vert), starting_pos.pos.y+vert);
}

// From starting point, angle, and desired horiz dist, return new pos
pair new_node_pos_h(node starting_pos, real theta, real horiz) {
  return starting_pos.pos+(horiz, horiz*Tan(theta));
}



