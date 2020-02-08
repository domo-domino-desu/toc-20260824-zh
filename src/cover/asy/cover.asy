// cover.asy
//  Draw the cover

import settings;
settings.outformat="pdf";
settings.tex = "xelatex";
settings.render=0;

// colors Triadic color theme
// see https://color.adobe.com/Triadic-color-theme-9913086/edit/?copy=true
pen green_color=rgb("E7FFCC");  // electric gree hex string
pen lightblack_color=rgb("313030");  // 
pen grey_color=rgb("929191");
pen lightblue_color=rgb("D2FCFF");
pen pink_color=rgb("FFD8CC");

import fontsize;
defaultpen(fontsize(9.24994pt));
// import texcolors;

unitsize(1inch);

// cd junk is needed for relative import 
// cd("../../asy");
// import settexpreamble;
// cd("");
// settexpreamble();
texpreamble("\usepackage{fontspec}\setmainfont{FreeSans}");

cd("../../asy/");
import jh;
cd("");

string OUTPUT_FN = "cover%02d";

import trembling; // see http://www.piprime.fr/files/asymptote/trembling/

// see https://tex.stackexchange.com/questions/167164/inserting-graphics-into-asymptote-or-pgfplots
// ============== cover ================
picture pic;
int picnum = 0;
// size(pic,4cm);
real papersize_width = 7.5inch;
real papersize_height=9.25inch;
path border = (0,0)--(papersize_width,0)--
  (papersize_width,papersize_height)--
  (0,papersize_height)--cycle;
fill(pic, border, pink_color);
// draw(pic, border, red);
layer(pic);
label(pic,graphic("../computingdivision.jpg","width=7.5in"),
      (papersize_width/2, papersize_height/2));
layer(pic);

srand(1414);  // seed random number generator
real MAXR = 0.05inch;
real fudge(real epsilon=MAXR) {
  return epsilon*(unitrand()-0.5);
}

real crop_top=6.5inch;
real crop_bottom=2.0inch;
real crop_left=0.35inch;
real crop_right=6.4inch;

path cropper = (crop_left,crop_bottom)--
  (crop_right+fudge(),crop_bottom+fudge())--
  (crop_right+fudge(),crop_top+fudge())--
  (crop_left+fudge(),crop_top+fudge())-- cycle;
draw(pic, cropper, green_color+linewidth(3pt));

path cropper = (crop_left,crop_bottom)--
  (crop_right+fudge(),crop_bottom+fudge())--
  (crop_right+fudge(),crop_top+fudge())--
  (crop_left+fudge(),crop_top+fudge())-- cycle;
tremble T = new tremble;
T.angle=4;
T.frequency=0.5;
T.random=2;
path tcropper=T.deform(cropper);
draw(pic, tcropper, green_color+linewidth(2pt));
path tcropper=T.deform(cropper);
draw(pic, tcropper, green_color+linewidth(2pt));

label(pic, "\makebox[0in][c]{Theory of Computation}",
      (papersize_width/2,8.55inch), fontsize(35)+lightblack_color);
label(pic, "\makebox[0in][c]{Making Connections}",
      (papersize_width/2,8.0inch), fontsize(19)+lightblack_color);
label(pic, "\makebox[0in][r]{\begin{tabular}{r}\Large Jim Hef{}feron \\[0.35ex] \texttt{http://joshua.smcvt.edu/computation}\end{tabular}}", (papersize_width-0.5inch,0.9inch), fontsize(14)+lightblack_color);

shipout(format(OUTPUT_FN,picnum),pic,format="pdf");
