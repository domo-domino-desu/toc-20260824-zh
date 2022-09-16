// tm_share.asy
//  A picture object that shows a turing machine

import three;
import tube;
import settings;

settings.dir="..";  // make it able to see jh.asy 
import jh;

picture turingmachine; 

pen TM_DOVETAILPEN=gray(0.3)+linewidth(0.1); // draw edges of box and stack

real tm_lh=3, tm_wd=4, tm_ht=1.3;  // dimensions of CPU box
pen beige_color=rgb("E2CBB3");
pen green_color=rgb("4B6635");
// pen purple_color=rgb("4D455D");
// Use the one from jh.sty pen red_color=rgb("F54E2A");
// pen blue_color=rgb("47C0B8");
// pen cpu_color=beige_color;
pen button_color=green_color;
pen halt_light_color=red_color;

// CPU
// Points
triple tm_origin=(0,0,0);
triple tm_bot_left_back=tm_origin;
triple tm_bot_left_front=(tm_lh,0,0);
triple tm_bot_rt_front=(tm_lh,tm_wd,0);
triple tm_bot_rt_back=(0,tm_wd,0);
triple tm_top_left_front=(tm_lh,0,tm_ht);
triple tm_top_left_back=(0,0,tm_ht);
triple tm_top_rt_front=(tm_lh,tm_wd,tm_ht);
triple tm_top_rt_back=(0,tm_wd,tm_ht);

// Edges
path3 tm_bot_left=tm_origin--tm_bot_left_front;
path3 tm_bot_front=tm_bot_left_front--tm_bot_rt_front;
path3 tm_bot_rt=tm_bot_rt_front--tm_bot_rt_back;
path3 tm_bot_back=tm_origin--tm_bot_rt_back;
path3 tm_top_left=tm_top_left_back--tm_top_left_front;
path3 tm_top_front=tm_top_left_front--tm_top_rt_front;
path3 tm_top_rt=tm_top_rt_front--tm_top_rt_back;
path3 tm_top_back=tm_top_left_back--tm_top_rt_back;
path3 tm_side_left_front=tm_bot_left_front--tm_top_left_front;
path3 tm_side_rt_front=tm_bot_rt_front--tm_top_rt_front;
path3 tm_side_left_back=tm_origin--tm_top_left_back;
path3 tm_side_rt_back=tm_bot_rt_back--tm_top_rt_back;

// Faces
path3 tm_front=tm_bot_front--tm_side_rt_front--reverse(tm_top_front)--cycle;
path3 tm_top=tm_top_left--tm_top_front--tm_top_rt--cycle;
path3 tm_rt=tm_bot_rt--tm_side_rt_back--reverse(tm_top_rt)--cycle;


// External box; an oracle or a stack
real eb_lh=1.25, eb_wd=1.5, eb_ht=1.75;  // dimensions of external box
// Points
triple eb_origin=(0,0,0);
triple eb_bot_left_back=eb_origin;
triple eb_bot_left_front=(eb_lh,0,0);
triple eb_bot_rt_front=(eb_lh,eb_wd,0);
triple eb_bot_rt_back=(0,eb_wd,0);
triple eb_top_left_front=(eb_lh,0,eb_ht);
triple eb_top_left_back=(0,0,eb_ht);
triple eb_top_rt_front=(eb_lh,eb_wd,eb_ht);
triple eb_top_rt_back=(0,eb_wd,eb_ht);

// Edges
path3 eb_bot_left=eb_origin--eb_bot_left_front;
path3 eb_bot_front=eb_bot_left_front--eb_bot_rt_front;
path3 eb_bot_rt=eb_bot_rt_front--eb_bot_rt_back;
path3 eb_bot_back=eb_origin--eb_bot_rt_back;
path3 eb_top_left=eb_top_left_back--eb_top_left_front;
path3 eb_top_front=eb_top_left_front--eb_top_rt_front;
path3 eb_top_rt=eb_top_rt_front--eb_top_rt_back;
path3 eb_top_back=eb_top_left_back--eb_top_rt_back;
path3 eb_side_left_front=eb_bot_left_front--eb_top_left_front;
path3 eb_side_rt_front=eb_bot_rt_front--eb_top_rt_front;
path3 eb_side_left_back=eb_origin--eb_top_left_back;
path3 eb_side_rt_back=eb_bot_rt_back--eb_top_rt_back;

// Faces
path3 eb_front=eb_bot_front--eb_side_rt_front--reverse(eb_top_front)--cycle;
path3 eb_top=eb_top_left--eb_top_front--eb_top_rt--cycle;
path3 eb_rt=eb_bot_rt--eb_side_rt_back--reverse(eb_top_rt)--cycle;


/// Material
//material box_outside=material(diffusepen=gray(.3),specularpen=gray(.6),emissivepen=rgb(0.8,0.8,0.8));
material tm_box_outside=material(diffusepen=rgb(0.50754,0.50754,0.50754),ambientpen=rgb(0.19225,0.19225,0.19225),specularpen=rgb(.508273,.508273,.508273),shininess=0.4*128,emissivepen=rgb(0.7,0.7,0.7));
material tm_box_outside=material(ambientpen=gray(0.19225),  // background color; color in shadow
				 diffusepen=gray(0.50754),  // color under white light 
				 specularpen=gray(0.508273),  // shiny parts
				 emissivepen=gray(0.7),
				   shininess=.4*128);
material eb_box_outside=material(ambientpen=gray(0.2),  // background color; color in shadow
				 diffusepen=gray(0.35),  // color under white light 
				 specularpen=gray(0.10),  // shiny parts
				 emissivepen=gray(0.3),
				   shininess=.2*128);

// render render=render(compression=0,merge=true);

// tm_draw  Draw the body of the Turing machine
void tm_draw(picture pic=currentpicture, pen p=TM_DOVETAILPEN) {
  draw(pic, surface(tm_front),tm_box_outside);
  draw(pic, surface(tm_top),tm_box_outside);
  draw(pic, surface(tm_rt),tm_box_outside);
  draw(pic, tm_top,p);
  draw(pic, tm_front,p);
  draw(pic, tm_rt,p);
}

// eb_draw  Draw the external box
void eb_draw(picture pic=currentpicture, pen p=TM_DOVETAILPEN, transform3 t=identity4, string eb_label="", material eb_material = eb_box_outside) {
    draw(pic, t*surface(eb_front),eb_material);
    draw(pic, t*surface(eb_top),eb_material);
    draw(pic, t*surface(eb_rt),eb_material);
    draw(pic, t*eb_top,p);
    draw(pic, t*eb_front,p);
    draw(pic, t*eb_rt,p);
    draw(pic, t*surface(shift(eb_lh,0.5*eb_wd,0.75*eb_ht)*scale3(0.03)*rotate(90,Y)*rotate(90,Z)*eb_label));
}


// Wire between the TM and the External box

void draw_wire(picture pic=currentpicture, triple tm_origin=(0,0,0), triple eb_origin=eb_origin, pen p=MAINPEN+boldcolor){
  path3 wire_center=(tm_origin+(-1,0,0))
    --(tm_origin+(-1,-1,0))
    ..(tm_origin+(-1,-3+0.05*unitrand(),0))
    ..(tm_origin+(-1+0.03*unitrand(),-3.5+0.1*unitrand(),0))
    ..(tm_origin+(-1+0.03*unitrand(),-3+0.1*unitrand(),0))
    ..(eb_origin+(-0.5+0.03*unitrand(),-2+0.03*unitrand(),0))
    ..(eb_origin+(-0.75+0.03*unitrand(),-1+0.03*unitrand(),0))
    ..(eb_origin+(-1,0,0));
  draw(pic, wire_center,p);
}

// START button
triple tm_but_center=(tm_lh,.2*tm_wd,.7*tm_ht);
path3 tm_button=circle(tm_but_center,.1*tm_ht,X);
// material tm_button_material=material(diffusepen=gray(.7),specularpen=gray(.1),emissivepen=rgb(0,0.6,0));
// material tm_button_material=material(diffusepen=gray(.7),specularpen=gray(.1),emissivepen=(green_color));
material tm_button_material=material(ambientpen=button_color+gray(.1),
				     diffusepen=button_color,
				     specularpen=white,
				     emissivepen=button_color,
				     shininess=.4);



void tm_draw_start_button(picture pic=currentpicture, string start_label="\textsf{Start}") {
  pen[] r={rgb(0,0.8,0)}; // colors for tube of start button
  path b = scale(.15)*unitcircle;
  triple button_path_end = tm_but_center+(0.08,0,0);
  surface start_button_tube=tube(tm_but_center--button_path_end,
  				 coloredpath(b,r));
  draw(pic, start_button_tube,tm_button_material);
  draw(pic, shift(button_path_end)*rotate(90,Y)*surface(b),tm_button_material);
  draw(pic, shift(button_path_end)*rotate(90,Y)*path3(b),TM_DOVETAILPEN);
  // draw(surface(tm_button),tm_button_material);
  // draw(tm_button,black+linewidth(0.4));
  draw(pic, surface(shift(tm_lh,0.2*tm_wd,0.4*tm_ht)*scale3(0.03)*rotate(90,Y)*rotate(90,Z)*start_label));
}

// Halt light
material tm_halt_material=material(ambientpen=halt_light_color+black,  // background color; color in shadow
				   diffusepen=halt_light_color,  // color under white light 
				   specularpen=white,  // shiny parts
				   emissivepen=halt_light_color,
				   shininess=.1);
path3 tm_halt_frame=circle((.8*tm_lh,.8*tm_wd,tm_ht),.25,Z);

void tm_draw_halt_light (picture pic=currentpicture, string tm_halt_label="\textsf{Halt}") {
    draw(pic, tm_halt_frame);
    draw(pic, shift(.8*tm_lh,.8*tm_wd,tm_ht)*scale3(.23)*unithemisphere,tm_halt_material);
    draw(pic, surface(shift(tm_lh,0.8*tm_wd,0.8*tm_ht)*scale3(0.03)*rotate(90,Y)*rotate(90,Z)*tm_halt_label));
}

pen TM_TAPEPEN=black+linewidth(0.1); // draw outline of tape
material tm_tape_material=material(diffusepen=gray(.7),specularpen=gray(.1),emissivepen=rgb(1,1,1));
real tm_tape_wd=1;
real tm_tape_ht=0.3*tm_ht;



// Right tape
path3 tm_rt_tape=(.5*tm_tape_wd,0,0)--(.5*tm_tape_wd,3,0)..(.5*tm_tape_wd,4,0)..(.5*tm_tape_wd,6,-0.2)
  --(-0.5*tm_tape_wd,6,-0.2)..(-0.5*tm_tape_wd,4,0)..(-0.5*tm_tape_wd,3,0)--(-0.5*tm_tape_wd,0,0)--cycle;

void tm_draw_rt_tape(picture pic=currentpicture, string tape_text="\texttt{01101}") {
  triple mouth_pos = 0.5*(tm_bot_rt_front+tm_bot_rt_back)
    +(0,0,tm_tape_ht);
  transform3 mouth_transform=shift(mouth_pos)*rotate(90,X)*yscale3(.15)*scale3(.65); 
  draw(pic, mouth_transform*unitdisk, rgb(0.95,0.95,0.95));
  draw(pic, shift(mouth_pos)*surface(tm_rt_tape),tm_tape_material); // over-wide; bug?
  draw(pic, surface(shift(mouth_pos)*shift(0.1,0.1,0)*rotate(90,Z)*scale3(0.05)*Label(tape_text,align=Align)));
  draw(pic, shift(mouth_pos)*tm_rt_tape,TM_TAPEPEN);  
}


// left tape
path3 lf_tape=(0.5*tm_tape_wd,0,0)--(0.5*tm_tape_wd,-1,0)
  ..(0.5*tm_tape_wd,-1.2,0)..(0.5*tm_tape_wd,-2.8,-0.2)
  ..(0.5*tm_tape_wd,-2.9,-0.2)--(0.5*tm_tape_wd,-3.0,-0.2)
  --(-0.5*tm_tape_wd,-3.0,-0.2)
  ..(-0.5*tm_tape_wd,-2.9,-0.2)..(-0.5*tm_tape_wd,-2.8,-0.2)..(-0.5*tm_tape_wd,-1.2,0)
  ..(-0.5*tm_tape_wd,-1,0)--(-0.5*tm_tape_wd,0,0)
  --cycle;
void tm_draw_lf_tape(picture pic=currentpicture) {
  triple mouth_pos = 0.5*(tm_bot_left_front+tm_bot_left_back)
    +(0,0,tm_tape_ht);
  transform3 lf_tape_transform=shift(mouth_pos); 
  draw(pic, lf_tape_transform*lf_tape,TM_TAPEPEN);  
}

