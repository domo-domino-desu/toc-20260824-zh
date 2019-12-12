// aristotle.asy
//  Draw wheels of different radii and animater their motion

import settings;
settings.outformat="pdf";
settings.render=0;

unitsize(1cm);

// cd junk is needed for relative import 
cd("../../../asy/");
import jh;
cd("");

real PI = 3.14159265359; // must be in there somewhere
pair origin=(0,0);
real small_wheel_r = 0.25;
real large_wheel_r = 2.1*small_wheel_r;
path small_wheel = circle(origin,small_wheel_r);
path small_wheel_rad = origin--(0,-small_wheel_r);
path large_wheel = circle(origin,large_wheel_r);
path large_wheel_rad = origin--(0,-large_wheel_r);


// Put the small wheel above the large one and roll them
real small_wheel_raise=1.1*(large_wheel_r+small_wheel_r); // how far to raise small wheel
int num_pics = 50;
for (int picnum=0; picnum <= num_pics; ++picnum) {
  // debugging: write(stdout,"Here.");
  picture p;
  unitsize(p,1cm);
  dot(p,(-large_wheel_r,-large_wheel_r),invisible);
  dot(p,(2*PI*large_wheel_r+large_wheel_r,small_wheel_raise+small_wheel_r),invisible);
  
  real rot=-(picnum/num_pics)*360; // How much to rotate each wheel?
  transform t_small=shift(0,small_wheel_raise)*rotate(rot);  // Trans of small wheel
  real small_dist_covered = picnum/num_pics*(2*PI*small_wheel_r);
  t_small = shift(small_dist_covered,0)*t_small;
  transform t_large=rotate(rot);                  //  and of large_wheel
  real large_dist_covered = picnum/num_pics*(2*PI*large_wheel_r);
  t_large = shift(large_dist_covered,0)*t_large;
  draw(p,(0,-large_wheel_r)--(large_dist_covered,-large_wheel_r),DARKPEN+squarecap+background_color);
  draw(p,t_large*large_wheel,DARKPEN+background_color);
  draw(p,t_large*large_wheel_rad,DARKPEN+roundcap+background_color);
  draw(p,(0,small_wheel_raise-small_wheel_r)--(small_dist_covered,small_wheel_raise-small_wheel_r),DARKPEN+squarecap+highlight_color);
  draw(p,t_small*small_wheel,DARKPEN+highlight_color);
  draw(p,t_small*small_wheel_rad,LIGHTPEN+roundcap+highlight_color);
  shipout(format("aristotle1%03d",picnum),p,format="pdf");
}


// Put the small wheel inside the large one and roll them
int num_pics = 50;
for (int picnum=0; picnum <= num_pics; ++picnum) {
  // debugging: write(stdout,"Here.");
  picture p;
  unitsize(p,1cm);
  dot(p,(-large_wheel_r,-large_wheel_r),invisible);
  dot(p,(2*PI*large_wheel_r+large_wheel_r,large_wheel_r),invisible);
  
  real rot=-(picnum/num_pics)*360; // How much to rotate each wheel?
  real small_dist_covered = picnum/num_pics*(2*PI*small_wheel_r);
  real large_dist_covered = picnum/num_pics*(2*PI*large_wheel_r);
  transform t_small=rotate(rot);  // Trans of small wheel
  t_small = shift(large_dist_covered,0)*t_small;
  transform t_large=rotate(rot);                  //  and of large_wheel
  t_large = shift(large_dist_covered,0)*t_large;
  draw(p,(0,-large_wheel_r)--(large_dist_covered,-large_wheel_r),DARKPEN+squarecap+background_color);
  draw(p,t_large*large_wheel,DARKPEN+background_color);
  draw(p,t_large*large_wheel_rad,DARKPEN+roundcap+background_color);
  draw(p,(0,-small_wheel_r)--(large_dist_covered,-small_wheel_r),DARKPEN+squarecap+highlight_color);
  draw(p,t_small*small_wheel,DARKPEN+highlight_color);
  draw(p,t_small*small_wheel_rad,LIGHTPEN+roundcap+highlight_color);
  shipout(format("aristotle2%03d",picnum),p,format="pdf");
}


real small_wheel_raise=1.0*(large_wheel_r+small_wheel_r); // how far to raise small wheel
// Put the small wheel inside the large one and correspond points
int num_pics = 25;
for (int picnum=0; picnum <= num_pics; ++picnum) {
  picture p;
  unitsize(p,1cm);
  // dot(p,(-large_wheel_r,-large_wheel_r),invisible);
  // dot(p,(large_wheel_r,large_wheel_r),invisible);
  // make the two wheels
  draw(p,large_wheel,DARKPEN+background_color);
  draw(p,small_wheel,DARKPEN+highlight_color);
  real of_the_way = picnum/num_pics;  // what percentage of the way are we?
  real ang = 360*of_the_way-90;
  pair unit_circle_pt = (Cos(ang),Sin(ang)); // Capitals do in degrees
  path intercircle_cor = small_wheel_r*unit_circle_pt--large_wheel_r*unit_circle_pt;
  path intercircle_cor_cut_off = cut_off_ends(intercircle_cor,0.025);
  draw(p,intercircle_cor_cut_off,DARKPEN+light_color,Arrows(arrowhead=TeXHead,size=1));
  // make the two intervals
  transform t = shift(5*large_wheel_r,-large_wheel_r);  // second picture over how far?
  draw(p,t*(0,small_wheel_raise)--t*(2*PI*small_wheel_r,small_wheel_raise),DARKPEN+squarecap+highlight_color);
  draw(p,t*(0,0)--t*(2*PI*large_wheel_r,0),DARKPEN+squarecap+background_color);
  path interline_cor = t*(2*PI*small_wheel_r*of_the_way,small_wheel_raise)--t*(2*PI*large_wheel_r*of_the_way,0);
  path interline_cor_cut_off = cut_off_ends(interline_cor,0.05);
  draw(p,interline_cor_cut_off,DARKPEN+light_color,Arrows(arrowhead=TeXHead,size=1));
  shipout(format("aristotle3%03d",picnum),p,format="pdf");
}
