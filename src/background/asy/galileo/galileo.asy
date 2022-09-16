// galileo.asy
//  Animate paradox that there are same number of squares as numbers 

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);


// Set up LaTeX defaults 
import settexpreamble;
settexpreamble();
// Set up Asy defaults
import jh;

//
real horiz_gap = 0.8;
real vert_gap = 1*horiz_gap; // how far to raise numbers
int num_pics = 12;
for (int picnum=0; picnum <= num_pics; ++picnum) {
  // debugging: write(stdout,"Here.");
  picture p;
  unitsize(p,1cm);
  dot(p,(-.05,0),invisible);  // Keep arrowhead in first pic from changing pic size 
  for (int i=0; i < num_pics; ++i) {
    label(p,format("$\makebox[0em]{%d}$",i*i),(i*horiz_gap,0));
    label(p,format("$\makebox[0em]{%d}$",i),(i*horiz_gap,vert_gap));
  }
  label(p,"$\ldots$",(num_pics*horiz_gap,0));
  label(p,"$\ldots$",(num_pics*horiz_gap,vert_gap));
  // Make the arrow showing correspondence
  path corr = (picnum*horiz_gap,0)--(picnum*horiz_gap,vert_gap);
  path corr_cut_off = cut_off_ends(corr, .15);
  if (picnum != num_pics) {  // no arrow between the ldots
    draw(p,corr_cut_off,DARKPEN+light_color,Arrows(arrowhead=TeXHead,size=1));
    // draw(p,corr,Arrows(arrowhead=TeXHead));
  }
  shipout(format("galileo%03d",picnum),p,format="pdf");
}
