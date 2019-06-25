// xygraphs.asy
//  Graphs of fcns

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1pt);

// cd junk is needed for relative import 
cd("../../../asy");
import settexpreamble;
cd("");
settexpreamble();
cd("../../../asy/");
import jh;
cd("");

string OUTPUT_FN = "xygraphs%02d";

import graph;
// some parameters
real axis_arrow_size = 0.35mm;
real axis_tick_size = 0.75mm;


// ============== plot H_1(2,y) ================
picture pic;
int picnum = 0;
size(pic,6cm);
real scalefactor = 1;
scale(pic,Linear(scalefactor),Linear(0.02*scalefactor));

// limits for graphs
real xmin=0;  
real xmax=10;
real ymin=0;
real ymax=600;

// data
pair [] H1pts = {(0,2),
		 (1,3),
		 (2,4),
		 (3,5),
		 (4,6),
		 (5,7),
		 (6,8),
		 (7,9),
		 (8,10),
		 (9,11)
};
pair [] H2pts = {
  (0,0),
  (1,2),
  (2,4),
  (3,6),
  (4,8),
  (5,10),
  (6,12),
  (7,14),
  (8,16),
  (9,18)
};
pair [] H3pts = {
  (0,1),
  (1,2),
  (2,4),
  (3,8),
  (4,16),
  (5,32),
  (6,64),
  (7,128),
  (8,256),
  (9,512)
};

// draw the points
dotfactor=1.5; // http://asymptote.sourceforge.net/FAQ/section3.html
for(pair pt: H1pts) {
  dot(pic, Scale(pic,pt), FCNPEN_SOLID+highlightcolor, Fill(black));
}
for(pair pt: H2pts) {
  dot(pic, Scale(pic,pt), FCNPEN_SOLID+black, Fill(black));
}
for(pair pt: H3pts) {
  dot(pic, Scale(pic,pt), FCNPEN_SOLID+backgroundcolor, Fill(black));
}
// labels 
label(pic,"$H_3$",Scale(pic,(9,450)),3*W,TICLABELPEN);
label(pic,"$H_2$",Scale(pic,(8,18)),2*N,TICLABELPEN);
label(pic,"$H_1$",Scale(pic,(9,16)),2*E,TICLABELPEN);

// axes
xaxis(pic,YZero,
      xmin-0.25, xmax+0.5,
      RightTicks(Label("$%2.0f$",TICLABELPEN), Step=5, step=1,
		 beginlabel=false, endlabel=true,
		 Size=axis_tick_size, size=0.5*axis_tick_size,
		 extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));
yaxis(pic,XZero,
      ymin-1, ymax+25,
      LeftTicks(Label("$%2.0f$",TICLABELPEN), Step=100, step=50,
		beginlabel=false, endlabel=true,
		Size=axis_tick_size, size=0.5*axis_tick_size,
		extend=false, begin=false),
      p=AXISPEN,
      Arrow(TeXHead,axis_arrow_size));


shipout(format(OUTPUT_FN,picnum),pic,format="pdf");




