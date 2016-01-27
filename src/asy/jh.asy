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
pen lightgrey_color=rgb("B8AE9C");
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
pen FCNPEN=linecap(0)
            +gray(0.3)
            +linewidth(1.5pt)
            +opacity(.5,"Normal");
pen AXISPEN=linecap(0)
            +gray(0.3)
            +linewidth(0.4pt)
             +opacity(.5,"Normal");
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
pen NODEPEN=fontsize(9pt);
pen EDGEPEN=fontsize(7pt); // +fontcommand("\ttfamily");
// //? doesn't do anything defaultlabelstyle=labelstyle(p=fontsize(6pt)+fontcommand("\ttfamily")+red);
// // define edge style
defaultdrawstyle=drawstyle(p=EDGEPEN, arrow=Arrow(DefaultHead,size=3));
// // Standard node is single-circle border
defaultnodestyle=nodestyle(textpen=NODEPEN, xmargin=1pt, drawfn=FillDrawer(FILLCOLOR,black));
// // Double circle nodes
nodestyle ns_accepting=nodestyle(textpen=NODEPEN, drawfn=Filler(FILLCOLOR)+DoubleDrawer(black));
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
  real roundratio = 0.05; // additional parameter
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

// circle centered at c, radius r
path circle(pair c, real r)
{
return shift(c)*scale(r)*unitcircle;
}

