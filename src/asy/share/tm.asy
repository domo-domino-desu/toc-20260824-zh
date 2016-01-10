// tm.asy
//  a turing machine

import three;
import tube;
import settings;
settings.dir="..";  // make it able to see jh.asy 
settings.outformat="pdf";
settings.render=0;

import jh;
defaultpen(fontsize(8pt));

size(300);  // units are big points: 72 is 1inch

import tm_share;
triple view_from = (32,12,10);
currentprojection=orthographic(view_from);
currentlight=light(view_from);

tm_draw_lf_tape();
tm_draw(); tm_draw_start_button(); tm_draw_halt_light();
tm_draw_rt_tape("1001010 1001000");

dot((0,1.15*tm_ht),invisible);  // little extra vert room
