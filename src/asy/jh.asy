// jh.asy Asymptote common definitions

import fontsize;
defaultpen(fontsize(9.24994pt));
import texcolors;

// note that the TeX preamble is set in settexpreamble.asy
// It has to come first; something like this at the start of the .asy file.
//
// cd("../../../asy");
// import settexpreamble;
// cd("");
// settexpreamble();
//
// cd("../../../asy");
// import jh;
// cd("");
//
// import settings;
// settings.outformat="pdf";


// colors villiers
// pen blue_color=rgb("122130");
// pen green_color=rgb("4B6635");
// pen lightgreen_color=rgb("D5E06D");
// pen beige_color=rgb("FFEDAF");
// pen red_color=rgb("F54E2A");

// colors Tech Office
pen darkgrey_color=rgb("595241");  // hex string
pen lightgrey_color=rgb("E0D4BE");  // rgb("B8AE9C");
pen white_color=rgb("FFFFFF");
pen lightblue_color=rgb("ACCFCC");
pen red_color=rgb("8A0917");

pen highlight_color=red_color;
pen background_color=lightblue_color;
pen bold_color=darkgrey_color;
pen light_color=lightgrey_color;
pen verylight_color=white_color;

// these match the text color names
pen highlightcolor=red_color;
pen backgroundcolor=lightblue_color;
pen boldcolor=darkgrey_color;
pen lightcolor=lightgrey_color;
pen verylightcolor=white_color;

// for places where the highlight color is too bold or dark, as with a colored node
pen highlight_light = rgb(248/255, 145/255, 157/255); // from: http://hslpicker.com/#f67987
pen bold_light = rgb(165/255, 155/255, 131/255); 


// ==================== General pens ===================
// pen FILLCOLOR=background_color;  // rgb("fff0ca");
pen FILLCOLOR=lightcolor;  // like listings backgrounds

pen MAINPEN=linecap(0)
            +linewidth(0.4pt);
pen VECTORPEN=linecap(0)
              +linewidth(0.8pt);
real VECTORHEADSIZE=5;
pen THINPEN=linecap(0)
            +linewidth(0.25pt);
pen DASHPEN=linecap(0)
            +linewidth(0.4pt)
            +linetype(new real[] {8,8});
pen FCNPEN_NOCOLOR=linecap(0)
  +linewidth(1.5pt);
pen FCNPEN_SOLID=FCNPEN_NOCOLOR
  +lightcolor;
// pen FCNPEN=linecap(0)
//             +lightcolor
//             +linewidth(1.5pt)
//             +opacity(.5,"Normal");
pen FCNPEN=FCNPEN_SOLID
  +opacity(.5,"Normal");
pen AXISPEN=linecap(0)
            +gray(0.5)
            +linewidth(0.4pt)
             +opacity(1,"Normal");
pen TICLABELPEN=fontsize(7pt);
pen DXPEN=linecap(0)
           +red
           +linewidth(1pt);
pen LIGHTPEN=linewidth(0.4pt); // matches mpost line_width_light
pen DARKPEN=linewidth(0.8pt); // line_width_dark



// HSL color space, to lighten or darken
// see http://en.wikipedia.org/wiki/HSL_and_HSV
// To lighten, something like this:
// HSL hsl=HSL(0.116,0.675,0.255);
// hsl.l=1-((1-hsl.l)/4.0);
// pen p=hsl.rgb();
struct HSL {
  real hue; // hue in degrees
  real h; // hue in [0..1]
  real s; // saturation
  real l; // lightness

  // Initialize
  // expects r, g, b in [0..1]
  void operator init(real r, real g, real b) {
  real mincolorsize=min(r,g,b);
  real maxcolorsize=max(r,g,b);
  real chroma=maxcolorsize-mincolorsize;
  // hue
  real hprime;
  if (chroma==0) {
    hprime=0;
  } else if (maxcolorsize==r) {
    hprime=fmod((g-b)/chroma,6);
  } else if (maxcolorsize==g) {
    hprime=2+(b-r)/chroma;
  } else {
    hprime=4+(r-g)/chroma; 
  }
  this.hue=60*hprime;
  this.h=this.hue/360.0;
  // lightness
  this.l=(maxcolorsize+mincolorsize)/2;
  //saturation
  if (chroma==0) {
    this.s=0;
  } else {
    this.s=chroma/(1-fabs(2*this.l-1)); 
  }
}

// return pen with the hsl converted to rgb
// Note: does not handle grays
pen rgb() {
  real chroma=(1-fabs(2*this.l-1))*this.s;
  real hprime=this.hue/60.0;
  real x=chroma*(1-fabs(fmod(hprime,2.0)-1));
  real r1, g1, b1, m, r, g, b;
  if ((0<=hprime) && (hprime<1)) {
    r1=chroma; g1=x; b1=0;
  } else if ((1<=hprime) && (hprime<2)) {
    r1=x; g1=chroma; b1=0;
  } else if ((2<=hprime) && (hprime<3)) {
    r1=0; g1=chroma; b1=x;
  } else if ((3<=hprime) && (hprime<4)) {
    r1=0; g1=x; b1=chroma;
  } else if ((4<=hprime) && (hprime<5)) {
    r1=x; g1=0; b1=chroma;
  } else {
    r1=chroma; g1=0; b1=x;
  }
  m=this.l-chroma/2.0;
  r=r1+m; g=g1+m; b=b1+m;
  return rgb(r,g,b); 
  }
}


// vec_outline draw a vector's outline, filled in white
// usage:
// pen inverse_image_pen=linecap(1)
// +linewidth(1.5pt);
// pen inverse_image_fill_pen=linecap(1)
// +linewidth(1pt);
// path vec=(0,0)--(2,0);
// picture p=vec_outline(vec,inverse_image_pen+color,inverse_image_fill_pen+white);
// add(p);
picture vec_outline(path p, pen exterior, pen interior) {
  picture pic;
  draw(pic,p,exterior,arrow=Arrow(DefaultHead,VECTORHEADSIZE),PenMargin(-1,0));
  draw(pic,p,interior,arrow=Arrow(DefaultHead,VECTORHEADSIZE),PenMargin(-3/4,1/4));
  return pic;
}


// cut_off_ends
//   Lop off ends of path, some radius from each end.
path cut_off_ends(path p, real epsilon) {
  path knife0 = circle(point(p,0),epsilon);
  // draw(q,knife0,red);
  path after_cut = firstcut(p,knife0).after;
  // draw(q,after_cut,green);
  path knife1 = circle(point(after_cut,length(after_cut)),epsilon);
  // draw(q,knife1,red);
  path after_cut = firstcut(after_cut,knife1).before;
  return after_cut;
}


// node.asy parameters
import node;
// define node style
pen NODEPEN=fontsize(7pt)+blue;
pen EDGEPEN=fontsize(7pt); // +fontcommand("\ttfamily");
pen  EDGEPEN_TT=EDGEPEN+fontcommand("\ttfamily");
// //? doesn't do anything defaultlabelstyle=labelstyle(p=fontsize(6pt)+fontcommand("\ttfamily")+red);
// // define edge style
defaultdrawstyle=drawstyle(p=EDGEPEN, arrow=Arrow(DefaultHead,size=3));
// // Standard node is single-circle border
defaultnodestyle=nodestyle(textpen=NODEPEN, xmargin=1pt, drawfn=FillDrawer(backgroundcolor,black));
// // Double circle nodes
nodestyle ns_accepting=nodestyle(textpen=NODEPEN+red, drawfn=Filler(FILLCOLOR)+DoubleDrawer(black));
// // nodes without any boxing
nodestyle ns_noborder=nodestyle(xmargin=1pt, drawfn=None);



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
  defaultdrawstyle=drawstyle(p=EDGEPEN,
			     arrow=Arrow(6,filltype=FillDraw(backgroundcolor,black)));

  // Pen for edges when Labelled
  // pen edge_text_pen = fontsize(7pt) + fontcommand("\ttfamily") + black;
  // color edges in walk
  //  pen walk_pen = linewidth(0.75bp) + highlight_color;
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
pair new_node_pos(node starting_pos, real theta, real vert) {
  return (starting_pos.pos.x+find_horiz(theta,vert), starting_pos.pos.y+vert);
}

// From starting point, angle, and desired horiz dist, return new pos
pair new_node_pos_h(node starting_pos, real theta, real horiz) {
  return (starting_pos.pos.x+horiz, starting_pos.pos.y+horiz*Tan(theta));
}

// circle centered at c, radius r
path circle(pair c, real r)
{
return shift(c)*scale(r)*unitcircle;
}

// Center a drawing using graph at the origin of the graph; see
// http://tex.stackexchange.com/questions/299297/asymptote-have-stuff-outside-the-box
// Call with centerAtOrigin() at the end
// void centerAtOrigin(picture p=currentpicture)
// {
//     pair origMinPoint = min(p)/72*2.54;
//     pair origMaxPoint = max(p)/72*2.54;
//     pair origSize = size(p)/72*2.54;
//     real xmin = origMinPoint.x;
//     real xmax = origMaxPoint.x;
//     real ymin = origMinPoint.y;
//     if (xmax > fabs(xmin)) { xmin = -xmax; }
//     if (fabs(xmin) > xmax) { xmax = -xmin; }
//     fill(shift(xmin,ymin)*scale(xmax-xmin,origSize.y)*
//         unitsquare, opacity(0)+white);
// }


