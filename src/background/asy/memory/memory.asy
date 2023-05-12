// memory.asy
//  Ilustrating pointers

// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

import settings;
settings.outformat="pdf";

string OUTPUT_FN = "memory%02d";


string[] PGM = {"void main() \{",
		"\ \   int* x,y;",
		"\ \   x = malloc(sizeof(int));",
		"\ \   y = malloc(sizeof(int));",
		"\ \   *x = 42;",
		"\ \   y=x;",
		"\ \   *y = 13;",
		"\}"
};
real LINETOLINE = 8.5pt;  // spacing between lines
// Show the code of the program, with the given lines highlighted
//  Usage example: draw_program(highlighted=new int[] {1,3})
picture draw_program(string[] pgm=PGM, int[] highlighted={}) {
  picture pic;
  unitsize(pic,1pt,1pt);

  int lineno = 0;
  for (string lne: pgm) {
    if (find(highlighted == lineno) >= 0) {
      label(pic,minipage("\makebox[1.3in][l]{\ttfamily "+lne+"}",1.3inch),(0,-lineno*LINETOLINE),fontsize(7pt)+highlightcolor);
    } else {
      label(pic,minipage("\makebox[1.3in][l]{\ttfamily "+lne+"}",1.3inch),(0,-lineno*LINETOLINE),fontsize(7pt)+black);
    }
    lineno = lineno+1;
  }
  return pic;
}

real MEMWIDTH=0.25inch;
real MEMHGT=10pt;
path membox(real width=MEMWIDTH, real height=MEMHGT) {
  return (0,0)--(width,0)--(width,height)--(0,height)--cycle;
}
picture draw_memboxes(int boxx, int boxy, int boxp0, int boxp1, bool showaddress=false) {
  picture pic;
  unitsize(pic,1pt,1pt);
  path box123 = membox(); // x is contents of this
  path box124 = membox(); // y is contents of this
  path box901 = membox(); // x will point here, sometimes y points here
  path box902 = membox(); // y will sometimes point here

  if (showaddress) {
    label(pic,"\textit{Address}",(0,2*MEMHGT),W,highlightcolor);
  }
  label(pic,"\makebox[0.5in][r]{$\vdots$}",(0.75*MEMWIDTH,2.25*MEMHGT),W,fontsize(7pt)+black);
  draw(pic,shift(0,0)*box123,boldcolor);
    if (showaddress) {
      label(pic,"\textsc{123}",(0,0.5*MEMHGT),W,fontsize(7pt)+highlightcolor);
    }
    if (boxx>=0) {
      label(pic,format("\makebox[0.75in][r]{%d}",boxx),(MEMWIDTH,0.5*MEMHGT),W,fontsize(7pt)+black);
    } else {
      // label(pic,"\makebox[0.35in][c]{\textit{--junk--}}",(MEMWIDTH,0.5*MEMHGT),W,fontsize(7pt)+lightcolor);
    }
  draw(pic,shift(0,-MEMHGT)*box124,boldcolor);
    if (showaddress) {
      label(pic,"\textsc{124}",(0,-0.5*MEMHGT),W,fontsize(7pt)+highlightcolor);
    }
    if (boxy>=0) {
      label(pic,format("\makebox[0.5in][r]{%d}",boxy),(MEMWIDTH,-0.5*MEMHGT),W,fontsize(7pt)+black);
    } else {
      // label(pic,"\makebox[0.35in][c]{\textit{--junk--}}",(MEMWIDTH,-0.5*MEMHGT),W,fontsize(7pt)+lightcolor);
    }
  label(pic,"\makebox[0.5in][r]{$\vdots$}",(0.75*MEMWIDTH,-1.75*MEMHGT),W,fontsize(7pt)+black);
  draw(pic,shift(0,-4.0*MEMHGT)*box901,boldcolor);
    if (showaddress) {
      label(pic,"\textsc{901}",(0,-3.5*MEMHGT),W,fontsize(7pt)+highlightcolor);
    }
    if (boxp0>=0) {
      label(pic,format("\makebox[0.35in][r]{%d}",boxp0),(MEMWIDTH,-3.5*MEMHGT),W,fontsize(7pt)+black);
    } else {
      // label(pic,"\makebox[0.35in][r]{\textit{--junk--}}",(MEMWIDTH,-3.5*MEMHGT),W,fontsize(7pt)+lightcolor);
    }
  draw(pic,shift(0,-5.0*MEMHGT)*box902,boldcolor);
    if (showaddress) {
      label(pic,"\textsc{902}",(0,-4.5*MEMHGT),W,fontsize(7pt)+highlightcolor);
    }
    if (boxp1>=0) {
      label(pic,format("\makebox[0.35in][r]{%d}",boxp1),(MEMWIDTH,-4.5*MEMHGT),W,fontsize(7pt)+black);
    } else {
      // label(pic,"\makebox[0.35in][r]{\textit{--junk--}}",(MEMWIDTH,-4.5*MEMHGT),W,fontsize(7pt)+lightcolor);
    }
  // label(pic,"\makebox[0.5in][r]{$\vdots$}",(0.75*MEMWIDTH,-5.65*MEMHGT),W,fontsize(7pt)+lightcolor);

  return pic;
}


// ---- Illustrate pointers
// The poster version (the version that shows when not in an animation)
// comes first because it is the largest, and animategraphics has
// trouble if the graphics are different lengths.
//   So I add an invisible dot to each picture, making all same width.
// .............. poster version
picture pic;
int picnum = 4;
unitsize(pic,1pt,1pt);

picture pgmpic = draw_program(highlighted=new int[] {});
// pic0
picture memboxpic = draw_memboxes(901,902,-1,-1,showaddress=true);
add(pic,memboxpic,(1.4inch,0),above=true);
// pic1
picture memboxpic = draw_memboxes(901,902,42,-1);
add(pic,memboxpic,(1.8inch,0),above=true);
// pic2
picture memboxpic = draw_memboxes(901,901,42,-1);
add(pic,memboxpic,(2.2inch,0),above=true);
// pic3
picture memboxpic = draw_memboxes(901,901,13,-1);
add(pic,memboxpic,(2.6inch,0),above=true);
real pgmpic_hgt = size(pgmpic).y;
real memboxpic_hgt = size(memboxpic).y;
fill(pic,shift(0,(memboxpic_hgt-pgmpic_hgt)/2)*box(min(pgmpic),max(pgmpic)),lightcolor);
add(pic,pgmpic,(0,(memboxpic_hgt-pgmpic_hgt)/2),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");

real posterpic_width = size(pic).x;
pair invisible_dot_loc=(posterpic_width,0)+(dotfactor/2)*linewidth()*(-1,0);  // no need to adjust the y coord as y= is somewhere in the middle
// write(format('The width of pic 4 is %f\n',size(pic).x),file=stdout);



// ..........
picture pic;
int picnum = 0;

picture pgmpic = draw_program(highlighted=new int[] {0,1,2,3});
picture memboxpic = draw_memboxes(901,902,-1,-1,showaddress=true);
real pgmpic_hgt = size(pgmpic).y;
real memboxpic_hgt = size(memboxpic).y;
fill(pic,shift(0,(memboxpic_hgt-pgmpic_hgt)/2)*box(min(pgmpic),max(pgmpic)),lightcolor);
add(pic,pgmpic,(0,(memboxpic_hgt-pgmpic_hgt)/2),above=true);
add(pic,memboxpic,(1.4inch,0),above=true);

invisible_dot_loc = posterpic_width+min(pic).x+(dotfactor/2)*linewidth()*(-1,0);  // no need to adjust the y coord as y= is somewhere in the middle
dot(pic,invisible_dot_loc,invisible); 

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
// write(format("The width of pic 0 is %f\n",size(pic).x),file=stdout);


// ..............
picture pic;
int picnum = 1;
// size(pic,posterpic_width,0);
dot(pic,invisible_dot_loc,invisible); // animate does not like different sized graphics

picture pgmpic = draw_program(highlighted=new int[] {4});
picture memboxpic = draw_memboxes(901,902,42,-1,showaddress=true);
real pgmpic_wdt = size(pgmpic).x;
real pgmpic_hgt = size(pgmpic).y;
real memboxpic_hgt = size(memboxpic).y;
fill(pic,shift(0,(memboxpic_hgt-pgmpic_hgt)/2)*box(min(pgmpic),max(pgmpic)),lightcolor);
add(pic,pgmpic,(0,(memboxpic_hgt-pgmpic_hgt)/2));
add(pic,memboxpic,(1.8inch,0),above=true);

invisible_dot_loc = posterpic_width+min(pic).x+(dotfactor/2)*linewidth()*(-1,0);  // no need to adjust the y coord as y= is somewhere in the middle
dot(pic,invisible_dot_loc,invisible); 
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
// write(format("The width of pic 1 is %f\n",size(pic).x),file=stdout);

// ..............
picture pic;
int picnum = 2;
size(pic,posterpic_width,0);
// dot(pic,invisible_dot_loc,invisible); // animate does not like different sized graphics

picture pgmpic = draw_program(highlighted=new int[] {5});
picture memboxpic = draw_memboxes(901,901,42,-1,showaddress=true);
real pgmpic_hgt = size(pgmpic).y;
real memboxpic_hgt = size(memboxpic).y;
fill(pic,shift(0,(memboxpic_hgt-pgmpic_hgt)/2)*box(min(pgmpic),max(pgmpic)),lightcolor);
add(pic,pgmpic,(0,(memboxpic_hgt-pgmpic_hgt)/2),above=true);
add(pic,memboxpic,(2.2inch,0),above=true);

invisible_dot_loc = posterpic_width+min(pic).x+(dotfactor/2)*linewidth()*(-1,0);  // no need to adjust the y coord as y= is somewhere in the middle
dot(pic,invisible_dot_loc,invisible); 
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............
picture pic;
int picnum = 3;
size(pic,posterpic_width,0);
// dot(pic,invisible_dot_loc,invisible); // animate does not like different sized graphics

picture pgmpic = draw_program(highlighted=new int[] {6});
picture memboxpic = draw_memboxes(901,901,13,-1,showaddress=true);
real pgmpic_hgt = size(pgmpic).y;
real memboxpic_hgt = size(memboxpic).y;
fill(pic,shift(0,(memboxpic_hgt-pgmpic_hgt)/2)*box(min(pgmpic),max(pgmpic)),lightcolor);
add(pic,pgmpic,(0,(memboxpic_hgt-pgmpic_hgt)/2),above=true);
add(pic,memboxpic,(2.6inch,0),above=true);

invisible_dot_loc = posterpic_width+min(pic).x+(dotfactor/2)*linewidth()*(-1,0);  // no need to adjust the y coord as y= is somewhere in the middle
dot(pic,invisible_dot_loc,invisible); 
shipout(format(OUTPUT_FN,picnum),pic,format="pdf");



// ---- Illustrate pointers

// .............. poster version
picture pic;
int picnum = 9;
size(pic,0,0,keepAspect=true);

// pic5
picture memboxpic = draw_memboxes(901,902,-1,-1,showaddress=true);
add(pic,memboxpic,(0,0),above=true);
// pic1
picture memboxpic = draw_memboxes(901,902,42,-1);
add(pic,memboxpic,(0.75inch,0),above=true);
// pic2
picture memboxpic = draw_memboxes(901,901,42,-1);
add(pic,memboxpic,(1.5inch,0),above=true);
// pic3
picture memboxpic = draw_memboxes(901,901,13,-1);
add(pic,memboxpic,(2.25inch,0),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
real posterpic_width = size(pic).x;



picture pic;
int picnum = 5;
size(pic,0,0);
dot(pic,(posterpic_width,0),invisible); // animate does not like different sized graphics

picture memboxpic = draw_memboxes(901,902,-1,-1,showaddress=true);
add(pic,memboxpic,(0,0),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............
picture pic;
int picnum = 6;
size(pic,0,0);
dot(pic,(posterpic_width,0),invisible); // animate does not like different sized graphics

picture memboxpic = draw_memboxes(901,902,42,-1,showaddress=true);
add(pic,memboxpic,(0,0),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............
picture pic;
int picnum = 7;
size(pic,0,0);
dot(pic,(posterpic_width,0),invisible); // animate does not like different sized graphics

picture memboxpic = draw_memboxes(901,901,42,-1,showaddress=true);
add(pic,memboxpic,(0,0),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


// ..............
picture pic;
int picnum = 8;
size(pic,0,0);
dot(pic,(posterpic_width,0),invisible); // animate does not like different sized graphics

picture memboxpic = draw_memboxes(901,901,13,-1,showaddress=true);
add(pic,memboxpic,(0,0),above=true);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");


